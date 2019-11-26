library(tidyverse)
library(readr)
injurydata <- read_delim("injurydata.csv", 
                         +     ";", escape_double = FALSE, trim_ws = TRUE)


