## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subNEISCC <- NEISCC[coalMatches, ]

aggTotalByYear <- aggregate(Emissions ~ year, subNEISCC, sum)



png("C:/Users/shania/Documents/GitHub/exploratory_data_analysis-project2/plot4.png", width=640, height=480)
g <- ggplot(aggTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()
