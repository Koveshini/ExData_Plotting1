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

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

## Plot 1 
plot(x = data$Datetime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Plot 2
plot(x = data$Datetime, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Plot 3
with(data, {
    plot(x = data$Datetime, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
    lines(x = data$Datetime, y = data$Sub_metering_2, type = "l", col = "red")
    lines(x = data$Datetime, y = data$Sub_metering_3, type = "l", col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", cex = .5, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 4
plot(x = data$Datetime, y = data$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
