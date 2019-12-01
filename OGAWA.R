library(tidyverse)
library(readr)
data <- read_delim("injurydata.csv",";", escape_double = FALSE, trim_ws = TRUE)


library(leaflet)

map <- data %>% filter(NATURETITLE=='Fractures') 
  leaflet() %>% 
  setView(-95, 40, zoom= 3.5) %>% 
  addCircles(data = map, lat= ~as.numeric(LATITUDE), lng = ~as.numeric(LONGITUDE),
             weight = 0.4, color="BLUE", stroke = TRUE, fillOpacity = 1) %>%
  addProviderTiles(providers$CartoDB.Positron, group = "Standard") %>%    addScaleBar()



  
  





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
  