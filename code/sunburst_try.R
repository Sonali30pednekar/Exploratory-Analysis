#Loading necessary libraries
library(dplyr)
library(janitor)
library(tidyverse)
library(plotly)
library(gganimate)
library(ggpubr)
library(scales)
library(ggalt)
library(ggplot2)
library(grid)
library(ggimage)
library(plotly)
library(ggtext)
library(magick)
library(treemap)

#Reading the data 
olympics_raw <- read_csv("Dataset_Contract_Sub-Awards.csv")
olympics_raw <- clean_names(olympics_raw)

data_limit <- olympics_raw %>% select(c('prime_award_awarding_agency_name',
                                        'prime_award_awarding_sub_agency_name',
                                        'prime_awardee_parent_name',
                                        'subawardee_name'))


library(plotly)

fig <- plot_ly(
  labels = c("DOD", "DARPA","RC","RTC","RC","RTC","DCMA"),
  parents = c("", "DOD", "DARPA","DARPA","DCMA","DCMA","DOD"),
  values = c(0, 10, 8,2,8,6,2),
  type = 'sunburst'
)

fig

                                        