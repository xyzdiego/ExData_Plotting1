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
sub_hpower$Date <- as.Date(sub_hpower$Date, format = "%d/%m/%Y")
sub_hpower$Time <- strptime(sub_hpower$Time, format = "%H:%M:%S")
sub_hpower[1:1440, "Time"] <- format(sub_hpower[1:1440,"Time"],
                                     "2007-02-01 %H:%M:%S")
sub_hpower[1441:2880, "Time"] <- format(sub_hpower[1441:2880,"Time"],
                                        "2007-02-02 %H:%M:%S")
sub_hpower$Sub_metering_1 <- as.numeric(as.character(sub_hpower$Sub_metering_1))
sub_hpower$Sub_metering_2 <- as.numeric(as.character(sub_hpower$Sub_metering_2))
sub_hpower$Sub_metering_3 <- as.numeric(as.character(sub_hpower$Sub_metering_3))
str(sub_hpower)
summary(sub_hpower)

# 3rd plot
png("plot3.png", width = 480, height = 480)
with(sub_hpower, plot(Time, Sub_metering_1, type = "n",
                      xlab = "", ylab = "Energy Sub metering",
                      main = "Energy sub metering per day"))
with(sub_hpower, lines(Time, Sub_metering_1, col = "black"))
with(sub_hpower, lines(Time, Sub_metering_2, col = "red"))
with(sub_hpower, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()