library(shiny)
library(shinydashboard)
library(lubridate)
library(tidyverse)
library(data.table)
library(ggplot2)

today_date <- as.Date("2018-5-29", "%Y-%m-%d")  #input variable (to be)
model_start_date <- as.Date("2014-1-1", "%Y-%m-%d")  #input variable (to be)

website <- "https://nwis.waterdata.usgs.gov/usa/nwis/uv/"
parameter <- "00060"
site_number <- "01646500"
start_date <- as.character(model_start_date)
end_date <- as.character(today_date)

link <- paste(website, 
              "?cb_",
              parameter,
              "=on&format=rdb&site_no=",
              site_number,
              "&period=&begin_date=",
              start_date,
              "&end_date=",
              end_date,
              sep="")
print("Downloading flow data")
X <- read.csv(url(link), skip = 31, sep = "\t")
colnames(X) <- c("agency","site_number", "datetime", "tz_cd", "discharge", "status_cd")
write.csv(X, file = "usgs_flow.csv")
return(X)