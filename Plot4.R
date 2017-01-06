#set the file URL as a variable
fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#cheack if data file exists and if not create one
if (!file.exists("data")){
    dir.create("data")
}
#download file into ./data
download.file(fileURL,"./data/Fhousehold_power_consumption.zip")

#create date stamp
dateDownloaded<-date()

#unzip file
unzip("./data/Fhousehold_power_consumption.zip",exdir = "./data")

#read the txt file using ";" as delimiter
Fhousehold<-read.csv("./data/household_power_consumption.txt",sep=";",na.strings="?")

#convert Fhousehold$Date into a date
Fhousehold$Date<-as.Date(as.character(Fhousehold$Date),"%d/%m/%Y")

#create a list called Datetime created from the time and date columns
dateTime<-strptime(paste(Fhousehold$Date,Fhousehold$Time),format= "%Y-%m-%d %H:%M:%S")

#add the datetime to the dataframe
Fhousehold$DateTime<-dateTime

#subset the dataframe to have only values bewteen Feb 1st and Feb 2nd 2007
FhouseSub<-with(Fhousehold,subset(Fhousehold,DateTime >= "2007-02-01" &  DateTime< "2007-02-03"))

# Open PNG graphics device and create plot
png("Plot4.PNG")

par(mfrow=c(2,2))

source('C:/Users/camea/Documents/Projects/ExplorAnal/Week1Project/ExData_Plotting1/Plot2.R')

plot(FhouseSub$DateTime,FhouseSub$Voltage,type="l",xlab = "datetime",ylab = "Voltage")

source("./Plot3.R")

plot(FhouseSub$DateTime,FhouseSub$Global_reactive_power 
     ,type="l",xlab = "datetime",ylab = "Global_reactive_power")
dev.off()