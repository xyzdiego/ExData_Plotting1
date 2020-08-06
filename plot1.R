############################################
### Exploratory Data Analysis. Project 1 ###
###        Coursera course project       ###
###   Produced by Diego Andres Benitez   ###
############################################

# Create the work directory file
if(!file.exists("./data")){dir.create("./data")}
setwd("./data")

# Downloades and read the file 
URL <- paste0("https://d396qusza40orc.cloudfront.net/",
              "exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(URL, "power_consumption.zip", method = "curl")
unzip("power_consumption.zip")
list.files()
hpower_con <- read.csv2("household_power_consumption.txt", header = T,
                        na.strings = "?")
str(hpower_con)

# Change data columns
hpower_con$Global_active_power <- as.numeric(as.character(
    hpower_con$Global_active_power))

# 1st plot
sub_hpower <- subset(hpower_con, hpower_con$Date == "1/2/2007" | 
                         hpower_con$Date == "2/2/2007")
summary(sub_hpower$Global_active_power)

png("plot1.png", width = 480, height = 480)
with(sub_hpower, hist(Global_active_power, col = "red",
                      main = "Global Active Power", 
                      xlab = "Global Active Power(kilowatts)",
                      xlim = c(0,6)))
dev.off()

## 1st plot with ggplot2
library(ggplot2)
png("plot1-ggplot.png", width = 480, height = 480)
ggplot(sub_hpower, aes(Global_active_power, fill = "red5")) + 
    geom_histogram(color = "gray80") + 
    labs(title = "Global Active Power", x = "Global Active Power(kilowatts)",
         y  = "Frecuency") +
    theme(plot.title = element_text(hjust = 0.5, color = "black", 
                                    size =  15, face = "bold"),
          legend.position = "none")
dev.off()