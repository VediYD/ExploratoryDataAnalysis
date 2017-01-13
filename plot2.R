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
png('plot2.png',width=480,height=480)
plot(PlotDat$DateTime,PlotDat$Global_active_power,ylab='Global Active Power (kilowatts)',type='line')
dev.off()