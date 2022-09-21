library(tidyverse)
library(janitor)
library(GGally)

data <- read_csv("Dataset_Contract_Sub-Awards.csv")
data <- clean_names(data)

data_discard <- data %>%  select(where(~ n_distinct(.) == 1)) 

data_small <- data %>% select(where(~ n_distinct(.) > 1))


# Plot
ggparcoord(data,
           columns = data %>% select(c('prime_award_awarding_agency_name',
                                       'prime_award_awarding_sub_agency_name',
                                       'prime_awardee_name',
                                       'subawardee_name'))
) 



write.csv(data_small,"data_small.csv", row.names = FALSE)






data <- read_csv("Dataset_Contract_Sub-Awards4.csv")
data <- clean_names(data)


olympics_raw2 <- separate_rows(data, subawardee_business_types, sep = ",", convert = TRUE)
olympics_raw2 <- olympics_raw2 %>% distinct()

write.csv(olympics_raw2,"data_altair.csv", row.names = FALSE)

