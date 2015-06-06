## Download zip if not exists
file <- file.path(getwd(), "household_power_consumption.zip")
if (!file.exists("household_power_consumption.zip")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, file)
}

## Read full data
data_org <- read.csv(unz(file, "household_power_consumption.txt"), sep=';', na.strings="?", stringsAsFactors=F)

## Find the correct subset
data_org$Date <- as.Date(data_org$Date, format="%d/%m/%Y")
data_subset <- subset(data_org, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove full data
rm(data_org)

## Create Datetime out of Date and Time
datetime <- paste(data_subset$Date, data_subset$Time)
data_subset$Datetime <- as.POSIXct(datetime)

## Plot it and save it to a file
png("plot2.png", width=480, height=480)
plot(data_subset$Global_active_power~data_subset$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
