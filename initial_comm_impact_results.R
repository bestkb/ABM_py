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
  
  
  
  ############### 100 households

impact_zero = read_csv("comm_impact_test0_100hh.csv") %>% 
  mutate(comm_impact = 0) %>% select(-1)

impact_two = read_csv("comm_impact_test02_100hh.csv") %>% 
  mutate(comm_impact = 0.2) %>% select(-1)

impact_four = read_csv("comm_impact_test04_100hh.csv") %>% 
  mutate(comm_impact = 0.4) %>% select(-1)

impact_six = read_csv("comm_impact_test06_100hh.csv") %>% 
  mutate(comm_impact = 0.6) %>% select(-1)

impact_eight = read_csv("comm_impact_test08_100hh.csv") %>% 
  mutate(comm_impact = 0.8) %>% select(-1)

impact_one = read_csv("comm_impact_test10_100hh.csv") %>% 
  mutate(comm_impact = 1.0) %>% select(-1)


impact_joined = impact_two %>%
  bind_rows(impact_four) %>%
  bind_rows(impact_six) %>%
  bind_rows(impact_eight) %>%
  bind_rows(impact_one)


impact_summary = impact_joined %>%
  group_by(comm_impact) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))


impact_joined %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = migrations))+
  labs(x = "Community Impact Factor", y = "Total Migrations")+
  theme_bw()

  