## getting file from url.

### Download/Open Data.

setwd("C:/Users/Vivek/Desktop/data Science/exploratry")

fileurl <- 'https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip'
if (!file.exists('./household_power_consumption.zip')){
    download.file(fileurl,'./household_power_consumption.zip',mode = "wb")
    unzip("household_power_consumption.zip", exdir = getwd)
}

# Read and convert data.

powerData <- read.table("household_power_consumption.txt", header= TRUE,sep=";" , na.strings = "?")

powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")

# filter data

powerData <- subset(powerData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
powerData <- powerData[complete.cases(powerData), ]

# combine date and time column

DateTime <- as.POSIXct(paste(powerData$Date, powerData$Time))
DateTime <- setNames(DateTime,"DateTime")

# adding DateTime to dataset

powerData <- cbind(powerData, DateTime)

# plot 4
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powerData, {
    plot(Global_active_power~DateTime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~DateTime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~DateTime, type="l", 
         ylab="Global Active Power", xlab="")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1,
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~DateTime, type="l", 
         ylab="Global_reactive_power",xlab="datetime")
})
dev.off()