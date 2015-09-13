## KHALIL H NAJAFI
## COURSE PROJECT 1 - BASE PLOTS
## The following code fully creates Plot 3, Plot of Sub Metering


## Set working directory & Download dataset & Install/load libraries
rm(list=ls())
if (!dir.exists("./A1")) {
        dir.create("./A1")
}
setwd(file.path("./A1"))

temp <- tempfile()
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipURL, dest = temp, method = "curl")
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = T, na.strings = "?", skip=grep("31/1/2007;23:58:00", readLines("household_power_consumption.txt")), nrows = 2880, stringsAsFactors = F)
unlink(temp)
pkgs <- c("dplyr", "lubridate")
if(length(setdiff(pkgs, rownames(installed.packages()))) > 0) {
        install.packages(setdiff(pkgs, rownames(installed.packages())))
}
library(dplyr)
library(lubridate)

## Correct variable names
colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Merge DATE and TIME, & re-class
data <- tbl_df(data) 
data <- mutate(data, Date = paste(Date, Time, sep =" ")) %>% select(-Time)
data$Date <- dmy_hms(data$Date)

## Plot Sub Metering
par(mfrow = c(1,1), mar = c(2, 4, 1, 2))
with(data, {plot(Date, Sub_metering_1, ylab = "Energy sub metering", type = "n")
        lines(Date, Sub_metering_1)
        lines(Date, Sub_metering_2, col = "red")
        lines(Date, Sub_metering_3, col ="blue")
        legend("topright", pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.copy(png, file = "plot3.png") # copy plot to PNG
dev.off()
