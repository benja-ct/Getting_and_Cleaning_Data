# Data folder has been saved into the working directory
# so we start by reading the different data files
# 
# First we read the description files

activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")


# Second we read the train set files

Subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# And finally we read the test set files

Subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# We assign names to the variables in the files previously read

names(activity) <- c("id_activity", "Activity_Type")
names(Subject_train) <- "ID_Subject"
names(Subject_test) <- "ID_Subject"
names(x_train) <- features$V2 
names(x_test) <- features$V2
names(y_train) <- "ID_activity" 
names(y_test) <- "ID_activity"

# We build the data set  from the 3 types of information but previously
# it is needed to join both train sets and test sets

x_Sets <- rbind(x_train, x_test)
y_Sets <- rbind(y_train, y_test)
subject_Sets <- rbind(Subject_train, Subject_test)

# Our data set only includes data from 'mean' and 'standard deviation' variables
# so we capture the position of such variables using grep()

meanstd <- grep("mean|std", names(x_Sets))

# and then we subset according to such vector meanstd

x_Sets2 <- x_Sets[,meanstd]

# We have to label each activity with its description. I do it by indexing

y_Sets$Activity_type <- y_Sets$ID_activity
y_Sets$Activity_type[y_Sets$Activity_type==1] <- "WALKING"
y_Sets$Activity_type[y_Sets$Activity_type==2] <- "WALKING_UPSTAIRS"
y_Sets$Activity_type[y_Sets$Activity_type==3] <- "WALKING_DOWNSTAIRS"
y_Sets$Activity_type[y_Sets$Activity_type==4] <- "SITTING"
y_Sets$Activity_type[y_Sets$Activity_type==5] <- "STANDING"
y_Sets$Activity_type[y_Sets$Activity_type==6] <- "LAYING"

# and finally the first data set is complete just when joining the columns of
# the aforementioned subsets

Data_Set1 <- cbind(subject_Sets, y_Sets, x_Sets2)

# and we write it as a txt file

write.table(Data_Set1, file = "Data_Set1.txt", row.names = FALSE)

# In order to create the second data file I need to expand the different
# combinations of the different subjects with the different activities and
# then add up the means by columns for each of the variables evaluated at
# these combinations as if they were interacting levels of factors. To ensure
# we are including all of them we use aggregate, in two steps:
# First step is creating a dataframe with some descriptive columns with unique
# values of the combinations of subjects and activity lebels -both as number and
# as a character label, just like in the first data file

Data_Set2 <-aggregate(Data_Set1[,4], by = list(Data_Set1$ID_Subject,
          Data_Set1$ID_activity, Data_Set1$Activity_type), 
          data = Data_Set1, FUN ="mean")

# and of course, we rename the variables in this data set

names(Data_Set2) <- c("ID_Subject", "ID_activity", "Activity_type", names(x_Sets2)[1])            

# The second step is using a loop to go through all the variables creating a data
# frame similar to the previously built in step one but keeping just the third 
# column which contains the mean at each combination of subject and activity

for (i in 5:ncol(Data_Set1)) {

Data_Set2 [,i] <-aggregate(Data_Set1[,i], by = list(Data_Set1$ID_Subject,
                      Data_Set1$Activity_type), data = Data_Set1, FUN ="mean")[,3]

}

# and we rename the variables created accordingly

names(Data_Set2)[5:ncol(Data_Set2)] <- names(Data_Set1)[5:ncol(Data_Set1)]        

# and the data set is done ready to be saved using write.

write.table(Data_Set2, file = "Data_Set2.txt", row.names = FALSE)

