library(dplyr)
library(lubridate)
EPC <- read.table("household_power_consumption.txt", 
                  sep = ";", header = TRUE, na.strings = "?")%>%
    filter(Date == "1/2/2007" | Date == "2/2/2007")

HPC <- EPC
HPC$Date <- dmy(EPC$Date)
HPC$Time <- dmy_hms(paste(EPC$Date, EPC$Time))

png("plot1.png", width = 480, height = 480, units = "px")
with(HPC, hist(Global_active_power, main = "Global Active Power", 
               xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
