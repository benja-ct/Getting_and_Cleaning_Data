---
title: "README.md"
author: "benja-ct"
date: "Monday, August 18, 2014"
output: html_document
---

# Getting and Cleaning Data Course Project

## Project Scope

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Script

In this repo it has been included all the data files mentioned above as well as the script `run.analysis.R` that contains the necessary instructions to perform the data recovery and cleaning in order to build the two data sets required by the Project.

Specifically, the script:

 * reads both train and test sets data files
 * selects a number of variables and merges the information creating a data set with descriptive names in the variables as well as in the activity types.
 * writes the first tidy data set to `Data_Set1.txt`
 * aggregates the variables by subject and activity type and calculate means
 * creates the second tidy data set
 * writes the second tidy data set to `Data_Set2.txt`
 
To perform the analysis we just have to write at the prompt  
 
```r
source('./run_analysis.R')
```
 
provided the data files within the appropriate folders are located into  the working directory. Otherwise the correct path to the files should be specified with 

```r
setwd()
```
The files containing the tidy data sets will be saved at the working directory in text format.

The **R** script containing the instructions is properly commented. For example:

```r
# and of course, we rename the variables in this data set

names(Data_Set2) <- c("ID_Subject", "ID_activity", "Activity_type", names(x_Sets2)[1])            

# The second step is using a loop to go through all the variables creating a data
# frame similar to the previously built in step one but keeping just the third 
# column which contains the mean at each combination of subject and activity

for (i in 5:ncol(Data_Set1)) {

Data_Set2 [,i] <-aggregate(Data_Set1[,i], by = list(Data_Set1$ID_Subject,
                      Data_Set1$Activity_type), data = Data_Set1, FUN ="mean")[,3]

```
so as to make it more understandable and reproducible.

Finally, there is a Code Book available in the repo in the file `CodeBook.md` for the newly created data sets. 