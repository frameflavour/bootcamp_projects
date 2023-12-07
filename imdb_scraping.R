install.packages("rvest")
install.packages("stringr")
library(tidyverse)
library(rvest)
library(stringr)
url <- "https://www.imdb.com/search/title/?sort=user_rating,desc&groups=top_100"

print(url)

# read html
imdb <- read_html(url)

# movie title
titles <- imdb %>% 
  html_nodes("h3.ipc-title__text") %>%
  html_text()

titles <- titles[1:50]

# rating
ratings <- imdb %>%
  html_nodes("span.ipc-rating-star.ipc-rating-star--base.ipc-rating-star--imdb.ratingGroup--imdb-rating") %>%
  html_text() %>%
  str_sub(1,3) %>%
  as.numeric()

# vote
votes <- imdb %>%
  html_nodes("div.sc-21df249b-0.jmcDPS") %>%
  html_text()

# build a dataset
df <- data.frame(
  title = titles,
  rating = ratings,
  num_vote = votes
)
