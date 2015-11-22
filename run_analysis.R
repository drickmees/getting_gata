# Those functions is for reading files from the folders 
#"test"(subject_test.txt, X_test.txt and y_test.txt) and "train"(subject_train, X_train and y_train)
# then does labelling and extracts the data for standard deviation and mean... 

datos = function (file_name, folder) {
  path = file.path(folder, paste0("y_", file_name, ".txt"))
  y_data = read.table(path, header=FALSE, col.names = c("ActiviytID"))
  
  path = file.path(folder, paste0("subject_", file_name, ".txt"))
  subject_data = read.table(path, header=FALSE, col.names=c("SubjectID"))
  
  data_columns = read.table("features.txt", header=FALSE, as.is=TRUE, col.names=c("MeasureID", "MeasureName"))
  
  path = file.path(folder, paste0("X_", file_name, ".txt"))
  dataset = read.table(path, header=FALSE, col.names=data_columns$MeasureName)
  
  subset_data_columns = grep(".*mean\\(\\)|.*std\\(\\)", data_columns$MeasureName)
  
  dataset = dataset[, subset_data_columns]
  
  dataset$ActivityID = y_data$ActivityID
  dataset$SubjectID = subject_data$SubjectID
  
  dataset
}

# call function "datos" to read the test dataset...
read_test_data = function() {
  datos("test", "test")
}

# call function "datos" to read the train dataset...
read_train_data = function () {
  datos("train", "train")
}

# merging...
mergeAll = function () {
  dataset = rbind(read_test_data(), read_train_data())
  cnames = colnames(dataset)
  cnames = gsub("\\.+mean\\.+", cnames, replacement = "Mean")
  cnames = gsub("\\.+std\\.+", cnames, replacement = "Std")
  colnames(dataset) = cnames
  dataset
}

# merging whit labels...
labelsForData = function (dataset) {
  activity_labels = read.table("activity_labels.txt", header = FALSE, as.is=TRUE, col.names = c("ActivityID", "ActivityName"))
  activity_labels$ActivityName = as.factor(activity_labels$ActivityName)
  data_labels = merge(dataset, activity_labels)
  data_labels
}

# merging with labels to the merged...
mergeLabelAndData = function () {
  labelsForData(mergeAll())
}

# Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 
datasTidy = function(mergeLabelAndData) {
  library(reshape2)
  
  vars = c("ActivityID", "ActivityName", "SubjectID")
  measure_vars = setdiff(colnames(mergeLabelAndData), vars)
  melted_data <- melt(mergeLabelAndData, id=vars, measure.vars=measure_vars)
  
  dcast(melted_data, ActivityName + SubjectID ~ variable, mean)
}

#Making the clean tidy data
datosTidy =function(file_name){
  tidy_data = datasTidy(mergeLabelAndData())
  write.table(tidy_data, file_name, row.name=FALSE)
}

#Making the file
datosTidy("tidy.txt")
