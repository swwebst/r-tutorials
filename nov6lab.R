#
# Steven Webster
# POLS 208 Lab
# November 6, 2014
#

# What are we doing?
# Scatterplots
# Line of best fit
# Bivariate regression and interpretation
# Multiple regression and interpretation
# Coefficients
# Standard errors
# t-value
# p-value
# R^2 and F statistic


setwd("/Users/swwebst/Desktop/")

dat <- read.csv("usadat2.csv")
# pid: 1=dem, 2=rep, 3=independent
# vote: 1=obama, 2=romney
# relig: 1=important, 0=not important

###############
# SCATTERPLOT #
###############
# policy liberalism in 1984 ----> policy liberalism in 2010?
plot(dat$ft_dem, dat$age)

# uhh... who knows? maybe? what can we do? add a line of best fit!
abline(lm(dat$ft_dem ~ dat$age))

########################
# BIVARIATE REGRESSION #
########################
model1 <- lm(ft_dem ~ age, data = dat)
model1
coefficients(model1) # coefficients
summary(model1)

# r and r-squared
r <- cor(dat$ft_dem, dat$age, use = "complete.obs")
r2 <- r^2
    # notice anything?


# OK, cool. A regression. We have done SCIENCE! Awesome.
# Except not really. Bivariate regressions do not really
# tell us much about the phenomena we are interested in.
# Why is this?




# ANSWER: Ommitted variable bias!
# Potential solution? Multiple regression.

#######################
# MULTIPLE REGRESSION #
#######################
model2 <- lm(ft_dem ~ age + support.aca, data = dat)
model2
coefficients(model2)
summary(model2)

model3 <- lm(ft_dem ~ age + support.aca + democrat, data = dat)
model3
coefficients(model3)
summary(model3)

# Which model is "better"?
# Why do you say this? Can
# we judge between models?

