install.packages("agricolae")
library(agricolae)

webui_df = BAN_602_Case_4

# Degrees of freedom
df_between <- 2
df_within <- 87

# Significance level for a two-tailed test
alpha <- 0.05

# Calculate critical F-values for two tails
lower_critical <- qf(alpha/2, df_between, df_within, lower.tail = TRUE)
upper_critical <- qf(1 - alpha/2, df_between, df_within, lower.tail = TRUE)
lower_critical
upper_critical

anova_interaction <- aov(Time_in_seconds ~ Font * Background, data=webui_df)
anova_summary <- summary(anova_interaction)


rnc_bg <- function(f_value, p_value, alph){
  cat("Null Hypothesis: The time spent by visitors to the Triple T website is equal for the three background colors.\n Mathematically speaking, μ_1 = μ_2 = μ_3\n")
  cat("Alternate Hypothesis: The time spent by visitors to the Triple T website is NOT equal for the three background colors.\n Mathematically speaking, μ_1 != μ_2 != μ_3\n")
  cat("With F-Value=", f_value, ", P-Value=", p_value, ", and confidence level=", alph, "\n")
  if (f_value > upper_critical || f_value < lower_critical){
    cat("Rejection Rules: Two-Tailed Critical Value Approach - One needs to be TRUE for H_0 to be rejected.\n")
    cat(f_value, ">", upper_critical, "= F-Upper_Crit","is", f_value > upper_critical, "\n")
    cat(f_value, "<", lower_critical, "= F-Lower_Crit" ,"is", f_value < lower_critical, "\n")
    cat("Reject the null hypothesis that the time spent by visitors to the Triple T website is equal for the three background colors.", "\n")
  } else {
    cat("Rejection Rules: Two-Tailed Critical Value Approach - One needs to be TRUE for H_0 to be rejected.\n")
    cat(f_value, ">", upper_critical, "= F-Upper_Crit","is", f_value > upper_critical, "\n")
    cat(f_value, "<", lower_critical, "= F-Lower_Crit" ,"is", f_value < lower_critical, "\n")
    cat("We cannot reject the null hypothesis that the time spent by visitors to the Triple T website is equal for the three background colors.", "\n")
  }
}

rnc_font <- function(f_value, p_value, alph){
  cat("Null Hypothesis: The time spent by visitors to the Triple T website is equal for the three fonts.\n Mathematically speaking, μ_1 = μ_2 = μ_3\n")
  cat("Alternate Hypothesis: The time spent by visitors to the Triple T website is NOT equal for the three fonts.\n Mathematically speaking, μ_1 != μ_2 != μ_3\n")
  cat("With F-Value=", f_value, ", P-Value=", p_value, ", and confidence level=", alph, "\n")
  if (f_value > upper_critical || f_value < lower_critical){
    cat("Rejection Rules: Two-Tailed Critical Value Approach - One needs to be TRUE for H_0 to be rejected.\n")
    cat(f_value, ">", upper_critical, "= F-Upper_Crit","is", f_value > upper_critical, "\n")
    cat(f_value, "<", lower_critical, "= F-Lower_Crit" ,"is", f_value < lower_critical, "\n")
    cat("Reject the null hypothesis that the time spent by visitors to the Triple T website is equal for the three fonts.", "\n")
  } else {
    cat("Rejection Rules: Two-Tailed Critical Value Approach - One needs to be TRUE for H_0 to be rejected.\n")
    cat(f_value, ">", upper_critical, "= F-Upper_Crit","is", f_value > upper_critical, "\n")
    cat(f_value, "<", lower_critical, "= F-Lower_Crit" ,"is", f_value < lower_critical, "\n")
    cat("We cannot reject the null hypothesis that the time spent by visitors to the Triple T website is equal for the three fonts.", "\n")
  }
}

rnc_int <- function(f_value, p_value, alph){
  cat("Null Hypothesis: The time spent by visitors to Triple T website is equal for the nine combinations of background color and font.\n Mathematically speaking, μ_1 = μ_2 ... = μ_9\n")
  cat("Alternate Hypothesis: The time spent by visitors to the Triple T website is equal for the nine combinations of background color and font.\n Mathematically speaking, μ_1 != μ_2 ... != μ_9\n")
  cat("With F-Value=", f_value, ", P-Value=", p_value, ", and confidence level=", alph, "\n")
  if (f_value > upper_critical || f_value < lower_critical){
    cat("Rejection Rules: Two-Tailed Critical Value Approach - One needs to be TRUE for H_0 to be rejected.\n")
    cat(f_value, ">", upper_critical, "= F-Upper_Crit","is", f_value > upper_critical, "\n")
    cat(f_value, "<", lower_critical, "= F-Lower_Crit" ,"is", f_value < lower_critical, "\n")
    cat("Reject the null hypothesis that the time spent by visitors to Triple T website is equal for the nine combinations of background color and font.", "\n")
  } else {
    cat("Rejection Rules: Two-Tailed Critical Value Approach - One needs to be TRUE for H_0 to be rejected.\n")
    cat(f_value, ">", upper_critical, "= F-Upper_Crit","is", f_value > upper_critical, "\n")
    cat(f_value, "<", lower_critical, "= F-Lower_Crit" ,"is", f_value < lower_critical, "\n")
    cat("We cannot reject the null hypothesis that the time spent by visitors to Triple T website is equal for the nine combinations of background color and font.", "\n")
  }
}
# 1. Has Triple T used an observational study or a controlled experiment? Explain.
# (3 points)
# Answer:
  # TourisTopia Travel is an online travel agency who is attempting to revise their websites homepage.
  # The group has designed prototype homepages featuring every combination of background colors and fonts.
  # They implemented computer code that directs each random visitor to one of the prototyped homepages. They
  # did this for three weeks and collected the amount of time (in seconds) that the random vistor spent
  # on the prototyped homepages. This design is known as a completely randomized design since visitors are
  # randomly assigned to a webpage that contains a certain combination of treatments i.e. background color and font color.
  # Since the company manipulates the background color and font of the page to observe the effect on screentime,
  # this is a controlled experiment. If there were no attempt to randomly assign different prototypes then this would
  # be an observational study.


# 2. Use the data from Triple T’s study to test the hypothesis that the time spent by visitors
# to the Triple T website is equal for the three background colors. Include both the factors
# and their interaction in the ANOVA model, and use a 0.05 level of significance. State
# the hypotheses both in words and mathematically, compute the test statistic and p-
#   value, explain the rejection rule and state the conclusion. (15 points)
p_value_bg <- 2 * anova_summary[[1]]$`Pr(>F)`[2] 
f_value_bg <- anova_summary[[1]]$`F value`[2]
rnc_bg(f_value_bg, p_value_bg, alpha)



# 3. Use the data from Triple T’s study to test the hypothesis that the time spent by visitors
# to the Triple T website is equal for the three fonts. Include both the factors and their
# interaction in the ANOVA model, and use a 0.05 level of significance. State the
# hypotheses both in words and mathematically, compute the test statistic and p-value,
# explain the rejection rule and state the conclusion. (15 points)
p_value_font <- 2 * anova_summary[[1]]$`Pr(>F)`[1] 
f_value_font <- anova_summary[[1]]$`F value`[1]
rnc_font(f_value_font, p_value_font, alpha)



# 4. Use the data from Triple T’s study to test the hypothesis that time spent by visitors to
# the Triple T website is equal for the nine combinations of background color and font.
# Include both factors and their interaction in the ANOVA model, and use a 0.05 level
# of significance. State the hypotheses both in words and mathematically, compute the
# test statistic and p-value, explain the rejection rule and state the conclusion. (15 points)
p_value_int <- 2 * anova_summary[[1]]$`Pr(>F)`[3]
f_value_int <- anova_summary[[1]]$`F value`[3]
rnc_int(f_value_int, p_value_int, alpha)



# 5. What is your overall recommendation? (2 points)

# p-value is 1, it implies that the observed data's distribution across categories is very likely to occur by 
# random chance under the assumption that the variables are independent
# null hypothesis, indicating that there is no statistically significant association between font categories 
# and background color categories

contingency_table <- table(webui_df$Font, webui_df$Background)
print(contingency_table)
chi_square_result <- chisq.test(contingency_table)
print(chi_square_result)


