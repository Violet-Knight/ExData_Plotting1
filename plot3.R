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
png(file="plot3.png", width=480, height=480)

plot(power$datetime,
     power$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

points(power$datetime,
       power$Sub_metering_2,
       type="l",
       col="red")

points(power$datetime,
       power$Sub_metering_3,
       type="l",
       col="blue")

legend("topright",
       lty=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()