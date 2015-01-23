#ATTENTION: the file must be already in your working directory

#Open libraries required during the script's execution. 
#If not already installed, install packages.
library(dplyr)
library(lubridate)

#load the database
data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE) 

#converts Date variable into a date format variable using lubridate
#and assign new format "yyyy-mm-dd"
data$Date <- as.Date(parse_date_time(data$Date, "dmy"))

#susbet database based on dates used in analysis (using new format)
data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

#create new variable merging Date and Time
data <- mutate(data, complete_date = paste(Date, Time, sep = " "))

#new variable is set as date. format "yyy-mm-dd hh:mm:ss"
data$complete_date <- parse_date_time(data$complete_date, "ymd_hms")

#plot 3

#prepares the file where will be saved
png(filename = "plot3.png", width = 480, height = 480, units = "px",
    bg = "transparent")

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
