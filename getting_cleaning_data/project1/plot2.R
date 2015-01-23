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

#plot 2

#prepares the file where will be saved
png(filename = "plot2.png", width = 480, height = 480, units = "px",
    bg = "transparent")

plot(data$complete_date, data$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#save the file
dev.off()
