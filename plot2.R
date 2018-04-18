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


#Plot line graph
png("plot2.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))
plot(pwr_sub$DateTime, pwr_sub$Global_active_power, 
     type="line", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()