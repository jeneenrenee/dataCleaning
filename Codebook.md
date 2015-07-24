**Codebook for run_analysis.R**

The data used for this project (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) consists of two sets of data, one referred to as the 'test' data and one referred to as the 'train' data.  Each of those data sets includes files containing data on 1. Subject: a single column with subject number 2. Activity: a single column with activity number, and 3. Data:  many columns of measurement data and statistics.  The data also includes files for column names for the measurements, and labels corresponding to the activity numbers.  The goal is to combine the 'test' and 'train' data, extract only the mean and standard deviation columns, clean it up, and find the averages for each subject over all activities.  This is done with the script 'run_analysis.R'.


run_analysis.R does the following:

* download and unzip the data files in the current working directory
* rename the data directory to make it easier to work with
* read in the 8 data files (3 for test data, 3 for train data, and 1 each for colunm names and activity labels)
* combine the 3 data files each for test and train into data frames
* label the Subject and Activity columns and change other column names to all lower case
* remove duplicate columns from both test and train data frames
* rbind the test and train data frames into one data frame, arranged by Subject and Activity
* replace the values in the Activity column with their corresponding labels
* extract a data frame containing only columns with names like "mean()" and "std()"
* clean up the column names a bit by removing "()" (see Notes)
* calculate the average for each subject across all activities

**Notes:**
* I didn't think I could improve on the column naming scheme, so I only removed the "()" to make them slightly more readable
* I assumed "bodybody" was a typo and replaced it with "body"

The final data frame is called **SubjectAverages_DF** containing averages of 68 variables over 6 different activities for each of 30 subjects.  There is one row per subject/activity pair.  The column labels are cumbersome, but they contain several pieces of information.  They can be decoded as follows:

* t:  raw data (time domain)
* f:  FFT data (frequency domain)
* body:  body signal
* gravity:  gravity signal
* gyro:  data taken from the gyroscope
* acc:  data taken from the accelerometer
* jerk:  derived jerk signal
* xyz:  3-d axis
* mean:  estimated mean value
* std:  estimated standard deviation
* Example: tbodyacc-mean-x:  mean of the time domain body signal in the x direction, take from the accelerometer

