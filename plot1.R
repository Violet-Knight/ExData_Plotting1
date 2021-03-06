## Assumes text source is in working directory (original file too large for GitHub)

## Read in just the necessary dates
library(sqldf)
power <- read.csv.sql("household_power_consumption.txt", sep=";", 
                      sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

## Create date class column from Date and Time columns
datetime <- paste(power$Date, power$Time)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
power <- cbind(power, datetime)


## Create the png file and set it as the writing device
png(file="plot1.png", width=480, height=480)

hist(power$Global_active_power,
     col="Red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.off()