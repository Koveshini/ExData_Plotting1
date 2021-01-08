library("data.table")

## Reading data 
data <- data.table::fread(input = "household_power_consumption.txt", na.strings = "?")

##Subsetting data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subdata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

## Plot 1
hist(as.numeric(as.character(subdata$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
