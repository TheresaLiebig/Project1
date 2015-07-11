

## loading data (household_power_consumption, subset: 01/02/2007 - 02/02/2007)

Data = read.table("C:/Users/Theresa/OneDrive/Work/Courses/Coursera_ExploratoryDataAnalysiswithR/Week1/Project1/household_power_consumption.txt", stringsAsFactors=F, header=F, sep=";", na.strings=c("?"), skip = 66637, nrow = 2880)

tail(Data, n=1)
str(Data)
head(Data)

cols <- c("V1", "V2")
Data$datetime <- do.call(paste, c(Data[cols], sep=" "))

Data$datetime <- dmy_hms(Data$datetime, tz = "")

Data$V1 <- dmy(Data$V1)
Data$V2 <- hms(Data$V2)

wdays <- wday(Data$V1, label = TRUE, abbr = TRUE)
Data <- cbind(Data, wdays)

##Plot 4

par(mfcol = c(2, 2)) 

plot2 <- plot(Data$V3, ylab="Global Active Power (kilowatts)", type="l", xaxt="n", xlab="")
axis(1, at=c(1,1441,2881), lab=c("Thu","Fri", "Sat"))

plot(Data$V7,xaxt="n", xlab="", type="l", col="darkgray", ylim=range(c(Data$V7,Data$V8, Data$V9)), ylab="Energy sub metering")
axis(1, at=c(1,1441,2881), lab=c("Thu","Fri", "Sat"))
par(new = TRUE)
plot(Data$V8,xaxt="n", ylim=range(c(Data$V7,Data$V8, Data$V9)), axes = FALSE, xlab = "", ylab = "", type="l", col="red")
par(new = TRUE)
plot(Data$V9,xaxt="n", ylim=range(c(Data$V7,Data$V8, Data$V9)), axes = FALSE, xlab = "", ylab = "", type="l", col="blue")
legend("topright", lty = 1, col = c("darkgray", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .7, bty = "n")

plot(Data$datetime, Data$V5, type="l", ylab="Voltage", xlab="datetime")

plot(Data$datetime, Data$V4, type="l", ylab="Global Reactive Power", xlab="datetime")

dev.copy(png, file = "plot4.png", width = 480, height = 480)  
dev.off()
