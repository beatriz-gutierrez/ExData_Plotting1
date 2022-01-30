# Load the packages required to select data and work with dates
library(lubridate)
library(dplyr)

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
period <- c('01/02/2007', '02/02/2007')
data <- household_data %>% 
        filter(as.Date(Date, "%d/%m/%Y") %in% as.Date(period, "%d/%m/%Y"))

# get the complete date time values
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
date_time <- paste(data$Date, data$Time)
data$DateTime <- as_datetime(date_time)

# plot the date
plot(data$Global_active_power~data$DateTime, type="s",
     xlab = "", ylab = "Global Active Power (kilowatts)")

# save the plot to a png file
dev.copy(png, file = "plot2.png", height = 480, width = 480 )
# close the graphics device
dev.off()
