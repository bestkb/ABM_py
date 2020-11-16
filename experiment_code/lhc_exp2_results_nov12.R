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

####read parameters 
lhs0 = read_csv("../current_model_code/lhs_test_0.csv") %>%
  select(-1) %>% mutate(run =0)
lhs1 = read_csv("../current_model_code/lhs_test_1.csv") %>%
  select(-1) %>% mutate(run =1)
lhs2 = read_csv("../current_model_code/lhs_test_2.csv") %>%
  select(-1) %>% mutate(run =2)
lhs3 = read_csv("../current_model_code/lhs_test_3.csv") %>%
  select(-1) %>% mutate(run =3)
lhs4 = read_csv("../current_model_code/lhs_test_4.csv") %>%
  select(-1) %>% mutate(run =4)
lhs5 = read_csv("../current_model_code/lhs_test_5.csv") %>%
  select(-1) %>% mutate(run =5)
lhs6 = read_csv("../current_model_code/lhs_test_6.csv") %>%
  select(-1) %>% mutate(run =6)
lhs7 = read_csv("../current_model_code/lhs_test_7.csv") %>%
  select(-1) %>% mutate(run =7)
lhs8 = read_csv("../current_model_code/lhs_test_8.csv") %>%
  select(-1) %>% mutate(run =8)
lhs9 = read_csv("../current_model_code/lhs_test_9.csv") %>%
  select(-1) %>% mutate(run =9)
lhs10 = read_csv("../current_model_code/lhs_test_10.csv") %>%
  select(-1) %>% mutate(run =10)
lhs11 = read_csv("../current_model_code/lhs_test_11.csv") %>%
  select(-1) %>% mutate(run =11)
lhs12 = read_csv("../current_model_code/lhs_test_12.csv") %>%
  select(-1) %>% mutate(run =12)
lhs13 = read_csv("../current_model_code/lhs_test_13.csv") %>%
  select(-1) %>% mutate(run =13)
lhs14 = read_csv("../current_model_code/lhs_test_14.csv") %>%
  select(-1) %>% mutate(run =14)
lhs15 = read_csv("../current_model_code/lhs_test_15.csv") %>%
  select(-1) %>% mutate(run =15)
lhs16 = read_csv("../current_model_code/lhs_test_16.csv") %>%
  select(-1) %>% mutate(run =16)
lhs17 = read_csv("../current_model_code/lhs_test_17.csv") %>%
  select(-1) %>% mutate(run =17)
lhs18 = read_csv("../current_model_code/lhs_test_18.csv") %>%
  select(-1) %>% mutate(run =18)
lhs19 = read_csv("../current_model_code/lhs_test_19.csv") %>%
  select(-1) %>% mutate(run =19)
lhs20 = read_csv("../current_model_code/lhs_test_20.csv") %>%
  select(-1) %>% mutate(run =20)
lhs20 = read_csv("../current_model_code/lhs_test_20.csv") %>%
  select(-1) %>% mutate(run =20)
lhs21 = read_csv("../current_model_code/lhs_test_21.csv") %>%
  select(-1) %>% mutate(run =21)
lhs22 = read_csv("../current_model_code/lhs_test_22.csv") %>%
  select(-1) %>% mutate(run =22)
lhs23 = read_csv("../current_model_code/lhs_test_23.csv") %>%
  select(-1) %>% mutate(run =23)
lhs24 = read_csv("../current_model_code/lhs_test_24.csv") %>%
  select(-1) %>% mutate(run =24)
lhs25 = read_csv("../current_model_code/lhs_test_25.csv") %>%
  select(-1) %>% mutate(run =25)
lhs26 = read_csv("../current_model_code/lhs_test_26.csv") %>%
  select(-1) %>% mutate(run =26)
lhs27 = read_csv("../current_model_code/lhs_test_27.csv") %>%
  select(-1) %>% mutate(run =27)
lhs28 = read_csv("../current_model_code/lhs_test_28.csv") %>%
  select(-1) %>% mutate(run =28)
lhs29 = read_csv("../current_model_code/lhs_test_29.csv") %>%
  select(-1) %>% mutate(run =29)
lhs30 = read_csv("../current_model_code/lhs_test_30.csv") %>%
  select(-1) %>% mutate(run =30)
lhs31 = read_csv("../current_model_code/lhs_test_31.csv") %>%
  select(-1) %>% mutate(run =31)
lhs32 = read_csv("../current_model_code/lhs_test_32.csv") %>%
  select(-1) %>% mutate(run =32)
lhs33 = read_csv("../current_model_code/lhs_test_33.csv") %>%
  select(-1) %>% mutate(run =33)
lhs34 = read_csv("../current_model_code/lhs_test_34.csv") %>%
  select(-1) %>% mutate(run =34)
lhs35 = read_csv("../current_model_code/lhs_test_35.csv") %>%
  select(-1) %>% mutate(run =35)
lhs36 = read_csv("../current_model_code/lhs_test_36.csv") %>%
  select(-1) %>% mutate(run =36)
lhs37 = read_csv("../current_model_code/lhs_test_37.csv") %>%
  select(-1) %>% mutate(run =37)
lhs38 = read_csv("../current_model_code/lhs_test_38.csv") %>%
  select(-1) %>% mutate(run =38)
lhs39 = read_csv("../current_model_code/lhs_test_39.csv") %>%
  select(-1) %>% mutate(run =39)
lhs40 = read_csv("../current_model_code/lhs_test_40.csv") %>%
  select(-1) %>% mutate(run =40)
lhs41 = read_csv("../current_model_code/lhs_test_41.csv") %>%
  select(-1) %>% mutate(run =41)
lhs42 = read_csv("../current_model_code/lhs_test_42.csv") %>%
  select(-1) %>% mutate(run =42)
lhs43 = read_csv("../current_model_code/lhs_test_43.csv") %>%
  select(-1) %>% mutate(run =43)
lhs44 = read_csv("../current_model_code/lhs_test_44.csv") %>%
  select(-1) %>% mutate(run =44)
lhs45 = read_csv("../current_model_code/lhs_test_45.csv") %>%
  select(-1) %>% mutate(run =45)
lhs46 = read_csv("../current_model_code/lhs_test_46.csv") %>%
  select(-1) %>% mutate(run =46)
lhs47 = read_csv("../current_model_code/lhs_test_47.csv") %>%
  select(-1) %>% mutate(run =47)
lhs48 = read_csv("../current_model_code/lhs_test_48.csv") %>%
  select(-1) %>% mutate(run =48)


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
  bind_rows(lhs18)%>%
  bind_rows(lhs19)%>%
  bind_rows(lhs20)%>%
  bind_rows(lhs21)%>%
  bind_rows(lhs22)%>%
  bind_rows(lhs23)%>%
  bind_rows(lhs24)%>%
  bind_rows(lhs25)%>%
  bind_rows(lhs26)%>%
  bind_rows(lhs27)%>%
  bind_rows(lhs28)%>%
  bind_rows(lhs29)%>%
  bind_rows(lhs30)%>%
  bind_rows(lhs31)%>%
  bind_rows(lhs32)%>%
  bind_rows(lhs33)%>%
  bind_rows(lhs34)%>%
  bind_rows(lhs35)%>%
  bind_rows(lhs36)%>%
  bind_rows(lhs37)%>%
  bind_rows(lhs38)%>%
  bind_rows(lhs39)%>%
  bind_rows(lhs40)%>%
  bind_rows(lhs41)%>%
  bind_rows(lhs42)%>%
  bind_rows(lhs43)%>%
  bind_rows(lhs44)%>%
  bind_rows(lhs45)%>%
  bind_rows(lhs46)%>%
  bind_rows(lhs47)%>%
  bind_rows(lhs48)


lhs_comb <- lhs_comb %>%
  inner_join(params, by = "run")

#write_rds(lhs_comb, "lhs_comb2.Rds")

#############################################################################
#lhs_comb = read_rds("experiment_code/lhs_comb1.Rds")
mc_runs = as.data.frame(rep(1:50, each = 100, times = 49))
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

