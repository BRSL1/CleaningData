Code Book
=========
This Code Book describes the variables, the data, and the transformations and work that I performed to clean up the data as part of the [**Coursera**](http://www.coursera.org)'s project **Getting and Cleaning Data** 

Here's a the link to [my final data set](https://s3.amazonaws.com/coursera-uploads/user-19e115787c80679a2336524b/973497/asst-3/3bd9f440a3c211e4901c7175d6058a45.txt) that contains required averages

My final data set contains...
* 2 Character Variables and
* 86  Numeric Variables called -Features-
* 180 Rows

![1st 6 Final Averages](/images/final_head.png "1st 6 Final Averages")

![Last 6 Final Averages](/images/final_tail.png "Last 6 Final Averages")


#####Transformations that I have done
* extracted Descriptions of features from **features.txt** file
* converted Descriptions into a single word by removing special symbols like **-  (  )  ,**
* replaced default data column names "V1", "V2", "V3" etc., with Features Descriptions
* later, extracted only data columns containing words **mean** and **std** from both **test** and **train** data
* finally, I got only **86 Features** containing words **mean** and **std** out of total **561**

#####New Columns that I have added
* Activity IDs from **Y_test.txt** and **Y_train.txt** files are converted to their Descriptions
* **Subject** and **Activity** columns separately for **test and train** data 
* for adding new columns I have used the function **mutate()** of **dplyr** package

###Merging test and train data and finding Final Averages
* using **rbind()** function, I combined **test data** (2947 rows) and **train data** (7352) rows into a single data set (**10299 rows**)
* ![Last 6 Final records](/images/before_average.png "Last 6 Final records")

* using the function **ddply()** from the package **plyr**, I grouped data on **Subject and Activity** columns and calculated **mean** of all **numerical** columns
~~~R
#calculating average of all 86 numeric columns by grouping on Subject and Activity
 final_means <- ddply(train_test_data,.(Subject,Activity),colwise(mean,is.numeric))   #180 rows  88 cols  
~~~

#####Data Dictionary  My Tidy Data

	-----------	----	-----------		------------	---------------------------------------------------------
	Variable	size	Description		Values			Value Explanation
	-----------	----	-----------		------------	---------------------------------------------------------
	Subject		2		Subject ID		1,2,3,4...30	IDs of a group of 30 volunteers within an age bracket of 
														19-48 years who performed **SIX activities** of daily 
														living (ADL) while carrying a waist-mounted smartphone 
														with embedded inertial sensors.
	
	Activity	1		Activity ID		1				WALKING
										2				WALKING_UPSTAIRS
										3				WALKING_DOWNSTAIRS
										4				SITTING
										5				STANDING
										6				LAYING
	
	tBodyAccmeanX
	tBodyAccmeanY
	tBodyAccmeanZ
	tBodyAccstdX
	tBodyAccstdY
	tBodyAccstdZ
	tGravityAccmeanX
	tGravityAccmeanY
	tGravityAccmeanZ
	tGravityAccstdX
	tGravityAccstdY
	tGravityAccstdZ
	tBodyAccJerkmeanX
	tBodyAccJerkmeanY
	tBodyAccJerkmeanZ
	tBodyAccJerkstdX
	tBodyAccJerkstdY
	tBodyAccJerkstdZ
	tBodyGyromeanX
	tBodyGyromeanY
	tBodyGyromeanZ
	tBodyGyrostdX
	tBodyGyrostdY
	tBodyGyrostdZ
	tBodyGyroJerkmeanX
	tBodyGyroJerkmeanY
	tBodyGyroJerkmeanZ
	tBodyGyroJerkstdX
	tBodyGyroJerkstdY
	tBodyGyroJerkstdZ
	tBodyAccMagmean
	tBodyAccMagstd
	tGravityAccMagmean
	tGravityAccMagstd
	tBodyAccJerkMagmean
	tBodyAccJerkMagstd
	tBodyGyroMagmean
	tBodyGyroMagstd
	tBodyGyroJerkMagmean
	tBodyGyroJerkMagstd
	fBodyAccmeanX
	fBodyAccmeanY
	fBodyAccmeanZ
	fBodyAccstdX
	fBodyAccstdY
	fBodyAccstdZ
	fBodyAccmeanFreqX
	fBodyAccmeanFreqY
	fBodyAccmeanFreqZ
	fBodyAccJerkmeanX
	fBodyAccJerkmeanY
	fBodyAccJerkmeanZ
	fBodyAccJerkstdX
	fBodyAccJerkstdY
	fBodyAccJerkstdZ
	fBodyAccJerkmeanFreqX
	fBodyAccJerkmeanFreqY
	fBodyAccJerkmeanFreqZ
	fBodyGyromeanX
	fBodyGyromeanY
	fBodyGyromeanZ
	fBodyGyrostdX
	fBodyGyrostdY
	fBodyGyrostdZ
	fBodyGyromeanFreqX
	fBodyGyromeanFreqY
	fBodyGyromeanFreqZ
	fBodyAccMagmean
	fBodyAccMagstd
	fBodyAccMagmeanFreq
	fBodyBodyAccJerkMagmean
	fBodyBodyAccJerkMagstd
	fBodyBodyAccJerkMagmeanFreq
	fBodyBodyGyroMagmean
	fBodyBodyGyroMagstd
	fBodyBodyGyroMagmeanFreq
	fBodyBodyGyroJerkMagmean
	fBodyBodyGyroJerkMagstd
	fBodyBodyGyroJerkMagmeanFreq
	angletBodyAccMean_gravity
	angletBodyAccJerkMean_gravityMean
	angletBodyGyroMean_gravityMean
	angletBodyGyroJerkMean_gravityMean
	angleX_gravityMean
	angleY_gravityMean
	angleZ_gravityMean
	-----------	----	-----------		--------		----------------------------------------------------------


