library(shiny)
library(shinydashboard)
library(lubridate)
library(tidyverse)
library(data.table)
library(ggplot2)

X1 <- read.csv("data/usgs_flow.csv", header = TRUE, sep = ',')

data.df <- X1 %>%
  dplyr::mutate (discharge = as.numeric(as.character(discharge))) %>%
  mutate(datetime = as.POSIXct(as.character(datetime), tz = "EST")) %>%
  #mutate(datetime = strptime(as.character(datetime), "%Y-%m-%d %H:%M:%S")) %>%
  mutate(datetime = floor_date(datetime, "day")) %>%
  group_by(datetime) %>% 
  summarize(discharge_daily = mean(discharge))  