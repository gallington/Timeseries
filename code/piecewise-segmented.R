#this method uses the segmented package,and constrains the segments to be nearly continuous.
#must specify a suggested breakpoint

ts<- read.csv(file="test.timeseries.csv", header=FALSE)
colnames(ts)<- c("Year", "NDVI")
linmod<- lm(NDVI~Year)


segmented.mod <- segmented(linmod, seg.Z = ~Year, psi=1997)
#use this one:
segmented.mod <- segmented(linmod, seg.Z = ~Year, psi=1997, K=#) # to specify # of breakpoints


#command, you will get the estimated breakpoint +/- some error,
#the intercept and slope for the first segment, and U1.x which
#is the difference in slopes between the first and second segment. 
#So if your coefficients are x = -0.9699 and U1.x = 1.4163, then the slope 
#of the second segment is -0.9699+1.4163 = 0.4464. 
#Using the slope(segmented.mod) command will give you the slopes of each 
#segment, which should match the above calculation
summary(segmented.mod)
slope(segmented.mod)

plot(Year, NDVI, pch=16, ylim=c(0.12,0.28))
lines(NDVI~Year, lwd=.5, title("Horqin"))
plot(segmented.mod, add=T, colors="chartreuse4", lwd=2)

#what if ignore end values?
ts.2<- ts[2:25, 1:2] #sebests without the end vals
#repeat all of above w subset data

linmod2<- lm(NDVI~Year)

segmented.mod2 <- segmented(linmod2, seg.Z = ~Year, psi=1997)
summary(segmented.mod2)
slope(segmented.mod2)

plot(Year, NDVI, pch=16, ylim=c(0.12,0.25))
plot(segmented.mod2, add=T)

####CROPLAND-HORQIN EXAMPLE#####
crop<- read.csv(file="crop-yr.csv", header=TRUE)
lincrop<- lm(NDVI~Date, data=crop)
plot(NDVI~Date, data=crop)
lines(NDVI~Date, data=crop)
seg.crop <- segmented(lincrop, seg.Z = ~Date, psi=NA, control=seg.control(display=FALSE, K=2))
slope(seg.crop)
summary(seg.crop)
plot(seg.crop, add=T, color="chartreuse4", xlab="Year")
title("Cropland-Horqin")
