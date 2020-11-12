library(tidyverse)

####read parameters 
params0 = read_csv("../current_model_code/parameters_0.csv") %>%
  select(-1) %>% mutate(run =0)
params1 = read_csv("../current_model_code/parameters_1.csv") %>%
  select(-1) %>% mutate(run =1)
params2 = read_csv("../current_model_code/parameters_2.csv") %>%
  select(-1) %>% mutate(run =2)
params3 = read_csv("../current_model_code/parameters_3.csv") %>%
  select(-1) %>% mutate(run =3)
params4 = read_csv("../current_model_code/parameters_4.csv") %>%
  select(-1) %>% mutate(run =4)
params5 = read_csv("../current_model_code/parameters_5.csv") %>%
  select(-1) %>% mutate(run =5)
params6 = read_csv("../current_model_code/parameters_6.csv") %>%
  select(-1) %>% mutate(run =6)
params7 = read_csv("../current_model_code/parameters_7.csv") %>%
  select(-1) %>% mutate(run =7)
params8 = read_csv("../current_model_code/parameters_8.csv") %>%
  select(-1) %>% mutate(run =8)
params9 = read_csv("../current_model_code/parameters_9.csv") %>%
  select(-1) %>% mutate(run =9)
params10 = read_csv("../current_model_code/parameters_10.csv") %>%
  select(-1) %>% mutate(run =10)
params11 = read_csv("../current_model_code/parameters_11.csv") %>%
  select(-1) %>% mutate(run =11)
params12 = read_csv("../current_model_code/parameters_12.csv") %>%
  select(-1) %>% mutate(run =12)
params13 = read_csv("../current_model_code/parameters_13.csv") %>%
  select(-1) %>% mutate(run =13)
params14 = read_csv("../current_model_code/parameters_14.csv") %>%
  select(-1) %>% mutate(run =14)
params15 = read_csv("../current_model_code/parameters_15.csv") %>%
  select(-1) %>% mutate(run =15)
params16 = read_csv("../current_model_code/parameters_16.csv") %>%
  select(-1) %>% mutate(run =16)
params17 = read_csv("../current_model_code/parameters_17.csv") %>%
  select(-1) %>% mutate(run =17)
params18 = read_csv("../current_model_code/parameters_18.csv") %>%
  select(-1) %>% mutate(run =18)
params19 = read_csv("../current_model_code/parameters_19.csv") %>%
  select(-1) %>% mutate(run =19)
params20 = read_csv("../current_model_code/parameters_20.csv") %>%
  select(-1) %>% mutate(run =20)
params21 = read_csv("../current_model_code/parameters_21.csv") %>%
  select(-1) %>% mutate(run =21)
params22 = read_csv("../current_model_code/parameters_22.csv") %>%
  select(-1) %>% mutate(run =22)
params23 = read_csv("../current_model_code/parameters_23.csv") %>%
  select(-1) %>% mutate(run =23)
params24 = read_csv("../current_model_code/parameters_24.csv") %>%
  select(-1) %>% mutate(run =24)
params25 = read_csv("../current_model_code/parameters_25.csv") %>%
  select(-1) %>% mutate(run =25)
params26 = read_csv("../current_model_code/parameters_26.csv") %>%
  select(-1) %>% mutate(run =26)
params27 = read_csv("../current_model_code/parameters_27.csv") %>%
  select(-1) %>% mutate(run =27)
params28 = read_csv("../current_model_code/parameters_28.csv") %>%
  select(-1) %>% mutate(run =28)
params29 = read_csv("../current_model_code/parameters_29.csv") %>%
  select(-1) %>% mutate(run =29)
params30 = read_csv("../current_model_code/parameters_30.csv") %>%
  select(-1) %>% mutate(run =30)
params31 = read_csv("../current_model_code/parameters_31.csv") %>%
  select(-1) %>% mutate(run =31)
params32 = read_csv("../current_model_code/parameters_32.csv") %>%
  select(-1) %>% mutate(run =32)
params33 = read_csv("../current_model_code/parameters_33.csv") %>%
  select(-1) %>% mutate(run =33)
params34 = read_csv("../current_model_code/parameters_34.csv") %>%
  select(-1) %>% mutate(run =34)
params35 = read_csv("../current_model_code/parameters_35.csv") %>%
  select(-1) %>% mutate(run =35)
params36 = read_csv("../current_model_code/parameters_36.csv") %>%
  select(-1) %>% mutate(run =36)
params37 = read_csv("../current_model_code/parameters_37.csv") %>%
  select(-1) %>% mutate(run =37)
params38 = read_csv("../current_model_code/parameters_38.csv") %>%
  select(-1) %>% mutate(run =38)
params39 = read_csv("../current_model_code/parameters_39.csv") %>%
  select(-1) %>% mutate(run =39)
params40 = read_csv("../current_model_code/parameters_40.csv") %>%
  select(-1) %>% mutate(run =40)
params41 = read_csv("../current_model_code/parameters_41.csv") %>%
  select(-1) %>% mutate(run =41)
params42 = read_csv("../current_model_code/parameters_42.csv") %>%
  select(-1) %>% mutate(run =42)
params43 = read_csv("../current_model_code/parameters_43.csv") %>%
  select(-1) %>% mutate(run =43)
params44 = read_csv("../current_model_code/parameters_44.csv") %>%
  select(-1) %>% mutate(run =44)
params45 = read_csv("../current_model_code/parameters_45.csv") %>%
  select(-1) %>% mutate(run =45)
params46 = read_csv("../current_model_code/parameters_46.csv") %>%
  select(-1) %>% mutate(run =46)
params47 = read_csv("../current_model_code/parameters_47.csv") %>%
  select(-1) %>% mutate(run =47)
params48 = read_csv("../current_model_code/parameters_48.csv") %>%
  select(-1) %>% mutate(run =48)

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
  bind_rows(params18)%>%
  bind_rows(params19)%>%
  bind_rows(params20)%>%
  bind_rows(params21)%>%
  bind_rows(params22)%>%
  bind_rows(params23)%>%
  bind_rows(params24)%>%
  bind_rows(params25)%>%
  bind_rows(params26)%>%
  bind_rows(params27)%>%
  bind_rows(params28)%>%
  bind_rows(params29)%>%
  bind_rows(params30)%>%
  bind_rows(params31)%>%
  bind_rows(params32)%>%
  bind_rows(params33)%>%
  bind_rows(params34)%>%
  bind_rows(params35)%>%
  bind_rows(params36)%>%
  bind_rows(params37)%>%
  bind_rows(params38)%>%
  bind_rows(params39)%>%
  bind_rows(params40)%>%
  bind_rows(params41)%>%
  bind_rows(params42)%>%
  bind_rows(params43)%>%
  bind_rows(params44)%>%
  bind_rows(params45)%>%
  bind_rows(params46)%>%
  bind_rows(params47)%>%
  bind_rows(params48) 


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

