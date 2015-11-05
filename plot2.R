# plot2.R
# Christopher Curley
# Exploratory Data Analysis (exdata-34)
# 2015-Nov-04
#
# I tried to set the as.Date on the read.table, which worked like gangbusters with Date but didn't work at
# all with Time. Then, I wasted a lot of time with lubridate parse_date_time writing the content back into
# the dataframe. Finally, I found stackoverflow using paste to format the date and time together, and to 
# hell with writing it back into the DF.

plot2 <- function(){
        
        # Data file is the output of getHPCData() sourced in plot1.R
        HPCData <- read.table("./HPCData.csv", header = TRUE, sep=";", stringsAsFactors = FALSE)
        
        # And... now we are going to have to muck around with time and date. Converting on the read.table
        # got the DATE correct but botched the SECONDS for reasons I still don't quite get. Stackoverflow 
        # points to as.Date:
        # (http://stackoverflow.com/questions/6876764/r-strptime-year-and-month-with-no-delimiter-returning-na)
        # but the hint in the assignment to use strptime worked. No reason to put it back in the DF.
        dateTime <- strptime(
                paste(HPCData$Date, HPCData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

        par(mar = c(6,6,6,6))
        par(mfrow = c(1,1))        
        png("plot2.png", width=504, height=504)
        plot(dateTime, HPCData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.off()
        
}