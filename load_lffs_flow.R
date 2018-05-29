library(shiny)
library(shinydashboard)
library(lubridate)
library(tidyverse)
library(data.table)
library(ggplot2)

filename <- "Z:/MODEL/p52fc05_sa/output/pltgen/river/p52Luke/PM7_4820_0001.flow"
X2 <- read.csv(filename, header = FALSE, skip = 26, sep = "")
colnames(X2) <- c("year","month", "day", "hour", "second", "discharge")
lffs_data1.df <- X2
lffs_data1.df$datetime<-ymd_hms(paste(lffs_data1.df$year, 
                                     lffs_data1.df$month, 
                                     lffs_data1.df$day, 
                                     lffs_data1.df$hour, 
                                     lffs_data1.df$second, 
                                     lffs_data1.df$second,
                                     sep="-"))
lffs_daily_data1.df <- lffs_data1.df %>%
  dplyr::mutate (discharge = as.numeric(as.character(discharge))) %>%
  mutate(datetime = as.POSIXct(as.character(datetime), tz = "EST")) %>%
  #mutate(datetime = strptime(as.character(datetime), "%Y-%m-%d %H:%M:%S")) %>%
  mutate(datetime = floor_date(datetime, "day")) %>%
  group_by(datetime) %>% 
  summarize(discharge_daily = mean(discharge))  
