 library(plyr)
 library(dplyr)
 setwd("UCI_HAR_Dataset")                 # setwd("C:/Users/Administrator/CleaningData/UCI_HAR_Dataset")

 test_data = read.table("test/X_test.txt")          #561 columns with default names V1, V2...V561
 train_data = read.table("train/X_train.txt")       #561 columns

 features = read.table("features.txt")              #561 features ( descriptions of columns )
 features = gsub("-|\\(|\\)","",features$V2)        # replacing - ( ) with space and comma with underscore
 features = gsub(",","_",features)                  #561 features as Character vector
 names(test_data)=features
 names(train_data)=features                         #default column names V1, V2... are changed to Features names
 unique_col_names = unique(features)   #only 477 unique columns names  ( 84 columns to be avoided)
#only 86 columns contain words mean and std
 mean_std_unique_col_names = unique_col_names[grepl("(mean|std)",unique_col_names,ignore.case=TRUE)]
 
 #final data to be averaged
 final_test_data = test_data[,mean_std_unique_col_names];
 final_train_data = train_data[,mean_std_unique_col_names];
 
 activity_labels = read.table("activity_labels.txt",as.is=TRUE)
 activity_labels = activity_labels$V2

 #generating Subject and ActivityNames columns for test data
 subject_test = read.table("test/subject_test.txt")
 Y_test = read.table("test/Y_test.txt")
 Y_test_subj_act = mutate(Y_test,Subject=as.character(subject_test$V1), Activity=factor(V1,labels=activity_labels))

 #generating Subject and ActivityNames columns for train data
 subject_train = read.table("train/subject_train.txt")
 Y_train = read.table("train/Y_train.txt")
 Y_train_subj_act = mutate(Y_train,Subject=as.character(subject_train$V1), Activity=factor(V1,labels=activity_labels))

 #combining Subject and ActivityNames columns with Readings columns of test data
 test_data_with_Subject_Activity = mutate(final_test_data, Subject=Y_test_subj_act$Subject, Activity=as.character(Y_test_subj_act$Activity))
 
 #combining Subject and ActivityNames columns with Readings columns of train data
 train_data_with_Subject_Activity = mutate(final_train_data, Subject=Y_train_subj_act$Subject, Activity=as.character(Y_train_subj_act$Activity))

 #combining test and train data
 train_test_data = rbind(train_data_with_Subject_Activity, test_data_with_Subject_Activity)   #10299 records
 
 #calculating average of all 86 numeric columns by grouping on Subject and Activity
 final_means = ddply(train_test_data,.(Subject,Activity),colwise(mean,is.numeric))            #180 rows  88 cols  
