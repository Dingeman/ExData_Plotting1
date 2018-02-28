library(dplyr)

## read complete dataset
energy <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

## subset data from 2007-02-01 and 2007-02-02
energy_feb <- subset(energy, Date=="1/2/2007" | Date=="2/2/2007")

## create Timestamp, combining Date and Time column 
energy_feb <- mutate(energy_feb, Timestamp = paste(energy_feb$Date, energy_feb$Time, sep = "-"))
energy_feb$Timestamp <- strptime(energy_feb$Timestamp, "%d/%m/%Y-%H:%M:%S")

## convert measurements
energy_feb$Global_active_power <- as.numeric(as.character(energy_feb$Global_active_power))

## create requested plot
png(filename = "plot2.png", width = 480, height = 480)
plot(energy_feb$Timestamp, energy_feb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
