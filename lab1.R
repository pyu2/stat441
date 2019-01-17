# Lab 1 Introduction to R

# Adapted and commented by Peng Yu
#
#########################################################################
# Basic Commands
#########################################################################

# create vector
x <- c(1,3,2,5)
# show x
x
x = c(1,6,2)
x
y = c(1,4,3)

length(x)  # length(x) return the length of x, x should be a vector.
length(y)
x+y     # operator + - * / for vectors works elementwise
ls()    # ls() returns the gloabl environment(variables)
rm(x,y) # rm() means remove, rm(x,y) remove variable x and y.
ls()
rm(list=ls()) # remove all the existing variables(global environment)
?matrix # ?xxx means you search help for xxx
x=matrix(data=c(1,2,3,4), nrow=2, ncol=2) # creating matrix
x
x=matrix(c(1,2,3,4),2,2) # data=, nrow=, ncol= can be removed.
matrix(c(1,2,3,4),2,2,byrow=TRUE) # byrow = T means data c(1,2,3,4) will fill the matrix row by row. By default it is false.
sqrt(x) # take square root of x (elementwise)
x^2 # take square of x (elementwise)
x=rnorm(50) # rnorm means random generate numbers form standard normal distribution. rnorm(n=, mean=, sd=).
y=x+rnorm(50,mean=50,sd=.1)
cor(x,y) # correlation betwween x and y
set.seed(1303) # # set seed for random number generation to get reproducible results
                 # set.seed(123)
                 # x1 = rnorm(50)
                 # set.seed(123)
                 # x2 = rnorm(50)
                 # then x1 and x2 are exactlly the same.
                 # the seed value doesn't matter that much
rnorm(50)
set.seed(3)
y=rnorm(100)
mean(y) 
var(y)
sqrt(var(y))
sd(y)


#########################################################################
# Graphics
#########################################################################


x=rnorm(100)
y=rnorm(100)
plot(x,y)
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y")

pdf("Figure.pdf") # create a pdf file, you can use getwd() to get your working direction. Figure.pdf should be there.
                  # for example > getwd()
                  #            [1] "C:/Users/pengy/Desktop/stat441"

plot(x,y,col="green") # create a plot inside the pdf.
dev.off() # finish the creation.
x=seq(1,10) # create a sequence from 1 to 10, x[i] - x[i-1] = 1. 
            # seq(10,1) from 10 to 1, x[i] - x[i-1] = -1.
x
x=1:10 # same as seq(from = 1,to = 10).
x
x=seq(-pi,pi,length=50) # create a vector from -pi to pi with length 50.
y=x
f=outer(x,y,function(x,y)cos(y)/(1+x^2)) # Outer Product of Arrays f[i,j] = cos(y[j])/(1+x[i]^2)    f is a 50 * 50 matrix now.
contour(x,y,f) # Create a contour plot, or add contour lines to an existing plot.
contour(x,y,f,nlevels=45,add=T) # nlevels = 45 means 45 contours, add = T means add to the existing plot.
fa=(f-t(f))/2 # f - transpose(f)
contour(x,y,fa,nlevels=15)
image(x,y,fa) # plot fa as image, fa[i,j] is treated as pixel.
persp(x,y,fa) # Perspective Plots, This function draws perspective plots of a surface over the x-y plane. persp is a generic function.
persp(x,y,fa,theta=30)
persp(x,y,fa,theta=30,phi=20) # angles defining the viewing direction. theta gives the azimuthal direction and phi the colatitude.
persp(x,y,fa,theta=30,phi=70)
persp(x,y,fa,theta=30,phi=40)

#########################################################################
# Indexing Data
#########################################################################


A=matrix(1:16,4,4)
A
A[2,3] # element on the 2th row and 3th column
A[c(1,3),c(2,4)] # a sub matrix of A containing only 1,3th row and 2,4th column.
A[1:3,2:4] # a sub matrix of A containing 1,2,3th row and 2,3,4th column.
A[1:2,] # a sub matrix of A containing 1,2th row.
A[,1:2] # a sub matrix of A containing 1,2th column.
A[1,] # A's first row, it is a vector not matrix anymore.
A[-c(1,3),] # a sub matrix of A by deleting A's 1,3th row.
A[-c(1,3),-c(1,3,4)] # ....by deleting A's 1,3th row and 1,3,4th column.
dim(A) # dimension of A



#########################################################################
# Loading Data
#########################################################################

# Loading Data


# website for data http://www-bcf.usc.edu/~gareth/ISL/Auto.data

Auto=read.table("Auto.txt") # use getwd() to look at your working direction and download Auto.data there so that you can run it ( I saved it as a txt file this time)
fix(Auto)
# you can also try reading online
Auto=read.table("http://www-bcf.usc.edu/~gareth/ISL/Auto.data", header=T, na.strings="?")

Auto=read.table("Auto.txt",header=T,na.strings="?") # na.strings = "?" means replace ? in the document as NA.
fix(Auto) # fix() ensures you can visualize and fix the data. 
Auto=read.csv("Auto.csv",header=T,na.strings="?") # the same thing but save it as .csv
fix(Auto)
dim(Auto) # 397, 9
Auto[1:4,]
Auto=na.omit(Auto) # omit rows which contains NA
dim(Auto) # becomes 392, 9 which means 5 rows are deleted.
names(Auto) # returns the variable names in Auto.

#########################################################################
# Additional Graphical and Numerical Summaries
#########################################################################


plot(cylinders, mpg)
plot(Auto$cylinders, Auto$mpg) # use $ to call variables in Auto. 
attach(Auto) # # use attach function to tell R name each column of Auto as a variable(don't need $ to call them anymore)
plot(cylinders, mpg)
cylinders=as.factor(cylinders) # transfer cylinder from numeric to factor.
plot(cylinders, mpg) # this time returns the boxplot, since cylinders is factor not numeric.
plot(cylinders, mpg, col="red")
plot(cylinders, mpg, col="red", varwidth=T) # varwidth=T  makes boxplot widths proportional to the square root of the samples sizes
plot(cylinders, mpg, col="red", varwidth=T,horizontal=T)
plot(cylinders, mpg, col="red", varwidth=T, xlab="cylinders", ylab="MPG")
hist(mpg) # histogram
hist(mpg,col=2)
hist(mpg,col=2,breaks=15)
pairs(Auto) # a scatter plot matrix of all variables of Auto
pairs(~ mpg + displacement + horsepower + weight + acceleration, Auto) # a scatter plot matrix of all selected variables of Auto
plot(horsepower,mpg)
identify(horsepower,mpg,name) # identify the value of a certain variable of selected points
summary(Auto)
summary(mpg)