# Steven Webster
# Intro to Programming in R
# Fall 2016
# Data visualization

# Start by loading the "countries" dataset.
setwd("~/Dropbox/teaching/fall 2016/intro to r/data/")
load("countries.RData")

# Histograms
hist(countries$exports)
hist(countries$exports, main = "Histogram of Exports", xlab = "Exports") 
hist(countries$exports, main = "Histogram of Exports", xlab = "Exports",
						col = "grey") # grey bars
hist(countries$exports, main = "Histogram of Exports", xlab = "Exports",
						col = "orange") # orange bars

hist(countries$exports, main = "Histogram of Exports", xlab = "Exports",
						col = "grey", breaks = 30) # changing breaks

# The most straightforward way to make graphics in R is to use the plot() function.
# Let's say we want to make a plot showing the relationship between
# a country's imports and exports. The syntax is: plot(x,y)
plot(countries$imports, countries$exports)

# Can we make it look nicer? 
plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports")

# In general, the default axes the R gives us on plots is pretty good.
# However, sometimes we may want to change the length of the axes.
plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports",
			ylim = c(0,500), xlim = c(0,300))

# Adding a line of best fit to the plot.
plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports")

abline(lm(countries$exports ~ countries$imports)) # Hard to see this line.
abline(lm(countries$exports ~ countries$imports), col = "blue") # Better.

# What if we don't like circles on our plot? Use the "pch" option.
plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports",
			pch = 24)

plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports",
			pch = 22)

# Adding text to the inside of a plot.
plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports")

text(200, 115, "hello!")
text(150, 150, "hi!")
text(25, 150, "red text", col = "red")

# Line plots (this is awful; for illlustrative purposes only. R usually picks the correct default.)
plot(countries$imports, countries$exports, 
			main = "Relationship between Imports and Exports",
			xlab = "Imports", ylab = "Exports",
			type = "l")

# Multiple plots in one plot screen
# We can put more than one plot on a screen
# by using the par() function. This function is
# short for "parameters."
par(mfrow=(c(1,2)))
hist(countries$exports, main = "Histogram of Exports", xlab = "Exports",
     col = "grey", breaks = 30)

hist(countries$imports, main = "Histogram of Imports", xlab = "Imports",
     col = "steelblue", breaks = 30)

# When we give arguments to mfrow, the syntax
# is always rows / columns (e.g. c(1,2) is 1 row, 2 cols)
par(mfrow=c(3,1))
hist(countries$exports, main = "Histogram of Exports", xlab = "Exports",
     col = "grey", breaks = 30)

hist(countries$imports, main = "Histogram of Imports", xlab = "Imports",
     col = "steelblue", breaks = 30)

hist(countries$coupplots, main = "Histogram of Coup Plots", xlab = "Coup Plots",
     col = "maroon", breaks = 30)

# Why R is so cool: you can customize everything.
# To change the settings around a plot, we need
# to really play around with the par() function.
usa <- subset(countries, cname == "United States")

# US Exports by Year
plot(usa$year, usa$exports, type = "l",
     main = "US Exports by Year", xlab = "Year", ylab = "Exports",
     xlim = c(1960,2010))

# Customizing our plot using par()
par(bg = "white", # can be any color or hex code; changes bg color
    bty = "l", # changes the plotting box
    family = "serif", # changes the font family for labels
    cex.main = 1.57 # how much we magnify the title relative to all other text
    )

plot(usa$year, usa$exports, type = "l",
     main = "", xlab = "Year", ylab = "Exports", 
     xlim = c(1960,2008))
mtext("U.S. Exports by Year", side = 3, adj = 0, cex = 1.57, line = 1.38, font = 2)
mtext("Measured in millions of US dollars", side = 3, adj = 0, cex = .95, line = .35, font = 3)

# What if we want to add a line indicating the mean?
mean(usa$exports, na.rm = TRUE) # 8.12761
abline(h = 8.12761, col = "blue", lty = 2)
text(2000, 7.8, "Mean U.S. exports", col = "blue")


################
# Using ggplot #
################
# Why use ggplot? The graphics are "nicer," you can create 
# your own custom themes, you have more control over the 
# graphics you produce, and you can add layers/design elements
# piece-by-piece. There are, however, a few things you need to get used to. 

# Let's recreate the imports vs. exports graph in ggplot.
# If you don't have ggplot2, use install.packages("ggplot2")

# Basic structure of ggplot graphics:
# ggplots(dataframe, aes(x-axis, y-axis)) + geom + extras

library(ggplot2)
p <- ggplot(countries, aes(imports, exports))
p <- p + geom_point()
p <- p + ggtitle("Relationship between Imports and Exports") + xlab("Imports") + ylab("Exports")
p <- p + theme_bw() # There are plenty of other themes to use; or, you could make your own.

# Adding a line of best fit
p <- p + geom_smooth(method = "lm") # with confidence intervals included (se = FALSE to remove them)

# Bar plot of exports from US, UK, Germany, France, Russia
countries_trimmed <- subset(countries, cname == "United States" | cname == "United Kingdom" |
							cname == "Germany" | cname == "France" | cname == "Russia")

p2 <- ggplot(countries_trimmed, aes(cname, exports))
p2 <- p2 + geom_bar(stat = "identity")
p2 <- p2 + ggtitle("Exports by Country") + xlab("Country") + ylab("Exports")
p2 <- p2 + theme_minimal()

# US exports by year (line plot)
p3 <- ggplot(usa, aes(year, exports))
p3 <- p3 + geom_line()
p3 <- p3 + ggtitle("US Exports by Year") + xlab("Year") + ylab("Exports") + xlim(1960,2010)
p3 <- p3 + theme_bw()

#########################
# ggplot data structure #
#########################
# What does our data need to look like for ggplot?
# "Long" vs "Wide" format
# Reshape2 package helps this
library(reshape2)

# "Big Five" personality trait estimates from 2008 CCAP:
# This dataset contains coefficient estimates for each of the
# Big Five personality traits across three different model specifications.
load("coefs.RData")

# Check the structure of the data
coef.points # This is in the "wide" format

# Transform from "wide" to "long" using melt
melted.coefs <- melt(coef.points, id = "Model")

# Now we can plot the data in ggplot
# create the base
p <- ggplot(melted.coefs, aes(color = Model)) 
# add a geom
p <- p + geom_point(aes(x = variable, y = value, fill = Model), lwd = 4, position = position_dodge(width = 1/2), shape = 21)
# change the theme to black and white
p <- p + theme_bw()
# flip the axes
p <- p + coord_flip()
# add a title
p <- p + ggtitle("Point Estimates for Big Five Personality Traits")

