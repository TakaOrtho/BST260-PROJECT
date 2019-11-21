library(haven)
library(tidyverse)
data <- read_dta("text.dta")
na.omit(data)


library(tidytext)
txt <- data %>%
  unnest_tokens(word, eventtitle)

data(stop_words)
txt <- txt %>% anti_join(stop_words)

txt %>%
  count(word, sort = TRUE) %>%
  filter(n > 1000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()
