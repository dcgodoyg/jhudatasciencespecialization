setwd("exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal combustion-related
#sources changed from 1999–2008?

#drop columns not required for this plot
NEIdropped <- NEI[, -c(3, 5)]

motorvehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
motorvehiclesSCC <- SCC[motorvehicles, ]$SCC
motorvehiclesNEI <- NEIdropped[NEIdropped$SCC %in% motorvehiclesSCC, ]

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