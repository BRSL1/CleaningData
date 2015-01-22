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


