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
    
    ## Now we can plot it !
    
    png(file="plot2.png", width=480,height=480)
    with(data, plot(y=Global_active_power,x=Time, type="l",col="black", ylab="Global Active Power (kilowatts)"))
    dev.off()
    
    
}