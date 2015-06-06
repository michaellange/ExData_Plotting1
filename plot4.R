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
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

## Top left
with(data_subset, plot(Global_active_power~Datetime, type="l", ylab="Global Active Power", xlab=""))

## Top right
with(data_subset, plot(Voltage~Datetime, type="l", xlab="datetime"))

## Bottom left
with(data_subset, {
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=1, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Bottom right
with(data_subset, plot(Global_reactive_power~Datetime, type="l", xlab="datetime"))

dev.off()
