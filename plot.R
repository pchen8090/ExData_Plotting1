library("dplyr")
gdata <- read.table("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?")
gtb<-tbl_df(gdata)
# process data
gtb1 <- gtb %>% mutate(Date=as.Date(Date,format="%d/%m/%Y")) %>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>% 
  mutate(datetime=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")) 
# plot 1
hist(gtb1$Global_active_power, col = "red",freq=TRUE, main="Global active power", xlab="Global active power (kilowatts)")
dev.copy(png,"plot1.png",width = 800, height = 800)
dev.off()
# plot 2
plot(gtb1$datetime,gtb1$Global_active_power,xlab="",ylab="Global active power (kilowatts)",type="l")
dev.copy(png,"plot2.png",width = 800, height = 800)
dev.off()
# plot 3
plot(gtb1$datetime,gtb1$Sub_metering_1,xlab="",ylab="Eneregy sub metering",type="n")
lines(gtb1$datetime,gtb1$Sub_metering_1,col="black")
lines(gtb1$datetime,gtb1$Sub_metering_2,col="red")
lines(gtb1$datetime,gtb1$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.copy(png,"plot3.png",width = 800, height = 800)
dev.off()

par(mfrow=c(2,2))
# plot1
with(gtb1,plot(datetime,Global_active_power,type="l",ylab="Global Active Power"))
# plot2
with(gtb1,plot(datetime,Voltage,type="l"))
# plot3
plot(gtb1$datetime,gtb1$Sub_metering_1,xlab="",ylab="Eneregy sub metering",type="n")
lines(gtb1$datetime,gtb1$Sub_metering_1,col="black")
lines(gtb1$datetime,gtb1$Sub_metering_2,col="red")
lines(gtb1$datetime,gtb1$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1, bty= "n")
# plot4
with(gtb1,plot(datetime,Global_reactive_power,type="l"))
dev.copy(png,"plot4.png",width = 800, height = 800)
dev.off()

