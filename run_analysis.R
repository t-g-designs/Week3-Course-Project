#Import all data from files into R
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subjectTrain <- read.table("./train/subject_train.txt")
XTrain <- read.table("./train/X_train.txt")
yTrain <- read.table("./train/y_train.txt")
subjectTest <- read.table("./test/subject_test.txt")
XTest <- read.table("./test/X_test.txt")
yTest <- read.table("./test/y_test.txt")

#Determine the dimensions of the data to see how they all fit together

dim(activityLabels)
dim(features)
dim(subjectTrain)
dim(subjectTest)
dim(XTrain)
dim(yTrain)
dim(XTest)
dim(yTest)

# Merge the test and training data together into 1 dataset
# Combine rows of Training and test data for Y
YData <- yTrain
YData <- rbind(YData, yTest)

# Combine the rows of Training and Test data for X
XData <- XTrain
XData <- rbind(XData, XTest)

# Reshape features file so that the rows are now column headers
measurement_names <- features[,2]

# Remove punctuation from column headers to make them easier to use in R
measurement_names <- gsub("-", "", measurement_names)

# Add the column headers to X Dataset
names(XData) <- measurement_names

# Add the subjects from training and test into one dataset
subjData <- subjectTrain
subjData <- rbind(subjData, subjectTest)

# Add all the data for X, Y, and subjects into one new dataset
data <- subjData
data <- cbind(data, YData)
data <- cbind(data, XData)

# Select the columns that contain the mean and std calculations
# Use fixed=TRUE to omit columns with meanFreq in the name
meancols <- grep("mean()", names(data), fixed=TRUE)
stdcols <- grep("std", names(data))

#Merge the 2 vectors from previous step and place in original column order
colNums <- c(meancols, stdcols)
colNums <- sort(colNums)

# Extract the correct columns for the mean and std into a new dataset
# and include the first 2 columns with subject number and activity
meanSTDData <- data[,c(1:2, colNums)]

# Change the integer values in column 2 for more descriptive activity labels
meanSTDData[,2] <- activityLabels[meanSTDData[,2],2]

library(dplyr)

# Relabel column names with more descriptive names
meanSTDData <- rename(meanSTDData, ParticipantNumber=V1, Activity=V1.1)

# Remove _ from Activity Labels
meanSTDData[,2] <- gsub("_", " ", meanSTDData[,2])

# Remove punctuation from Column names and rename them to more descriptive names
names(meanSTDData) <- gsub("[[:punct:]]", "", names(meanSTDData))
names(meanSTDData) <- gsub("tBody", "timeBody", names(meanSTDData))
names(meanSTDData) <- gsub("tGravity", "timeGravity", names(meanSTDData))
names(meanSTDData) <- gsub("Acc", "Accel", names(meanSTDData))
names(meanSTDData) <- gsub("Mag", "Magnitude", names(meanSTDData))
names(meanSTDData) <- gsub("fBody", "FFTBody", names(meanSTDData))
names(meanSTDData) <- gsub("fGravity", "FFTGravity", names(meanSTDData))
names(meanSTDData) <- gsub("BodyBody", "Body", names(meanSTDData))

# Create new tidy dataset which shows the average of each variable for each activity and each subject
# Need to convert dataframe to data table to use dplyr functions
library(data.table)
meanSTDData <- data.table(meanSTDData)

tidyData <- meanSTDData %>% group_by(ParticipantNumber, Activity) %>% summarise_each(funs(mean), meanSTDData[,3:68])

# Create a text file of the tidy data to submit

write.table(tidyData, file="tidyData.txt", sep=" ", row.names = FALSE)


