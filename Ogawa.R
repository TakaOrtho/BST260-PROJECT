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

#NLP
text <- data %>%  unnest_tokens(word, narra)
data(stop_words)
text <- text %>% anti_join(stop_words)
text <-transform(txt,Freq=0)

#Bar chart
text %>%
  count(word, sort = TRUE) %>%
  filter(n > 1000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

#Word Cloud
library(wordcloud2)
wordcloud2(text,size=1,minSize=10)
wctext <- text %>% group_by(word) %>% mutate(Freq = n())

wctext%>% select(word,Freq)%>% 
  distinct(word, .keep_all = TRUE)%>%
  arrange(desc(Freq)) %>% 
  head(4)%>%
    wordcloud2()

