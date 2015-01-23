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

#subset data based on city
#Baltimore
motorbaltimoreNEI <- subset(motorvehiclesNEI, fips == "24510")
motorbaltimoreNEI <- cbind(motorbaltimoreNEI, city = "Baltimore")
#Los Angeles
motorlaNEI <- subset(motorvehiclesNEI, fips == "06037")
motorlaNEI <- cbind(motorlaNEI, city = "Los Angeles")

#create one database binding rows
finalbaseNEI <- rbind(motorbaltimoreNEI, motorlaNEI)
head(finalbaseNEI)

#prepares file where plot will be saved
png(filename = "plot6.png", width = 480, height = 480, units = "px",
    bg = "white")

#create barplot using ggplot and divide type by facets (panels)

ggplot(finalbaseNEI, aes(factor(year), Emissions)) +
        geom_bar(stat="identity") +
        facet_grid(. ~ city) +
        xlab("year") + 
        ggtitle("Motor Vehicle Emissions in Baltimore and LA from 1999 to 2008")

#save the file
dev.off()





