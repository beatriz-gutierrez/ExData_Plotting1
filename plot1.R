# download and unzip data from the web
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- ".\\exdata_data_household_power_consumption.zip"
if (!file.exists(zip_file)) {
        download.file(file_url, destfile = zip_file, mode = 'wb')
        unzip(zipfile = zip_file, exdir = getwd())
        date_download <- date() 
}

# read data 
file_name <- substr(zip_file, nchar(".\\exdata_data_")+1, nchar(zip_file)-4)
file_name <- paste(file_name, '.txt', sep = '')
household_data <- read.csv(file_name, header = TRUE, sep = ';', na.strings = '?')

# subset from the dates 2007-02-01 and 2007-02-02
# Load the packages required to select data and work with dates
library(lubridate)
library(dplyr)
period <- c('01/02/2007', '02/02/2007')
data <- household_data %>% 
        filter(as.Date(Date, "%d/%m/%Y") %in% as.Date(period, "%d/%m/%Y"))
#check
table(data$Date)

# plot1: histogram of Global Active Power
hist(as.numeric(data$Global_active_power), 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.copy(png, file = "plot1.png", height = 480, width = 480 )
dev.off()
