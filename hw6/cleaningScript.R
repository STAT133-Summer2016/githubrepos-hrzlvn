library(dplyr)
library(stringr)
library(xml2)
library(rvest)
library(readr)
library(tidyr)
library(plyr)

cleaned_population = read_csv("population.csv")
cols = str_detect(colnames(cleaned_population), "[0-9a-z]")
cleaned_population = cleaned_population[!is.na(cols)]
names(cleaned_population) = c('country', str_replace(names(cleaned_population)[2:82], "([0-9]{4}).0", "\\1"))
cleaned_population = cleaned_population %>% 
  filter(!is.na(country))

na_years = as.character(c(1801:1809,
                          1811:1819, 
                          1821:1829, 
                          1831:1839, 
                          1841:1849, 
                          1851:1859,
                          1861:1869, 
                          1871:1879, 
                          1881:1889,
                          1891:1899, 
                          1901:1909, 
                          1911:1919,
                          1921:1929, 
                          1931:1939, 
                          1941:1949))

na_df = data.frame(matrix(NA, ncol = 135, nrow = 275))
names(na_df) = na_years
na_df = mutate(na_df, country = cleaned_population$country)
cleaned_population = left_join(cleaned_population, na_df)
cleaned_population = cleaned_population[,c('country', c(as.character(1800:2015)))]


for (i in 1:nrow(cleaned_population)){
  for (j in 1800:2015){
    if (is.na(cleaned_population[i, as.character(j)])){
      adjcent_years_population = cleaned_population[i, intersect(as.character((j %/% 10 * 10) : ((j %/% 10 * 10) + 9)), x = colnames(cleaned_population))]
      
      adjcent_years_population = as.numeric(adjcent_years_population[!is.na(adjcent_years_population)])
      if (length(adjcent_years_population) > 0){
        replace_val = mean(adjcent_years_population)
        cleaned_population[i, as.character(j)] = mean(adjcent_years_population)
      }
    }
  }
}

life_expectancy = read_csv("lifeexpectancy.csv") %>% 
  gather(key = year, value = lifeexpectancy, -`Life expectancy with projections. Yellow is IHME`) %>% 
  mutate(country = `Life expectancy with projections. Yellow is IHME`) %>%
  mutate(year = as.numeric(year)) %>% 
  select(country, year, lifeexpectancy) %>% 
  filter(!is.na(country))

population = cleaned_population %>%
  gather(key = year, value = population, -country) %>%
  mutate(year = as.numeric(year)) %>% 
  select(country, year, population)

gdppc = read_csv("gdppc.csv") %>% 
  gather(key = year, value = gdp, -`GDP per capita`) %>% 
  mutate(country = `GDP per capita`) %>%
  select(country, year, gdp) %>% 
  mutate(year = as.numeric(year)) %>% 
  filter(!is.na(country))

table = read_html("https://docs.google.com/spreadsheets/d/1OxmGUNWeADbPJkQxVPupSOK5MbAECdqThnvyPrwG5Os/pub?gid=1#") %>% 
  html_nodes(xpath="//table[@class='waffle']") %>%
  .[2] %>%
  html_table(fill = TRUE) %>% 
  data.frame() %>%
  mutate(country = Var.2, region = Var.3, code = Var.4) %>%
  select(country, region, code) %>%
  filter(country != "Entity")

cleaned_demographics = left_join(table, population) %>% 
  left_join(gdppc) %>% 
  left_join(life_expectancy)

write_csv(cleaned_demographics, "cleaned_demographics.csv")
