library(tidyverse)

####read parameters 
parameters <- read_csv("lhc_params_nov2020.csv") %>%
  pivot_longer(c(2:41))
mig_util = parameters %>% filter(X1 == 0) 
mig_threshold = parameters %>% filter(X1 == 1)

all_params <- cbind(mig_util, mig_threshold) 
names(all_params) = c("X1", "model_run", "mig_util", "X2", "name", "mig_threshold")

all_params <- all_params %>%
  select(-c("X1", "X2", "name"))

####read test results
myfiles = list.files(path = ".", pattern = "*.csv")
myfiles = myfiles[-1]

all = c()
for (i in myfiles){
  model = str_split(i, "_")[[1]][3]
  comm_impact <- str_split(i, "_")[[1]][4]
  comm_scale = gsub("^[^_]*_|\\.csv", "", comm_impact)
  data = read.csv(i)
  data = as.data.frame(data)
  data = data %>% mutate(run_number = model, comm_impact_scale = comm_scale) 
  all = bind_rows(all, data)
}

all$run_number = as.numeric(all$run_number)
all$comm_impact_scale = as.numeric(all$comm_impact_scale)
all_params$model_run = as.numeric(all_params$model_run)

lhs_comb <- all %>%
  inner_join(all_params, by = c("run_number" = "model_run"))

#write_rds(lhs_comb, "lhs_comb_nov2.Rds")

#############################################################################
#lhs_comb = read_rds("experiment_code/lhs_comb1.Rds")


mc_runs = as.data.frame(rep(1:20, each = 100, times = 240))
names(mc_runs) = "mc_run"

lhs_joined = lhs_comb %>% cbind(mc_runs)


lhs_joined = lhs_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

###### now we have data by each combo (run_number) ############

x = 39 # here we can specify run number
look = lhs_joined %>% filter(run_number == x)

impact_summary = look %>%
  group_by(comm_impact_scale, mc_run) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

impact_summary_diff = look %>%
  group_by(comm_impact_scale, mc_run, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth),
            av_impact = mean(num_shocked))


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact_scale), y = av_migs))+
  labs(x = "Community Impact Factor", y = "Average Migrations/ HH")+
  theme_bw()


impact_summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact_scale), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()

impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact_scale), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()


impact_summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_impact_scale), fill = as.factor(mig_binary), y = av_impact))+
  labs(x = "Community Impact Factor", y = "Average HH Impact")+
  theme_bw()


head(all_params)

working_params <- all_params %>% 
  filter(model_run %in% c(3, 7, 13, 14, 20, 23, 36, 37, 38, 39)) %>% 
  mutate(mig_util_taka = mig_util * 50000, 
         mig_threshold_taka = mig_threshold * 80000000)

working_params %>%
  ggplot(aes(x = mig_util_taka, y = mig_threshold_taka))+
  geom_point()+
  geom_smooth(method = 'lm')+ 
  geom_point(data = all_params, aes(x = mig_util * 50000, y = mig_threshold * 80000000), alpha = 0.5, color = "green")+
  geom_point(data = working_params, aes(x = mig_util_taka, y = mig_threshold_taka), size = 2)+
  theme_bw()+
  labs(x = "Migration Utility", y = "Migration Threshold", 
       title = "Successful Parameter Combinations")



