=============================================================
Project submitted for the Getting and Cleaning Data course
=============================================================
0. Make sure you download the run_analysis.R script and save it inside the "UCI HAR Dataset" directory/folder (the folder that contains all the raw datasets)
1. In RStudio, Set your working directory to "UCI HAR Dataset"
2. Install "dplyr" and "reshape2" packages
3. In the console type source("run_analysis.R") and then run_analysis()

##What run_analysis does
###Loading features data
1. reads into R the data in "features.txt" and stores it into a data.frame named "rawFeatures" with 561 observations of 2 variables
2. renames "rawFeatures" columns into "featureNumber" and "feature"
3. subsets the "feature" column from "rawFeature" data.frame and stores it into factor object named "features"

###Loading test data
4. reads into R the data in "X_test.txt" and stores it into a data.frame named "rawTestset" with 2947 observations of 561 variables
5. renames "rawTestset" columns into corresponding features names using the "features" object
6. reads into R the data in "y_test.txt" and stores it into a data.frame named "rawTestActivity" with 2947 observations of 1 variable
7. renames "rawTestActivity" column into "Activity"
8. reads into R the data in "subject_test.txt" and stores it into a data.frame named "rawSubjectsTest" with 2947 observations of 1 variable
9. renames "rawSubjectsTest" column into "SubjectId"
10. creates a data.frame with "SubjectId" and "Activity" columns named "subjectsNtestActivity"
11. creates a "testData" data.frame with columns "SubjectId", "Activity", and the features names as remaining columns i.e 2947 observations of 563 variables

###Loading train data
12. reads into R the data in "X_train.txt" and stores it into a data.frame named "rawTrainingset" with 7352 observations of 561 variables
13. renames "rawTrainingset" columns into corresponding features names using the "features" object
14. reads into R the data in "y_train.txt" and stores it into a data.frame named "rawTrainingActivity" with 7352 observations of 1 variable
15. renames "rawTrainingActivity" column into "Activity"
16. reads into R the data in "subject_train.txt" and stores it into a data.frame named "rawSubjectsTrain" with 7352 observations of 1 variable
17. renames "rawSubjectsTrain" column into "SubjectId"
18. creates a data.frame with "SubjectId" and "Activity" columns named "subjectsNtrainActivity"
19. creates a "trainData" data.frame with columns "SubjectId", "Activity", and the features names as remaining columns i.e 7352 observations of 563 variables

###Merging trainData set with testData set
20. merges "trainData" and "testData" into "processedDataSet" data.frame of 10299 observations of 563 variables

###Extracting columns with mean and standard deviation in it
21. extracts columns with "mean()", "mean()-X/Y/Z and meanFreq()-X/Y/Z from "processedDataSet" and storing them into "proDatasetwithmean" data.frame of 10299 observations of 46 variables
22. loads "dplyr"
23. extracts columns with mean() and mean()-X/Y/Z only from "proDatasetwithmean" and stores them into "proDatasetwithmeanOnly" data.frame of 10299 observations of 33 variables
24. extracts columns with std() and std()-X/Y/Z from "processedDataSet" and storing them into "proDatasetwithstd" data.frame of 10299 observations of 33 variables
25. merges everything into one data.frame named "messyDataSet" data.frame of 10299 observations of 68 variables

###Renaming Activity values
26. changes "messyDataSet$Activity" values from "Integer" to "character" type
27. replaces all "messyDataSet$Activity" values into corresponding activity's names

###Restructuring and aggregating data set
28. loads "reshape" package
29. restructures dataset in such way that each observation is in its own row and stores it into "tidyDataSet"
30. aggregates the Dataset by subjectId and Activity, computes the mean for each numeric value and stores them into "averagedTidyDataSet"

###Writing the dataset to a ".txt" file
31. writes our "averagedTidyDataSet" to a "averagedTidyDataSet.txt" file inside the working directory

###Printing the first 6 rows of the "averagedTidyDataSet" on the console
32. prints the first 6 rows of the "averagedTidyDataSet" on the console

   **_This is it, hope your reading was smooth..._**
