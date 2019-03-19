library(xml2)
library(tidyverse)
library(rvest)

c <- 1
for (i in 1:77) {
  zakazky <- read_lines(paste0("https://zakazky.brno-stred.cz/contract_index.html?type=all&state=all&page=", i))
  writeLines(zakazky, paste0("zakazky/", i, ".html"))
  c <- c + 1
  print(c)
}
rm(c,i)

results <- character()

for (i in 1:77) {
  html <- read_html(paste0("zakazky/", i, ".html"))
  result <- html_nodes(html, "#centerBlock > div > table > tbody > tr > td > a") %>% html_attrs() %>% unlist()
  results <- append(results, result)
}

c <- 1
for (i in results) {
  zakazky <- read_lines(paste0("https://zakazky.brno-stred.cz/", i))
  writeLines(zakazky, paste0("zakazky/", i))
  c <- c + 1
  print(c)
}
rm(c,i)