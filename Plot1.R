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
data1$Time  <- strptime(data1$Time, "%H:%M:%S") # put data into 

#names(data1) ; head(data1); class(data1$Global_active_power)  #data checks
data1$Global_active_power <- as.numeric(data1$Global_active_power) #Change to numeric
par(mfrow = c(1,1)) # Changing global settings in case 
hist(data1$Global_active_power, col= "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")



dev.copy(png, file = "Plot1.png")
dev.off()


