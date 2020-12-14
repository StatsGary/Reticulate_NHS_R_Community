###########################NHS R Community - Reticulate and R - a happy union ###################
#################################CODE WRITTEN BY GARY HUTSON ####################################

#!/usr/bin/env python
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
import warnings as warn
from pandas import Series, DataFrame
from matplotlib import rcParams


rcParams.update({'figure.autolayout': True}) #Set the matplot lib to auto layout

'''
Read in the data frame from the previous example

'''
df = pd.read_csv("Data/ttbs.csv")
print(df)

'''
    Create a function to prepare the sns pairplot
'''

def make_sns_plot(data, hue_val):
  if hue_val == "":
    print("There was no hue value entered.")
    exit
  else:
    sns.pairplot(data=data, hue=hue_val)


# Do some descriptive stats
with warn.catch_warnings():
  warn.simplefilter('ignore')
  make_sns_plot(df, 'TTBS_mins') #Suppress the zero variance errors here

# Write out descriptive statistics
df.describe()
df.ndim
df.dtypes


  
