
Overview
========
There are four files I created to clean up the data.  The original data had many measurements that had separate X, Y, and Z values.  The X, Y, Z measurements are in a separate file from those that do not.



Data Dictionary
===============

AxisMeasurements.csv contains the X, Y, Z measurements and uses the following columns

subject  – Test Subject ID 
activity - The activity the subject was doing, taken from activity_labels.txt.
datasource – Whether the data came from the training or test data set in the original data.
measurement – The measurement records
value – The value that was recorded for the measurement.
axis -  The axis the measurement was recorded on.  “X”, “Y” and “Z” are the only available options.

NonAxisMeasurements.csv uses the same fields, except for axis.


AxisAverages.csv and nonAxisAverages.csv takes the data from their respective measurement files and averages the values by Subject and Activity. Both use the same format.
 
subject - Test Subject ID 
activity - The activity the subject was doing, taken from activity_labels.txt.
measurement – The measurement records
avgvalue – the average of the measurements by subject and activity


Detail 
======

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

The Mean and Standard deviation of the variables for each pattern are stored in two files.
The measurements that used 3-axial signals in the X, Y and Z directions are stored in the file axismeasures.csv.  

The measurements collected for these files are below:

anglegravitymean
fBodyAccJerkmean
fBodyAccJerkmeanFreq
fBodyAccJerkstd
fBodyAccmean
fBodyAccmeanFreq
fBodyAccstd
fBodyGyromean
fBodyGyromeanFreq
fBodyGyrostd
tBodyAccJerkmean
tBodyAccJerkstd
tBodyAccmean
tBodyAccstd
tBodyGyroJerkmean
tBodyGyroJerkstd
tBodyGyromean
tBodyGyrostd
tGravityAccmean
tGravityAccstd



The values that did not have an X, Y and Z measurement are sorted in the file nonaxisaverages.csv 

The averages for these measurement is stored in nonaxisaverages.csv

The measurements collected for these files are below:

fBodyAccMagmean
fBodyAccMagmeanFreq
fBodyAccMagstd
fBodyBodyAccJerkMagmean
fBodyBodyAccJerkMagmeanFreq
fBodyBodyAccJerkMagstd
fBodyBodyGyroJerkMagmean
fBodyBodyGyroJerkMagmeanFreq
fBodyBodyGyroJerkMagstd
fBodyBodyGyroMagmean
fBodyBodyGyroMagmeanFreq
fBodyBodyGyroMagstd
tBodyAccJerkMagmean
tBodyAccJerkMagstd
tBodyAccMagmean
tBodyAccMagstd
tBodyGyroJerkMagmean
tBodyGyroJerkMagstd
tBodyGyroMagmean
tBodyGyroMagstd
tGravityAccMagmean
tGravityAccMagstd


The complete list of variables of each feature vector is available in 'features.txt' in the original data available at 


https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is avialable at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
