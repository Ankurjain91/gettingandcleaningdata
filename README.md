# gettingandcleaningdata
Contains files for coursera course - Getting and cleaning data - course project 

####	Files in the repository:
######	run_analysis.R
This is the main R script to perform the analysis.
######	Codebook.pdf
It contains the definition of all the variables present in the dataset.

####	Requirements to run the script:
1)  [Optional] Samsung data should be present in the working directory. Essentially, the working directory should have the “UCI HAR Dataset” directory. All the data should be present maintaining the original directory structure. If however, the directory is not present in the working directory, the run_analysis script will automatically download the data in the current working directory.

2)	[Optional] R package “dplyr” should be installed. If the package is not installed, then the script run_analysis will automatically download and install it.

#### Details of the script:
1)	If the data does not exist, download and extract the original data in working directory.

2)	If the package “dplyr” is not installed, download and install it from the web.

3)	Read the text files constituting test data and variable names.

4)	 Combine all files to create a single test data.

5)	Create the train data in similar manner.

6)	Combine test and train data to create a full data.

7)	Select Volunteer_ID, Activity_ID and all the columns containing either “mean” or “std” in their name, to select only the mean and standard deviation measure.

8)	Remove columns containing either “Freq” or “angle” as those columns do not contain either mean or standard deviation measure.

9)	Read the descriptive activity names and replace Activity_ID with their descriptive names in the complete dataset.

10)	Rename the columns to make them more descriptive.

11)	Group the data by Volunteer_ID and Activity type.

12)	Summarise the data to create mean of each variable, for each unique combination o Volunteer_ID and Activity type.

13)	Display the summarized data.

14)	Write the summarized data to the "summarised_data.txt" in working directory.


#### Testing Conditions:

The script was developed and tested on the computer with the following specifications:

1)	Operating system used: Windows 7 – Home Premium (64-Bit)

2)	Physical memory (RAM): 4 GB

3)	R version 3.1.3

4)	R studio - Version 0.98.1103


