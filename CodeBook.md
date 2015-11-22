CodeBook
Narges Shahhoseini

November 21, 2015

###Run_analysis.R:
An R script to cretae a tidy dataset from all of the data collected from an experiment 

#Overview of the Data:
Human Activity Recognition database based on the recordings of 30 subjects while doing activities (daily routines like walking or going up the stairs). Every subject wears a waist-mounted smartphone with inertial sensors.

#Data Collection:
A group of 30 volunteers aged betwenn 19-48 years
Each person performed six activities:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

The subjects were wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured
The experiments have been recorded and each of them were labeled manually. The resulted data was randomly partitioned into two sets (70% for training data and 30% the test data).

##Step 1: 
R Script run_analysis at first downloads the zip file and saves it as ./G&C_Data/Dataset.zip in the working directory
Next Dataset.zip will be unzipped to ./G&C_Data directory of working directory. Now there should be a directory called “UCI HAR Dataset” which contains all files needed:

	list.files("./G&C_Data/UCI HAR Dataset")
	## [1] "activity_labels.txt" "features_info.txt"   "features.txt"       
	## [4] "README.txt"          "test"                "train"

Files:
* features_info.txt: Shows information about feature vector
* features.txt : List of all features (561 features) 
* activity_labels.txt: Actvity name for every activity labels (6 activities)
* README.txt: Infromation about all files and the whole experiment

Directories:
* test: Datasets regarding test group
  * X_test.txt: Test set
  * y_test.txt: Test labels 
  * subject_test.txt: subject who performed the test

* train: Datasets regarding train group
  * X_train.txt: Training set 
  * y_train.txt: Training labels 
  * subject_train.txt: subject who performed the test


Unit of Measurement: 
Features are all raw signals from the accelerometer (tAcc-XYZ) and gyroscope 3-axial (tGyro-XYZ) at a constant rate of 50 Hz. Values for features inside the tables are all normalized and bounded within [-1,1].

##Step 2: 
In the next step run_analysis.R reads the subjects and their activities data from Test and Train datasets into:
* Act_Test: Test group activity data (2947 by 1)
* Sub_Test: Test group subjects data (2947 by 1) 
* Act_Train: Train group activity data (7352 by 1)
* Sub_Train: Train group subjects data (7352 by 1) 

##Step 3: 
Then list of all wanted features (mean and standard deviation) are gathered in Ftr_Wanted (a 79 length vector).

##Step 4:
At this point Run_analysis.R reads Test and Train Data on measurements (only wanted features):
* Ftr_Test: Wanted features for test group (2947 by 79)
* Ftr_Train: Wanted features for train group (7532 by 79)

##Step 5:
It's time to Combine Test and Train Data separately: 
* Train_Data: Subject, Activity and feature measurements in training set (7352 by 81)
* Test_Data: Subject, Activity and feature measurements in test set (2947 by 81)

##Step 6:
Now that all the data are extracted, the data for training and test data needs to be combined:
* Data: all data - test and training (10299 by 81)

##Step 7:
Then the script gives descriptive names to the columns of Data and replace all the abbreviations with full words

##Step 8:
And finally it's time for run_analysis.R to create a second dataset with average of each variable for each activity and each subject:
* Data_2nd: average of each variable for every subject (180 by 81)

##Step 9:
A file named tidy.txt is created based on Data_2nd dataset and saved in "./G&C_Data" subdirectory of the working directory.

