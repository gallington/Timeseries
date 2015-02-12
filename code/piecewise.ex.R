#piecewise linear regression not using the segmented package--must specify a range for the breakpoints
#does nto force continuous segments, so they will be different from the output of the segmented package
x <- c(1:10, 13:22)
y <- numeric(20)
## Create first segment
y[1:10] <- 20:11 + rnorm(10, 0, 1.5)
## Create second segment
y[11:20] <- seq(11, 15, len=10) + rnorm(10, 0, 1.5)
## Plot it
par(mar=c(4,4,1,1)+0.2)
plot(x,y, ylim=c(5, 20), pch=16)

#The complicated bit is choosing the breakpoint. 
#We can eyeball the data and say that the breakpoint is somewhere between 9 and 17. 
#Choose a wider range than you might think, just to be safe. 
#Create a variable called breaks to hold these breakpoints:
breaks <- x[which(x >= 9 & x <= 17)]

#Create an empty container for MSE values from each model
mse<- numeric(length(breaks))
# use a for( ) loop to run a linear regression for each possible breakpoint. 
#Formulate the linear model exactly like the above formula.
for(i in 1:length(breaks)){
  piecewise1 <- lm(y ~ x*(x < breaks[i]) + x*(x>=breaks[i]))
  mse[i] <- summary(piecewise1)[6]
}
mse <- as.numeric(mse)
#which breakpoint has the lowest mean square error?
breaks[which(mse==min(mse))]
#result is 9 for me, but 15 from teh example online
#run again with the output of above
piecewise2 <- lm(y ~ x*(x < 9) + x*(x > 9))
summary(piecewise2)
#
#use the output of summary for the following
#  
#The intercept for the line when x < 9 is (Intercept) + x < 9TRUE
#The slope of the line when x < 15 is x + x:x<15TRUE
#So, when x is less than 15, the formula is
plot(x,y, ylim=c(5, 20), pch=16)
curve((3.3133 + 16.6352) + (0.5843-1.3025)*x, add=T, from=1, to=9)
curve((3.3133 - 0.9116) + 0.5843*x, add=T, from=9, to=max(x))
abline(v=15, lty=3)
