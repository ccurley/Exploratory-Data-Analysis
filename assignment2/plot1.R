# ccurley
# Coursera - Exploratory Data Analyis Assignment 2, Plot 1
#
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
# 
# I went with the scatter plot over the bar plot, because I wanted to solve the problems
# with the y-axis. I use the bar plot in plot2.
#
# y-axis formatting is a giant pain in the ass. When plotting the graph, the y-axis
# displayed with values in scientific notation. This is not exatly up to Tufte's 
# standards, so I have to format the y-axis by hand... and undertaking about as easy
# as learning to speak Hungarian. Use stackoverflow for reference.
#
# Keeping the colors black and white, since colors don't convey any additional info
# (Tufte).
# 
# Run the code to generate the plot in png format. See comments.

plot1 <- function(){
        library(plyr)
        library(dplyr)
        
        # get the data
        NEI <- readRDS("summarySCC_PM25.rds")
        
        # get the totals by year
        plotdata <- NEI %>%
                    group_by(year) %>%
                    summarize(Emissions = sum(Emissions))
        
        
        # specify the output device as a png file
        png("plot1.png", width = 480, height = 480)
        
        # set the margins
        par(mar=c(6, 6, 6, 6))
        
        # plot the data. Turn off the y axis. Use Year for the x axis. Make the points bigger, black dots.
        print({
        with(plotdata, plot(year, 
             Emissions, 
             yaxt="n", 
             xlab="Year", 
             lty=3, ylab = "Total PM2.5 Emissions",
             col = "black",
             pch = 19,
             main = "Total emissions from PM2.5 in the United States from 1999 to 2008"))
        
        # deal with the BLOODY y-axis. Format Emissions to NOT show the values in sci notiation. Rotate
        # the Emissions ticks to vertical, so they won't over write the y label. Then, shrink the size so 
        # they will fit on the plot
        axis(2,
             at=pretty(plotdata$Emissions),
             labels=format(pretty(plotdata$Emissions),
                           big.mark=",", scientific=FALSE),
             cex.axis = .75,
             las=0)
        
        # calculate a linear regression to hammer the point about the decrasing trend in PM2.5, the plot
        # a dotted red line to illustrate
        r <- lm(Emissions ~ year, plotdata)
        abline(r, lwd = 2, lty = "dotted", col = "black")
        })
        # close the graphical device
        dev.off()
} # end of plot1.R