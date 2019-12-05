library(tidyverse)
library(readr)
data <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)

#filter hospitarisation
dataa <- data %>% filter(HOSPITALIZED<2)
datas <- dataa %>% filter(HOSPITALIZED>-1)
#filter
datad <- datas %>% filter(AMPUTATION<2)
dataf <- datad %>% filter(AMPUTATION>-1)
dataq <- dataf %>% filter(NEAR_FID>0)
datag <- dataq %>% filter(NEAR_DIST<10^6)