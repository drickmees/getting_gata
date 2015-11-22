# getting_gata
##  Getting and Cleaning Data Course Project - Coursera

Ths scripts works:
 Step 1: Merging the datas from training files and the test files in one data set...
 Step 2: Doing measurements on the mean and standard deviation for each measurement and make the data set...
 Step 3: Using descriptive activity names to name the activities in the data set..
 Step 4: Appropriately labeling the data set with descriptive activity names...
 Step 5: Creating a second, independent tidy data set with the average of each variable for each activity and each subject...

"run_analysis.R" imports the test and training datasets  from each folder and merge them to dataframe, with the columns named from the features.txt file provided in the archive. This data frame is returned from the function "datos", meeting the requirements of the assignment. Then, calculatd means and standard deviations of these sets of data - one each for the X, Y and Z dimensions: tBodyAcc-X, tBodyAcc-Y, tBodyAcc-Z, tBodyGyro-X, tBodyGyro-Y, tBodyGyro-Z. Labels for activitys are converted from numeric vectors to text with the corresponding text activity label using the mapvalues function from plyr, and this factor is added to the data frame containing all the mean and standard deviation observations. An additional column containing the subject id for each observation is also included. At last, the tidy data are maked by the script datosTidy("tidy.txt").





