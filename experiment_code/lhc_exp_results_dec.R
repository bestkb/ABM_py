library(tidyverse)



#########read environmental shock results #########
unique_combos <- shock %>% select(mig_util, mig_threshold) %>% unique() %>% 
  mutate(run_number = seq(1,99))
write_csv(unique_combos, "param_combos.csv")

shock <- read_csv("/data/kelsea/ABM_exp/lhs_results_shock_Dec2020.csv") %>% 
  mutate(mig_binary = ifelse(migrations > 0, 1, 0))

shock_summary <- shock %>% group_by(hh_id, ag_fac, mig_util, mig_threshold, comm_scale) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth)) %>%
  left_join(unique_combos, by = c("mig_util", "mig_threshold"))

shock_summary_diff = shock %>%
  group_by(hh_id, ag_fac, mig_util, mig_threshold, comm_scale, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth),
            av_impact = mean(num_shocked))%>%
  left_join(unique_combos, by = c("mig_util", "mig_threshold"))



############ now need to look at different combinations ######### 
#54, 59, 89 looks really good

x = 89 # here we can specify run number
impact_summary <- shock_summary %>% 
  filter(run_number == x)

impact_summary_diff <- shock_summary_diff %>% 
  filter(run_number == x)



impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), y = av_migs, fill = as.factor(ag_fac)))+
  labs(x = "Community Impact Factor", y = "Average Migrations/ HH")+
  theme_bw()


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), y = av_wealth, fill = as.factor(ag_fac)))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()


impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  facet_wrap(~ag_fac)+ 
  theme_bw()


impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), fill = as.factor(mig_binary), y = av_impact))+
  labs(x = "Community Impact Factor", y = "Average HH Impact")+
  facet_wrap(~ag_fac)+ 
  theme_bw()



working_params <- unique_combos %>% 
  filter(run_number %in% c(3, 7, 20, 23, 36, 37, 38, 39)) 

working_params %>%
  ggplot(aes(x = mig_util_taka, y = mig_threshold_taka))+
  geom_point()+
  geom_smooth(method = 'lm')+ 
  geom_point(data = all_params, aes(x = mig_util * 50000, y = mig_threshold * 80000000), alpha = 0.5, color = "green")+
  geom_point(data = working_params, aes(x = mig_util_taka, y = mig_threshold_taka), size = 2)+
  theme_bw()+
  labs(x = "Migration Utility", y = "Migration Threshold", 
       title = "Successful Parameter Combinations")




