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
library(ggtext)
library(magick)

#Reading the data 
olympics_raw <- read_csv("Dataset_Contract_Sub-Awards.csv")
olympics_raw <- clean_names(olympics_raw)

olympics_plot2 <- olympics_raw %>% select(subaward_number,subaward_action_date_fiscal_year,subaward_number)
olympics_plot2 <- olympics_plot2 %>% distinct()


count_num <- olympics_plot2 %>% group_by(subaward_action_date_fiscal_year) %>% count()

ggplot()+
  geom_line(data = count_num,
            mapping = aes(
              x = subaward_action_date_fiscal_year,
              y = n
            ),show.legend = FALSE)
