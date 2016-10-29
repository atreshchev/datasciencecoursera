## DS_C4_W1_assign
## Making Plots of Electric power consumption's data set
## UC Irvine Machine Learning Repository of Data: http://archive.ics.uci.edu/ml/

data_path <- "./data/household_power_consumption.txt"


# 1. Initial data analysis
initial <- read.table(data_path, nrows = 6, sep = ";", header = TRUE)
head(initial)
dataclasses <- sapply(initial, class)


# 2. Reading data rows corresponding to 2007-02-01 - 2007-02-02 period
library(lubridate)
initdate <- dmy_hms(paste(initial$Date[1], initial$Time[1])) # get Date & Time from first row of data
startdate <- dmy_hm("01/02/2007 00:00")
stopdate <- dmy_hm("02/02/2007 23:59")

startrow <- as.numeric(difftime(startdate, initdate, units = "mins")) # get searched row difference as time difference
stoprow <- as.numeric(difftime(stopdate, initdate, units = "mins"))

data <- read.table(data_path, skip = (startrow + 1), nrows = (stoprow + 1 - startrow),
                   sep = ";", na = "?", header = FALSE, col.names = colnames(initial),
                   colClasses = dataclasses) # read desired rows only
head(data)
tail(data)


# 3.Drawing plots
# 3.1 Plot1 - Hist (GAP)
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")


# 3.2 Plot2 - Plot (GAP per day dynamics)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

library(lubridate)
fulldate <- dmy_hms(paste(data$Date, data$Time))
plot(fulldate, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

Sys.setlocale("LC_TIME", "ru_RU.UTF-8")


# 3.3 Plot3 - Plot (Sub metering 1/2/3 per day dynamics)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

library(lubridate)
fulldate <- dmy_hms(paste(data$Date, data$Time))
with(data, {
  plot(fulldate, Sub_metering_1, type = "l", col = "black",
       xlab = "", ylab = "Energy sub metering")
  points(fulldate, Sub_metering_2, type = "l", col = "red")
  points(fulldate, Sub_metering_3, type = "l", col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lwd = 1,
       legend = colnames(data)[7:9])

Sys.setlocale("LC_TIME", "ru_RU.UTF-8")


# 3.4 Plot4 - Multiple drawings
Sys.setlocale("LC_TIME", "en_US.UTF-8")

png(filename = "Plot4.png", height = 480, width = 600)
par(mfrow = c(2, 2),  mar = c(4, 4, 1, 2), oma = c(0, 0, 0, 0))
library(lubridate)
fulldate <- dmy_hms(paste(data$Date, data$Time))

with(data, {
  plot(fulldate, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
  plot(fulldate, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(fulldate, Sub_metering_1, type = "l", col = "black",
       xlab = "", ylab = "Energy sub metering")
  points(fulldate, Sub_metering_2, type = "l", col = "red")
  points(fulldate, Sub_metering_3, type = "l", col = "blue")
  legend("topright", col = c("black", "red", "blue"), bty = "n", lwd = 1,
         legend = colnames(data)[7:9])
  
  plot(fulldate, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()

Sys.setlocale("LC_TIME", "ru_RU.UTF-8")


# 4. Writing plots as PNG
dev.copy(png, file = "Plot4.png", width=600, height=480) # this approach use specified size
dev.off()
