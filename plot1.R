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

# To create the first plot
png(file = "plot1.png",
		width = 480,
		height = 480)
hist(power_plot$Global_active_power, 
		col = "red", 
		main = "Global Active Power", 
		xlab = "Global Active Power (kilowatts)", 
		ylab = "Frequency")
dev.off()
