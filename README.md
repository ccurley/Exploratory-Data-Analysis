# Exploratory-Data-Analysis
Repo for assignments in the Exploratory Data Analysis class offered through Coursera.

I'm rubbish with this sort of thing, so beware of using anything you find in this repository. The answers are freqently incorrect.

Assignment 1, Due 8 November 2015
---------------------------------

Given that I made a pig's ear out of the class project in Getting and Cleaning Data, assignment 1 for Exploratory Data Analysis wasn't especially difficult.

There are plot1.R, plot2.R, plot3.R and plot4.R create plot1.png, plot2.png, plot3.png and plot4.png respectively. plot1.R also contains the callHPCData() function that will download and unzip the data sample Household Power Consumption data set.

Each plot_n_() function reads in only the data from 2007-02-01 and 2007-02-02 using grep to find the last record for 2007-01-31 ("31/1/2007;23:59:00") and then get the next 2880 rows (e.g. 1440 seconds in day, over two days). It would be more efficient to write that subset to file and call just those 2880 rows in subsequent plots, but I as of this time, I haven't done that because I'm lazy.

The other mildly tricky part was the data and time in two separate columns. Formatting with as.Date() on the read.table worked with Date, but I couldn't get it to format Time properly. I also spent too much time using lubridate's parse_date_time(), again with Date working out as desired and Time ending up a bit of mess. Eventually, I hit on the stackoverflow post on using paste to unite the time and date formatted to a POSIX vectory, which I used for the plots.

When I pulled the same PNGs to Gimp, the canvass size was 504, so that's what I went with.

Assignment 2, Due 21 Novermber 2015
-----------------------------------
TBD

