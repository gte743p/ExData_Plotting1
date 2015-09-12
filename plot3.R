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

png(filename = "plot3.png", width = 480, height = 480)
with(smallData, plot(DateTime, Sub_metering_1, 
                     type = "n", xlab = "",
                     ylab = "Energy sub metering"))
with(smallData, lines(DateTime, Sub_metering_1, type = "l", col = "black"))
with(smallData, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(smallData, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), 
       lwd = c(1, 1, 1), col = c("black", "red", "blue"))

dev.off()

rm(classes, data, temp, smallData)
