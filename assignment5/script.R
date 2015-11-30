
setwd("E:/Personal/Repos/DS_at_scale/assignment5")

library(caret)
library(rpart)
library(tree)
library(randomForest)
library(e1071)
library(ggplot2)

seaflow <- read.csv("seaflow_21min.csv")
head(seaflow)

summary(seaflow)

smp_size <- floor(0.5 * nrow(seaflow))
train_ind <- sample(seq_len(nrow(seaflow)), size = smp_size)
trainData <- seaflow[train_ind,]
testData <- seaflow[-train_ind,]

mean(trainData$time)

plot <- ggplot(seaflow, aes(seaflow$pe, seaflow$chl_small, color = seaflow$pop)) + geom_point()
plot

fol <- formula(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
model <- rpart(fol, method = "class", data = trainData)
print(model)

predictData <- predict(model, testData, type = "class")
head(predictData)
accuracy_of_model <- sum(predictData == testData$pop) / length(predictData)
accuracy_of_model
table(pred = predictData, true = testData$pop)
model_rf <- randomForest(fol, data = trainData)
print(model_rf)

predictData <- predict(model_rf, testData)
head(predictData)
accuracy_of_model <- sum(predictData == testData$pop) / length(predictData)
accuracy_of_model
table(pred = predictData, true = testData$pop)
importance(model)

model_svm <- svm(fol, data = trainData)
predictData <- predict(model_svm, testData)
head(predictData)
accuracy_of_model <- sum(predictData == testData$pop) / length(predictData)
accuracy_of_model
table(pred = predictData, true = testData$pop)

t <- subset(trainData, file_id != 208)
tt <- subset(testData, file_id != 208)

plot_new <- ggplot(seaflow, aes(seaflow$time, seaflow$chl_big, color = seaflow$pop)) + geom_point()
plot_new

summary(subset(seaflow, seaflow$file_id != 208))