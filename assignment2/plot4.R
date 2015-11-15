# ccurley
# Coursera - Exploratory Data Analysis. Plot 4 question
# 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#
# This function will filter out the combusttion related SCC rows, then merge that data into the NEI data set
# to get the emissions data. The subsetted data is grouped by year and EI.sector -- which is used to build a
# stacked bar chart.
#
# the scales and grid libaries are needed to for formatting the themes in the ggplot. 

plot4 <- function(){

        library(scales)
        library(grid)
        library(ggplot2)
        library(plyr)
        library(dplyr)
        
        # Read in the data. This plot needs SCC and NEI.
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        
        # Get the subset from SCC. Yes, I could have used SCC[grepl("^Fuel Comb.*Coal", SCC$EI.Sector),] to get the
        # subset, but regular expressions make unreadable code. Yes, it's possible that the EI.Sectors will change tp
        # add another ^Fuel Comb.*Coal sector, but I'm going to be that's a rare event that would be updated in the
        # a codebook and easily fixed in the statement below.
        plotdata <- filter(SCC, EI.Sector == "Fuel Comb - Electric Generation - Coal" |
                              EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal" |
                              EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
        
        # merge the subset
        plotdata <- merge(NEI, plotdata, by = "SCC")
        
        # get the total by year - group by year and EI.Sector, so I can build a stacked bar
        plotdata <- plotdata %>% 
                group_by(year, EI.Sector) %>%
                summarize(emissions = sum(Emissions)) 
        
        # set year as char, so that I don't get rounded numbers in the x axis
        plotdata$year <- as.character(plotdata$year)
        
        # create a stacked bar plot. separate the layers with a white line. use the pastel1 color
        # scheme. add titles and bump the main title a little to the right. don't print the gray
        # background.
        #
        # Note: I've removed the data labels -- there was no practiacl want to set the ypos values for the
        # the label in a way that would be readable for 1999 and 2008. The choice was to either ungroup
        # the plotdata or go without labels. Leaving the data grouped conveys more data about the fuel
        # comb for coal, so I went with that.
        # To get the yvals and the ypos, you just need to transform the data set first with cumsum for 
        # emissions and then another transform for the ylabs formatted and rounded from the cumsum of
        # emissions (see also http://stackoverflow.com/questions/30656846/draw-the-sum-value-above-the
        # -stacked-bar-in-ggplot2)
        
        png("plot4.png", width = 480, height = 480)
        
        print({
        g <- ggplot(plotdata, aes(year, emissions, fill = EI.Sector))
        g + geom_bar(stat = "identity", color = "white") +
                scale_fill_brewer(palette = "Pastel1") +
                labs(title = "Emissions from Coal Combustion-related Sources, 1999–2008",
                     x = "Year", y = "Total PM2.5 Emissions") +
                scale_y_continuous(labels = comma) +
                theme_bw() +
                theme(plot.title = element_text(hjust = 0))
        })
        
        dev.off()
}