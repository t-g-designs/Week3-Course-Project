# Week3-Course-Project

The run_analysis.R file contains the script which will take all the raw data files and merge them into a tidy Dataset which can be used for analysis.

**Note: run_analysis should be downloaded into the UCI HAR Dataset directory which contains the test and train sub-directories in order for the code to work. The UCI HAR Dataset should also be set as your working directory.**

The following packages will need to be installed: *dplyr, data.table.* 

Here is a list of all the steps that the code performs:

### Importing Data and Determining Structure
  1. Imports all data files into R.
  2. Determines the dimensions of the data to see how they all fit together.

### Merging the test and training data together into 1 dataset
  3. Combines the rows from Training and test data for Y.
  4. Combines the rows from Training and Test data for X.
  5. Reshapes the features file so that the rows are now column headers.
  6. Removes punctuation from column headers to make them easier to use in R.
  7. Combines the column headers from previous step to X Dataset.
  8. Combines the subjects from training and test data into one dataset.
  9. Combines all the data for X, Y, and subjects into one new dataset.

### Extracts the columns that contain mean and STD calculations into a new dataset
  10. Selects the columns that contain the mean and std calculations.
  11. Extracts these columns into a new dataset and includes the first 2 columns with subject number and activity.

### Changes column headers to more descriptive names and changes the activity numbers to names
  12. Relabels column names with more descriptive names.
  13. Removes _ from Activity Labels.
  14. Removes punctuation from Column names and rename them to more descriptive names.

### Creates new tidy dataset which shows the average of each variable for each activity and each subject
  15. Creates a new dataset by using data.table and dplyr functions group_by and summarise_each. 

### Creates a txt file of tidy Dataset
