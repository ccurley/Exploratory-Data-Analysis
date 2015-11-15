# ccurley
# Coursea - Exploratory Data Analysis - Assignment 2, Plot 2
#
# Assignment question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
#
# Plot 1 explicitly called out plotting data for 1999, 2002, 2006, and 2008. This question can
# be satisified with just two data points: 1999 and 2008.
# 
# So, I'm using a bar plot.
# 
# I've kept the color black and white since, since color conveys no information (per Tufte).


plot2 <- function() {
        library(plyr)
        library(dplyr)
        
        # get the data
        NEI <- readRDS("summarySCC_PM25.rds")
        
        # get the totals by year. Filter for Baltimore (fips 24510), then filter for 1999 and 2008, since
        # we don't need 2002, 2006 to answer the question, then sum for the two years we're looking at in
        # our date range.
        plotdata <- NEI %>%
                filter(fips == "24510") %>%
                filter(year == "1999" | year == "2008") %>%
                group_by(year) %>%
                summarize(Emissions = sum(Emissions))
        
        # set the output device
        png("plot2.png", width = 480, height = 480)
        
        # set the margins
        par(mar=c(6, 6, 6, 6))
        
        # okay, what we're doing here is setting the y position on the bar chart where we want the bar
        # labels to appear. We take the values for 1999 and 2009 and subtract a constant. This gives us
        # a y value that just below the top of the bar in the barplot for each year.
        ytext1999 = round(plotdata[1,2]) - 250
        ytext2008 = round(plotdata[2,2]) - 250
        
        # set the bar plot. The only exotic thing going on here is the explicity call for space to = 1,
        # which is just there to help set the reference for the x value in the text labels for the bar
        # values.
        barplot(height=plotdata$Emissions, 
                names.arg=plotdata$year, 
                xlab="Years - 1999 and 2008", 
                ylab="Total PM2.5 Emissions",
                main="Total emissions from PM2.5 in Baltimore, Maryland, 1999 to 2008",
                col = "black",
                space = 1)
        
        # Okay, now, let's put in the bar values. add two text lines. For 1999, x is 1.5 so it will show
        # up in the middle of the 1999 bar, having set the spacing for the bars to 1; y will show up just
        # just below the top of the bar inside the bar area. The value is the contents of the row/column
        # Then, we do the same for y, with x adjusted to 3.5 given spacing 1.
        text(x = 1.5, y = ytext1999, labels = round(plotdata[1,2]), cex = 1, pos = 3, col = "white")
        text(x = 3.5, y = ytext2008, labels = round(plotdata[2,2]), cex = 1, pos = 3, col = "white")
        
        # close the output device
        dev.off()
}