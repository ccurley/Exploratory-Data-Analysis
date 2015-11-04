getHPCData <- function()  {
        
        # https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
        
        # If the Household Power Consumption Text is not inthe working directory, get it. Used for plot
        # one, dropped for subsequent plots.
        wk_files <- list.files()
        chk_dir  <- "household_power_consumption.txt"
        
        if (!chk_dir %in% wk_files) {
                
                # create place to put a temp file after download, a location to unzip the temp file
                # and the location of the remote file for download
                tmp_file <- tempfile()
                dest_dir <- getwd()
                dl_file  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                
                # now, download the tempfile and stick it in the temp dir, and specify a binary download
                download.file(dl_file, tmp_file, mode = "wb")
                
                # finally, unzip the file from the temp location to the 
                my_file <- unzip(tmp_file, exdir = dest_dir)
        } else {
                print("You already downloaded the file, dummy. Try running the plot1(), instead.")
        } # end if/else
}
        
plot1 <- function() {      

        # see the var
        dateStr = "31/1/2007;23:59:00"                   # mark the skip line file read start
        daysNum = 2880                                   # the num of seconds in two days
        fileName <- "./household_power_consumption.txt"  # the name of the source file
                
        # From a starting point, read just the data we're going to work with into the data frame.
        # No mucking about with time and data here, so don't bother with it.
        # Debug with head(HPCData, n = 1) for 1/2/2007 00:00:00 and tail(HPCData, n = 1) for
        # 2/2/2007 23:59:00
        HPCData <- read.table(fileName, 
                              sep =";",
                              header = FALSE,
                              stringsAsFactors = FALSE,
                              dec = ".",
                              skip=grep(dateStr, readLines(fileName)),
                              nrows=daysNum)
        
        # we're going to need column names
        HPCColNames <- read.table("./household_power_consumption.txt", sep =";", header=TRUE,nrows=1)
        names(HPCData) <- names(HPCColNames)
        
        # Create the png device handle, write the content, then close the device. Comment png and dev.off to debug
        # Set the par values to be sure, since I might have changed them with other pltos
        par(mar = c(6,6,6,6))
        par(mfrow = c(1,1))
        png("plot1.png", width=504, height=504)
        hist(HPCData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
        dev.off()
}