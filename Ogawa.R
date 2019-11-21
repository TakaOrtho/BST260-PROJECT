#na.omit(data)
library(tidytext)
library(haven)
library(tidyverse)
library(readr)
data <- read_csv("severeinjury.csv")
data %>%   rename('Final Narrative' = 'narra')
data <- data %>%   rename('narra' = 'Final Narrative')
head(data)
names(data)

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
  head(100)%>%
    wordcloud2()

