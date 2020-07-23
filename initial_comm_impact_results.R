library(tidyverse)

impact_one = read_csv("data/comm_impact_test0.csv") %>% 
  mutate(comm_impact = 0) %>% 
  select(total_mig, comm_impact)

impact_two = read_csv("data/comm_impact_test1.csv") %>% 
  mutate(comm_impact = 0.1) %>% 
  select(total_mig, comm_impact)

impact_three = read_csv("data/comm_impact_test4.csv") %>% 
  mutate(comm_impact = 0.4) %>% 
  select(total_mig, comm_impact)

impact_four = read_csv("data/comm_impact_test5.csv") %>% 
  mutate(comm_impact = 0.5) %>% 
  select(total_mig, comm_impact)

impact_five = read_csv("data/comm_impact_test8.csv") %>% 
  mutate(comm_impact = 0.8) %>% 
  select(total_mig, comm_impact)

impact_six = read_csv("data/comm_impact_test100.csv") %>% 
  mutate(comm_impact = 1) %>% 
  select(total_mig, comm_impact)


impact_joined = impact_one %>%
  bind_rows(impact_two) %>%
  bind_rows(impact_three) %>%
  bind_rows(impact_four) %>%
  bind_rows(impact_five) %>%
  bind_rows(impact_six)


impact_summary = impact_joined %>%
  group_by(comm_impact) %>%
  summarise(av_migs = mean(total_mig),
            sd_migs = sd(total_mig))


impact_joined %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = total_mig))+
  labs(x = "Community Impact Factor", y = "Total Migrations")+
  theme_bw()
  
  
  
  
  