library(dplyr)
library(lubridate)
EPC <- read.table("household_power_consumption.txt", 
                  sep = ";", header = TRUE, na.strings = "?")%>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")

HPC <- EPC
HPC$Date <- dmy(EPC$Date)
HPC$Time <- dmy_hms(paste(EPC$Date, EPC$Time))

## note for my fellow coursera students: I am working on a german system
## my labels for the day of the week are therefore in german
## translation: Do = Thu, Fr = Fri, Sa = Sat

png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), mar = c(4,4,2,2))
with(HPC, plot(Time, Global_active_power, type = "l", 
               ylab = "Global Active Power (kilowatts)", xlab = ""))
with(HPC, plot(Time, Voltage, type = "l", 
               ylab = "Voltage", xlab = "datetime"))
with(HPC, plot(Time, Sub_metering_1, col = "black", type = "l", 
               ylab = "Energy sub metering", xlab = ""))
with(HPC, lines(Time, Sub_metering_2, col = "red"))
with(HPC, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 1, bty = "n")
with(HPC, plot(Time, Global_reactive_power, type = "l", 
               ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()
