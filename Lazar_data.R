
library(tidyverse)
library(readxl)
library(zoo)

lazar_data <- read_xlsx("Lazar_data.xlsx", sheet = "Typical expenditure levels", skip = 1) %>%
  select(-1) %>% rename("type" = "...2") 

lazar_data_longer <- lazar_data %>% pivot_longer(cols = c("1991", "1995", 
                                                             "2010", "2014")) %>%
  na.locf()
names(lazar_data_longer) = c("type", "level", "year", "value")



lazar_data_figs <- read_xlsx("Lazar_fig_data.xlsx", sheet = "Fig2 & Fig5 & FigS2.1", skip =1) %>%
  pivot_longer(cols = c(-"ArchetypeID", -"Livelihood type")) %>% 
  na.locf()
  
farming <- lazar_data_figs %>% filter(`Livelihood type` == "Farming")
farm_labor <- lazar_data_figs %>% filter(`Livelihood type` == "FarmLabour")
livestock <- lazar_data_figs %>% filter(`Livelihood type` == "Livestock")
remittances <- lazar_data_figs %>% filter(`Livelihood type` == "Remittance")
services <- lazar_data_figs %>% filter(`Livelihood type` == "Services")
fishing <- lazar_data_figs %>% filter(`Livelihood type` == "Fishing")

lazar_data_figs %>%
  filter(ArchetypeID == "AR3(SLO)") %>%
  ggplot()+
  geom_boxplot(aes(x =  `Livelihood type`, y = value)) +
  theme_bw()
  
  
  
  
  
  
