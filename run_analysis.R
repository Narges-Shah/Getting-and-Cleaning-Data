#Create the Data directory
  if(!file.exists("./G&C_Data"))
    dir.create("./G&C_Data")

#Download and Unzip files
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(url, destfile="./G&C_Data/Dataset.zip", method="curl")
  unzip(zipfile="./G&C_Data/Dataset.zip", exdir="./G&C_Data")
  path <- file.path("./G&C_Data", "UCI HAR Dataset")
  all_files<-list.files(path, recursive=TRUE)

#Read Test and Train Data Regarding each Subject and their Activity
  Act_Test  <- read.table(file.path(path, "test" , "Y_test.txt" ), header = FALSE)
  Act_Train <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)
  Sub_Train <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)
  Sub_Test  <- read.table(file.path(path, "test" , "subject_test.txt"), header = FALSE)

#Extract the list of all wanted features (mean and standard deviation)
  Ftr_Wanted <- grep(".*mean.*|.*std.*", Ftr_Names[,2])
  Ftr_Wanted.names <- Ftr_Names[Ftr_Wanted,2]
  Ftr_Wanted.names = gsub('-mean', 'Mean', Ftr_Wanted.names)
  Ftr_Wanted.names = gsub('-std', 'Std', Ftr_Wanted.names)
  Ftr_Wanted.names <- gsub('[-()]', '', Ftr_Wanted.names)

#Read Test and Train Data on measurements (only wanted features)
  Ftr_Test  <- read.table(file.path(path, "test" , "X_test.txt" ), header = FALSE)[Ftr_Wanted]
  Ftr_Train <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)[Ftr_Wanted]

#Combine Test and Train Data separately: Subject's Number, Subject's Activity and measurements on subject
  Train_Data <- cbind(Sub_Train, Act_Train, Ftr_Train)
  Test_Data <- cbind(Sub_Test, Act_Test, Ftr_Test)

#Combine Test and Train Data 
  Data <- rbind(Train_Data, Test_Data)

#Give names to the columns
  colnames(Data) <- c("Subjects", "Activity", Ftr_Wanted.names)

#Create descriptive names for each Activity and Apply to the Data file
  Act_Labels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
  Data$Activity <- factor(Data$Activity, levels = Act_Labels[,1], labels = Act_Labels[,2])
  
#Replace abbreviations
  names(Data)<-gsub("^t", "time", names(Data))
  names(Data)<-gsub("^f", "frequency", names(Data))
  names(Data)<-gsub("Acc", "Accelerometer", names(Data))
  names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
  names(Data)<-gsub("Mag", "Magnitude", names(Data))
  names(Data)<-gsub("BodyBody", "Body", names(Data))

#Create second data set with average of each variable for each activity and each subject
  library(plyr);
  Data_2nd<-aggregate(. ~Subjects + Activity, Data, mean)
  Data_2nd<-Data_2nd[order(Data_2nd$Subjects, Data_2nd$Activity),]
  write.table(Data_2nd, file = "tidydata.txt", row.name = FALSE)
