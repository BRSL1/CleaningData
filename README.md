Getting and Cleaning Data Solution
==================================

Activity codes are maintaining in the files

	1. Y_test.txt
	2. Y_train.txt

~~~R
library(plyr)
library(dplyr)
~~~

> plyr package is for finding
> mean of all numeric variables 
>
> at the last step of the analysis

~~~R
setwd("UCI_HAR_Dataset")

test_data = read.table("test/X_test.txt")
train_data = read.table("train/X_train.txt")
~~~	
	
The folder **UCI_HAR_Dataset** contains the data

X files contain 561 variables. 
Both test and train data have been loaded.

at the end of step 2 you have a data frame with 10299 observations and about 70 columns

At the end of step 5 you have a new data frame with 180 observations and about 70 columns. 

The new frame contains the mean value of each variable averaged across all cases of the same subject and activity - hence 180 observations = 30 subjects x 6 activities.



![example image](/images/result1.jpg "An exemplary image")

![example image](https://github.com/HANAGA/CleaningData/blob/master/images/result1.jpg "An exemplary image")



