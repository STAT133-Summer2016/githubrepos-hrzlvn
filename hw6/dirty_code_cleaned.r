library(dplyr)
library(stringr)
library(xml2)
library(rvest)
library(readr)
library(tidyr)
library(plyr)

table = read_html("https://en.wikipedia.org/wiki/Automotive_industry") %>% 
  html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[1] %>% 
  html_table(fill = TRUE) %>% 
  data.frame() %>% 
  mutate(Group = tolower(Group)) %>% 
  select(-Cars, -LCV, -HCV, -Heavy.Bus, -Total)

mpg2 <- read.csv("mpg2.csv.bz2", stringsAsFactors=FALSE,  strip.white=TRUE) %>%
  mutate(make = tolower(make))

mpg2 = merge(mpg2, table) %>% 
  select(-trans_dscr, -eng_dscr, -Rank, -Group) %>% 
  mutate(vclass = str_replace(vclass, "[-/ ]?[ ]?[24][wWdD]{2}$", "")) %>%
  mutate(vclass = str_replace(vclass, ", ", " ")) %>%
  mutate(vclass = str_replace(vclass, " Passenger", "")) %>%
  mutate(vclass = str_replace(vclass, " Cargo", "")) %>%
  mutate(vclass = str_replace(vclass, " Type", "")) %>%
  mutate(vclass = str_replace(vclass, "Midsize-Large", "Large")) %>%
  mutate(vclass = str_replace(vclass, "(.*[^s ]$)", "\\1s"))

mpg2$guzzler[is.na(mpg2$guzzler)] = FALSE
mpg2$guzzler = as.logical(mpg2$guzzler)

write.csv(subset(mpg2, year >= 2000), "mpg2-clean.csv")
mpg3 <- read.csv("mpg2-clean.csv", stringsAsFactors=FALSE,  strip.white=TRUE)
View(mpg3)