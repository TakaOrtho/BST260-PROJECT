#Import
library(tidyverse)
library(readr)
data <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)

#filtering
#hospitalised   -1~2
#amputation -1~2
#near_fid  0~
dataa <- data %>% filter(HOSPITALIZED<2)
datas <- dataa %>% filter(HOSPITALIZED>-1)
datad <- datas %>% filter(AMPUTATION<2)
dataf <- datad %>% filter(AMPUTATION>-1)
dataq <- dataf %>% filter(NEAR_FID>0)

hist(dataf$NEAR_DIST)
summary(dataf$NEAR_DIST)

datag <- dataq %>% filter(NEAR_DIST<10^6)

#left function
Left<-function(x,chr){
  return(substr(x,1,chr))}

#making Multiple Injury (0/1) column
datag<-mutate(datag, leftMul = Left(PARTOFBODYTITLE,3))
datag<-mutate(datag, MultiInj = ifelse(datag$leftMul=="Mul", "1", "0"))

#write to csv
write.csv(datag, "C:/Users/keiko/Desktop/BST260-PROJECT/injurydata1130.csv", sep=";") 
write.table(datag, "C:/Users/keiko/Desktop/BST260-PROJECT/injurydata1130.txt", sep="\t") 

#read txt
library(readr)
injurydata1130 <- read_delim("injurydata1130.txt", 
                             "\t", escape_double = FALSE, trim_ws = TRUE)
View(injurydata1130)