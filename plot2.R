getHPCData <- function()  {
        
        # see plot1.R or readme.md for code annotation
        wk_files <- list.files()
        chk_dir  <- "household_power_consumption.txt"
        
        if (!chk_dir %in% wk_files) {
                tmp_file <- tempfile()
                dest_dir <- getwd()
                dl_file  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(dl_file, tmp_file, mode = "wb")
                my_file <- unzip(tmp_file, exdir = dest_dir)
        } else {
                print("You already downloaded the file, dummy. Try running the plot2(), instead.")
        } 
}

plot2 <- function(){
        
        # see plot1.R or readme.md for code annotation.
        dateStr = "31/1/2007;23:59:00"
        daysNum = 2880 
        fileName <- "./household_power_consumption.txt"
        
        HPCData <- read.table(fileName, 
                              sep =";",
                              header = FALSE,
                              stringsAsFactors = FALSE,
                              dec = ".",
                              skip=grep(dateStr, readLines(fileName)),
                              nrows=daysNum)
        
        HPCColNames <- read.table("./household_power_consumption.txt", sep =";", header=TRUE,nrows=1)
        names(HPCData) <- names(HPCColNames)
        
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