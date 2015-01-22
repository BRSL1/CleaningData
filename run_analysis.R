 library(plyr)
 library(dplyr)
 setwd("UCI_HAR_Dataset")

 test_data = read.table("test/X_test.txt")
 train_data = read.table("train/X_train.txt")

 features = read.table("features.txt")
 features = gsub("-","",features$V2)
 features = gsub("\\(","",features)
 features = gsub("\\)","",features)
 features = gsub(",","_",features)
 names(test_data)=features
 names(train_data)=features
 unique_col_names = unique(names(test_data))
 UQCols_test_data=test_data[,unique_col_names]
 UQCols_train_data=train_data[,unique_col_names]


 mean_std_test_data=select(UQCols_test_data,contains("mean"),contains("std"))
 mean_std_train_data=select(UQCols_train_data,contains("mean"),contains("std"))

 activity_labels = read.table("activity_labels.txt",as.is=TRUE)
 activity_labels = activity_labels$V2


 subject_test = read.table("test/subject_test.txt")
 Y_test = read.table("test/Y_test.txt")
 Y_test_names = mutate(Y_test,Subject=as.character(subject_test$V1), Activity=factor(V1,labels=activity_labels))

 subject_train = read.table("train/subject_train.txt")
 Y_train = read.table("train/Y_train.txt")
 Y_train_names = mutate(Y_train,Subject=as.character(subject_train$V1), Activity=factor(V1,labels=activity_labels))


 test_data_with_Subject_Activity = mutate(mean_std_test_data, Subject=Y_test_names$Subject, Activity=as.character(Y_test_names$Activity))
 train_data_with_Subject_Activity = mutate(mean_std_train_data, Subject=Y_train_names$Subject, Activity=as.character(Y_train_names$Activity))



 train_test_data = rbind(train_data_with_Subject_Activity, test_data_with_Subject_Activity)


 grouped_data = group_by(train_test_data,Subject,Activity)



 final_means = ddply(grouped_data,.(Subject,Activity),colwise(mean,is.numeric))    
 