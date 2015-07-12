library(dplyr)
library(lubridate)

power_consumption <- read.table("household_power_consumption.txt", 
		header = TRUE,
		sep = ";",
		na.strings = "?")

power_consumption$Date <- as.Date(strptime(power_consumption$Date, "%d/%m/%Y",
		tz = "UTC"))

power_plot <- subset(power_consumption, 
		Date < as.Date("2007-02-03") & Date > as.Date("2007-01-31"))

power_plot <- mutate(power_plot, 
		Datetime = ymd_hms(paste(power_plot$Date, power_plot$Time)))

#To create fourth plot
png(file = "plot4.png",
		width = 480,
		height = 480)
par(mfrow = c(2, 2))
with(power_plot, plot(Global_active_power~Datetime,
		type = "l",
		xlab = "", 
		ylab = "Global Active Power"))
with(power_plot, plot(Voltage~Datetime,
		type = "l",
		xlab = "datetime"))
with(power_plot, plot(Sub_metering_1~Datetime,
		type = "l",
		xlab = "",
		ylab = "Energy sub metering"))
points(power_plot$Sub_metering_2~power_plot$Datetime, 
		col = "red",
		type = "l")
points(power_plot$Sub_metering_3~power_plot$Datetime, 
		col = "blue",
		type = "l")
legend("topright", 
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
		col = c("black", "red", "blue"), 
		lty= c(1, 1, 1), 
		bty = "n")
with(power_plot, plot(Global_reactive_power~Datetime,
		type = "l",
		xlab = "datetime"))
dev.off()
