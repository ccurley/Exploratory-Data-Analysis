# plot3.R
# Christopher Curley
# Exploratory Data Analysis (exdata-34)
# 2015-Nov-04
#
# See plot1.R for annotation on the read.table and plot2.R for annotation on the dateTime formatting.
# Plot3 just layers on additional data series and a legend.

plot3 <- function(){
        
        # Data file is the output of getHPCData() sourced in plot1.R
        HPCData <- read.table("./HPCData.csv", header = TRUE, sep=";", stringsAsFactors = FALSE)
        
        # See plot2.R or readme.md for code annotation on the BLOODY TIME AND DATE syntax
        dateTime <- strptime(
                paste(HPCData$Date, HPCData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

        par(mar = c(6,6,6,6))
        par(mfrow = c(1,1))
        
        # This one is just a bit of mucking about with layering on the additional lines over the plots to 
        # make it look like the sample.
        png("plot3.png", width=504, height=504)
        plot(dateTime, HPCData$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
        lines(dateTime, HPCData$Sub_metering_2, type="l", col="red")
        lines(dateTime, HPCData$Sub_metering_3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
        dev.off()
        
}