#check readme in order to download the data set

#once data set has been downloaded and unzipped
#set working directory
setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#drop columns not required for this plot
NEIdropped1 <- NEI[, -c(1, 2, 3, 5)]

#agreggate data based on year variable and calculate
#sum (total) for each year
sum_emissions <- aggregate(. ~ year, NEIdropped1, sum)

#prepares file where plot will be saved
png(filename = "plot1.png", width = 480, height = 480, units = "px",
    bg = "white")

#create barplot. Divide emissions by 1000 and get kilotons.
barplot(sum_emissions$Emissions/1000, names.arg = sum_emissions$year,
        main = "Total emissions from 1999 to 2008",
        ylab="emissions in kilotons")
#save the file
dev.off()

#END

