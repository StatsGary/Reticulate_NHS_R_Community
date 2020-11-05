library(reticulate)
library(tidyverse)
library(caret)
library(tidymodels)
library(magrittr)
library(plotly)
library(data.table)

# Setup
conda_list()
use_condaenv("anaconda3")
py_available()

#Create a new conda environment to install your packages to 
my_env <- "r-reticulate-gary-env"
#conda_create(my_env)

#Install packages into anaconda environment new environment
#py_install("pandas",envname = my_env)
#py_install("numpy", envname = my_env)
#py_install("seaborn", envname = my_env)
#py_install("scikit-learn",envname = my_env)
#py_install("matplotlib", envname = my_env)

#Specifiy which environment you want to use

use_condaenv(my_env)
conda_version()
conda_list()


# Setup is now complete

#Create python objects as R
numpy <- import("numpy")
pandas <- import("pandas")

# Import libraries for ski-kit learn

sl_model_selection <- import("sklearn.model_selection")
skl <- import("sklearn")
skl_ensemble <- import("sklearn.ensemble")
skl_pipeline <- import("sklearn.pipeline")
skl_metrics <- import("sklearn.metrics")
skl_externals <- import("sklearn.externals")
skl_lm <- import("sklearn.linear_model")

# Import visualisation libraries
sns <- import('seaborn')
plt <- import('matplotlib.pyplot')
# Python users will be used to from sklearn import sub module # this can be handled as such

#------------------------ Writing functions in Python -------------------------#

py_run_string("def square_root(x):
                value = x * 0.5
                return(value)")

# To use the function in R you need to use the below

py$square_root(10) #Or
py_eval("square_root(10)")


# Create a bigger version of the air quality data set

make_blobs_of_blobs <- function (number_of_blobs, df){
  n <- number_of_blobs
  do.call("rbind", replicate(n, df, simplify = FALSE))
}

air <- airquality
air <- make_blobs_of_blobs(50, air)
#Exclude month and day, as we are going to pass to Sk Learn to do a linear model on
air %<>% 
  select(everything(), -c(Month, Day)) %>% 
  drop_na()

# X and Y predictions
X <- air[,1:3]
Y <- data.frame(Temp=air[,4])

# Convert the data frame to a python data type - this conversion will result in a Python dictionary or Pandas data frame

py_air <- r_to_py(air)
py_X <- r_to_py(X)
py_Y <- r_to_py(Y)
py_air$head() # Call the head on the Python object
py_air$dtypes
py_air$nunique
py_air$describe()

py_list_attributes(py_air)
py_len(py_air)

# Now we have the data in a python format we can use the model selection library to 

split <- sl_model_selection$train_test_split(X, Y, test_size=0.75)
# Python has a cool trick called multiple assignment where you can 
#Convert back to python objects

py_X_train <- r_to_py(split[[2]])
py_X_test <- r_to_py(split[[1]])
py_Y_train <- r_to_py(split[[4]])
py_Y_test <- r_to_py(split[[3]])

# In Sk Learn we need to instantiate a model before using it

sk_lm_model <- skl_lm$LinearRegression()
model <- sk_lm_model$fit(py_X_train, py_Y_train)
r_squared <- model$score(py_X_test, py_Y_test)



model_intercept <- model$intercept_
model_coef <- model$coef_
# Create prediction vs actual fit data frame
model_predict <- model$predict(py_X_test)
model_results <- data.frame(Predicted_Temp=model_predict, 
                            py_to_r(py_Y_test),
                            py_to_r(py_Y_test) - model_predict)
colnames(model_results) <- c("Predicted", "Actual", "Residual")

# Convert model results back to Python to do stuff with

py_mod_results <- r_to_py(model_results)
py_mod_results$dtypes

#Create line plot in seaborn

sns$lineplot(data=py_mod_results, x="Actual", y="Predicted")
plt$show()

# Create the same plot in ggplot now in R

plot <- model_results %>% 
  ggplot(aes(x=Actual, 
             y=Predicted)) + geom_point() +
  geom_smooth(method = 'lm', formula = "y ~ x") 

plotly::ggplotly(plot) 

# Export air data frame to csv and then we will run a custom python script stored in 
# a file to pick up where the csv is stored and this will run a snspairplot

data.table::fwrite(air, "temperature_pred.csv")
#What we will do now is run the python script which looks at the 
#summary_stats <- source_python("sns_plot.py")

# Here we have two plots we will now use to pass python objects through to
py_run_file("sns_plot.py") #This has a call to pick up the data and a function 
# to create a pair plot
plt$show()

# Finally we will create a correlation matrix in matplot lib 
corr <- py_air$corr()
sns$heatmap(corr, annot=TRUE, cmap="YlGnBu")
#plt$show()
plt$savefig("correlation_plot.png")

