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

png(filename = "plot1.png", width = 480, height = 480)
with(smallData, hist(Global_active_power, main = "Global Active Power", 
                     xlab = "Global Active Power (kilowatts)", 
                     ylab = "Frequency", col = "red"))
dev.off()

rm(classes, data, temp, smallData)