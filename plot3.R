library("data.table")

## Reading the data 
dataFull <- data.table::fread(input = "household_power_consumption.txt", na.strings = "?")

## Subsetting the data
dataFull$Date <- as.Date(dataFull$Date, format = "%d/%m/%Y")
data <- subset(dataFull, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataFull)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 3
with(data, {
  plot(x = data$Datetime, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
  lines(x = data$Datetime, y = data$Sub_metering_2, type = "l", col = "red")
  lines(x = data$Datetime, y = data$Sub_metering_3, type = "l", col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
