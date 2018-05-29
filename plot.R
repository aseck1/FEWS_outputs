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
