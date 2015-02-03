#trialing changepoint package in R
#can't just read in a csv file bc cpt needs data as a vector
#test data files pulled from greenest pixel timeseries from Google Earth Engine and saved in Timeseries folder in Documentsgzd<-c(0.442976773,


#this is not a good long-term solution to getting the data in as a vector.
crop.v<- c(0.288946182,0.206392571,0.461697102,0.338389397,0.55735749,0.251359582,0.418967426,0.184874564,0.221389428,0.462150216,0.373956442,0.202210858,0.114857547,0.169945583,0.264042407,0.963894248,0.798456788,0.372505873,0.668985426,0.547768712,0.355483383,0.552623808,0.591260552,0.793723047,0.785846651)

#visualize it:
ts.plot(crop.v)

cpt.test<- cpt.mean(crop.v, penalty="SIC", pen.value=0, method="PELT", class=TRUE, param.estimates="TRUE")
#or simpler:
cpt.pelt<-cpt.mean(crop.v, method="PELT")
#PELT=

#then plot it
plot(cpt.pelt, type="1", cpt.col="blue", xlab="Year",cpt.width=4)cpt.width specifies line width
#that genereated an error bc invalid type so try this:
plot(cpt.pelt, cpt.col="blue", xlab="Year",cpt.width=4)
#then try to output the location of teh changepoints
cpts(cpt.pelt) #this should return a list of #s at which the mean (in this case) of the data 'change'

#try with the variance rather than mean
crop.cpt.var<- cpt.var(crop.v, method="PELT")
plot(crop.cpt.var, xlab="Year")
#number of changepoints
ncpts(crop.cpt.var)
#logLik(crop.cpt.var) #to compare outputs between methods.

cpt.test<- cpt.mean(crop.v, penalty="SIC", pen.value=0, method="PELT", class=TRUE, param.estimates="TRUE")

#with data from Horqin sandy land 
horqin.succ<- c(0.179197967,0.15456523,0.152888149,0.140569419,0.14688693,0.148395404,0.115002044,0.126614213,0.126614213,0.12565586,0.136780366,0.129891455,0.141188487,0.135559723,0.150414303,0.150874451,0.145629361,0.159304023,0.180569053,0.160697281,0.151757017,0.161179796,0.175090492,0.171478093,0.178194612,0.173388571)
ts.plot(horqin.succ)
hor.mean.pelt<- cpt.mean(horqin.succ, method="PELT")
plot(hor.mean.pelt, cpt.col="blue", xlab="Year")
hor.var.pelt<- cpt.var(horqin.succ, method="PELT")
plot(hor.var.pelt, cpt.col="red", xlab="Year")
cpts(hor.var.pelt) #gives teh timepoints at which the variance changes.

#grazed site
gzd<-c(0.442976773,
0.382634282,
0.367733717,
0.308709979,
0.340819895,
0.352207094,
0.34451139,
0.366591036,
0.431466818,
0.377004385,
0.466338754,
0.401931673,
0.313874125,
0.456872612,
0.383233547,
0.264818758,
0.304096848,
0.298382699,
0.484170377,
0.304047883,
0.346563101,
0.284393549,
0.222271159,
0.326116353,
0.304162651,
0.213127181)
gzd
ts.plot(gzd)
gzd.cpt.mean<- cpt.mean(gzd, method="PELT")
plot(gzd.cpt.mean, cpt.col="blue", xlab="Year")
gzd.cpt.var<- cpt.var(gzd, method="PELT")
plot(gzd.cpt.var, cpt.col="red", xlab="Year")

