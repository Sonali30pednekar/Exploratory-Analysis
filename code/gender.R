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

#Reading the data 
olympics_raw <- read_csv("Dataset_Contract_Sub-Awards.csv")
olympics_raw <- clean_names(olympics_raw)








olympics_plot2 <- olympics_raw %>% select(subawardee_name,subaward_amount)

olympics_plot3 <- olympics_plot2 %>% group_by(subawardee_name) %>% summarise(total_amount = sum(subaward_amount))

olympics_plot4<-olympics_plot3 %>% arrange(desc(total_amount)) %>% head(10)


olympics_plot4 <- olympics_plot4 %>% mutate( color_bar = case_when(
  subawardee_name == "ALLIANT TECHSYSTEMS OPERATIONS LLC" ~ "one",
  TRUE ~ "two"
)
)


p1 <- ggplot()+
  geom_bar(data = olympics_plot4,
           mapping = aes(
             x=reorder(subawardee_name,total_amount),
             y = total_amount,
             fill = color_bar),
           stat = "identity",
           show.legend = FALSE)+
  coord_flip()
  
p1 <- p1+ scale_y_continuous(labels = scales::comma)+
  #transition_reveal(year) +
  theme_classic()+
  scale_fill_manual(values = c("one" = "#a65628","two" = "#ff7f00"))+
  theme( 
    #axis.text.x=element_text(angle=90,hjust=1,vjust=0.5),
    plot.title = element_markdown(lineheight = 1.1),
    plot.caption = element_markdown(lineheight = 1.1),
    legend.position="bottom",
    legend.key.width = unit(1.2, "cm"),
    plot.background = element_rect(fill = "#F6F5F5"),
    panel.background = element_rect(fill = "#F6F5F5",
                                    colour = "#F6F5F5",
                                    size = 0.5, linetype = "solid"),
    legend.key = element_rect(fill = "transparent"))+
  labs(
    x = "Sub-Award Company",
    y = "Total Amount",
    title = paste0("**Monetory Distribution of Sub-Award Companies**"),
    subtitle = "Displaying the top 10 companies by amount"              
    )
#scale_x_continuous("year", labels = as.character(year), breaks = year)

p1


#ggsave("Plots/money_plot.png")






