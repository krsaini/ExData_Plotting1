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
    
# plot 1
    png("plot1.png",width=480,height=480)
    hist(powerData$Global_active_power,main="Global Active Power",xlab = "Global Active Power (kilowatts)", col= "red")
    dev.off()