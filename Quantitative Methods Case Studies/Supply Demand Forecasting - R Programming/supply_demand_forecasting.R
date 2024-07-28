# Provided information: 
# 
# 4 members suggest the following inventory quantities | 13,000 | 17,000 | 26,000 | 29,000 |
# 
# Senior Sales Forecasters suggests mean demand of 22,500 units with 0.97 (+-2 sds) of the demand falling between
# 7,000 units and 38,000 units
#
# Cost/unit: $17
# Retail price/unit: $29
# Clearance price/unit: $7


# 1. Use the sales forecaster’s prediction to describe a normal probability distribution that can be used to approximate the demand distribution. 
#    Sketch the distribution and show its mean and variance. (10 points)

# NOTE: We need to find the first sd
mean_demand <- 22500

# mean demand + 2sd
mu_plus_two_sd <- 38000

# sd demand = mean demand - 38000 / 2
sd_demand <- (mu_plus_two_sd - mean_demand) / 2

# Create Sequence of values for plotting
x <- seq(mean_demand - (3 * sd_demand), mean_demand + (3 * sd_demand))

# create Probability Density Function
pdf_demand <- dnorm(x, mean = mean_demand, sd = sd_demand)

plot(x, pdf_demand, type = "l", col = "purple", lwd = 2,
     xlab = "Value", ylab = "Probability Density for Mean Demand",
     main = "Weather Teddy Demand")

abline(v = c(mean_demand, mean_demand - sd_demand, mean_demand + sd_demand),
       col = c("magenta", "cyan2", "cyan2"),
       lwd = c(2, 1, 1),
       lty = c(1, 2, 2),
       labels = c("Mean", "-1 SD", "+1 SD"))

# Add legend
legend("topright",legend = c("PDF", "Mean", "-1 SD", "+1 SD"),
       col = c("purple", "magenta", "cyan2", "cyan2"),
       lwd = c(1, 1, 1, 1),
       lty = c(1, 1, 2, 2))

text(mean_demand - sd_demand, max(pdf_demand), paste("-1 SD =", mean_demand - sd_demand), pos = 1, col = "cyan2", offset = 18)
text(mean_demand + sd_demand, max(pdf_demand), paste("+1 SD =", mean_demand + sd_demand), pos = 1, col = "cyan2", offset =18)
text(mean_demand, max(pdf_demand), paste("Mean =", mean_demand), pos = 1, col = "purple", offset = 5)






# 2. Compute the probability of a stock-out for the order quantities suggested by members of the management team. (2.5 * 4 = 10 points)

# Calculate z-score
compute_z <- function(value) {
  
  z_score <- (value - mean_demand) / sd_demand
  
  return(z_score)
}

# Calculate the probability using pnorm
compute_prob_stockout <- function(z_score) {

  probability <- pnorm(z_score)
  
  return(probability)
}

# 13,000
p_13k <- (1 - compute_prob_stockout(compute_z(13000)))
cat("The Probability of running out of an inventory stock of 13,000 units with mean demand 22,500 is", round(p_13k*100, 2),"%\n")
# 17,000
p_17k <- (1 - compute_prob_stockout(compute_z(17000)))
cat("The Probability of running out of an inventory stock of 17,000 units with mean demand 22,500 is", round(p_17k*100, 2),"%\n")
# 26,000
p_26k <- (1 - compute_prob_stockout(compute_z(26000)))
cat("The Probability of running out of an inventory stock of 26,000 units with mean demand 22,500 is", round(p_26k*100, 2),"%\n")
# 29,000
p_29k <- (1 - compute_prob_stockout(compute_z(29000)))
cat("The Probability of running out of an inventory stock of 29,000 units with mean demand 22,500 is", round(p_29k*100, 2),"%\n")







# 3. Compute the projected profit for the order quantities suggested by the management team under three scenarios: 
# worst case in which sales=12,000 units, most likely case in which sales=22,500 units, and best case in which sales=33,000 units. (4 * 3 = 12 points)

# The inventory quantities suggested by the management team: | 13,000 | 17,000 | 26,000 | 29,000 | 
# Profit = (Units * Retail price/unit - cost/unit) + (units not sold * Clearance price/unit - cost/unit)

projected_profile <- function(inventory, units_sold) {
  
  # if we have a surplus
  if (units_sold < inventory){
    surplus <- inventory - units_sold
    sold <- inventory - surplus
    
    return ((sold * (29 - 17)) + (surplus * (7 - 17)))
    
  # we sold all of our inventory
  } else {
    
    return (inventory *(29 - 17))
    
  }
    
}
################################
# Worse Case: 12,000 units sold
################################
# 13,000 units
cat("Our Projected Profit if we have an inventory of 13,000 units of Weather Teddy but sell 12,000 units is: $",projected_profile(13000, 12000),"\n")
# 17,000 units
cat("Our Projected Profit if we have an inventory of 17,000 units of Weather Teddy but sell 12,000 units is: $",projected_profile(17000, 12000),"\n")
# 26,000 units
cat("Our Projected Profit if we have an inventory of 26,000 units units of Weather Teddy but sell 12,000 units is: $",projected_profile(26000, 12000),"\n")
# 29,000 units
cat("Our Projected Profit if we have an inventory of 29,000 units of Weather Teddy but sell 12,000 units is: $",projected_profile(29000, 12000),"\n")


######################################
# Most Likely Case: 22,500 units sold 
######################################
cat("Our Projected Profit if we have an inventory of 13,000 units of Weather Teddy but sell 22,500 units is: $",projected_profile(13000, 22500),"\n")
# 17,000 units
cat("Our Projected Profit if we have an inventory of 17,000 units of Weather Teddy but sell 22,500 units is: $",projected_profile(17000, 22500),"\n")
# 26,000 units
cat("Our Projected Profit if we have an inventory of 26,000 units units of Weather Teddy but sell 22,500 units is: $",projected_profile(26000, 22500),"\n")
# 29,000 units
cat("Our Projected Profit if we have an inventory of 29,000 units of Weather Teddy but sell 22,500 units is: $",projected_profile(29000, 22500),"\n")


###############################
# Best Case: 33,000 units sold 
###############################
cat("Our Projected Profit if we have an inventory of 13,000 units of Weather Teddy but sell 33,000 units is: $",projected_profile(13000, 33000),"\n")
# 17,000 units
cat("Our Projected Profit if we have an inventory of 17,000 units of Weather Teddy but sell 33,000 units is: $",projected_profile(17000, 33000),"\n")
# 26,000 units
cat("Our Projected Profit if we have an inventory of 26,000 units units of Weather Teddy but sell 33,000 units is: $",projected_profile(26000, 33000),"\n")
# 29,000 units
cat("Our Projected Profit if we have an inventory of 29,000 units of Weather Teddy but sell 33,000 units is: $",projected_profile(29000, 33000),"\n")





# 4. One of Specialty’s managers felt that the profit potential was so great that the order quantity should have a 92% chance of meeting demand 
#    and only an 8% chance of any stockouts. What quantity would be ordered under this policy, and what is the projected profit under 
#    the three sales scenarios? (5 + 5 = 10 points)

# get z-value from qnorm
z_upper_8 <- qnorm(.92)

# calculate the stock needed in order to have an 8% chance 
quantity_8_percent_stockout <- mean_demand + (z_upper_8 * sd_demand)

# Validate that we calculated the inventory correctly by finding the stock out probability 
p_8_percent_stockout <- (1 - compute_prob_stockout(compute_z(quantity_8_percent_stockout)))
cat("The Probability of running out of an inventory stock of 33,390 units with mean demand 22,500 is", round(p_8_percent_stockout*100, 2),"%\n")

###################################################################################
# Profit with inventory of 33,390 w.r.t. 3 demand cases | 12,000 | 22,500 | 33,000
###################################################################################
cat("Our Projected Profit if we have an inventory of 33,390 units of Weather Teddy but sell 12,000 units is: $",projected_profile(33390, 12000),"\n")
cat("Our Projected Profit if we have an inventory of 33,390 units of Weather Teddy but sell 22,500 units is: $",projected_profile(33390, 22500),"\n")
cat("Our Projected Profit if we have an inventory of 33,390 units of Weather Teddy but sell 33,000 units is: $",projected_profile(33390, 33000),"\n")





# 5. Provide your own recommendation for an order quantity and note the associated profit projections. 
#    Provide a rationale for your recommendation. (3 + 3 + 2 = 8 points)

cat("Our Projected Profit if we have an inventory of 26,400 units of Weather Teddy but sell 12,000 units is: $", projected_profile(26400, 12000),"\n")
cat("Our Projected Profit if we have an inventory of 26,400 units of Weather Teddy but sell 22,500 units is: $",projected_profile(26400, 22500),"\n")
cat("Our Projected Profit if we have an inventory of 26,400 units of Weather Teddy but sell 33,000 units is: $",projected_profile(26400, 33000),"\n")

opt_percent_stockout <- (1 - compute_prob_stockout(compute_z(26400)))
cat("The Probability of running out of an inventory stock of 26,400 units with mean demand 22,500 is", round(opt_percent_stockout*100, 2),"%\n")