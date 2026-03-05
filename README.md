# R-Programming
Statistics with R
Introduction

This assignment explores key statistical concepts using the R programming language. The objective is to apply techniques such as data extraction, statistical summarization, visualization, and regression analysis to develop practical skills in analysing and interpreting real-world data using R.

Part 1: Data Analysis Using R
Data Source

The dataset used in this assignment was obtained from the World Bank DataBank, specifically inflation rate data.

Source:
https://databank.worldbank.org/reports.aspx?source=2&series=FP.CPI.TOTL.ZG&country=

The data was downloaded and then imported into RStudio for further analysis.

Importing the Dataset into R

After downloading the dataset, it was imported into RStudio for analysis and statistical computation.

Basic Statistical Measures

Several statistical measures were calculated to understand the central tendency and variability of the dataset.

Mean

The mean represents the average value of the inflation data.

mean(statsr$Inflation)

Median

The median represents the middle value of the dataset.

median(statsr$Inflation)

Mode

The mode represents the most frequently occurring value in the dataset.

mode <- names(sort(-table(statsr$Inflation)))[1]

Standard Deviation

Standard deviation measures the dispersion or variability in the dataset.

sd(statsr$Inflation)

Data Visualization

Different types of graphs were created in order to better understand the distribution and trends in the inflation data.

Histogram

A histogram was used to visualize the distribution of inflation values.

hist(statsr$Inflation)

Bar Plot

A bar plot was created to represent inflation values graphically.

barplot(statsr$Inflation)

Scatter Plot

A scatter plot was used to analyze the relationship between time and inflation.

plot(Time, Inflation)

Pie Chart

A pie chart was created to visualize the proportional distribution of the inflation values.

pie(Inflation)

Regression Analysis

Regression analysis was performed to study the relationship between inflation and time.

Running Regression Model
regression <- lm(Inflation ~ Time, data = statsr)
Interpreting the Output

The regression results were interpreted by analyzing:

Coefficients – show the relationship between variables

R-squared value – indicates how well the model explains the data

p-values – determine statistical significance

summary(regression)
Plotting the Regression Line

The regression line was added to the scatter plot for visualization.

abline(regression, col = "blue")

Part 2: Data Types in R

R supports several types of data structures used for storing and processing data.

Integer

Stores whole numbers.

class(3L)
class(-3L)
Numeric

Stores numbers including integers and decimal values.

class(3)
Logical

Represents Boolean values (TRUE or FALSE).

class(TRUE)
class(FALSE)
class(NA)
Character

Represents text or strings.

class("saloni")
Complex

Represents complex numbers.

class(3i)
Vectors

Vectors are the most basic data structures in R and store elements of the same data type.

Creating a Vector
x <- c(1,2,3,4,5,6)
Arithmetic Operations with Vectors
x + 4
x - 4
x * 4
x / 4
Operations Between Vectors
y <- c(2,3,4,5,6,7)

x + y
x - y
x * y
x / y
Subsetting Vectors

Selecting elements to keep:

z <- x[c(2,3)]

Selecting elements to remove:

q <- x[c(-1,-2)]
Matrices

Matrices are two-dimensional data structures containing rows and columns.

Creating a Matrix
number_matrix = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), nrow = 3, ncol = 4)
Creating Matrix by Row
number_matrix = matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), nrow = 3, ncol = 4, byrow = TRUE)
Adding Rows and Columns
number_matrix = rbind(number_matrix, c(13,14,15,16))

number_matrix = cbind(number_matrix, c(17,18,19,20))
Arrays

Arrays allow storage of multi-dimensional data.

Creating an Array
number_array = array(c(1:30), dim = c(2,3,5))
Factors

Factors are used to store categorical data.

Creating a Factor
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))
Adding Levels
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"),
levels = c("Classic", "Jazz", "Pop", "Rock", "Other"))
Finding Length of Factor
length(music_genre)
Lists

Lists can store multiple data types within a single structure.

Creating a List
thislist <- list("apple", "banana", "cherry")
Accessing Elements
thislist[1]
Modifying Elements
thislist[1] <- "blackcurrant"
Length of List
length(thislist)
Data Frames

Data frames are commonly used in R for storing tabular data.

Creating a Data Frame
Data_Frame = data.frame(
Training = c("Strength", "Stamina", "Other"),
Pulse = c(100,150,120),
Duration = c(60,30,45)
)
Summarizing Data
summary(Data_Frame)
Adding a Row
Data_Frame <- rbind(Data_Frame, c("Power",110,110))
Removing Columns
Data_Frame[-c(1), -c(1)]
Conclusion

This assignment demonstrated how the R programming language can be used for statistical analysis and data visualization. By importing real-world data from the World Bank, calculating statistical measures, generating graphs, and performing regression analysis, the assignment provided practical experience in understanding data trends and relationships. Additionally, it explored fundamental R data structures such as vectors, matrices, arrays, factors, lists, and data frames, which are essential for effective data analysis.
