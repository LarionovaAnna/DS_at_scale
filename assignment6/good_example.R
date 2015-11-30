# ---
#   title: 'Visualizarions: San Francisco Crime in R'
# author: "Jovita De Loatch"
# date: "November 28, 2015"
# output: pdf_document
# ---
#   
#   Problem Description:
#   'The City' is known more for its tech scene than its criminal past. From 1934 to 1963, San Francisco was infamous for housing some of the world's most notorious criminals on the inescapable island of Alcatraz. With reports of rising wealth inequality, housing shortages, and a proliferation of expensive handheld toysis there a way to identify the patterns of crime in The City by the bay.
# 
# The San Francisco Crime Classification Kaggle competition provides nearly 12 years of crime given time and location reports from across all of San Francisco's neighborhoods.  The goal is to predict the category of crime that occurred. 
# 
# Date –  date
# Time - timestamp
# Category – The type of crime, Larceny, etc.
# Descript – A more detailed description of the crime.
# DayOfWeek – Day of crime: Monday, Tuesday, etc.
# PdDistrict - Police department district.
# Resolution - What was the outcome, Arrest, Unfounded, None, etc.
# Address – Street address of crime.
# X and Y – GPS coordinates of crime.
# 
# Step 1: Read  the data

#Load, Explore and Visualise data
library(xts)
library(dygraphs)
library(lubridate)
library(leaflet)
library(zoo)
library(gdata)
library(dplyr)
library(ggplot2)
library(chron)
library(qcc)

SFCrime <- read.csv(file="sanfrancisco_incidents_summer_2014.csv", head=TRUE,sep=",")

SFCrime$PdId = NULL
#SFCrime$Address = NULL
SFCrime$IncidntNum = NULL

#Step 2 : Data Visualization

# The goal is to begin to analyze criminal incident data from San Francisco to visualize patterns of activity for a small set of data for the summer of 2014. The hope is to pick a few visualizations that can answer a few of these types of questions: how do incidents vary by time of day? Which incidents are most common in the evening? During what periods of the day are robberies most common? how do incidents vary by neighborhood? Which incidents are most common in the city center? In what areas or neighborhoods are robberies or thefts most common?how do incidents vary month to month in the Summer 2014 dataset? which incident types tend to correlate with each other on a day-by-day basis?
# 
# Given the assignment alots 30mins to this task. the following 3 visualizations are offered for your review.

#Plot 1
##############################  
# Build a Pareto Charts of relationships
pareto.chart(table(SFCrime$Category)) 
pareto.chart(table(SFCrime$PdDistrict)) 


#Plot 2 
########################################
# Get a closer look at the relationship of catagories on a log scale.
total.category <- table(SFCrime$Category)
order.category <- order(total.category, decreasing = TRUE)
SFCrime$Category <- factor(SFCrime$Category, levels = names(total.category[order.category]))
ggplot(SFCrime, aes(Category)) +
    geom_histogram(aes(fill = Category,color=Category)) +
    ggtitle("SF Crime Category Frequency") +
    labs(x="Category", y="Frequency(log scale)") + 
    scale_y_log10() +
    scale_x_discrete(limits = levels(SFCrime$Category)[34:1]) +
    theme(legend.position="none", axis.text.x = element_text(angle = 45, hjust = 1)) +
    coord_flip()


#Plot 3
##################################################################
#Maping the Locations

SFCrime <- subset(SFCrime, !is.na(SFCrime$Category))


state_popup <- paste0("<strong>SFCrime 2014: </strong>  ", 
                      SFCrime$Category, 
                      " ",
                      SFCrime$DayOfWeek,
                      " ",
                      SFCrime$Incident_Time,
                      " ",
                      SFCrime$PdDistrict)

map=leaflet(data = SFCrime) %>% 
    addTiles() %>% 
    addMarkers(~X, ~Y,
               popup =  state_popup ,         
               clusterOptions = markerClusterOptions() )
map