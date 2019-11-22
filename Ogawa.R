#na.omit(data)
library(tidytext)
library(haven)
library(tidyverse)
library(readr)
data <- read_csv("severeinjury.csv")
data <- data %>%   rename('narra' = 'Final Narrative')

dist <- read_csv("EucDistHp.csv")
dist <- dist %>%   rename('Zip' = 'ZIPCODE')

cens <- read_csv("ACS_16_5YR_S1811_with_ann.csv")
cens <- cens %>%   rename('Zip' = 'GEO.id2')

cens <- cens[-1,]
cens$Zip <- as.numeric(cens$Zip)

hpno <- read_csv("HpNumPerZip.csv")
hpno <- hpno %>%   rename('Zip' = 'ZIPCODE')

names(data)
 
#merge
data <- left_join(data,dist,by="Zip")
data <- left_join(data,cens,by="Zip")
data <- left_join(data,hpno,by="Zip")
head(data)




#REGRESSION
mod1 <- lm(Amputation ~ MEAN, data = data)
mod2 <- lm(Amputation ~ AREA, data = data)
library(jtools)
summ(mod1, confint = T)
summ(mod2, confint = T)




