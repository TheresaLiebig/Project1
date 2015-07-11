
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

##Plot 2

plot2 <- plot(Data$V3, ylab="Global Active Power (kilowatts)", type="l", xaxt="n", xlab="")
axis(1, at=c(1,1441,2881), lab=c("Thu","Fri", "Sat"))

dev.copy(png, file = "plot2.png", width = 480, height = 480)  
dev.off()