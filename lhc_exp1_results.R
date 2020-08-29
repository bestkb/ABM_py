library(tidyverse)

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



