# plot4.R
# Christopher Curley
# Exploratory Data Analysis (exdata-34)
# 2015-Nov-04
#
# See plot1.R for annotation on the read.table and plot2.R for annotation on the dateTime formatting. 
#
# The only change in plot4 is settin mfrow to c(2,2)
# 
# ... that and I spent way too much time debugging plots that didn't come out right because I was using 
# the wrong column names.

plot4 <- function(){
        
        # Data file is the output of getHPCData() sourced in plot1.R
        HPCData <- read.table("./HPCData.csv", header = TRUE, sep=";", stringsAsFactors = FALSE)
        
        # See plot2.R or readme.md for code annotation on the BLOODY TIME AND DATE syntax
        dateTime <- strptime(
                paste(HPCData$Date, HPCData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

        png("plot4.png", width=504, height=504)
        par(mar = c(4,4,4,4))  # let's give ourselves a little more margins
        par(mfrow = c(2,2))    # two by two
        
        # Top left - Global Active Power
        plot(dateTime, HPCData$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
        
        # Top right - Voltage -- with a capital "V", you idiot! Not voltage
        plot(dateTime, HPCData$Voltage, type="l", xlab="dateTime", ylab="Voltage")
        
        # Bottom left - Submetering (see also code3.R)
        plot(dateTime, HPCData$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
        lines(dateTime, HPCData$Sub_metering_3, type="l", col="red")
        lines(dateTime, HPCData$Sub_metering_3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
        
        # Bottom right - Global --- REACTIVE --- power, you idiot! Not Active.
        plot(dateTime, HPCData$Global_reactive_power, type="l", xlab="dateTime", ylab="Global_reactive_power")
        dev.off()
        
}