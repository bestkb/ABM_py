library(tidyverse)

myfiles = list.files(path = ".", pattern = "sens_numjobs_push_*")

#set current_model_code as WD
all = c()
for (i in myfiles){
  jobs <- str_split(i, "_")[[1]][5] #4 for not push, 5 for push
  jobs = gsub("^[^_]*_|\\.csv", "", jobs)
  jobs = as.numeric(jobs)
  data = read.csv(i)
  data = as.data.frame(data)
  data = data %>% mutate(num_jobs = jobs) 
  all = bind_rows(all, data)
}

all <- all %>% 
  mutate(mig_binary = ifelse(migrations > 0, 1, 0))

summary <- all %>% group_by(hh_id, mig_util, mig_threshold, comm_scale, num_jobs) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth)) 

summary_diff = all %>%
  group_by(hh_id, mig_util, mig_threshold, comm_scale, mig_binary, num_jobs) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth),
            av_impact = mean(num_shocked))



summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), y = av_migs))+
  labs(x = "Community Impact Factor", y = "Average Migrations/ HH")+
  facet_wrap(~num_jobs)+ 
  theme_bw()


summary %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), y = av_wealth, fill = as.factor(num_jobs)))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  theme_bw()


summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), fill = as.factor(mig_binary), y = av_wealth))+
  labs(x = "Community Impact Factor", y = "Average HH Wealth")+
  facet_wrap(~num_jobs)+ 
  theme_bw()


summary_diff %>% 
  ggplot()+
  geom_boxplot(aes(x= as.factor(comm_scale), fill = as.factor(mig_binary), y = av_impact))+
  labs(x = "Community Impact Factor", y = "Average HH Impact")+
  facet_wrap(~num_jobs)+ 
  theme_bw()

