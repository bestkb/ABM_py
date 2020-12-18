library(tidyverse)



#########read environmental shock results #########
unique_combos <- shock %>% select(mig_util, mig_threshold) %>% unique() %>% 
  mutate(run_number = seq(1,99))
#write_csv(unique_combos, "param_combos.csv")

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

x = 99 # here we can specify run number
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


param_results <- read_csv("param_combos.csv") %>%
  mutate(working = ifelse(pattern_impact_high > 0, 1, 0))

working_params <- unique_combos %>% 
  filter(run_number %in% c(54, 59, 89)) 

param_results %>%
  ggplot(aes(x = mig_util, y = mig_threshold, color = as.factor(working)), size = 2)+
  geom_point()+
  #geom_smooth(method = 'lm')+ 
  theme_bw()+
  labs(x = "Migration Utility", y = "Migration Threshold", 
       title = "Successful Parameter Combinations")

working_vals <- param_results %>% filter(working ==1)

mean(working_vals$mig_threshold) #10,517,430
sd(working_vals$mig_threshold) #+- 7,817,592

#does not seem to be sensitive to migration utility 
