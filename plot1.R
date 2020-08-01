#Load the required libraries
library(dplyr)

#Create a folder for the data (if it does not yet exist)
if(!file.exists("../data")){
  dir.create("../data")
}

#Unzip the data
unzip("../data/exdata_data_household_power_consumption.zip", list = FALSE, exdir = "../data")

#Read in the data
data <- read.table("../data/household_power_consumption.txt", header = TRUE, sep = ";")

#Convert formats of columns to proper formats
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data[3:9] <- sapply(data[3:9], as.numeric)

#Subset data from dates 2007-02-01 and 2007-02-02
data2 <- data %>% filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#Creating the plot
png(file="plot1.png")
plot.new()
hist(data2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()