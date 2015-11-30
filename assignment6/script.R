setwd("E:/Personal/Repos/DS_at_scale/assignment6")

library(chron)
library(ggplot2)

sf_crime <- read.csv("sanfrancisco_incidents_summer_2014.csv")

sf_crime$Time1 <- chron(times. = paste0(as.character(sf_crime$Time), ":00", sep=""))
sf_crime$DayTime <- ifelse(sf_crime$Time1 >= chron(times. = "00:00:00") & sf_crime$Time1 < chron(times. = "06:00:00"), "night", "")
sf_crime$DayTime <- ifelse(sf_crime$Time1 > chron(times. = "18:00:00") & sf_crime$Time1 <= chron(times. = "23:59:00"), "evening", sf_crime$DayTime)
sf_crime$DayTime <- ifelse(sf_crime$Time1 > chron(times. = "12:00:00") & sf_crime$Time1 <= chron(times. = "18:00:00"), "day", sf_crime$DayTime)
sf_crime$DayTime <- ifelse(sf_crime$Time1 >= chron(times. = "06:00:00") & sf_crime$Time1 <= chron(times. = "12:00:00"), "morning", sf_crime$DayTime)
sf_crime$DayTime <- as.factor(sf_crime$DayTime) 

crimes_daytime <- aggregate(sf_crime$Descript ~ sf_crime$Category + sf_crime$DayTime, data = sf_crime, length)
names(crimes_daytime) <- c("Category", "DayTime", "Crime_frequency")
head(crimes_daytime[order(-crimes_daytime$Crime_frequency),], 15)
g1 <- ggplot(crimes_daytime, aes(x = crimes_daytime$Category, y = crimes_daytime$Crime_frequency, fill = crimes_daytime$DayTime)) + geom_histogram(binwidth = .5, alpha = .5, stat = "identity") + theme(axis.title = element_blank(), legend.position = "right", axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) + ggtitle("Crimes in San Francisco by time of the day")
g1

crime_by_weekday <- as.data.frame(summary(sf_crime$DayOfWeek))
crime_by_weekday$WeekDay <- rownames(crime_by_weekday)
names(crime_by_weekday) <- c("Crime_frequency", "WeekDay")
crime_by_weekday <- crime_by_weekday[c(2, 6, 7, 5, 1, 3, 4),c(2, 1)]
rownames(crime_by_weekday) <- NULL
crime_by_weekday$WeekDay <- factor(crime_by_weekday$WeekDay, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
g2<- ggplot(crime_by_weekday, aes(x = factor(crime_by_weekday$WeekDay), y = crime_by_weekday$Crime_frequency)) + geom_histogram(binwidth = .5, alpha = .5, stat = "identity") + theme(axis.title = element_blank(), legend.position = "none", axis.text.x = element_text(angle = 0, hjust = 1, vjust = 0.5)) + ggtitle("Crimes in San Francisco by day of the week")
g2

crimes_weekday <- aggregate(sf_crime$Descript ~ sf_crime$Category + sf_crime$DayOfWeek, data = sf_crime, length)
names(crimes_weekday) <- c("Category", "WeekDay", "Crime_frequency")
crimes_weekday$WeekDay <- factor(crimes_weekday$WeekDay, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
head(crimes_weekday[order(-crimes_weekday$Crime_frequency),], 15)
g3 <- ggplot(crimes_weekday, aes(x = crimes_weekday$Category, y = crimes_weekday$Crime_frequency, fill = crimes_weekday$WeekDay)) + geom_histogram(binwidth = .5, alpha = .5, stat = "identity") + theme(axis.title = element_blank(), legend.position = "right", axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) + ggtitle("Crimes in San Francisco by type and day of the week")
g3
