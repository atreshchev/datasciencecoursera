## DS_C4_W4_assign
## Exploratory analysis of PM2.5 (fine particulate matter) emissions  
## Environmental Protection Agency (EPA) - National Emissions Inventory (NEI) Data: 
## http://www.epa.gov/ttn/chief/eiinformation.html

data_path <- "data/exdata-data-NEI_data/"

NEI <- readRDS(paste(data_path, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(data_path, "Source_Classification_Code.rds", sep = ""))

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#    Using the base plotting system, make a plot showing the total PM2.5 emission 
#     from all sources for each of the years 1999, 2002, 2005, and 2008.
library(plyr)
PM <- ddply(NEI, .(year), summarize, sum = sum(Emissions))
plot(PM$year, PM$sum, type = "b", pch = 19,
     xlab = "Year", ylab = "PM2.5 emission, tons", 
     main = "US PM2.5 in 1999-2008", xaxt = "n") # draw without x-axis labels (because of xaxt="n")
  axis(side = 1, at = PM$year, labels = PM$year) # draw only specified labels in specified ('at') points

dev.copy(png, file = "plot1.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()


# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#     from 1999 to 2008? Use the base plotting system to make a plot answering this question.
library(plyr)
PM <- ddply(NEI[NEI$fips == "24510", ], .(year), summarize, sum = sum(Emissions))
plot(PM$year, PM$sum, type = "b", pch = 19,
     xlab = "Year", ylab = "PM2.5 emission", 
     main = "Baltimore PM2.5 in 1999-2008", xaxt = "n")
  axis(side = 1, at = PM$year, labels = PM$year)

dev.copy(png, file = "plot2.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()


# 3. Of the four types of sources indicated by the 'type' (point, nonpoint, on-road, non-road) variable,
#     which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#    Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system
#     to make a plot answer this question.
NEI <- transform(NEI, type = factor(type))
PM <- ddply(NEI[NEI$fips == "24510", ], .(year, type), summarize, sum = sum(Emissions)) # apply for combination of factors 

# 3.1.1
plot(PM$year, PM$sum, pch = 19,
     xlab = "Year", ylab = "PM2.5 emission, tons", 
     main = "Baltimore PM2.5 in 1999-2008 by type", xaxt = "n", col = PM$type)
  axis(side = 1, at = PM$year, labels = PM$year)
  legend("topright", col = unique(PM$type), legend = unique(PM$type), pch = 19)

# 3.1.2
plot(PM$year[PM$type == "POINT"], PM$sum[PM$type == "POINT"], type="b", pch = 19,
     xlim = range(PM$year), ylim = range(PM$sum),
     xlab = "Year", ylab = "PM2.5 emission, tons", 
     main = "Baltimore PM2.5 in 1999-2008 by type", xaxt = "n")
  lines(PM$year[PM$type == "NONPOINT"], PM$sum[PM$type == "NONPOINT"], type="b", col = 2, pch = 19)
  lines(PM$year[PM$type == "ON-ROAD"], PM$sum[PM$type == "ON-ROAD"], type="b", col = 3, pch = 19)
  lines(PM$year[PM$type == "NON-ROAD"], PM$sum[PM$type == "NON-ROAD"], type="b", col = 4, pch = 19)
  axis(side = 1, at = PM$year, labels = PM$year)
  legend("topright", col = unique(PM$type), legend = unique(PM$type), pch = 19)

# 3.2.1
library(ggplot2)
qplot(year, sum, data = PM, colour = type) + geom_line() + geom_point() +
  labs(list(title = "Baltimore PM2.5 in 1999-2008 by type", x = "Year", y = "PM2.5 emission, tons", color = "Type")) +
  theme(plot.title = element_text(size = 14, face = "bold"))

# 3.2.2 (slightly more fast)
library(ggplot2)
ggplot(PM, aes(year, sum, colour = type)) + geom_line() + geom_point() +
  labs(list(title = "Baltimore PM2.5 in 1999-2008 by type", x = "Year", y = "PM2.5 emission, tons", color = "Type")) +
  theme_minimal() + theme(plot.title = element_text(size = 14, face = "bold"))

dev.copy(png, file = "plot3.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()


# 4. Across the United States, how have emissions from coal combustion-related sources changed
#     from 1999–2008?
IndexesCombCoal <- grep("( coal.* comb)|( comb.* coal)", tolower(SCC$Short.Name)) # search 2 words in any order
SCCcoal <- SCC[IndexesCombCoal, ]$SCC
PM <- ddply(NEI[NEI$SCC %in% SCCcoal, ], .(year), summarize, sum = sum(Emissions))
plot(PM$year, PM$sum, pch = 19, type = "b",
     xlab = "Year", ylab = "PM2.5 emission, tons", 
     main = "US PM2.5 from Coal Comb in 1999-2008", xaxt = "n")
  axis(side = 1, at = PM$year, labels = PM$year)

dev.copy(png, file = "plot4.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()


# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
IndexesMotorVehicle <- grep("motor", tolower(SCC$Short.Name)) # search 2 words in any order
SCCMotorVehicle <- SCC[IndexesMotorVehicle, ]$SCC
PM <- ddply(NEI[NEI$SCC %in% SCCMotorVehicle & NEI$fips == "24510", ], .(year), summarize, sum = sum(Emissions))
plot(PM$year, PM$sum, pch = 19, type = "b",
     xlab = "Year", ylab = "PM2.5 emission, tons", 
     main = "Baltimore PM2.5 from motor vehicles in 1999-2008", xaxt = "n")
  axis(side = 1, at = PM$year, labels = PM$year) 

dev.copy(png, file = "plot5.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()


# 6. Compare emissions from motor vehicle sources in Baltimore City 
#     with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
#    Which city has seen greater changes over time in motor vehicle emissions?
IndexesMotorVehicle <- grep("motor", tolower(SCC$Short.Name)) # search 2 words in any order
SCCMotorVehicle <- SCC[IndexesMotorVehicle, ]$SCC
PM_Balt <- ddply(NEI[NEI$SCC %in% SCCMotorVehicle & NEI$fips == "24510", ], .(year), summarize, sum = sum(Emissions))
PMB_LA <- ddply(NEI[NEI$SCC %in% SCCMotorVehicle & NEI$fips == "06037", ], .(year), summarize, sum = sum(Emissions))
plot(PM_Balt$year, PM_Balt$sum, pch = 19, type = "b",
     ylim = range(c(PM_Balt$sum, PMB_LA$sum)),
     xlab = "Year", ylab = "PM2.5 emission, tons", 
     main = "Baltimore & Los Angeles PM2.5\nfrom motor vehicles in 1999-2008", xaxt = "n")
  lines(PMB_LA$year, PMB_LA$sum, pch = 19, type = "b", col = 2)
  axis(side = 1, at = PM_Balt$year, labels = PM_Balt$year)
  legend("right", col = c(1, 2), legend = c("Baltimore", "Los Angeles"), pch = 19)

dev.copy(png, file = "plot6.png", width=600, height=480) # copy plot to .png from the active device (with specified size)
dev.off()