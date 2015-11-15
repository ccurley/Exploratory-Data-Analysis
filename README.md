# Exploratory-Data-Analysis
Repo for assignments in the Exploratory Data Analysis class offered through Coursera.

I'm rubbish with this sort of thing, so beware of using anything you find in this repository. The answers are freqently incorrect.

Assignment 1, Due 8 November 2015
---------------------------------

Given that I made a pig's ear out of the class project in Getting and Cleaning Data, assignment 1 for Exploratory Data Analysis wasn't especially difficult.

There are four scripts -- plot1.R, plot2.R, plot3.R and plot4.R -- and each one creates an image file -- plot1.png, plot2.png, plot3.png and plot4.png, respectively.

plot1.R also contains the getHPCData() function that will download and unzip the data sample Household Power Consumption data set, then it will write only the subsetted data to a table. plot#() reads this subsetted table to perform the plots. 
callHPCData() features two arguments. dateStr takes a sequence that would appear from the start of row containing unparsed values for date and time separated by a ";" -- the default value is "31/1/2007;23:59:00". This arg is used to set the skip rows arg in the read.table function call.

daysNum takes a numeric input for the number of days worth of data will be subsetted. Call getHPCData() without args to get the data set used in this assignment. It is used for the nrows argument in the read.table function call.

The other mildly tricky part was the data and time in two separate columns. Formatting with as.Date() on the read.table worked with Date, but I couldn't get it to format Time properly. I also spent too much time using lubridate's parse_date_time(), again with Date working out as desired and Time ending up a bit of mess. Eventually, I hit on the stackoverflow post on using paste to unite the time and date formatted to a POSIX vectory, which I used for the plots in
plot2(), plot3(), and plot().

When I pulled the same PNGs to Gimp, the canvass size was 504 by 504, so that's what I went with when defining the PNG
dimensions.

Since the file names for assignment 1 and assignment 2 are the same for the first four plots, I have each assignment in a subfolder for the class.

Assignment 2, Due 21 Novermber 2015
-----------------------------------
There are four scripts -- plot1.R, plot2.R, plot3.R plot4.R, plot5.R and plot4.R -- and each one creates an image file -- plot1.png, plot2.png, plot3.png, plot4.png, plot5.png and plot6.png, respectively.

Sournce the file, and then call the functions by file name (e.g. plot1()) to render the png file output.

I don't know why, precisely, but I wrapped the plots in print({}) statements instead of printing with a print(x) statement.

I use dplyr for for the subsetting, since I think that it makes more readable code. I call plyr before dplyr as a best practice to prevent odd behavior that can occur if plyr is called after dplyr for any reason.

In the stacked bar plots, I did not print data lables. I sorted out the code to print each label just under the top of the subsection of the stacked bar, but the 1999 and 2008 stacked bars were unreadable. It was better to leave them off.

Since the file names for assignment 1 and assignment 2 are the same for the first four plots, I have each assignment in a subfolder for the class.