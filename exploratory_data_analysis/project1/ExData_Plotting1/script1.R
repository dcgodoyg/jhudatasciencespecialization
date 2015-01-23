#ATTENTION: the file must be already in your working directory

#Open libraries required during the script's execution
library(dplyr)
library(lubridate)

#load the database
data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE) 

#converts Date variable into a date format variable using lubridate
data$Date <- as.Date(parse_date_time(data$Date, "dmy"))

#susbet database based on dates used in analysis
data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

#create new variable merging Date and Time
data <- mutate(data, complete_date = paste(Date, Time, sep = " "))

#new variable is set as date
data$complete_date <- parse_date_time(data$complete_date, "ymd_hms")

#plot 1

#prepares the file where will be saved
png(filename = "plot1.png", width = 353, height = 353, units = "px")

#create histogram, set title, set title for x axis, set color
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")

#save the file
dev.off()

#plot 2

#prepares the file where will be saved
png(filename = "plot2.png", width = 353, height = 353, units = "px")

plot(data$complete_date, data$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#save the file
dev.off()

#plot 3

#prepares the file where will be saved
png(filename = "plot3.png", width = 353, height = 353, units = "px")

x1 <- data$complete_date
y1 <- as.numeric(data$Sub_metering_1)
y2 <- data$Sub_metering_2
y3 <- data$Sub_metering_3
plot(x = x1, y = y1, type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     legend = TRUE)
lines(x1, y2, col = "red")
lines(x1, y3, col = "blue")
legend("topright", lty = 1 , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       )

#save the file
dev.off()

#plot4

#prepares the file where will be saved
png(filename = "plot4.png", width = 504, height = 504, units = "px")

par(mfrow = c(2, 2))
        #plot 1,1
        
        plot(data$complete_date, data$Global_active_power, type = "l",
             xlab = "",
             ylab = "Global Active Power (kilowatts)")
        
        #plot 2,1
        
        plot(data$complete_date, data$Voltage, type = "l",
             xlab = "datetime",
             ylab = "Voltage")
        
        #plot 1,2
        
        plot(x = x1, y = y1, type = "l",
             xlab = "",
             ylab = "Energy sub metering",
             legend = TRUE)
        lines(x1, y2, col = "red")
        lines(x1, y3, col = "blue")
        legend("topright", lty = 1 , col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               bty = "n"
        )
        
        #plot 2,2
        
        plot(data$complete_date, data$Global_reactive_power, type = "l",
             xlab = "datetime",
             ylab = "Global_reactive_power")
        
#save the file
dev.off()

     







