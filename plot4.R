#install.packages("downloader")
#library(downloader)
#download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="dataset.zip", mode="wb")
unzip("dataset.zip", exdir = ".")
data <- readLines("household_power_consumption.txt")
firstOrSecond <- grep("^[12]/2/2007", substr(data, 1,9))
final <- read.table(text=data[firstOrSecond], header = TRUE, sep=";", 
                    col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                    na="?")

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
x<-strptime(paste(final$Date, final$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
plot(x, final$Global_active_power, type="l", xlab = "", ylab= "Global Active Power")

plot(x, final$Voltage, type="l", xlab = "datetime", ylab= "Voltage")


plot(x, final$Sub_metering_1 , type="n", xlab="", ylab = "Energy sub metering")
lines(x, final$Sub_metering_1, col="black")
lines(x, final$Sub_metering_2, col="red")
lines(x, final$Sub_metering_3, col="blue")
legend("topright", 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
        bty="n")
plot(x, final$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()