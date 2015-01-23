#check readme in order to download the data set

#once data set has been downloaded and unzipped
#set working directory
setwd("exdata-data-NEI_data")
#load data used in this script
NEI <- readRDS("summarySCC_PM25.rds")

#Have total emissions from PM2.5 decreased in the United States
#from 1999 to 2008? Using the base plotting system, make a plot
#showing the total PM2.5 emission from all sources for each of
#the years 1999, 2002, 2005, and 2008.

#subset Baltimore data
NEIBaltimore <- subset(NEI, fips == "24510")

#drop columns not required for this plot
NEIdropped <- NEIBaltimore[, -c(1, 2, 3)]

#aggregate data by year and calculate sums of emissions
sum_emissions <- aggregate(. ~ year + type, NEIdropped, sum)

#prepares file where plot will be saved
png(filename = "plot3.png", width = 480, height = 480, units = "px",
    bg = "white")

#create barplot using ggplot and use facets (panels) by type
ggplot(sum_emissions, aes(x=factor(year), y=Emissions)) +
        geom_bar(stat="identity") +
        facet_grid(. ~ type) +
        xlab("Year") +
        ggtitle("Total emissions from 1999 to 2008 in Baltimore by source type")

#save the file
dev.off()

#END