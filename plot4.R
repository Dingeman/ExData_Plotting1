library(dplyr)

## read complete dataset
energy <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## subset data from 2007-02-01 and 2007-02-02
energy_feb <- subset(energy, Date=="1/2/2007" | Date=="2/2/2007")

## create Timestamp, combining Date and Time column 
energy_feb <- mutate(energy_feb, Timestamp = paste(energy_feb$Date, energy_feb$Time, sep = "-"))
energy_feb$Timestamp <- strptime(energy_feb$Timestamp, "%d/%m/%Y-%H:%M:%S")

## convert measurements into numeric
energy_feb$Global_active_power <- as.numeric(as.character(energy_feb$Global_active_power))
energy_feb$Global_reactive_power <- as.numeric(as.character(energy_feb$Global_reactive_power))
energy_feb$Voltage <- as.numeric(as.character(energy_feb$Voltage))
energy_feb$Sub_metering_1 <- as.numeric(as.character(energy_feb$Sub_metering_1))
energy_feb$Sub_metering_2 <- as.numeric(as.character(energy_feb$Sub_metering_2))
energy_feb$Sub_metering_3 <- as.numeric(as.character(energy_feb$Sub_metering_3))

## open png device and setup multiplot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

## create first plot
plot(energy_feb$Timestamp, energy_feb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## create second plot
plot(energy_feb$Timestamp, energy_feb$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## create third plot
plot(energy_feb$Timestamp, energy_feb$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(energy_feb$Timestamp, energy_feb$Sub_metering_2, col = "red")
lines(energy_feb$Timestamp, energy_feb$Sub_metering_3, col = "blue")
legend("topright", bty = "n", pch = "_", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## create fourth plot
plot(energy_feb$Timestamp, energy_feb$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()
