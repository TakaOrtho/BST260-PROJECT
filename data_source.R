library(tidyverse)
library(readr)
dataz <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)

#filter hospitarisation(0/1)
dataa <- dataz %>% filter(HOSPITALIZED<2)
datas <- dataa %>% filter(HOSPITALIZED>-1)
#filter amputation(0/1)
datad <- datas %>% filter(AMPUTATION<2)
dataf <- datad %>% filter(AMPUTATION>-1)
#filter by hospital id
dataq <- dataf %>% filter(NEAR_FID>0)

#distance less than 10^5 meter
data <- dataq %>% filter(NEAR_DIST<10^5)

