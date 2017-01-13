filename<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption"
#Downloading the data-set if its absent from the working directory.
if(!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,filename,method="curl")
}
if(!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}
#reading the data into R workspace
PowerDat<-read.table("household_power_consumption.txt",header=T,sep=";")
#converting to date class from factor
PowerDat$Date<-as.Date(PowerDat$Date,'%d/%m/%Y')
#extracting only Plot data
PlotDat<-subset(PowerDat,Date=="2007/02/01"|Date=="2007/02/02")
#Creating date time object
PlotDat$DateTime<-strptime(paste(PlotDat$Date,PlotDat$Time),format="%Y-%m-%d %H:%M:%S")
#plotting the graph
png('plot4.png',width=480,height=480)
par(mfrow=c(2,2))
plot(PlotDat$DateTime,PlotDat$Global_active_power,ylab='Global Active Power',xlab="datetime",type='line')
plot(PlotDat$DateTime,PlotDat$Voltage,ylab='Voltage',xlab="datetime",type='line')
plot(PlotDat$DateTime,PlotDat$Sub_metering_1,xlab="datetime",ylab='Energy sub metering',type='line')
lines(PlotDat$DateTime,PlotDat$Sub_metering_2,type="line",col="red")
lines(PlotDat$DateTime,PlotDat$Sub_metering_3,type="line",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
plot(PlotDat$DateTime,PlotDat$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="line")
dev.off()
