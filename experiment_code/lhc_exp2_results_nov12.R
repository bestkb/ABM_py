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

#write_rds(lhs_comb, "lhs_comb_nov.Rds")

#############################################################################
#lhs_comb = read_rds("experiment_code/lhs_comb1.Rds")


mc_runs = as.data.frame(rep(1:20, each = 100, times = 240))
names(mc_runs) = "mc_run"

lhs_joined = lhs_comb %>% cbind(mc_runs)


lhs_joined = lhs_joined %>% mutate(mig_binary = ifelse(migrations > 0, 1, 0))

###### now we have data by each combo (run_number) ############


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

