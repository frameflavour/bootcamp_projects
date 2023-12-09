library(tidyverse)
library(rvest)

url <- "https://specphone.com/Samsung-Galaxy-S23-FE-5G-8-256.html"

# read html
specphone <- read_html(url)

att <- specphone %>%
  html_nodes("div.topic") %>%
  html_text()

value <- specphone %>%
  html_nodes("div.detail") %>%
  html_text()

phonedata <- data.frame(
  attribute = att,
  value = value
)

samsung_url <- read_html("https://specphone.com/brand/Samsung")

links <- samsung_url %>%
  html_nodes("li.mobile-brand-item a") %>%
  html_attr("href")

full_links <- paste0("https://specphone.com", links)

result <- data.frame()

for (link in full_links[1:10]) {
  ss_topic <- link %>%
    read_html() %>%
    html_nodes("div.topic") %>%
    html_text()
  
  ss_detail <- link %>%
    read_html() %>%
    html_nodes("div.detail") %>%
    html_text()
  
  tmp <- data.frame(attribute = ss_topic,
                    value = ss_detail)
  
  result <- bind_rows(result, tmp)
  print("Progress ...")
}


