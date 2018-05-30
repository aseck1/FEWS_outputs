plot(data.df$datetime, 
     data.df$discharge_daily,
     type="l",
     xlab="",
     ylab="Flow (cfs)",
     col = "blue",
     frame.plot=TRUE)

lines(lffs_daily_data1.df$datetime,
      lffs_daily_data1.df$discharge_daily,
      lty=2, lwd=2, col="red")

lines(lffs_daily_data2.df$datetime,
      lffs_daily_data2.df$discharge_daily,
      lty=1, lwd=2, col="green")

legend("topright", inset=.04, legend=c("USGS", "LFFS_05_29_2018", "LFFS_03_12_2018" ), 
       col=c("blue", "red", "green"), 
       lty=1:1, cex=1.2)
