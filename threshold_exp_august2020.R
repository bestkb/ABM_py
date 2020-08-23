library(tidyverse)

#list = [500, 1000, 1500, 2000, 2500, 3000, 5000]

threshold_one = read_csv("threshold_test_500.csv") %>% 
  mutate(comm_threshold = 500) %>% select(-1)

threshold_two = read_csv("threshold_test_1000.csv") %>% 
  mutate(comm_threshold = 1000) %>% select(-1)

threshold_three = read_csv("threshold_test_1500.csv") %>% 
  mutate(comm_threshold = 1500) %>% select(-1)

threshold_four = read_csv("threshold_test_2000.csv") %>% 
  mutate(comm_threshold = 2000) %>% select(-1)

threshold_five = read_csv("threshold_test_2500.csv") %>% 
  mutate(comm_threshold = 2500) %>% select(-1)

threshold_six = read_csv("threshold_test_3000.csv") %>% 
  mutate(comm_threshold = 3000) %>% select(-1)

threshold_seven = read_csv("threshold_test_5000.csv") %>% 
  mutate(comm_threshold = 5000) %>% select(-1)


threshold_joined = threshold_one %>%
  bind_rows(threshold_two) %>%
  bind_rows(threshold_three) %>%
  bind_rows(threshold_four) %>%
  bind_rows(threshold_five) %>%
  bind_rows(threshold_six)%>%
  bind_rows(threshold_seven) 
  


####### add integer for MC run #######
mc_runs = as.data.frame(rep(1:100, each = 50, times = 7))
names(mc_runs) = "run"

threshold_joined = threshold_joined %>% cbind(mc_runs)

threshold_joined = threshold_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

threshold_summary = threshold_joined %>%
  group_by(comm_threshold, run) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

threshold_summary_diff = threshold_joined %>%
  group_by(comm_threshold, run, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth), av_shock = mean(num_shocked))


threshold_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_threshold), y = av_migs))+
  labs(x = "Community threshold Factor", y = "Average Migrations/ HH")+
  theme_bw()


threshold_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_threshold), y = av_wealth))+
  labs(x = "Community threshold Factor", y = "Average HH Wealth")+
  theme_bw()

threshold_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_threshold), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community threshold Factor", y = "Average HH Wealth")+
  theme_bw()

threshold_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_threshold), fill = as.factor(mig_binary), y = av_shock))+
  labs(x = "Community threshold Factor", y = "Average Env Shocks")+
  theme_bw()




################################### migration util #############################

library(tidyverse)

#list = [500, 1000, 1500, 2000, 2500, 3000, 5000]

util_one = read_csv("util_test_100.csv") %>% 
  mutate(comm_util = 100) %>% select(-1)

util_two = read_csv("util_test_200.csv") %>% 
  mutate(comm_util = 200) %>% select(-1)

util_three = read_csv("util_test_300.csv") %>% 
  mutate(comm_util = 300) %>% select(-1)

util_four = read_csv("util_test_400.csv") %>% 
  mutate(comm_util = 400) %>% select(-1)

util_five = read_csv("util_test_500.csv") %>% 
  mutate(comm_util = 500) %>% select(-1)

util_six = read_csv("util_test_1000.csv") %>% 
  mutate(comm_util = 1000) %>% select(-1)


util_joined = util_one %>%
  bind_rows(util_two) %>%
  bind_rows(util_three) %>%
  bind_rows(util_four) %>%
  bind_rows(util_five) %>%
  bind_rows(util_six)



####### add integer for MC run #######
mc_runs = as.data.frame(rep(1:100, each = 50, times = 6))
names(mc_runs) = "run"

util_joined = util_joined %>% cbind(mc_runs)

util_joined = util_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

util_summary = util_joined %>%
  group_by(comm_util, run) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

util_summary_diff = util_joined %>%
  group_by(comm_util, run, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth), av_shock = mean(num_shocked))


util_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_util), y = av_migs))+
  labs(x = "Migration util Factor", y = "Average Migrations/ HH")+
  theme_bw()


util_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_util), y = av_wealth))+
  labs(x = "Migration util Factor", y = "Average HH Wealth")+
  theme_bw()

util_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_util), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Migration util Factor", y = "Average HH Wealth")+
  theme_bw()

util_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_util), fill = as.factor(mig_binary), y = av_shock))+
  labs(x = "Community util Factor", y = "Average Env Shocks")+
  theme_bw()

