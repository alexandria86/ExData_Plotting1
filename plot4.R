# Reading Data from file and subsetting to specific dates
zipF<- "./Data Sets/exdata%2Fdata%2Fhousehold_power_consumption.zip"
outDir<-"./Data Sets"
unzip(zipF,exdir=outDir)

pwr<-read.table("./Data Sets/household_power_consumption.txt", header=TRUE, sep = ";", colClasses = c("character","character", rep("numeric",7)), na.strings = "?")
pwr_sub<-subset(pwr,pwr$Date=="1/2/2007" | pwr$Date == "2/2/2007")

# converting data and time to specific format and assigning in to a new column"DateTime" 
pwr_sub$Date <- as.Date(pwr_sub$Date, format = "%d/%m/%Y")
pwr_sub$DateTime <- as.POSIXct(paste(pwr_sub$Date, pwr_sub$Time))
Sys.setlocale("LC_ALL", "English")

## Plotting
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfcol = c(2, 2))


plot(pwr_sub$DateTime,
     pwr_sub$Global_active_power,
     type = "line",
     xlab = "",
     ylab = "Global Active Power")



plot(pwr_sub$DateTime,
     pwr_sub$Sub_metering_1,
     "n",
     xlab = "",
     ylab = "Energy sub metering")

points(pwr_sub$DateTime, pwr_sub$Sub_metering_1, type = "line")

points(pwr_sub$DateTime,pwr_sub$Sub_metering_2, type = "line", col = "red")

points(pwr_sub$DateTime, pwr_sub$Sub_metering_3, type = "line", col = "blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1),
       bty = "n")

plot(pwr_sub$DateTime,
     pwr_sub$Voltage,
     type = "line",
     xlab = "datetime",
     ylab = "Voltage")

plot(pwr_sub$DateTime,
     pwr_sub$Global_reactive_power,
     type = "line",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()
