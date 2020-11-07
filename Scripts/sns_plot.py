#!/usr/bin/env python
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from pandas import Series, DataFrame
'''
Read in the data frame from the previous example

'''
df = pd.read_csv("temperature_pred.csv")
print(df)

'''
    Create a function to prepare the sns pairplot
'''

def make_sns_plot(data, hue_val):
  if hue_val == "":
    exit
  else:
    sns.pairplot(data=data, hue=hue_val)


# Do some descriptive stats

make_sns_plot(df, 'Temp')
df.describe()
df.ndim
df.dtypes


  
