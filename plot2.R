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

##Plot 2
plot(x = data$Datetime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
