library("dplyr")
gdata <- read.table("household_power_consumption.txt",sep=";",header = TRUE,)
gtb<-tbl_df(gdata)
# process data
gtb1 <- gtb %>% mutate(Date=as.Date(Date,format="%d/%m/%Y")) %>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>% 
  mutate(datetime=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")) %>%
  mutate(Sub_metering_1=as.numeric(as.character(Sub_metering_1))) %>% 
  mutate(Sub_metering_1=as.numeric(as.character(Sub_metering_1))) %>% 
  mutate(Sub_metering_2=as.numeric(as.character(Sub_metering_2))) %>% 
  mutate(Sub_metering_3=as.numeric(as.character(Sub_metering_3))) %>%
  mutate(Voltage=as.numeric(as.character(Voltage))) %>%
  mutate(Global_active_power=as.numeric(as.character(Global_active_power))) %>%
mutate(Global_reactive_power=as.numeric(as.character(Global_reactive_power)))
# plot 1
hist(gtb1$Global_active_power, col = "red",freq=TRUE, main="Global active power", xlab="Global active power (kilowatts)")
dev.copy(png,"plot1.png")
dev.off()
# plot 2
plot(gtb1$datetime,gtb1$Global_active_power,xlab="",ylab="Global active power (kilowatts)",type="l")
dev.copy(png,"plot2.png")
dev.off()
# plot 3
plot(gtb1$datetime,gtb1$Sub_metering_1,xlab="",ylab="Eneregy sub metering",type="n")
lines(gtb1$datetime,gtb1$Sub_metering_1,col="black")
lines(gtb1$datetime,gtb1$Sub_metering_2,col="red")
lines(gtb1$datetime,gtb1$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"),col=c("black","red","blue"),lty=1)
dev.copy(png,"plot3.png")
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
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"),col=c("black","red","blue"),lty=1, bty= "n")
# plot4
with(gtb1,plot(datetime,Global_reactive_power,type="l"))
dev.copy(png,"plot4.png")
dev.off()

