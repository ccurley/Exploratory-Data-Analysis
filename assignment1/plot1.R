# plot1.R
# Christopher Curley
# Exploratory Data Analysis (exdata-34)
# 2015-Nov-04
#
# The idea for the get HPCData was to open a connection to the remote table and just read the lines for the 
# two days used in the exercise, then write the table out. With the file zipped, it was more practical to 
# download the file and parse it to the two-day subset.
#
# I know it would be faster to 'filter' or '%in%' to subset the data, but I wanted to try the skip and nrows
# args on the read.table. The assignment instructions hinted at it, so I wanted to give it a go.
# 
# getHPCData takes two args, which are really just there for debugging. dateStr takes a sequence that would appear
# from the start of row containing unparsed values for date and time separated by a ";". A more elegant solution
# would take a the date you want to get, subject a day from it, convert it to chr and paste the seconds back on.
# Maybe in a future iteration. daysNum takes a numeric representing the number of days of data you are looking for.
# This is then multiplied by the number of seconds in day to define how many rows from the first line after skip the
# function should read in - e.g. each row of data contains observations in one second increments.
#
# Finally, I don't do any date conversion in the file parsing. It was more economical to do that in the plots that
# needed dateTime in the plots. See plots2:4 for dateTime parsing.
# 
# Once you have the subset of the data and the BLOODY dates sorted out, the plots are actually pretty easy to generate.

getHPCData <- function(dateStr = "31/1/2007;23:59:00", daysNum = 2)  {
        
        # https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
        # dateStr defines where the skip row stops. The line AFTER this input will be the first line
        # daysNum defines how many days of data after the skip line you want. It's based on the num-
        # ber of seconds in a day -- since there is one row per second of data collected.
        
        # seed the download check.
        wk_files <- list.files()
        chk_dir  <- "HPCData.csv"

        # don't waste time and bandwidth... only download the file remote file and parse the subset
        # if the HPCData.csv is not in the working directory. 
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
                
                # see the var
                # dateStr = "31/1/2007;23:59:00"                 # mark the skip line file read start
                daysNum  <- 1440 * daysNum                         # the num of seconds in two days
                fileName <- "./household_power_consumption.txt"  # the name of the source file
                
                # From a starting point, read just the data we're going to work with into the data frame.
                # No need for mucking about with time and date conversion here, so don't bother with it.
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
                
                # finally, write the subset file to the working directory. Plot1:4 will use this file for the 
                # src of data in the plots.
                write.table(HPCData, "./HPCData.csv", 
                            row.names=TRUE, 
                            col.names=TRUE, 
                            sep=";")
        } else {
                print("You already downloaded and parsed the file. Try running the plot1(), instead.")
        } # end if/else

} # end getDHCData function
        
plot1 <- function() {      
 
        # The getHPCData() function creates a subsetted data file for just the 1/1/2007 and 2/2/2007 
        HPCData <- read.table("./HPCData.csv", header = TRUE, sep=";", stringsAsFactors = FALSE)
        
        # Create the png device handle, write the content, then close the device. Comment png and dev.off to debug
        # Set the par values to be sure, since I might have changed them with other pltos
        par(mar = c(6,6,6,6))
        par(mfrow = c(1,1))
        png("plot1.png", width=504, height=504)
        hist(HPCData$Global_active_power, 
             col="red", 
             main="Global Active Power", 
             xlab="Global Active Power (kilowatts)")
        dev.off()
}