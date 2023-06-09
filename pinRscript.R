### Part 1

library(pwr)
pwr.anova.test(k=3,n=NULL,f=((.5*sqrt((3^2)-1))/(2*3)),sig.level=0.05,power=.75)
library(agricolae)

treatments<-c("green","yellow","blue")
design<-design.crd(trt=treatments,r=13,seed = 12345)
design$book

library(knitr)

F_levels <- cbind(z$plots,z$r,z$treatments) 
kable(F_levels,caption = "Completely Randomized Design ", col.names = c("Plot","Replication","Color of Ball"))

z <- read.csv("https://raw.githubusercontent.com/Rusty1299/Projects/main/Part%202%20data%20redoe.csv")
z$treatments <- as.factor(z$treatments)

boxplot(z$distance~z$treatments, col= c("Red","Green","Yellow"), main = "Distance of each ball", xlab = "Treatment balls", ylab = "Distance in inches")
qqnorm(z$distance)
a <- aov(data = z , distance~treatments)
summary(a)

## Part 2
trts<-c(2,3)
design<-design.ab(trt=trts, r=3, design="crd",seed=878900)
design$book

BungeeEx<-read.csv("https://raw.githubusercontent.com/Rusty1299/Projects/main/Factorial%20Design%20Project.csv")
library(GAD)
BungeeEx$Pin.Location<-as.fixed(BungeeEx$Pin.Location)
BungeeEx$Angle<-as.random(BungeeEx$Angle)

model<-aov(BungeeEx$Distance...Inches.~BungeeEx$Pin.Location*BungeeEx$Angle)
gad(model)

model<-aov(BungeeEx$Distance...Inches.~BungeeEx$Pin.Location+BungeeEx$Angle)
gad(model)

interaction.plot(BungeeEx$Angle,BungeeEx$Pin.Location,BungeeEx$Distance...Inches., type = "l", col = 5:7 ,main ="Interraction Plot", ylab = "Distance", xlab = "Release Angles", trace.label = "Pin Elevation", lwd = 3, lty = 1)

plot(model)
boxplot(BungeeEx$Distance...Inches.~BungeeEx$Angle, col = 6:9:3, main = "Boxplot for Relaease Angle", xlab = "Release Angle", ylab = "Distance")
boxplot(BungeeEx$Distance...Inches.~BungeeEx$Pin.Location, col = 2:4, main = "Boxplot for Pin Elevation", xlab = "Pin Elevation", ylab = "Distance")

## Part 3

library(agricolae)
#?design.ab
trts<-c(2,2,2,2)
design<-design.ab(trt=trts, r=1, design="crd",seed=878900)

design$book

library(knitr)
A <- c("Pin Location","Postion 1","Postion 3")
B <-c("Bungee Position"	,"Position 2",	"Position 3")
C<-c("Release Angle",	"140 degrees",	"170 degrees")
D<-c("Ball Type",	"Yellow",	"Red")
F_levels <- rbind(A,B,C,D)
colnames(F_levels)<- c("Factor","Low Level(-1)","High Level(+1)")
kable(F_levels,caption = "Factors and Low and High Levels")

library(DoE.base)
Pin_Elevation<-c(-1,-1,-1,1,1,1,-1,-1,-1,1,1,1,1,-1,-1,1)
Bungee_Position<-c(-1,-1,1,1,-1,1,1,1,1,1,-1,-1,1,-1,-1,-1)
Release_Angle<-c(1,1,-1,1,1,1,1,1,-1,-1,-1,1,-1,-1,-1,-1)
Ball_Type<-c(-1,1,1,-1,-1,1,1,-1,-1,1,1,1,-1,1,-1,-1)
response<-c(36,35,34,60,68,60,37,38,33,41,42,52,51,34,26,47)
dat<-data.frame(Pin_Elevation,Bungee_Position,Release_Angle,Ball_Type,response)
dat

model<-lm(response~Pin_Elevation*Bungee_Position*Release_Angle*Ball_Type, data = dat)
#summary(model)
coef(model)

halfnormal(model)
Pin_Elevation<-as.factor(Pin_Elevation)
Bungee_Position<-as.factor(Bungee_Position)
Release_Angle<-as.factor(Release_Angle)
Ball_Type<-as.factor(Ball_Type)

model1<-aov(response~Pin_Elevation+Release_Angle)
summary(model1)
coef(model1)
