![tidy](/images/tidy_time.png)
## R language Code behind Tidying the data

#### Wearable Computing
One of the most exciting areas in all of data science right now is wearable computing. 
![PhoneMotion](/images/phone_motion.png)

The data for this project is collected from **Human Activity Recognition database** built from the recordings of 30 subjects (volunteers) performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. The purpose of this project is to **collect and clean a data set** that is collected from the HAR database.

#### Code Overview
* extracting test and train data having columns containing **mean** and **std** words
* attaching appropriate Activity names to Activity Ids
* adding Subject and Activity columns to Features columns
* combining test and train data sets
* creating a final Tidy data set with the average of each Feacture for each Subject and Activity

#### Code Explanation

###### importing required packages and setting the default directory
~~~R
 library(plyr)
 library(dplyr)
 setwd("UCI_HAR_Dataset")                 
~~~

###### loading experimental readings into R data frames
* each row of both test data and train data contains values of **561 variables**(Columns)
* initially column names are **V1** **V2** **V3** ... **V561**
~~~R
 test_data  <- read.table("test/X_test.txt")    
 train_data <- read.table("train/X_train.txt")
~~~

###### tidying the names of features
* total features are **561**
* replacing - ( ) with space and comma with underscore
* replacing test and train data columns names V1, V2... with Feature's descriptions
~~~R
 features <- read.table("features.txt")          
 features <- gsub("-|\\(|\\)","",features$V2)     
 features <- gsub(",","_",features)
 
 names(test_data)  <- features
 names(train_data) <- features          
~~~

## 86/561
###### extracting only those columns which contain **mean** and **std** words in them
* out of 561 columns there are **84 repeated** columns
* so unique columns are **477**. out of them only **86 columns** contain words **mean** and **std** 
~~~R 
 unique_col_names          <- unique(features)  
 mean_std_unique_col_names <- unique_col_names[grepl("(mean|std)",unique_col_names,ignore.case=TRUE)]

 final_test_data  <- test_data[,mean_std_unique_col_names];
 final_train_data <- train_data[,mean_std_unique_col_names];
~~~

###### attaching Subject and Activity columns for test and train data 
~~~R
 activity_labels <- read.table("activity_labels.txt",as.is=TRUE)
 activity_labels <- activity_labels$V2

 # generating Subject and ActivityNames columns for test data
 subject_test <- read.table("test/subject_test.txt")
 Y_test <- read.table("test/Y_test.txt")
 Y_test_subj_act <- mutate(Y_test,Subject=as.character(subject_test$V1), Activity = factor(V1, labels = activity_labels))

 # generating Subject and ActivityNames columns for train data
 subject_train <- read.table("train/subject_train.txt")
 Y_train <- read.table("train/Y_train.txt")
 Y_train_subj_act <- mutate(Y_train,Subject=as.character(subject_train$V1), Activity = factor(V1, labels = activity_labels))

 # combining Subject and ActivityNames columns with Readings columns of test data
 test_data_with_Subject_Activity <- mutate(final_test_data, Subject=Y_test_subj_act$Subject, Activity = as.character(Y_test_subj_act$Activity))
 
 # combining Subject and ActivityNames columns with Readings columns of train data
 train_data_with_Subject_Activity <- mutate(final_train_data, Subject=Y_train_subj_act$Subject, Activity = as.character(Y_train_subj_act$Activity))
~~~

#### Final Steps
* combining test and train data ( total 10299 records )
* calculating average of all 86 numeric columns by **grouping on Subject and Activity** 
* total aggregated records are **180**
~~~R
 train_test_data <- rbind(train_data_with_Subject_Activity, test_data_with_Subject_Activity)
 final_means     <- ddply(train_test_data,.(Subject,Activity),colwise(mean,is.numeric))  
~~~
![1st 6 Final Averages](/images/final_head.png "1st 6 Final Averages")

![Last 6 Final Averages](/images/final_tail.png "Last 6 Final Averages")
