install.packages("vtable")
install.packages("BSDA")
install.packages("qicharts2")
install.packages("ggplot2")
library("qicharts2")
library("ggplot2")
library("vtable")
library("BSDA")
require("BSDA")


# Evaluate results and conclude
conclusion <- function(p_value, z_stat, sample_num) {
  cat("Z Test Statistic:", z_stat, "\n")
  # Print the p-value
  cat("P-value:", p_value, "\n")
  cat(p_value, "<=", alpha, "?", p_value <= alpha, "\n")
  if (p_value <= alpha){
    return(cat("There is sufficient statistical evidence to reject the null hypothesis for sample #", sample_num, "\n"))
  }
  else {
    return(cat("There is NOT sufficient statistical evidence to reject the null hypothesis for sample #", sample_num, "\n"))
  }
}



chi_conclusion <- function(sample_chi_value, sample_num){
  
  p_value <- 2 * min(pchisq(sample_chi_value, df), pchisq(sample_chi_value, df, lower.tail = FALSE))
  cat("Chi-Squared Test Statistic:", sample_chi_value, "\n")
  # Print the p-value
  cat("P-value:", p_value, "\n")
  cat(p_value, "<=", alpha, "?", p_value <= alpha, "\n")
  # Make a decision based on the p-value
  if (p_value <= alpha){
    return(cat("There is sufficient statistical evidence to reject the null hypothesis for sample #", sample_num, "\n"))
  }
  else {
    return(cat("There is NOT sufficient statistical evidence to reject the null hypothesis for sample #", sample_num, "\n"))
  }
  
}




# Define constants
alpha = 0.05
pop_mean = 12
pop_sd = 0.21
pop_variance <- (pop_sd)^2
s_n = 30
df <- (s_n - 1)

# get data, see how its structured 
data <- BAN_602_Case_3
head(data)

# remove first row of data which is the name of each sample
data <- data[-1,]

# rename columns w.r.t the sample they represent
new_column_names <- c("Sample_1", "Sample_2", "Sample_3", "Sample_4")
names(data) <- new_column_names
data <- data.frame(lapply(data, as.numeric))



# 1. Provide summary statistics (mean, median, standard deviation) of each of the four sample
#    data sets separately in one table. (3x4 = 12 points)
sumtable(data,
         title = "Manufacturing Sample Summaries",
         vars = new_column_names,
         digits = 4,
         summ = list(c('mean(x)','median(x)','sd(x)'),
         summ.names = list(c('Mean','Median','SD'))))










# 2. Conduct a hypothesis test for each sample at α = 0.05. Discuss your findings and determine
#    what action, if any, should be taken. Provide the test statistic and p-value for each test. (4x4= 16 points)

# Z-Test 
# Sample 1
s1_z_result <- z.test(x=data$Sample_1, mu=pop_mean, sigma.x=pop_sd, alternative="two.sided", conf.level=.95)
s1_z_statistic <- s1_z_result$statistic
s1_p_value <- s1_z_result$p.value
conclusion(s1_p_value, s1_z_statistic, 1)

# Sample 2
s2_z_result <- z.test(x=data$Sample_2, mu=pop_mean, sigma.x=pop_sd, alternative="two.sided", conf.level=.95)
s2_z_statistic <- s2_z_result$statistic
s2_p_value <- s2_z_result$p.value
conclusion(s2_p_value, s2_z_statistic, 2)


# Sample 3
s3_z_result <- z.test(x=data$Sample_3, mu=pop_mean, sigma.x=pop_sd, alternative="two.sided", conf.level=.95)
s3_z_statistic <- s3_z_result$statistic
s3_p_value <- s3_z_result$p.value
conclusion(s3_p_value, s3_z_statistic, 3)


# Sample 4
s4_z_result <- z.test(x=data$Sample_4, mu=pop_mean, sigma.x=pop_sd, alternative="two.sided", conf.level=.95)
s4_z_statistic <- s4_z_result$statistic
s4_p_value <- s4_z_result$p.value
conclusion(s4_p_value, s4_z_statistic, 4)

# Chi-Squared Hypothesis Test
# Two-Tailed we want to know if sd is a good fit
# H_0: pop var = .21^2
# H_a: pop var != .21^2

# Sample 1
s1_chi_value <- (df * var(data$Sample_1))/pop_variance
chi_conclusion(s1_chi_value, 1)

# Sample 2
s2_chi_value <- (df * var(data$Sample_2))/pop_variance
chi_conclusion(s2_chi_value, 2)

# Sample 3
s3_chi_value <- (df * var(data$Sample_3))/pop_variance
chi_conclusion(s3_chi_value, 3)

# Sample 4
s4_chi_value <- (df * var(data$Sample_4))/pop_variance
chi_conclusion(s4_chi_value, 4)






# 3. Does the assumption of 0.21 for the population standard deviation appear reasonable? (2 points)
# Answer in Case Report






# 4. Compute limits for the sample mean x-bar around μ = 12 such that, as long as a new sample
#    mean is within those limits, the process will be considered to be operating satisfactorily. If
#    x-bar exceeds the upper limit or if x-bar is below the lower limit, corrective action will be taken.
#    These limits are referred to as upper and lower control limits for quality control purposes. (6 points)

values <- unname(as.matrix(data))
# calculate Margin of Error
MOE <- qnorm(.975, mean=0, sd=1) * (.21 / sqrt(length(values)))
LB <- 12 - MOE
UB <- 12 + MOE
cat("μ = 12", "produces a Lower Bound of", LB, "and an Upper Bound of", UB, "with Margin of Error", MOE)








# 5. Discuss the implications of changing the level of significance to a larger value or a smaller
#    value. What type of mistakes or errors could go up if the level of significance is increased?
#    What could happen if the level of significance is decreased? (4 + 4 = 8 points)

# Answer: 
# If we were to increase the value of the significance level from α = 0.05 to α = 0.10 then this
# would increase our chances of rejecting the null hypothesis when it is actually true, also know as a Type I Error.
# Accepting weaker evidence makes it harder to detect real effects or differences if they exist and would directly 
# impact the Manufacturing line's precision to produce satisfactory products since the test is wider and less constraining. 

# On the other hand, if we were to decrease the value of the significance level from α = 0.05 to α = 0.01 then of course we would decrease the 
# chances of making a Type I Error but consequently raise the chances of accepting a null hypothesis that is actually
# false, also know as a Type II Error. Being less willing to accept evidence or being more constraining could prolong the decision making process and 
# could also make it hard to detect real difference which also impacts the precision of producing satisfactory products just as 
# increasing the significance level does. 









# 6. Plot the sample means of the four sample data sets in a chart, with the population mean,
#    upper control limit and lower control limit displayed as parallel horizontal lines. This chart,
#    aka process control chart, helps us understand if a process is in statistical control. (6 points)


s1_xbar <- mean(data$Sample_1)
s2_xbar <- mean(data$Sample_2)
s3_xbar <- mean(data$Sample_3)
s4_xbar <- mean(data$Sample_4)

# Create the control chart
control_chart <- qic(unlist(as.list(values)), chart = "i", title = "Quality Control Chart", xlab = "Sample Points")

# Add horizontal lines for UCL, LCL, and the overall mean
control_chart + geom_hline(yintercept = c(UB, LB, pop_mean, s1_xbar, s2_xbar, s3_xbar, s4_xbar),
                           color = c("red", "red", "green", "yellow", "yellow", "yellow", "yellow"),
                         linetype = "dashed")
# legend(1, 95, legend=c("UB", "LB", "Pop Mean", "s1 mean", "s2 mean", "s3 mean", "s4 mean"),
#        col=c("red", "red", "green", "yellow", "yellow", "yellow", "yellow"), lty=1:2, cex=0.8)
# plot(control_chart)
