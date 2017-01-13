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
#PowerDat$DateTime<-paste(as.character(PowerDat$Date),PowerDat$Time)#Not needed for this Plot


PowerDat$Date<-as.Date(PowerDat$Date,'%d/%m/%Y')
PlotDat<-subset(PowerDat,Date=="2007-02-01"|Date=="2007-02-02")
PlotDat$Global_active_power<-as.numeric(as.character(PlotDat$Global_active_power))
png('plot1.png',width=480,height=480)
hist(PlotDat$Global_active_power,col='red',xlab='Global Active Power (kilowatts)', ylab='Frequency',main='Global Active Power')
dev.off()