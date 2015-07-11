
## loading data (household_power_consumption, subset: 01/02/2007 - 02/02/2007)

Data = read.table("household_power_consumption.txt", stringsAsFactors=F, header=F, sep=";", na.strings=c("?"), skip = 66637, nrow = 2880)

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

##Plot 3

plot(Data$V7,xaxt="n", xlab="", type="l", col="darkgray", ylim=range(c(Data$V7,Data$V8, Data$V9)), ylab="Energy sub metering")
axis(1, at=c(1,1441,2881), lab=c("Thu","Fri", "Sat"))
par(new = TRUE)
plot(Data$V8,xaxt="n", ylim=range(c(Data$V7,Data$V8, Data$V9)), axes = FALSE, xlab = "", ylab = "", type="l", col="red")
par(new = TRUE)
plot(Data$V9,xaxt="n", ylim=range(c(Data$V7,Data$V8, Data$V9)), axes = FALSE, xlab = "", ylab = "", type="l", col="blue")
legend("topright", lty = 1, col = c("darkgray", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .7)

dev.copy(png, file = "plot3.png", width = 480, height = 480)  
dev.off()