# Packages and Importing
install.packages("sqldf")
install.packages("vtable")
library("sqldf")
library("vtable")

# student data
student_df = BAN_602_Case_1
head(student_df)

# Check for Na
sapply(student_df, anyNA)

# check datatypes
sapply(student_df, typeof)

#  | Quantitative Variables
#  | Full Time Enrollment | Students per faculty | Domestic Tuition | Foreign Tuition |
#  | Age_Years | Percentage_Foreign_Students | Starting_Salary |

# string -> numerical also removes comma seperated number
student_df$Domestic_Tuition_. <- as.numeric(gsub(",","",student_data$Domestic_Tuition_.))
student_df$Foreign_Tuition_. <- as.numeric(gsub(",","",student_data$Foreign_Tuition_.))
student_df$Starting_Salary_. <- as.numeric(gsub(",","",student_data$Starting_Salary_.))
# renaming
student_df$Domestic_Tuition <- student_df$Domestic_Tuition_.
student_df$Foreign_Tuition <- student_df$Foreign_Tuition_.
student_df$Starting_Salary <-student_df$Starting_Salary_.




# PART 1
# Use a table to display the summary
# measures of all the quantitative variables in one place. What insights do these descriptive
# statistics provide regarding the Asia-Pacific business schools? 
# mean, median, standard deviation, variance, range, and inter-quartile range

# separate quantitative variables for df for summary table 
quantitative <- sqldf("select 
                            Full_Time_Enrollment,
                            Students_per_Faculty,
                            Domestic_Tuition,
                            Foreign_Tuition,
                            Age_Years,
                            Percentage_Foreign_Students,
                            Starting_Salary 
                      from student_df")

sumtable(quantitative, summ = list(
  c('mean(x)','median(x)','sd(x)','var(x)','min(x)','max(x)','IQR(x)'),
summ.names = list(
  c('N','Mean','Median','SD','var','Min','Max', 'IQR'))
))




# PART 2
# Summarize the data to compare the following:
#  a. Mean differences between domestic and foreign tuitions for schools requiring
#     versus not requiring GMAT.

mean_diff_required <- mean(abs(student_df$Foreign_Tuition[student_df$GMAT_Reqd == "Yes"] - student_df$Domestic_Tuition[student_df$GMAT_Reqd == "Yes"]))
mean_diff_not_required <- mean(abs(student_df$Foreign_Tuition[student_df$GMAT_Reqd == "No"] - student_df$Domestic_Tuition[student_df$GMAT_Reqd == "No"]))
cat("The mean difference between domestic and foreign tuitions for schools requiring the GMAT is:\n", mean_diff_required)
cat("The mean difference between domestic and foreign tuitions for schools NOT requiring the GMAT is:\n", mean_diff_not_required)


#  b. Any difference between mean starting salaries for schools requiring versus not
#     requiring work experience.

mean_salary_experience <- mean(student_df$Starting_Salary[student_df$Work_Experience_Years == "Yes"])
mean_salary_no_experience <- mean(student_df$Starting_Salary[student_df$Work_Experience_Years == "No"])
cat("The Mean difference in Salary for students with experience versus no experience is:\n", abs(mean_salary_experience - mean_salary_no_experience))


#  c. Any difference between mean starting salaries for schools requiring versus not
#     requiring English test.

mean_salary_eng <- mean(student_df$Starting_Salary[student_df$English_Test_Reqd == "Yes"])
mean_salary_no_eng <- mean(student_df$Starting_Salary[student_df$English_Test_Reqd == "No"])
cat("The Mean difference in Salary for students required to pass an English test versus those who werent is:\n", abs(mean_salary_eng - mean_salary_no_eng))





# PART 3
# Does starting salary appear to be related to domestic tuition? Does starting salary appear
# to be associated with foreign tuition? Justify using both visual and numerical measures
-----------------------------------------------------
# Scatter plots to visualize trends
-----------------------------------------------------
plot(student_df$Starting_Salary, student_df$Domestic_Tuition,
     xlab = "Starting Salary",
     ylab = "Foreign Tuition Cost",
     main = "Scatter Plot of Salary vs. Domestic Tuition Cost")

plot(student_df$Starting_Salary, student_df$Foreign_Tuition,
     xlab = "Starting Salary",
     ylab = "Foreign Tuition Cost",
     main = "Scatter Plot of Salary vs. Foreign Tuition Cost")

-----------------------------------------------------
# R coefficient - Numerical descriptive measure 
-----------------------------------------------------
  
# Calculate Correlation coefficient for Starting Salary vs. Domestic Tuition
dev_mean_salary = (student_df$Starting_Salary - mean(student_df$Starting_Salary))

dev_mean_domestic <- (student_df$Domestic_Tuition - mean(student_df$Domestic_Tuition))
corr_sal_domestic <- sum(dev_mean_salary * dev_mean_domestic) / 
  sqrt(sum((student_df$Starting_Salary - mean(student_df$Starting_Salary))**2) * 
  sum((student_df$Domestic_Tuition - mean(student_df$Domestic_Tuition))**2))  

cat("Correlation coefficient for Starting Salary vs. Domestic Tuition is:\n",corr_sal_domestic)


# Calculate Correlation coefficient for Starting Salary vs. Foreign Tuition
dev_mean_foreign <- (student_df$Foreign_Tuition - mean(student_df$Foreign_Tuition))
corr_sal_domestic <- sum(dev_mean_salary * dev_mean_foreign) / 
  sqrt(sum((student_df$Starting_Salary - mean(student_df$Starting_Salary))**2) * 
         sum((student_df$Foreign_Tuition - mean(student_df$Foreign_Tuition))**2))

cat("Correlation coefficient for Starting Salary vs. Foreign Tuition is:\n",corr_sal_domestic)




# PART 4
# Draw a boxplot to graphically summarize the starting salary data. Identify the first, second
# and third quartiles from the boxplot. Are there any outliers? 

boxplot(student_df$Starting_Salary,
        main = "Boxplot of Salary",
        ylab = "Salary",
        col = "lightgreen",
        border = "black"
        )

stripchart(student_df$Starting_Salary,
           method='jitter',
           pch = 3,
           col="pink",
           add=T,
           vertical=T)

q1 <- quantile(student_df$Starting_Salary, 0.25)
median_val <- median(student_df$Starting_Salary)
q3 <- quantile(student_df$Starting_Salary, 0.75)


# Add labels
text(1, q1, labels = paste("Q1:$", q1), pos=3)
text(1, median_val, labels = paste("Median:$", median_val), pos = 3)
text(1, q3, labels = paste("Q3:$", q3), pos = 3)
text(x = 1, y = bp$stats[1], labels = paste("Min:$", bp$stats[1]), pos = 3)
text(x = 1, y = bp$stats[5], labels = paste("Max:$", bp$stats[5]), pos = 1)