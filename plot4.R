main <- function() {
    ## Will be useful later on
    
    Sys.setlocale("LC_TIME", "en_US.UTF-8")
    
    ## Get the files in the script folder
    
    files <- list.files()
    
    ## Check if dataset is here
    
    if(!("household_power_consumption.txt" %in% files)) {
        stop("Dataset not in script folder")    
    }
    
    ## Read data
    
    data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows=2075259)
    
    ## Subset it
    
    
    data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
    
    ## Convert it
    
    data$Time <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y%H:%M:%S")
    data[,1] <- as.Date(data[,1],format="%d/%m/%Y")
    data[,3] <- as.numeric(as.character(data[,3]))
    data[,7] <- as.numeric(as.character(data[,7]))
    data[,8] <- as.numeric(as.character(data[,8]))
    data[,9] <- as.numeric(as.character(data[,9]))
    data[,5] <- as.numeric(as.character(data[,5]))
    data[,4] <- as.numeric(as.character(data[,4]))
    
    ## Now we can plot it !
    png(file="plot4.png")
    with(data, par(mfrow=c(2,2)))
    with(data, plot(y=Global_active_power,x=Time, type="l",col="black", xlab="", ylab="Global Active Power (kilowatts)"))
    
    with(data, plot(y=data$Voltage, x=data$Time, type="l", ylab="Voltage", xlab="datetime"))
    
    with(data, plot(y=data$Sub_metering_1,x=data$Time, type="l",col="black", ylab="Energy sub metering", xlab=""))
    with(data, lines(y=data$Sub_metering_2, x=data$Time, type="l", col="red"))
    with(data, lines(y=data$Sub_metering_3, x=data$Time, type="l", col="blue"))
    with(data, legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), pch=c("-","-","-")))
    
    with(data, plot(y=data$Global_reactive_power, x=data$Time, type="l", col="black", xlab="datetime"))
    
    dev.off()
    
    
    
}