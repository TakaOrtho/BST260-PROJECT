library(tidyverse)
library(readr)
library(ggrepel)
library(dslabs)

data <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)

#cleaning_employer 
data$EMPLOYER =gsub(".*usps|us postal|united states postal|u.s. postal|u.s postal|u. s postal|u. s. postal.*","US_Postal_Service",                   ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*US_Postal_Service.*","USPS", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*united parcel|ups |ups,.*","United_Parcel_Service", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*United_Parcel_Service.*","UPS", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*american airl.*","American Airlines", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*AT &|AT&.*","AT_T", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*AT_T.*","AT&T Inc", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*walmart|wallmart|wal-mart.*","wal_mart", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*wal_mart.*","Walmart", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Publix.*","Publix_", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Publix_.*","Publix", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Asplundh.*","Asplundh_", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Asplundh_.*","Asplundh", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*sodexo.*","sodexo_", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*sodexo_.*","Sodexo", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Waste Management.*","Waste_Management", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Waste_Management.*","Waste Management", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Tyson Foods.*","Tyson_Foods", ignore.case = TRUE, data$EMPLOYER)
data$EMPLOYER =gsub(".*Tyson_Foods.*","Tyson Foods", ignore.case = TRUE, data$EMPLOYER)

#add SES
a <-read_csv("ACS_17_5YR_S0101_with_ann.csv")
b  <-read_csv("ACS_17_5YR_S0701_with_ann.csv")
c <-read_csv("ACS_17_5YR_S0801_with_ann.csv")
d <-read_csv("ACS_17_5YR_S1101_with_ann.csv")
e <-read_csv("ACS_17_5YR_S1901_with_ann.csv")
f <-read_csv("ACS_17_5YR_S2301_with_ann.csv")
a<-a %>%   rename('ZIP' = 'GEO.id2')
b<-b %>%   rename('ZIP' = 'GEO.id2')
c<-c %>%   rename('ZIP' = 'GEO.id2')
d<-d %>%   rename('ZIP' = 'GEO.id2')
e<-e %>%   rename('ZIP' = 'GEO.id2')
data <- data %>% left_join(a,by="ZIP")
data <- data %>% left_join(b,by="ZIP")
data <- data %>% left_join(c,by="ZIP")
data <- data %>% left_join(d,by="ZIP")
data <- data %>% left_join(e,by="ZIP")


#add_state population
f <-read_csv("state_pop.csv",col_names = F)
f <- rename(f,STATE=X1)
dataa <- data %>% left_join(f, by="STATE")


#filter hospitarisation(0/1)
dataa <- datax %>% filter(HOSPITALIZED<2)
datas <- dataa %>% filter(HOSPITALIZED>-1)
#filter amputation(0/1)
datad <- datas %>% filter(AMPUTATION<2)
dataf <- datad %>% filter(AMPUTATION>-1)
#filter by hospital id
dataq <- dataf %>% filter(NEAR_FID>0)

#distance less than 10^5 meter
data <- dataq %>% filter(NEAR_DIST<10^5)

#add_multiple injury
Left<-function(x,chr){
  return(substr(x,1,chr))}

data<-mutate(data, leftMul = Left(PARTOFBODYTITLE,3))
data<-mutate(data, MultiInj = ifelse(data$leftMul=="Mul", "1", "0"))

data
#### 出力
##write.csv(datag, "C:/Users/keiko/Desktop/BST260-PROJECT/injurydata1130.csv", sep=";" ) 

