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
sub_hpower$Date <- as.Date(sub_hpower$Date, format = "%d/%m/%Y")
sub_hpower$Time <- strptime(sub_hpower$Time, format = "%H:%M:%S")
sub_hpower[1:1440, "Time"] <- format(sub_hpower[1:1440,"Time"],
                                     "2007-02-01 %H:%M:%S")
sub_hpower[1441:2880, "Time"] <- format(sub_hpower[1441:2880,"Time"],
                                        "2007-02-02 %H:%M:%S")
str(sub_hpower)

# 2nd plot
png("plot2.png", width = 480, height = 480)
with(sub_hpower, plot(Time, Global_active_power, type = "l",
                      xlab = "", ylab = "Global Active Power(kilowatts)",
                      main = "Time vs Global Active Power"))
dev.off()