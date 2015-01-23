#check readme in order to download the data set

#once data set has been downloaded and unzipped
#set working directory
setwd("exdata-data-NEI_data")
#load data used in this script
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal
#combustion-related sources changed from 1999–2008?

#drop columns not required for this plot
NEIdropped <- NEI[, -c(1, 3, 5)]

#find combustion and coal related data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_combustion <- (combustion & coal)

#subset based on (logic) data
combustionSCC <- SCC[coal_combustion, ]$SCC
combustionNEI <- NEIdropped[NEIdropped$SCC %in% combustionSCC, ]

#prepares file where plot will be saved
png(filename = "plot4.png", width = 560, height = 480, units = "px",
    bg = "white")

#create barplot using ggplot
library(ggplot2)
ggplot(combustionNEI, aes(x=factor(year), y=Emissions/1000)) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab("Total emissions in kilotons") + 
        ggtitle("Coal Combustion Emissions Across US from 1999 to 2008")

#save the file
dev.off()

#END