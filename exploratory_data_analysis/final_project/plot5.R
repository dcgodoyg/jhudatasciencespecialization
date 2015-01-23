#check readme in order to download the data set

#once data set has been downloaded and unzipped
#set working directory
setwd("exdata-data-NEI_data")
#load data used in this script
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed
#from 1999–2008 in Baltimore City?

#drop columns not required for this plot
NEIdropped <- NEI[, -c(3, 5)]

#find vehicles related data
motorvehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
motorvehiclesSCC <- SCC[motorvehicles, ]$SCC
#subset based on (logic) data
motorvehiclesNEI <- NEIdropped[NEIdropped$SCC %in% motorvehiclesSCC, ]

#subset data set so it only includes Baltimore info
motorbaltimoreNEI <- subset(motorvehiclesNEI, fips == "24510")

#prepares file where plot will be saved
png(filename = "plot5.png", width = 480, height = 480, units = "px",
    bg = "white")

#create barplot using ggplot and divide type by facets (panels)
ggplot(motorbaltimoreNEI, aes(factor(year), Emissions)) +
        geom_bar(stat="identity") +
        xlab("year") + 
        ggtitle("Motor Vehicle Emissions in Baltimore from 1999 to 2008")

#save the file
dev.off()