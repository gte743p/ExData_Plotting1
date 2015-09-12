## Note that this script assumes the source file 
## "household_power_consumption.txt" is in the current working directory

library("data.table")
library("dplyr")

temp <- read.table(file = "household_power_consumption.txt", header = TRUE, 
                   sep = ";", nrows = 5)
classes <- sapply(temp, class)

data <- read.table(file = "household_power_consumption.txt", header = TRUE,
                   sep = ";", nrows = 2075259, colClasses = classes, 
                   na.strings = "?")

## we only want data for 2007-02-01 and 2007-02-02
## date format is in "dd/mm/yyyy"
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

smallData <- data %>%
      filter(Date %in% as.Date(c("2007-02-01", "2007-02-02")))

smallData$DateTime <- paste(smallData$Date, smallData$Time)
smallData$DateTime <- strptime(smallData$DateTime, 
                               format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)
with(smallData, plot(DateTime, Global_active_power, 
                     type = "n", xlab = "",
                     ylab = "Global Active Power (kilowatts)"))
with(smallData, lines(DateTime, Global_active_power, type = "l"))
dev.off()

rm(classes, data, temp, smallData)