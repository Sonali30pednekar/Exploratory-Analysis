#Loading necessary libraries
library(tidyverse)
library(janitor)
library(sf)
library(spData)
library(skimr)
library(knitr)
library(naniar)
library(GGally)
library(styler)
library(ggtext)
library(data.table)
library(grid)
library(plotly)
library(ggplot2)
library("scales")
library(timeDate)
library(ggiraph)
library(ggridges)
library(ggimage)
library(ggpubr)

#Reading the data 
olympics_raw <- read_csv("Dataset_Contract_Sub-Awards4.csv")
olympics_raw <- clean_names(olympics_raw)

olympics_raw2 <- separate_rows(olympics_raw, subawardee_business_types, sep = ",", convert = TRUE)
#olympics_raw2 <- olympics_raw2 %>% distinct()

olympics_raw2$subawardee_business_types <- as.factor(olympics_raw2$subawardee_business_types)



olympics_plot <- olympics_raw2 %>% 
  group_by(subawardee_name) %>% 
  summarise(Unique_Elements = n_distinct(subawardee_business_types)) %>% 
  arrange(desc(Unique_Elements)) %>% 
  head(5)
  

trans1 <- olympics_plot %>% left_join(olympics_raw2,by = "subawardee_name")

write.csv(trans1,"altair_top5.csv", row.names = FALSE)


olympics_5 <- read_csv("altair_top5.csv")






trans2 <-olympics_5 %>% select(subawardee_name,subaward_amount,subaward_description_list) %>% distinct() 
  
  
trans3<- trans2 %>% 
  pivot_wider(names_from = subawardee_name, values_from = subaward_amount)



trans4 <- trans3 %>% 
  remove_rownames %>% column_to_rownames(var="subaward_description_list")

ggballoonplot(trans4, fill = "value",show.legend = FALSE)+
  scale_fill_brewer(option = "C")+
  theme_classic()+
  theme(
    axis.text.x=element_text(angle=90,hjust=0.1,vjust=0.2),
    plot.background = element_rect(fill = "#F6F5F5"),
    panel.background = element_rect(fill = "#F6F5F5",
                                    colour = "#F6F5F5",
                                    size = 0.5, linetype = "solid")
  )+
  labs(
    x = "Sub-Award Company",
    y = "Description List",
    title = paste0("Monetory Breakdown"),
    subtitle = "Displaying the top 4 companies and their expenditure in material"              
  )





#write.csv(trans1,"altair_top5.csv", row.names = FALSE)


