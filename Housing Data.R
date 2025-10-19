# Load necessary libraries
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
# Change the file path to the file location.
setwd("/Users/tlnguyen/Documents/Study/Data 670")
# Read the CSV file. housing_data 
housing_data <- read.csv("housing.csv")
zhvi_data <- read.csv("ZHVI.csv")
income_data <- read.csv("fredgraph.csv")
# Handle missing data
# Detection
sapply(housing_data, function(x) sum(is.na(x)))
sapply(zhvi_data, function(x) sum(is.na(x)))
sapply(income_data, function(x) sum(is.na(x)))
# Imputation for numerical columns
zhvi_data <- zhvi_data %>% mutate_if(is.numeric, ~ifelse(is.na(.), mean(., na.rm = TRUE), .))
# Correct Inconsistency
housing_data$date <- as.character(housing_data$date)
housing_data$date <- as.Date(housing_data$date, format="%Y%m%d")
zhvi_data$date <- as.Date(zhvi_data$date, format="%Y-%m-%d")
income_data$date <- as.Date(income_data$date, format="%Y-%m-%d")
# Merging Datasets
combined_data <- housing_data %>%
  left_join(zhvi_data, by = c("date")) %>%
  left_join(income_data, by = c("date"))
write.csv(housing_data, file = "housing_data.csv", row.names = FALSE)
write.csv(zhvi_data, file = "zhvi_data.csv", row.names = FALSE)
write.csv(income_data, file = "income_data.csv", row.names = FALSE)

