# ccurley
# Coursera - Exploratory Data Analysis - Assignment 2, Plot 3
#
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which 
# of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have 
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this 
# question.

plot3 <- function() {
        library(ggplot2)
        library(plyr)
        library(dplyr)
        
        # get the NEI data
        NEI <- readRDS("summarySCC_PM25.rds")
        
        # subset the data for 
        plotdata <- NEI %>% 
                    filter(fips == "24510") %>%
                    group_by(type, year) %>%
                    summarize(emissions = sum(Emissions))
        
        # technically, not necessary. But, for facets with ggplot2 it's good practice
        plotdata = transform(plotdata, type = factor(type))
        
        # set the output device
        png("plot3.png", width = 480, height = 480)
        
        # set the margins
        par(mar=c(6, 6, 6, 6))
        
        # plot the data faceted by type. Plot the points, add a lm line, remove the uncertainty
        # since it makes the plot harder to read. Split out the facets, then add the labels.
        print({
        g <- ggplot(plotdata, aes(year, emissions))
        g + geom_point() +
                geom_smooth(method="lm", color = "black", se = FALSE) +
                facet_wrap( ~ type, ncol = 2) +
                labs(title = "Total Emissions Baltimore by Type",
                     x = "Year", y = "Total PM2.5 Emissions") +
                        theme_bw()
        })

        # turn off the device
        dev.off()
}