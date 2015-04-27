#!/bin/sh -

echo "Checking for Perl stuff...";

if ! perl -MAlgorithm::NaiveBayes -e '' >/dev/null 2>&1; then
    echo "You are missing the Perl module Algorithm::NaiveBayes";
fi

if perl -c naivebayes.pl; then
  echo "The script naivebayes.pl looks good!";
else
  echo "The script naivebayes.pl failed syntax check!";
fi

echo "Checking some Ruby stuff...";

if ! ruby -e 'require "kmeans"' >/dev/null 2>&1; then
  echo "You are missing the Ruby gem kmeans.";
fi

if ruby -c kmeans.rb; then
  echo "The script kmeans.rb looks good!";
else
  echo "The script kmeans.rb failed syntax check!";
fi

echo "Checking for R...";

# R library sqldf
if ! echo 'library("xts")' | R --slave >/dev/null 2>&1; then
  echo "You are missing the R module xts.";
fi

# R library tm
if ! echo 'library("lubridate")' | R --slave >/dev/null 2>&1; then
  echo "You are missing the R module lubridate.";
fi

echo "Testing some R plots...";

# run R visualizations...
for script in *.R; do
  R --slave < $script >/dev/null
  rm -f *.pdf
  rm -f *.png
done;

echo "Checking for Python...";

# Python's Pandas data handling library
if ! python -c 'import pandas' >/dev/null 2>&1; then
    echo "You are missing the Python Pandas framework.";
fi

if ! python -c 'import matplotlib' >/dev/null 2>&1; then
    echo "You are missing the Python matplot library.";
fi

if ! python -c 'import datetime' >/dev/null 2>&1; then
    echo "You are missing the Python datetime module.";
fi

if python -m py_compile pandas-weather.py; then
  echo "The script pandas-weather.py looks good!";
else
  echo "The script pandas-weather.pl failed syntax check!";
fi

rm -f *.pyc

echo "We're done!";
