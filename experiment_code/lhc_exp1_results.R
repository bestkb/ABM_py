library(tidyverse)

####read parameters 
params0 = read_csv("parameters_0.csv") %>%
  select(-1) %>% mutate(run =0)
params1 = read_csv("parameters_1.csv") %>%
  select(-1) %>% mutate(run =1)
params2 = read_csv("parameters_2.csv") %>%
  select(-1) %>% mutate(run =2)
params3 = read_csv("parameters_3.csv") %>%
  select(-1) %>% mutate(run =3)
params4 = read_csv("parameters_4.csv") %>%
  select(-1) %>% mutate(run =4)
params5 = read_csv("parameters_5.csv") %>%
  select(-1) %>% mutate(run =5)
params6 = read_csv("parameters_6.csv") %>%
  select(-1) %>% mutate(run =6)
params7 = read_csv("parameters_7.csv") %>%
  select(-1) %>% mutate(run =7)
params8 = read_csv("parameters_8.csv") %>%
  select(-1) %>% mutate(run =8)
params9 = read_csv("parameters_9.csv") %>%
  select(-1) %>% mutate(run =9)
params10 = read_csv("parameters_10.csv") %>%
  select(-1) %>% mutate(run =10)
params11 = read_csv("parameters_11.csv") %>%
  select(-1) %>% mutate(run =11)
params12 = read_csv("parameters_12.csv") %>%
  select(-1) %>% mutate(run =12)
params13 = read_csv("parameters_13.csv") %>%
  select(-1) %>% mutate(run =13)
params14 = read_csv("parameters_14.csv") %>%
  select(-1) %>% mutate(run =14)
params15 = read_csv("parameters_15.csv") %>%
  select(-1) %>% mutate(run =15)
params16 = read_csv("parameters_16.csv") %>%
  select(-1) %>% mutate(run =16)
params17 = read_csv("parameters_17.csv") %>%
  select(-1) %>% mutate(run =17)
params18 = read_csv("parameters_18.csv") %>%
  select(-1) %>% mutate(run =18)

params <- params0 %>%
  bind_rows(params1)%>%
  bind_rows(params2)%>%
  bind_rows(params3)%>%
  bind_rows(params4)%>%
  bind_rows(params5)%>%
  bind_rows(params6)%>%
  bind_rows(params7)%>%
  bind_rows(params8)%>%
  bind_rows(params9)%>%
  bind_rows(params10)%>%
  bind_rows(params11)%>%
  bind_rows(params12)%>%
  bind_rows(params13)%>%
  bind_rows(params14)%>%
  bind_rows(params15)%>%
  bind_rows(params16)%>%
  bind_rows(params17)%>%
  bind_rows(params18)


####read parameters 
lhs0 = read_csv("lhs_test_0.csv") %>%
  select(-1) %>% mutate(run =0)
lhs1 = read_csv("lhs_test_1.csv") %>%
  select(-1) %>% mutate(run =1)
lhs2 = read_csv("lhs_test_2.csv") %>%
  select(-1) %>% mutate(run =2)
lhs3 = read_csv("lhs_test_3.csv") %>%
  select(-1) %>% mutate(run =3)
lhs4 = read_csv("lhs_test_4.csv") %>%
  select(-1) %>% mutate(run =4)
lhs5 = read_csv("lhs_test_5.csv") %>%
  select(-1) %>% mutate(run =5)
lhs6 = read_csv("lhs_test_6.csv") %>%
  select(-1) %>% mutate(run =6)
lhs7 = read_csv("lhs_test_7.csv") %>%
  select(-1) %>% mutate(run =7)
lhs8 = read_csv("lhs_test_8.csv") %>%
  select(-1) %>% mutate(run =8)
lhs9 = read_csv("lhs_test_9.csv") %>%
  select(-1) %>% mutate(run =9)
lhs10 = read_csv("lhs_test_10.csv") %>%
  select(-1) %>% mutate(run =10)
lhs11 = read_csv("lhs_test_11.csv") %>%
  select(-1) %>% mutate(run =11)
lhs12 = read_csv("lhs_test_12.csv") %>%
  select(-1) %>% mutate(run =12)
lhs13 = read_csv("lhs_test_13.csv") %>%
  select(-1) %>% mutate(run =13)
lhs14 = read_csv("lhs_test_14.csv") %>%
  select(-1) %>% mutate(run =14)
lhs15 = read_csv("lhs_test_15.csv") %>%
  select(-1) %>% mutate(run =15)
lhs16 = read_csv("lhs_test_16.csv") %>%
  select(-1) %>% mutate(run =16)
lhs17 = read_csv("lhs_test_17.csv") %>%
  select(-1) %>% mutate(run =17)
lhs18 = read_csv("lhs_test_18.csv") %>%
  select(-1) %>% mutate(run =18)



lhs_comb <- lhs0 %>%
  bind_rows(lhs1)%>%
  bind_rows(lhs2)%>%
  bind_rows(lhs3)%>%
  bind_rows(lhs4)%>%
  bind_rows(lhs5)%>%
  bind_rows(lhs6)%>%
  bind_rows(lhs7)%>%
  bind_rows(lhs8)%>%
  bind_rows(lhs9)%>%
  bind_rows(lhs10)%>%
  bind_rows(lhs11)%>%
  bind_rows(lhs12)%>%
  bind_rows(lhs13)%>%
  bind_rows(lhs14)%>%
  bind_rows(lhs15)%>%
  bind_rows(lhs16)%>%
  bind_rows(lhs17)%>%
  bind_rows(lhs18)


lhs_comb <- lhs_comb %>%
  inner_join(params, by = "run")

#write_rds(lhs_comb, "lhs_comb1.Rds")

#############################################################################
lhs_comb = read_rds("experiment_code/lhs_comb1.Rds")
mc_runs = as.data.frame(rep(1:50, each = 100, times = 19))
names(mc_runs) = "mc_run"

lhs_joined = lhs_comb %>% cbind(mc_runs)

lhs_joined = lhs_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

lhs_summary = lhs_joined %>%
  group_by(run, comm_impact, mig_threshold, mig_util) %>%
  summarise(av_migs = mean(migrations),
            sd_migs = sd(migrations),
            av_wealth = mean(wealth),
            sd_wealth = sd(wealth))

lhs_summary_diff = lhs_joined %>%
  group_by(run, comm_impact, mig_threshold, mig_util, mig_binary) %>%
  summarise(av_wealth = mean(wealth),
            sd_wealth = sd(wealth), av_shock = mean(num_shocked))


library(wesanderson)
pal <- wes_palette("Zissou1", 100, type = "continuous")

lhs_summary %>% 
  ggplot()+
  geom_point(aes(x= as.factor(comm_impact), y = mig_threshold, color = av_migs), size = 5, alpha = 0.7)+
  scale_color_gradientn(colours = pal) + 
  labs(x = "Community Impact", y = "Migration Threshold")+
  theme_bw()

lhs_summary %>% 
  ggplot()+
  geom_point(aes(x= as.factor(comm_impact), y = mig_util, color = av_migs), size = 5, alpha = 0.7)+
  scale_color_gradientn(colours = pal) + 
  labs(x = "Community Impact", y = "Migration Utility")+
  theme_bw()

lhs_summary %>% 
  ggplot()+
  geom_point(aes(x= as.factor(comm_impact), y = mig_threshold, color = av_wealth), size = 5, alpha = 0.7)+
  scale_color_gradientn(colours = pal) + 
  labs(x = "Community Impact", y = "Migration Threshold")+
  theme_bw()

lhs_summary %>% 
  ggplot()+
  geom_point(aes(x= as.factor(comm_impact), y = mig_util, color = av_wealth), size = 5, alpha = 0.7)+
  scale_color_gradientn(colours = pal) + 
  labs(x = "Community Impact", y = "Migration Utility")+
  theme_bw()


lhs_summary_diff %>% 
  ggplot()+
  geom_point(aes(x= as.factor(comm_impact), color = as.factor(mig_binary), y = av_shock), size = 2)+
  labs(x = "Community Scale", y = "Average Env Shocks")+
  theme_bw()

lhs_summary_diff %>% 
  ggplot()+
  geom_point(aes(x= mig_threshold, color = as.factor(mig_binary), y = av_wealth), size = 5)+
  labs(x = "Migration Threshold", y = "Wealth")+
  theme_bw()



######## 3D visualization ##########

library(plot3D)

scatter3D(lhs_summary$comm_impact, lhs_summary$mig_threshold, lhs_summary$mig_util, 
          colvar = lhs_summary$av_migs, 
          phi = 0, bty = "g",
          pch = 20, cex = 2, xlab = "Comm_impact",
          ylab ="Mig_thresh", zlab = "Mig_util",
          ticktype = "detailed")


########################## small multiples #######################

lhs_summary %>% 
  filter(run %in% c(2, 4, 6, 8, 10, 12, 14, 15)) %>%
  ggplot()+
  geom_point(aes(x= comm_impact, y = av_migs))+
  facet_grid(vars(mig_util))+
  theme_bw()

