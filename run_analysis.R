#############################################################################################################################################
##############script analysing the test and train data sets#######################################################################
#############################################################################################################################################
run_analysis <- function(){
    ##################loading features data######################
    #loading List of all features
    rawFeatures <- read.table("features.txt", header= FALSE)
    #renaming colnames
    colnames(rawFeatures) <- c("featureNumber","feature")
    features <- rawFeatures[,2]

    #####loading test related data##############################
    #loading Test set
    rawTestset <- read.table("test/X_test.txt", header = FALSE)
    #rename column names
    colnames(rawTestset) <- features
    #loading Test labels
    rawTestActivity <- read.table("test/y_test.txt", header = FALSE)
    #renaming rawTestActivity column
    colnames(rawTestActivity) <- c("Activity")
    #loading subjects data
    #Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    rawSubjectsTest <- read.table("test/subject_test.txt", header = FALSE)
    #renaming rawSubjectsTest column
    colnames(rawSubjectsTest) <- c("SubjectId")
    #biding subjectId and Activity columns
    subjectsNtestActivity <- cbind(rawSubjectsTest,rawTestActivity)
    #creating the processed test data set
    testData <- cbind(subjectsNtestActivity,rawTestset)

    #####loading train data#########################################################################################
    #loading training set
    rawTrainingset <- read.table("train/X_train.txt", header = FALSE)
    #rename column names
    colnames(rawTrainingset) <- features
    #loading training labels
    rawTrainingActivity <- read.table("train/y_train.txt", header = FALSE)
    colnames(rawTrainingActivity) <- c("Activity")
    #loading subject data
    #Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    rawSubjectsTrain <- read.table("train/subject_train.txt", header = FALSE)
    #renaming rawSubjectsTrain column
    colnames(rawSubjectsTrain) <- c("SubjectId")
    #biding subjectId and Activity columns
    subjectsNtrainActivity <- cbind(rawSubjectsTrain,rawTrainingActivity)
    #creating the processed train data set
    trainData <- cbind(subjectsNtrainActivity,rawTrainingset)

    #######################merging trainData set with testData set ########################################################
    #merges trainData and testData
    processedDataSet <- rbind(testData,trainData)

    #######################extracting columns with mean and standard deviation in it #####################################
    #extract columns with mean() , mean()-X/Y/Z and meanFreq()-X/Y/Z
    proDatasetwithmean <- processedDataSet[,grepl("mean()", colnames(processedDataSet))]
    #loads "dplyr"
    library(dplyr)
    #extract columns with mean() and mean()-X/Y/Z only
    proDatasetwithmeanOnly <- select(proDatasetwithmean,-(c(24,25,26,30,31,32,36,37,38,40,42,44,46)))
    #extract columns with std() and std()-X/Y/Z
    proDatasetwithstd <- processedDataSet[,grepl("std()", colnames(processedDataSet))]
    #merges everything into "messyDataSet"
    messyDataSet <- cbind(processedDataSet[,1:2],proDatasetwithmeanOnly,proDatasetwithstd)

    ##############################renaming Activity values##################################################################
    messyDataSet$Activity <- as.character(messyDataSet$Activity)
    messyDataSet$Activity[messyDataSet$Activity == "1"] <- "WALKING"
    messyDataSet$Activity[messyDataSet$Activity == "2"] <- "WALKING_UPSTAIRS"
    messyDataSet$Activity[messyDataSet$Activity == "3"] <- "WALKING_DOWNSTAIRS"
    messyDataSet$Activity[messyDataSet$Activity == "4"] <- "SITTING"
    messyDataSet$Activity[messyDataSet$Activity == "5"] <- "STANDING"
    messyDataSet$Activity[messyDataSet$Activity == "6"] <- "LAYING"

    ###################################################################
    ###use reshape package to restructuring and aggregating dataset###
    #################################################################
    library(reshape2)
    ##restructures dataset in such way that each observation is in its own row
    tidyDataSet <- melt(messyDataSet,id=(c("SubjectId","Activity")))
    #aggregates the Dataset by subjectId and Activity and computes the mean for each numeric value
    averagedTidyDataSet <- cast(tidyDataSet,SubjectId+Activity~variable,mean)

    #####################writes our tidyDataSet to a file "averagedTidyDataSet"######################
    write.table(averagedTidyDataSet, "averagedTidyDataSet.txt",row.name=FALSE)

    #####prints the first 6 rows of averagedTidyDataSet to the console#############
    return(head(averagedTidyDataSet))
}
