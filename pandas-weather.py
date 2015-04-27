#!/usr/bin/env python

import sys
from datetime import datetime, date, time

import pandas
from pandas import Series, DataFrame, Panel

import matplotlib.pyplot as plt
import matplotlib as matplot

matplot.rc('figure', figsize=(12, 8))

data = pandas.read_csv('tageswerte-1948-2012.csv',
                       parse_dates = {'Messdatum': ['MESS_DATUM']},
                       index_col   = 'Messdatum')

# extract certain columns we're interested in
ticks = data.ix[:, ['NIEDERSCHLAGSHOEHE', 'LUFTTEMPERATUR']]

# display 5 first rows
print ticks.head()

# output a couple of basic statistics - minimum, maximum, mean, etc
print ticks.describe()

# get a specific value - lowest values of two columns
print ticks.min()

# get a specific value - highest temperatur
print ticks.LUFTTEMPERATUR.max()

#extract a specific column
temperature = ticks.LUFTTEMPERATUR

# display 20 rows
print temperature.head(20)

# display value of rows 5 to 8
print temperature.ix[5:8]

# create a simple plot by date range
temperature['1948-01-01':'1948-01-31'].plot()

# basic configuration of plot
plt.ylim(-25.0, 40.0)
plt.legend()
plt.axhline(linewidth = 1, color = 'g')

# display the whole thing
plt.show()

