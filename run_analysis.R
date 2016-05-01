# Assignment
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

########################################## 
### SET UP
##########################################
### Load Libraries
library(dplyr)
library(tidyr)
#library(RCurl)

# Set your working directory
wd <- "~/Documents/OneDrive/Data science/Assignments/Cleaning Data Project"
setwd(wd)

### Download data if not available in your work directory
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(url, "dataset.zip", method ="auto")
#unzip ("dataset.zip", exdir = "./")

########################################## 
### END OF SET UP
########################################## 


########################################## 
## Preparation of Activity Lables and Features. 
## These two variables will be joined below with the test and trained data set.
########################################## 

# Read Activity_Labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header= FALSE) 
names(activity_labels) <- c("id_activity_labels","activity") #Set column names

# Read Features
features <- read.csv("UCI HAR Dataset/features.txt", header= FALSE, sep="")
names(features) <- c("feature_id", "feature") #Set column names

# Extract variables to be presented Mean & Standard Deviation (std)
filtered_features <- features %>% filter(grepl('[Mm]ean|[Ss]td',feature )) #86 features includes mean or std

# Clean up
rm(features)


####################################
## Reading and preparing Train data
####################################
# Read Subject_train = Who did it
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header= FALSE)
names(subject_train) <- "subject"

# Read y_train = Activity labels and join it with Activity Lables --> get descriptive labels
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", header= FALSE)
names(y_train) <- "id_activity_labels"
y_train <- left_join(y_train, activity_labels, by = "id_activity_labels") # Adding activity labels


# Read x_train data set and join
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", header= FALSE)
# Select columns to be used by using filtered_features
filtered_x_train <- x_train %>% select(filtered_features$feature_id)
names(filtered_x_train) <- filtered_features$feature #Add column names

# Add features and activity labels to data set
df_train <- bind_cols(subject_train, y_train, filtered_x_train)

# clean up
rm(subject_train)
rm(y_train)
rm(filtered_x_train)
rm(x_train)

### END OF TRAIN DATA SET PREPARATION


####################################
## Reading and preparing TEST data
####################################
# Read Subject_test = Who did it
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header= FALSE)
names(subject_test) <- "subject"

# Read y_test = Activity labels and join it with Activity Lables --> get descriptive labels
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", header= FALSE)
names(y_test) <- "id_activity_labels"
y_test <- left_join(y_test, activity_labels, by = "id_activity_labels") # Adding activity labels

# Read x_test data set and join
x_test <- read.table("UCI HAR Dataset/test/x_test.txt", header= FALSE)
# Select columns to be used by using filtered_features
filtered_x_test <- x_test %>% select(filtered_features$feature_id)
names(filtered_x_test) <- filtered_features$feature #Add column names


# Add features and activity labels to data set
df_test <- bind_cols(subject_test, y_test, filtered_x_test)

# clean up
rm(subject_test)
rm(y_test)
rm(filtered_x_test)
rm(x_test)

### END OF TEST DATA SET PREPARATION


##### JOIN TRAIN AND TEST DATA SET 
## AND GROUP ON subject, activity_labels and calculate average on all variables
##################################

group_of_subject_activity <- bind_rows(df_train, df_test) %>% 
        select(-c(id_activity_labels)) %>% #remove a column not needed
        group_by(subject, activity) %>% #group on subject, activity_labels
        summarise_each(funs(mean)) #calculate average for all variables

# Save Tidy data set to file 
write.table(group_of_subject_activity,"group_of_subject_activity.txt", row.names = FALSE)


# clean up
rm(df_train)
rm(df_test)
rm(activity_labels)
rm(filtered_features)
