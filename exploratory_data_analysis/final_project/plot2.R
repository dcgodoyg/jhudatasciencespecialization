#download .zip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              temp)
#unzip file and create folder in working directory
unzip("exdata-data-NEI_data.zip", exdir="exdata-data-NEI_data")
#set working directory
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City,
#from 1999 to 2008?

NEIBaltimore <- subset(NEI, fips == "24510")

#drop columns not required for this plot
NEIdropped <- NEIBaltimore[, -c(1, 2, 3, 5)]

#agreggate data based on year variable and calculate
#sum (total) for each year
sum_emissions <- aggregate(. ~ year, NEIdropped, sum)

#prepares file where plot will be saved
png(filename = "plot2.png", width = 560, height = 480, units = "px",
    bg = "white")

#create barplot. Divide emissions by 1000 and get kilotons.
barplot(sum_emissions$Emissions/1000, names.arg = sum_emissions$year,
        main = "Total emissions from 1999 to 2008 in Baltimore",
        ylab="emissions in kilotons")
#save the file
dev.off()

#END