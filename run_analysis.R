# download and unzip dataset

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "Dataset.zip")
("Dataset.zip", exdir=".")
file.rename("UCI HAR Dataset", "Dataset")

# read in data

testSubjects <- read.table("Dataset/test/subject_test.txt")
testActivity <- read.table("Dataset/test/y_test.txt")
testData <- read.table("Dataset/test/X_test.txt")

trainSubjects <- read.table("Dataset/train/subject_train.txt")
trainActivity <- read.table("Dataset/train/y_train.txt")
trainData <- read.table("Dataset/train/X_train.txt")

DataColNames <- read.table("Dataset/features.txt")
ActivityLabel <- read.table("Dataset/activity_labels.txt")

# combine test and train data into data frames, rename columns and remove duplicate columns

ColNames <- c("Subject","Activity",tolower(as.character(DataColNames[,2])))

test_DF <- cbind(testSubjects, testActivity, testData)
names(test_DF) <- ColNames
test_DF <- test_DF[,!duplicated(colnames(test_DF))]

train_DF <- cbind(trainSubjects, trainActivity, trainData)
names(train_DF) <- ColNames
train_DF <- train_DF[,!duplicated(colnames(train_DF))]

# bind test and train data frames together and arrange by Subject and Activity

testTrain_DF <- rbind(test_DF,train_DF) %>% arrange(Subject, Activity)

# replace values in Activity column with corresponding Activity label

testTrain_DF$Activity <- ActivityLabel[testTrain_DF$Activity,2]

# extract mean and standard deviation columns, and cbind them together

SubjectActivity <- testTrain_DF[c("Subject","Activity")]
Mean_DF <- testTrain_DF[grep("mean\\()",names(testTrain_DF))]
STD_DF <- testTrain_DF[grep("std\\()",names(testTrain_DF))]
MeanSTD_DF <- cbind(SubjectActivity, Mean_DF, STD_DF)


# clean up the column names a bit

cleanNames <- gsub("\\()","", names(MeanSTD_DF))
cleanNames <- gsub("bodybody", "body", cleanNames)
names(MeanSTD_DF) <- cleanNames
                   
# Calculate the averages by Student and Activity

subjectAverages_DF <- ddply(MeanSTD_DF, .(Subject,Activity),colwise(mean))


