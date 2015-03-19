# Tidy-Data
Tidy Data for Getting and Cleaning Data Course

The code works by first reading in both the activity labels and feature labels. These are labels that assoicate the numbers 1-6 with activity names such as "WALKING" and "SITTING" as well as descriptive names of variables that name measurements of a user, respectively. They are named act and feat, respectively. The code for this follows.

act<-read.table("activity_labels.txt",header=FALSE,col.names=c("activity","name")) #activity labels
feat<-read.table("features.txt",header=FALSE)       #feature labels (in column 2)

Next the test data set is read into R (this is data obtained from subjects assigned to the 'test' group) and only the variables that correspond to mean or standard deviation measurements (in either time or frequency domain)  are used by applying a subset procedure. The subsetted data is given the name xtest. The code for this follows.

xtest<-read.table("X_test.txt",header=FALSE,sep="",col.names=feat[,2])   #test set data with feature labels
xtest<-xtest[,(grepl("mean",colnames(xtest))|grepl("std",colnames(xtest)))] #subsets the columns so that only the column names with mean "mean" or standard deviation "std" are included (in both time 't' and frequency 'f' domain)

Similar to the test data set, the training data set is read into R (this is data obtained from subjects assigned to the 'train' group) and only the variables that correspond to mean or standard deviation measurements (in either time or frequency domain)  are used by applying a subset procedure. The subsetted data is given the name xtrain. The code for this follows.

xtrain<-read.table("X_train.txt",header=FALSE,sep="",col.names=feat[,2])  #train set data with feature labels
xtrain<-xtrain[,(grepl("mean",colnames(xtrain))|grepl("std",colnames(xtrain)))] #subsets the columns so that only the column names with mean "mean" or standard deviation "std" are included (in both time 't' and frequency 'f' domain)

Next, files that associate observations with subject numbers for both the test and train data sets are read into R. The names are subtest and subtrain, respectively. The code for this follows.

subtest<-read.csv("subject_test.txt",header=FALSE,col.names="subject")   #subject codes for test set, naming variable subject
subtrain<-read.csv("subject_train.txt",header=FALSE,col.names="subject") #subject codes for train set, naming variable subject

Also, files that associate observations with activities for both the test and train data sets are read into R. The names are ytrain and ytest, respectively. THe code for this follows.

ytrain<-read.csv("Y_train.txt",header=FALSE,col.names="activity") #activity codes for test set
ytest<-read.csv("Y_test.txt",header=FALSE,col.names="activity")   #activity codes for train set

Next, the observations in the test data set are 'attached' with the subject number associations and the acitivity associations and called xts. A similar procedure is applied to the train data set and the output set is called xtr. The code for this follows.

xts<-cbind(subtest,ytest,xtest) 
xtr<-cbind(subtrain,ytrain,xtrain)

Now, the activity, subject-labelled observations for the train and test data sets are concatenated into one data frame called x. Further, the labels for activities (numbers 1-6) are converted to their proper names using the act data frame. The code for these two tasks follows (in order).

x<-rbind(xts,xtr) #combines the test and train data with subject identifier and activity label
for(i in 1:6){x[x$activity==i,]$activity<-as.character(act[i,2])} #labels the numbered activities with their labels from the act data frame

The above code accomplishes steps 1-4 in the course assignment. What follows transforms the x data frame to accomplish task 5 in the assignment. First, in order to melt and cast the data in a new way, the reshape2 library must be loaded.

library(reshape2) #loads library in order to melt and cast data set

Next the x data frame containing all observations on mean and standard deviation measurements with both activity and subject-number labels is melted (and called xmelt) so that there is on observation for each unique combination of subject, activity, and measure variable (ordered by subject, then activitiy, then(measurement) variable). The code for this follows.

xmelt<-melt(x,id=c("subject","activity"),measure.vars=colnames(x[,3:ncol(x)])) #melts the binded set x for easier manipulation
xmelt<-xmelt[order(xmelt$subject,xmelt$activity,xmelt$variable),] #orders the melted data set by subject then activity, then feature variable 

Next, the melted data can be recast to make analysis easier. Specifically, the resulting cast data frame called xcast gives the mean for each unique combination of subject number and activity, e.g. categories like subject 10 and "SITTING." This is done with the dcast function and the code follows.

xcast<-dcast(xmelt,subject+activity~variable,mean) #recasts the melted data set giving the mean of each feature variable for each unique combination of subject and activity

Finally, the xcast (which has the summarized information, i.e. means for each unique subject-number-activity-label pair for each measurement involving a mean or standard deviation in either the time or frequency domain) is written out to a table. The code for this follows.

write.table(xcast,file="tidy_data.txt",row.name=FALSE) #creates output file


