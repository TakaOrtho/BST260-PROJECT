library(tidyverse)
library(readr)
dataz <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)

#filter hospitarisation
dataa <- dataz %>% filter(HOSPITALIZED<2)
datas <- dataa %>% filter(HOSPITALIZED>-1)
#filter
datad <- datas %>% filter(AMPUTATION<2)
dataf <- datad %>% filter(AMPUTATION>-1)
dataq <- dataf %>% filter(NEAR_FID>0)
data <- dataq %>% filter(NEAR_DIST<10^5)

