# ccurley
# Coursera - Exploratory Data Analysis - Assignment 2, Question 5

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
# 
# I've kept to the same format as plot4 since it's easy, and kept away from labels on the 
# stacked bar for the same reason. I changed the color palette to see what other options there
# are.


plot5 <- function(){
        library(scales)
        library(grid)
        library(ggplot2)
        library(plyr)
        library(dplyr)
        
        # Read in the data. This plot needs SCC and NEI.
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        # Yes -- grepl on the regex "^Mobile.*Vehicles" would work, too. I find this more readable 
        # and I find regex expressions make as much sense as hieroglypics.
        plotdata <- filter(SCC,    EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" |
                                   EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")
        
        # cut NEI down to just the Baltimore. You could so this step after the merge, but doing it 
        # first cuts a lot of time off the merge operation
        subNEI <- filter(NEI, fips == "24510")
        
        # a less painful merge
        plotdata <- merge(subNEI, plotdata, by = "SCC")
        
        plotdata <- plotdata %>%
                group_by(year, EI.Sector) %>%
                summarize(emissions = sum(Emissions))
        
        # set year as char, so that I don't get rounded numbers in the x axis
        plotdata$year <- as.character(plotdata$year)
        
        png("plot5.png", width = 480, height = 480)
        
        print({
                g <- ggplot(plotdata, aes(year, emissions, fill = EI.Sector))
                g + geom_bar(stat = "identity", color = "white") +
                        scale_fill_brewer(palette = "Spectral") +
                        labs(title = "Emissions from Vehicles, 1999–2008",
                             x = "Year", y = "Total PM2.5 Emissions") +
                        scale_y_continuous(labels = comma) +
                        theme_bw() +
                        theme(plot.title = element_text(hjust = 0))
        })
        
        dev.off()
}