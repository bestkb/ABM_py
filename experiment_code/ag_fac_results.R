library(tidyverse)

#list = [20, 40, 60, 80, 100, 200]

ag_factor_one = read_csv("data/ag_factor_test_20.csv") %>% 
  mutate(comm_ag_factor = 20) %>% select(-1)

ag_factor_two = read_csv("data/ag_factor_test_40.csv") %>% 
  mutate(comm_ag_factor = 40) %>% select(-1)

ag_factor_three = read_csv("data/ag_factor_test_60.csv") %>% 
  mutate(comm_ag_factor = 60) %>% select(-1)

ag_factor_four = read_csv("data/ag_factor_test_80.csv") %>% 
  mutate(comm_ag_factor = 80) %>% select(-1)

ag_factor_five = read_csv("data/ag_factor_test_100.csv") %>% 
  mutate(comm_ag_factor = 100) %>% select(-1)

ag_factor_six = read_csv("data/ag_factor_test_200.csv") %>% 
  mutate(comm_ag_factor = 200) %>% select(-1)


ag_factor_joined = ag_factor_one %>%
  bind_rows(ag_factor_two) %>%
  bind_rows(ag_factor_three) %>%
  bind_rows(ag_factor_four) %>%
  bind_rows(ag_factor_five) %>%
  bind_rows(ag_factor_six)



####### add integer for MC run #######
mc_runs = as.data.frame(rep(1:50, each = 100, times = 6))
names(mc_runs) = "run"

ag_factor_joined = ag_factor_joined %>% cbind(mc_runs)

ag_factor_joined = ag_factor_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

ag_factor_summary = ag_factor_joined %>%
  group_by(comm_ag_factor, run) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

ag_factor_summary_diff = ag_factor_joined %>%
  group_by(comm_ag_factor, run, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth), av_shock = mean(num_shocked))


ag_factor_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_ag_factor), y = av_migs))+
  labs(x = "Community Ag Factor", y = "Average Migrations/ HH")+
  theme_bw()


ag_factor_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_ag_factor), y = av_wealth))+
  labs(x = "Community ag_factor Factor", y = "Average HH Wealth")+
  theme_bw()

ag_factor_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_ag_factor), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community ag_factor Factor", y = "Average HH Wealth")+
  theme_bw()

ag_factor_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_ag_factor), fill = as.factor(mig_binary), y = av_shock))+
  labs(x = "Community ag_factor Factor", y = "Average Env Shocks")+
  theme_bw()


