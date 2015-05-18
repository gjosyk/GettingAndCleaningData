# 1 -  Merge the training and the test sets to create one data set
#setwd("C:\\education\\DataScience\\Getting_and_Cleaning_Data\\UCI HAR Dataset\\")
setwd("C:\\Users\\GJOsyk\\GettingAndCleaningData\\UCI HAR Dataset\\")
trainXData <- read.table("./train/X_train.txt")
trainYLabels <- read.table("./train/y_train.txt")
trainSubjects <- read.table("./train/subject_train.txt")
testXData <- read.table("./test/X_test.txt")
testYLabels <- read.table("./test/y_test.txt")  
testSubjects <- read.table("./test/subject_test.txt")
allXData <- rbind(trainXData, testXData)
allYLabels <- rbind(trainYLabels, testYLabels)
allSubjects <- rbind(trainSubjects, testSubjects)

# 2 -  Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt")
meanStandardDeviation <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinedData <- allXData[, meanStandardDeviation]
# Clean names
names(joinedData) <- gsub("\\(\\)", "", features[meanStandardDeviation, 2])
names(joinedData) <- gsub("-", "", names(joinedData))

# 3 - Use descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt")
activityLabels <- activity[allYLabels[, 1], 2]
allYLabels[, 1] <- activityLabels
names(allYLabels) <- "activity"

# 4 - Appropriately label the data set with descriptive activity nanes
names(allSubjects) <- "subject"
allColumns <- cbind(allSubjects, allYLabels, joinedData)
write.table(allColumns, "merged_data_set.txt")

# 5 - Create a second, independent tidy data set with the avrage of each variable for each activity and each subject 
activityLength <- dim(activity)[1]
columnLength <- dim(allColumns)[2]
subjectLength <- length(table(allSubjects)) 
result <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength) 
result <- as.data.frame(result)
colnames(result) <- colnames(allColumns)
row <- 1
for(i in 1:subjectLength) {
  for(j in 1:activityLength) {
    result[row, 1] <- sort(unique(allSubjects)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    subjectCheck <- i == allColumns$subject
    activityCheck <- activity[j, 2] == allColumns$activity
    result[row, 3:columnLength] <- colMeans(allColumns[subjectCheck1&activityCheck, 3:columnLength])
    row <- row + 1
  }
}
write.table(result, "mean_and_std_dev_data.txt")
