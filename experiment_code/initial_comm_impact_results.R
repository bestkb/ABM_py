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
  
  
  
  ############### 100 households ###################

impact_zero = read_csv("comm_impact_test00_100hh.csv") %>% 
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


impact_joined = impact_zero %>%
  bind_rows(impact_two) %>%
  bind_rows(impact_four) %>%
  bind_rows(impact_six) %>%
  bind_rows(impact_eight) %>%
  bind_rows(impact_one)


####### add integer for MC run #######
top = as.data.frame(rep(1:100, each = 100))
names(top) = "run"
mc_runs = as.data.frame(rep(1:100, each = 50, times = 5))
names(mc_runs) = "run"
mc_runs_all = bind_rows(top, mc_runs)

impact_joined = impact_joined %>% cbind(mc_runs_all)

impact_joined = impact_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

impact_summary = impact_joined %>%
  group_by(comm_impact, run) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

impact_summary_diff = impact_joined %>%
  group_by(comm_impact, run, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth))


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = av_migs))+
  labs(x = "Community Impact Factor", y = "Average Migrations/ HH")+
  theme_bw()


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()

impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()

#### sum across MC runs #### look at wealth #####

impact_zero_totals = read_csv("comm_impact_test00_100hh_totals.csv") %>% 
  mutate(comm_impact = 0) %>% select(-1)

impact_two_totals = read_csv("comm_impact_test02_100hh_totals.csv") %>% 
  mutate(comm_impact = 0.2) %>% select(-1)

impact_four_totals = read_csv("comm_impact_test04_100hh_totals.csv") %>% 
  mutate(comm_impact = 0.4) %>% select(-1)

impact_six_totals = read_csv("comm_impact_test06_100hh_totals.csv") %>% 
  mutate(comm_impact = 0.6) %>% select(-1)

impact_eight_totals = read_csv("comm_impact_test08_100hh_totals.csv") %>% 
  mutate(comm_impact = 0.8) %>% select(-1)

impact_one_totals = read_csv("comm_impact_test10_100hh_totals.csv") %>% 
  mutate(comm_impact = 1.0) %>% select(-1)


impact_joined_total = impact_zero_totals %>%
  bind_rows(impact_two_totals) %>%
  bind_rows(impact_four_totals) %>%
  bind_rows(impact_six_totals) %>%
  bind_rows(impact_eight_totals) %>%
  bind_rows(impact_one_totals)


impact_summary_totals = impact_joined_total %>%
  group_by(comm_impact) %>%
  summarise(av_migs = mean(total_mig),
            sd_migs = sd(total_mig))


impact_joined_total %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = total_mig))+
  labs(x = "Community Impact Factor", y = "Total Migrations")+
  theme_bw()



############### 100 households w/ auction ###################

impact_zero = read_csv("comm_impact_test00_100hh_auction2.csv") %>% 
  mutate(comm_impact = 0) %>% select(-1)

impact_two = read_csv("comm_impact_test02_100hh_auction2.csv") %>% 
  mutate(comm_impact = 0.2) %>% select(-1)

impact_four = read_csv("comm_impact_test04_100hh_auction2.csv") %>% 
  mutate(comm_impact = 0.4) %>% select(-1)

impact_six = read_csv("comm_impact_test06_100hh_auction2.csv") %>% 
  mutate(comm_impact = 0.6) %>% select(-1)

impact_eight = read_csv("comm_impact_test08_100hh_auction2.csv") %>% 
  mutate(comm_impact = 0.8) %>% select(-1)

impact_one = read_csv("comm_impact_test10_100hh_auction2.csv") %>% 
  mutate(comm_impact = 1.0) %>% select(-1)


impact_joined = impact_zero %>%
  bind_rows(impact_two) %>%
  bind_rows(impact_four) %>%
  bind_rows(impact_six) %>%
  bind_rows(impact_eight) %>%
  bind_rows(impact_one)


####### add integer for MC run #######
mc_runs = as.data.frame(rep(1:100, each = 50, times = 6))
names(mc_runs) = "run"

impact_joined = impact_joined %>% cbind(mc_runs)

impact_joined = impact_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

impact_summary = impact_joined %>%
  group_by(comm_impact, run) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

impact_summary_diff = impact_joined %>%
  group_by(comm_impact, run, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth), av_shock = mean(num_shocked))


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = av_migs))+
  labs(x = "Community Impact Factor", y = "Average Migrations/ HH")+
  theme_bw()


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()

impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()

impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), fill = as.factor(mig_binary), y = av_shock))+
  labs(x = "Community Impact Factor", y = "Average Env Shocks")+
  theme_bw()

#### sum across MC runs #### look at wealth #####

impact_zero_totals = read_csv("comm_impact_test00_100hh_auction_totals.csv") %>% 
  mutate(comm_impact = 0) %>% select(-1)

impact_two_totals = read_csv("comm_impact_test02_100hh_auction_totals.csv") %>% 
  mutate(comm_impact = 0.2) %>% select(-1)

impact_four_totals = read_csv("comm_impact_test04_100hh_auction_totals.csv") %>% 
  mutate(comm_impact = 0.4) %>% select(-1)

impact_six_totals = read_csv("comm_impact_test06_100hh_auction_totals.csv") %>% 
  mutate(comm_impact = 0.6) %>% select(-1)

impact_eight_totals = read_csv("comm_impact_test08_100hh_auction_totals.csv") %>% 
  mutate(comm_impact = 0.8) %>% select(-1)

impact_one_totals = read_csv("comm_impact_test10_100hh_auction_totals.csv") %>% 
  mutate(comm_impact = 1.0) %>% select(-1)


impact_joined_total = impact_zero_totals %>%
  bind_rows(impact_two_totals) %>%
  bind_rows(impact_four_totals) %>%
  bind_rows(impact_six_totals) %>%
  bind_rows(impact_eight_totals) %>%
  bind_rows(impact_one_totals)


impact_summary_totals = impact_joined_total %>%
  group_by(comm_impact) %>%
  summarise(av_migs = mean(total_mig),
            sd_migs = sd(total_mig))


impact_joined_total %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact), y = total_mig))+
  labs(x = "Community Impact Factor", y = "Total Migrations")+
  theme_bw()



  