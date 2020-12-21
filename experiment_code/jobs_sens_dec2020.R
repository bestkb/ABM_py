library(tidyverse)

myfiles = list.files(path = "current_model_code/", pattern = "*.csv")

#set current_model_code as WD
all = c()
for (i in myfiles){
  jobs <- str_split(i, "_")[[1]][3]
  jobs = gsub("^[^_]*_|\\.csv", "", jobs)
  jobs = substr(jobs, )
  data = read.csv(i)
  data = as.data.frame(data)
  data = data %>% mutate(run_number = model, comm_impact_scale = comm_scale) 
  all = bind_rows(all, data)
}
