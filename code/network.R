library("arules")
library("tidyverse")
library("janitor")
library(igraph)
library(networkD3)


olympics_raw <- read_csv("munged_avi.csv")
olympics_raw <- clean_names(olympics_raw)


#trans = read.transactions("munged_avi.csv", format = "single",sep =",", cols = c("subawardee_name", "subaward_description_list"),header = TRUE)
trans <- olympics_raw %>% select(subawardee_name,subaward_description_list,subaward_amount)
trans <- trans %>% drop_na()

trans1 <- olympics_plot4 %>% left_join(trans,by = "subawardee_name")




# create a dataset:
data <- data.frame(
  from=trans1$subaward_description_list,
  to=trans1$subawardee_name)
  #weight = trans$subaward_amount)



library(RColorBrewer)
colourCount = length(unique(data$from))
getPalette = colorRampPalette(brewer.pal(3, "Set2"))

# Map the color to cylinders


# Plot
p <- simpleNetwork(data, height="100px", width="100px",linkColour = "red",fontSize = 12,
                   opacity = 5,
                   linkDistance = 500,
                   nodeColour = getPalette(colourCount),
                   zoom = TRUE) # ability to zoom when click on the node
p
