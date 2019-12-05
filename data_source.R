library(tidyverse)
library(readr)
dataz <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)

#add_state population
injury_state <- dataz %>% group_by(STATE) %>% summarise(number = n())
datax <- transform(injury_state, population = c(4898246,735720,55689,7275070,3026412,39747267,5770545,3567871,975033,711571,29087070,10627767,162742,1416589,1790182,12700381,6718616,3167997,2910931,4484047,4652581,1342097,6062917,6939373,10020472,5655925,2987895,6147861,1074532,1940919,3087025,1363852,8922547,2096034,19491339,10497741,760900,55144,11718568,3948950,4245901,12813969,3113659,1056738,5147111,892631,6833793,29087070,3221610,627180,106405,8571946,7666343,1791951,5832661,572381))
datax %>% ungroup(STATE)

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
