library(tidyverse)


hh_track = read_csv("current_model_code/track_hh_wtp.csv") %>%
  select(-1)

mc_runs = as.data.frame(rep(1:50, each = 2000, times = 1))
names(mc_runs) = "mc_run"

hh_track = hh_track %>% cbind(mc_runs) 
 
hh_mig <- hh_track %>% 
  filter(tick == 19) %>%
 mutate(mig_binary = ifelse(migrations > 0, 1, 0)) %>%
  select(hh_id, mig_binary, mc_run, num_shocked)

hh_track <- hh_track %>% select(-num_shocked) %>%
  inner_join(hh_mig, by = c("hh_id", "mc_run"))

hh_means <- hh_track %>% group_by(mig_binary, tick) %>%
  summarise(mean_mig = mean(migrations), sd_mig = sd(migrations),
            mean_wealth = mean(wealth), sd_wealth = sd(wealth),
            mean_wtp = mean(wtp), mean_wta = mean(wta))

hh_means2 <- hh_track %>% group_by(tick) %>%
  summarise(mean_wtp = mean(wtp), mean_wta = mean(wta))

hh_means %>% 
  ggplot()+
  geom_line(aes(x = tick, y = mean_wealth, group = mig_binary,    
                color = as.factor(mig_binary)), size = 1.4)+
  geom_line(aes(x = tick, y = mean_wealth + sd_wealth, group = mig_binary,    
                color = as.factor(mig_binary)), linetype = "dashed")+
  geom_line(aes(x = tick, y = mean_wealth - sd_wealth, group = mig_binary,    
                color = as.factor(mig_binary)), linetype = "dashed")+
  theme_bw()+
  labs(x = "Tick", y = "HH Wealth")

hh_track %>% 
  ggplot()+
  geom_line(aes(x = tick, y = wta, group = hh_id), color = "green")+
  geom_line(aes(x = tick, y = wtp, group = hh_id), color = "blue", size = 1.4)+
  theme_bw()+
  labs(x = "Tick", y = "WTP/ WTA")


hh_shocks <- hh_track %>% group_by(mig_binary, mc_run) %>%
  summarise(mean_shocks = mean(num_shocked), sd_shocks = sd(num_shocked))
  


