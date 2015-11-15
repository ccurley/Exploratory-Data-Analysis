# ccurley
# Coursera - Exploratory Data Analysis - Assignment 2, Plot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

# for the final plot, we'll use lattice, since we've used base and ggplot up to this point.
# And, since it's getting late and this is the 6th plot, we'll make it as simple as we can.

plot6 <- function(){

        library(lattice)
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
        subNEI <- filter(NEI, fips == "24510" | 
                              fips == "06037")
        
        # a less painful merge
        plotdata <- merge(subNEI, plotdata, by = "SCC")
        
        plotdata <- plotdata %>%
                group_by(year, fips) %>%
                summarize(emissions = sum(Emissions))
        
        # I can't remember if I use 'mutate' or 'transform' here, and it being the 6th plot, I'm getting
        # tired, so I'll sin with highly unreadable code... 
        # Basically, now that we've got a plot set, find the code in fips, and replace it with the city name
        plotdata[plotdata$fips == "06037", ][, "fips"] <- "Los Angeles County"
        plotdata[plotdata$fips == "24510", ][, "fips"] <- "Baltimore City"
        
        # call the output device
        png("plot6.png", width=480, height=480)

        # we'll just make a simple lattice plot comparring Baltimre to Los Angeles County
        print ({
        xyplot(emissions ~ year | fips, data = plotdata, layout = c(2,1), panel = function(x, y, ...) {
                panel.xyplot(x, y, ...)
                panel.lmline(x, y, col = 2)
                })
        })
 
# close the output device               
dev.off()
}