output_directory <- "C://Users/secka/documents/icprb/FEWS_outputs/data/"
archive_directory1 <- "C://Users/secka/documents/icprb/FEWS_outputs/archive/"
archive_directory2 <- "C://Users/secka/documents/icprb/FEWS_outputs/archive/"

rivercode_list <- read.csv("C://Users/secka/documents/icprb/FEWS_outputs/data/riverlist.csv")


for (i in c(1:12)){
  rivercode = rivercode_list$Rivercode[i]
  rivername = rivercode_list$Rivername[i]
  #print(paste("The river is", rivercode))
  #print(paste("The river is", rivername))
  #rivercode <- "PM7_4820_0001_1"
  #rivername <- "little"
  riverfile <- paste0(output_directory , rivercode, ".flow")
  #print (riverfile)
  
  lffs_daily_data1.df <- get_lffs_daily(riverfile)
  lffs_hourly_data1.df <- get_lffs_hourly(riverfile, 1080)
  
  filename1 <- paste0(archive_directory1, rivername, "_daily", format(Sys.time(), "_%Y%m%d_%H"), ".csv")
  filename2 <- paste0(archive_directory1, rivername, "_hourly", format(Sys.time(), "_%Y%m%d_%H"), ".csv")
  #print (filename1)
  #print (filename2)
  
  write.csv(lffs_daily_data1.df, file=filename1)
  write.csv(lffs_hourly_data1.df, file=filename2)
  
}

# rivercode <- "PM7_4820_0001_1"
# rivername <- "little"
# riverfile <- paste0(directory, "data/", rivercode, ".flow")
# 
# lffs_daily_data1.df <- get_lffs_daily(riverfile)
# lffs_hourly_data1.df <- get_lffs_hourly(riverfile, 1080)
# 
# filename <- paste0(directory, "river", format(Sys.time(), "%Y%m%d_%H"), ".csv")
# write.csv(lffs_hourly_data1.df, file=filename)

# # -------------------------------------------------------------------
# # Linked plots (middle and right)
# ranges2 <- reactiveValues(x = NULL, y = NULL)
# 
# 
# output$plot2 <- renderPlot({
#   #ggplot(mtcars, aes(wt, mpg)) +
#   # geom_point()
#   plot(usgs_data.df$datetime, 
#        usgs_data.df$discharge_daily,
#        type="l",
#        xlab="",
#        ylab="Flow (cfs)",
#        col = "blue",
#        frame.plot=TRUE,
#        main = "Flow at Little Falls")
#   
#   lines(lffs_daily_data1.df$datetime,
#         lffs_daily_data1.df$discharge_daily,
#         lty=2, lwd=2, col="red")
#   
#   lines(lffs_daily_data2.df$datetime,
#         lffs_daily_data2.df$discharge_daily,
#         lty=1, lwd=2, col="green")
#   
#   legend("topright", inset=.04, legend=c("USGS", "LFFS_05_29_2018", "LFFS_03_12_2018" ), col=c("blue", "red", "green"), lty=1:1, cex=1.2)
# })
# 
# output$plot3 <- renderPlot({
#   #ggplot(mtcars, aes(wt, mpg)) +
#   # geom_point() +
#   #coord_cartesian(xlim = ranges2$x, ylim = ranges2$y, expand = FALSE)
#   plot(usgs_data.df$datetime, 
#        usgs_data.df$discharge_daily,
#        type="l",
#        xlab="",
#        ylab="Flow (cfs)",
#        col = "blue",
#        frame.plot=TRUE,
#        xlim=ranges2$x,
#        ylim = ranges2$y)
#   
#   lines(lffs_daily_data1.df$datetime,
#         lffs_daily_data1.df$discharge_daily,
#         lty=2, lwd=2, col="red")
#   
#   lines(lffs_daily_data2.df$datetime,
#         lffs_daily_data2.df$discharge_daily,
#         lty=1, lwd=2, col="green")
# })