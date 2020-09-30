
library(tidyverse)
library(readxl)
library(zoo)

lazar_data <- read_xlsx("Lazar_data.xlsx", sheet = "Typical expenditure levels", skip = 1) %>%
  select(-1) %>% rename("type" = "...2") 

lazar_data_longer <- lazar_data %>% pivot_longer(cols = c("1991", "1995", 
                                                             "2010", "2014")) %>%
  na.locf()
names(lazar_data_longer) = c("type", "level", "year", "value")



lazar_data_figs <- read_xlsx("Lazar_fig_data.xlsx", sheet = "Fig2 & Fig5 & FigS2.1", skip =1)
  

