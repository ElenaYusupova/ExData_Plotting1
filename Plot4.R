library(lubridate)

getwd()
setwd("Y:/R_ElkaTraining/Coursera/Data_Science/4_Exploratory data analysis/Week1")
sFilePath <- "Y:/R_ElkaTraining/Coursera/Data_Science/4_Exploratory data analysis/Week1"

#Step 0:
#Download the data if it does not exists
if (!file.exists("projectdata.zip")) {
    
    projectdata<- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                                "projectdata.zip")
    
}

if (!dir.exists("Data") && !file.exists(file.path(sDataDir, "household_power_consumption.txt"))) {
    
    # Unzip files to Data directory
    unzip("projectdata.zip", exdir = "Data")
    
}

# Read in the data 
sDataDir <- file.path("Data")
data <- read.table(file.path(sDataDir, "household_power_consumption.txt"), sep = ";", 
                   header = T, stringsAsFactors = F)

# Read in the first column as dates
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data1 <- data[which(data$Date %in% as.Date(c("2007-02-01","2007-02-02")) ),] #select only the two target dates
data1$Date_Time <- with(data1, as.POSIXct(paste(Date, Time))) #class(data1$Date_Time)

# Split the screen
par(mfrow = c(2,2), mar = c(4, 4, 1.5,1.5))

# Plot 1
data1$Global_active_power <- as.numeric(data1$Global_active_power) #Change to numeric
with (data1, 
      {plot(Global_active_power ~ Date_Time, type = "l",ylab = "Global Active Power", xlab = "")})

# Plot 2
data1$Voltage <- as.numeric(data1$Voltage) #Change to numeric
with (data1, 
      {plot(Voltage ~ Date_Time, type = "l",ylab = "Voltage", xlab = "datetime")})

#Plot 3
data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1) #Change to numeric
data1$Sub_metering_2 <- as.numeric(data1$Sub_metering_2)
data1$Sub_metering_3 <- as.numeric(data1$Sub_metering_3)

with (data1, 
      {plot(Sub_metering_1 ~ Date_Time, type = "l",ylab = "Energy sub metering", xlab = "")
          lines(Sub_metering_2 ~ Date_Time, type = "l", col = "red")
          lines(Sub_metering_3 ~ Date_Time, type = "l", col = "blue")
      })
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#Plot 4
data1$Global_reactive_power <- as.numeric(data1$Global_reactive_power) #Change to numeric
with (data1, 
      {plot(Global_reactive_power ~ Date_Time, type = "l",ylab = "Global reactive power", xlab = "datetime")})

#Export 
dev.copy(png, file = "Plot4.png")
dev.off()
