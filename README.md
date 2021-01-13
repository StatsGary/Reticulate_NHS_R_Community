---
bibliography: references.bib
---

# NHS R Community Reticulate Webinar - a happy union 

<p></p>

![NHSRCommunity](Images/AGEM_NHSR.png)
![](Images/nhs_logo_nottinghamshire.png)
![](Images/nhs_logo_making_a_difference.png)

## Overview of Scikit Learn - Andreas 

Package `reticulate` (Ushey, Allaire, and Tang 2020) makes the integration between `R` and `Python` so easy that the first time I tried it I really could not believe my eyes. Here is an example where `Python` runs a text mining process in the background with `Scikit-learn` (Pedregosa et al. 2011) and plots some results with `ggplot2` (Wickham 2016), in just a few lines of `R` code:

![](Images/reticulate_example_code.png)

It is really _that_ simple!

Package `reticulate` is a game-changer, because the `R` user like myself gains access to the suite of `Python`'s powerful Machine Learning tools, without necessarily being a `Python` expert.

The idea is to use the `Python` elements that are clearly superior to the `R` counterparts, without necessarily having to master `Python`. Personally, I needed access to a much more advanced Machine Learning interface than the ones that are available in `R`, and so I spent a few weeks building a pipeline with `Python`'s `Scikit-learn`. I still do not know `Python` very well. But I do know `Scikit-learn` now. The result? Immensely faster processing times, with results readily available for reporting and visualization with `R`'s `shiny` (Chang et al. 2020) and `golem` (Fay et al. 2020).

In my slide pack I give an overview of `Scikit-learn`. I then compare it with `R`'s well-known Machine Learning libraries `tidymodels`  (Kuhn and Wickham 2020) and `mlr3` (Lang et al. 2019). Finally, I provide a few practical tips for attacking Machine Learning problems with these three libraries.

## Reticulate with R examples - Gary Hutson

Next, the following sections take you through the content of the webinar:

## Setting up the reticulate environment and conversion between environments

The next tutorial focusses on how to use R's reticulate package to work with Python objects in R. The focus of the tutorial is to:

- Setup a miniconda environment and install packages to the environment
- Use the miniconda environment to bring in Python libraries to R
- Create R objects and pass these through to Python
- Creating functions in Python and passing through reticulate style

## Modelling with Python and R

This section looks at cleaning data in R and passing it through to Scikit learn:

- Data setup in R
- Splitting data and using Python's train_test_split function
- Fitting a multiple linear regression model with Scikit learn
- Making predictions with the model in Python and passing back to an R data frame

## Visualising R data with Python's Matplotlib and Seaborn packages

This section looks at visualising:

- The model fit from the regression in Python and R Plotly
- Running an external Python script in R to create a Seaborn pairplot
- Creating a correlation matrix with Python's heatmap


The visual outputs are included hereunder:

![Seaborn Plot](Images/seaborn.png)

![Seaborn Pair Plot](Images/snspairplot.png)

![Seaborn Pair Plot](Images/correlation_plot.png)


# Conclusion

There is much more that can be done with reticulate, such as building Tensorflow and Keras interfaces, if you are inclined, but it really opens up the tools that you can use for analytical tasks.

# References

Chang, Winston, Joe Cheng, JJ Allaire, Yihui Xie, and Jonathan McPherson. 2020. Shiny: Web Application Framework for R. https://CRAN.R-project.org/package=shiny.

Fay, Colin, Vincent Guyader, Sébastien Rochette, and Cervan Girard. 2020. Golem: A Framework for Robust Shiny Applications. https://github.com/ThinkR-open/golem.

Kuhn, Max, and Hadley Wickham. 2020. Tidymodels: A Collection of Packages for Modeling and Machine Learning Using Tidyverse Principles. https://www.tidymodels.org.

Lang, Michel, Martin Binder, Jakob Richter, Patrick Schratz, Florian Pfisterer, Stefan Coors, Quay Au, Giuseppe Casalicchio, Lars Kotthoff, and Bernd Bischl. 2019. “mlr3: A Modern Object-Oriented Machine Learning Framework in R.” Journal of Open Source Software, December. https://doi.org/10.21105/joss.01903.

Pedregosa, F., G. Varoquaux, A. Gramfort, V. Michel, B. Thirion, O. Grisel, M. Blondel, et al. 2011. “Scikit-Learn: Machine Learning in Python.” Journal of Machine Learning Research 12: 2825–30.

Ushey, Kevin, JJ Allaire, and Yuan Tang. 2020. Reticulate: Interface to ’Python’. https://CRAN.R-project.org/package=reticulate.

Wickham, Hadley. 2016. Ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York. https://ggplot2.tidyverse.org.

