## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("C:/Users/shania/Documents/GitHub/exploratory_data_analysis-project2/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("C:/Users/shania/Documents/GitHub/exploratory_data_analysis-project2/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# 24510 is Baltimore, see plot2.R, 06037 is LA CA
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)
subNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subNEI, sum)
aggTotalByYearAndFips$fips[aggTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggTotalByYearAndFips$fips[aggTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("C:/Users/shania/Documents/GitHub/exploratory_data_analysis-project2/plot6.png", width=1040, height=480)
g <- ggplot(aggTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
