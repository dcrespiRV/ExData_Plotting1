# Import data
library(tidyverse)
fullData = read.table('household_power_consumption.txt',header = T,sep = ';')

# Filter data for those dates and convert gap to numeric
rawData = fullData %>% filter(Date %in% c('1/2/2007','2/2/2007')) %>% droplevels()
rawData$Global_active_power = as.numeric(as.character(rawData$Global_active_power))

# Date time formatting to combine into 1 column
rawData$Date = as.character(rawData$Date)
rawData$Date[which(rawData$Date == '1/2/2007')] = '2007-02-01'
rawData$Date[which(rawData$Date == '2/2/2007')] = '2007-02-02'
rawData$Date = as.Date(rawData$Date)
rawData$Time = as.character(rawData$Time)
rawData$Time = format(strptime(rawData$Time,'%T'),'%T')
rawData$DateTime = as.POSIXct(paste(rawData$Date, rawData$Time), format="%Y-%m-%d %H:%M:%S")

# Convert these to numeric
rawData$Sub_metering_1 = as.numeric(as.character(rawData$Sub_metering_1))
rawData$Sub_metering_2 = as.numeric(as.character(rawData$Sub_metering_2))
rawData$Sub_metering_3 = as.numeric(as.character(rawData$Sub_metering_3))

par(mfrow = c(1,1))
plot(rawData$DateTime,rawData$Sub_metering_1,type = 'l',xlab = '',ylab = 'Energy sub metering')
lines(rawData$DateTime,rawData$Sub_metering_2,col = 'red')
lines(rawData$DateTime,rawData$Sub_metering_3,col = 'blue')
dev.copy(png,'plot3.png')
dev.off()