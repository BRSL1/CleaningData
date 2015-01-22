Getting and Cleaning Data Solution
==================================

Activity codes are maintaining in the files

	1. Y_test.txt
	2. Y_train.txt

~~~R
library(plyr)
library(dplyr)

setwd("UCI_HAR_Dataset")

test_data = read.table("test/X_test.txt")
train_data = read.table("train/X_train.txt")

~~~	
	
	
	
Tables can look like this:

	size  material      color
	----  ------------  ------------
	9     leather       brown
	10    hemp canvas   natural
	11    glass         transparent	