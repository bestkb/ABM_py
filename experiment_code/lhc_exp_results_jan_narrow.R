library(tidyverse)



#########read environmental shock results #########

shock <- read_csv("/data/kelsea/ABM_exp/lhs_results_jan_higherwealth.csv") %>% 
  mutate(mig_binary = ifelse(migrations > 0, 1, 0))


unique_combos <- shock %>% select(mig_util, mig_threshold) %>% unique() %>% 
  mutate(run_number = seq(1,99))
#write_csv(unique_combos, "param_combos_narrow.csv")


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
#### make this automated ######
pattern_df = c()
for (i in 1:99){
  impact_summary <- shock_summary %>% 
    filter(run_number == i)
  
  impact_summary_diff <- shock_summary_diff %>% 
    filter(run_number == i)
  
  zero_imp <- impact_summary %>% filter(comm_scale == 0)
  low_imp <- impact_summary %>% filter(comm_scale == 0.1)
  high_imp <- impact_summary %>% filter(comm_scale == 0.6)
  
  if (mean(zero_imp$av_migs) > mean(low_imp$av_migs) &
      mean(zero_imp$av_migs) < mean(high_imp$av_migs)) {
    comm_pattern = 1} else {
    comm_pattern = 0 }
  
  mig <- impact_summary_diff %>% filter(mig_binary == 1)
  nonmig <- impact_summary_diff %>% filter(mig_binary == 0)
  
  if (mean(nonmig$av_impact) <= mean(mig$av_impact)){
    impact_pattern = 1} else {
    impact_pattern = 0 }
  
  row_pattern = c(i, comm_pattern, impact_pattern)
  names(row_pattern) = c("run_number", "comm_pattern", "impact_pattern")
  
  pattern_df = bind_rows(pattern_df, row_pattern)
  
}


patterns_with_vars <- pattern_df %>% inner_join(unique_combos, by = "run_number") %>%
  mutate(success = ifelse(comm_pattern == 1 & impact_pattern == 1, 1, 0))


patterns_with_vars %>% 
  ggplot(aes(x = mig_util, y = mig_threshold, color = as.factor(success)))+
  geom_point(size = 2)+
  theme_bw()


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), y = av_migs))+
  labs(x = "Community Impact Factor", y = "Average Migrations/ HH")+
  theme_bw()


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()


impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()


impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), fill = as.factor(mig_binary), y = av_impact))+
  labs(x = "Community Impact Factor", y = "Average HH Impact")+
  theme_bw()


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







