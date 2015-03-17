act<-read.table("activity_labels.txt",header=FALSE,col.names=c("activity","name")) #activity labels
feat<-read.table("features.txt",header=FALSE)       #feature labels (in column 2)

xtest<-read.table("X_test.txt",header=FALSE,sep="",col.names=feat[,2])   #test set data with feature labels
xtest<-xtest[,(grepl("mean",colnames(xtest))|grepl("std",colnames(xtest)))] #subsets the columns so that only the column names with mean "mean" or standard deviation "std" are included (in both time 't' and frequency 'f' domain)

xtrain<-read.table("X_train.txt",header=FALSE,sep="",col.names=feat[,2])  #train set data with feature labels
xtrain<-xtrain[,(grepl("mean",colnames(xtrain))|grepl("std",colnames(xtrain)))] #subsets the columns so that only the column names with mean "mean" or standard deviation "std" are included (in both time 't' and frequency 'f' domain)

subtest<-read.csv("subject_test.txt",header=FALSE,col.names="subject")   #subject codes for test set, naming variable subject
subtrain<-read.csv("subject_train.txt",header=FALSE,col.names="subject") #subject codes for train set, naming variable subject

ytrain<-read.csv("Y_train.txt",header=FALSE,col.names="activity") #activity codes for test set
ytest<-read.csv("Y_test.txt",header=FALSE,col.names="activity")   #activity codes for train set

#ytrain_lab<-as.data.frame(merge(ytrain,act,by="activity",sort=FALSE)[,2]) #labeled activities ordered by training data
#ytest_lab<-as.data.frame(merge(ytest,act,by="activity",sort=FALSE)[,2]) #labeled activities ordered by training data
#colnames(ytest_lab)<-"activity"   #gives correct column name
#colnames(ytrain_lab)<-"activity"  #gives correct column name

#xts<-cbind(subtest,ytest_lab,xtest) #combines subject number, labeled activity, and test data by column
#xtr<-cbind(subtrain,ytrain_lab,xtrain) #combines subject number, labeled activity, and train data by column

xts<-cbind(subtest,ytest,xtest) 
xtr<-cbind(subtrain,ytrain,xtrain)

x<-rbind(xts,xtr) #combines the test and train data with subject identifier and activity label
for(i in 1:6){x[x$activity==i,]$activity<-as.character(act[i,2])} #labels the numbered activities with their labels from the act data frame

library(reshape2) #loads library in order to melt and cast data set

xmelt<-melt(x,id=c("subject","activity"),measure.vars=colnames(x[,3:ncol(x)])) #melts the binded set x for easier manipulation
xmelt<-xmelt[order(xmelt$subject,xmelt$activity,xmelt$variable),] #orders the melted data set by subject then activity, then feature variable 

xcast<-dcast(xmelt,subject+activity~variable,mean) #recasts the melted data set giving the mean of each feature variable for each unique combination of subject and activity

write.table(xcast,file="tidy_data.txt",row.name=FALSE) #creates output file
