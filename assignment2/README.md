# Exploratory-Data-Analysis Assingment 2
Repo for assignments in the Exploratory Data Analysis class offered through Coursera.

I'm rubbish with this sort of thing, so beware of using anything you find in this repository. The answers are freqently incorrect.

Assignment 2, Due 21 Novermber 2015
-----------------------------------
There are six scripts in this repository, where each one generates a png of plotted data answering assignment questions.

Source and call functions corresponding to the file name (e.g. plot1.R sources plot1()). Call the functions without args.

The functions assume that the data for peer assessment (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip) has been downloaded and unzipped in the working directory. For examples on how to do this programmatically, please see the assignments in the Getting and Cleaning Data repo (esp. https://github.com/ccurley/getting_and_cleaning_data/blob/master/run_analysis.R).

I've avoided using grepl to subset the SCC data set, because I find that regex can only ever be read and understood by the person who wrote the expression. All others have to decypher it like Egyptologists (i.e. "^Comb.*Coal"). I use filter statements for the exact SCC EI.Sector strings, since there are a few to account for.

Rather than writing the plots to a list x and then calling print(x), I just wrapped the plot statements in print({}). I found it easier to build and debug the functions this way. I don't suppose I had to put the code in functions, but it seemed to be the way to make this portable -- that is, if I wanted to be able to comp different cities, I could have added an arg for "fips", and so on.

There are lots of ways to subset the data and merge the data sets. I used the dplyr lib and merge functions to do the job -- since that makes for relatively clean code for others to read. 

In plots 1 to 5, I focused on including some element of the lessons into the plots. On plot 1, I focused on readable x and y axis; on plot 2, I worked to include data lables, in plot 3, facets. In plots 4 and 5, working with colors in a stacked bar to convey visual data. In plot 6, the goal was to do the job as simply as possible using the lattice and trellis libraries, since I hadn't called lattice yet.
