library(tidyverse)


hh_track = read_csv("track_hh.csv") %>%
  select(-1)

mc_runs = as.data.frame(rep(1:50, each = 2000, times = 1))
names(mc_runs) = "mc_run"

hh_track = hh_track %>% cbind(mc_runs) 
 
hh_track <- hh_track %>% 
 mutate(mig_binary = ifelse(migrations > 0, 1, 0))

hh_track_1 = hh_track %>%
  filter(mc_run == 1)

hh_track_1 %>% 
  ggplot()+
  geom_line(aes(x = tick, y = wealth, group= hh_id, color = as.factor(mig_binary)), alpha = 0.7)+
  theme_bw()+
  labs(x = "Tick", y = "HH Wealth")
  

hh_track_1 %>% 
  filter(hh_id == 2| hh_id == 10 | hh_id == 20)%>%
  ggplot()+
  geom_line(aes(x = tick, y = migrations, group= hh_id, color = as.factor(num_shocked)), alpha = 0.7)+
  theme_bw()+
  labs(x = "Tick", y = "Migrations")
