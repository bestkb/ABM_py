#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This runs the ABM of environmental migration

@author: kelseabest
"""

#import packages
from ABM_model_steps import *

from matplotlib.colors import LinearSegmentedColormap
import pandas as pd
import random
import math
import numpy as np
import matplotlib.pyplot as plt

#define vars
comm_list = [0, 0.05, 0.1, 0.15, 0.02, 0.25, 0.4]
num_jobs = [10, 50, 100, 200, 300]

N = 700 #number of individual agents
N_hh = 100 #number of households
mig_threshold = 1000000 #migration threshold
mig_util = 10000 #utility to migrate
ag_factor = 10000 #land productivity factor
wealth_factor = 50000 #initialization of wealth factor
run_time = 20 #steps to run
decision = "utility"
mc_runs = 20 #number of runs in MC 
environmental_method = "shock"

data2 = pd.DataFrame()

for j in comm_list: 
    comm_scale =  j  
    for x in num_jobs:
        jobs_avail = x 

        #now run through MC loop 
        data = pd.DataFrame()
        data2 = pd.DataFrame()
        for i in range(mc_runs):
            # initialize model
            model = ABM_Model(run_time, N_hh, N, decision, mig_util, mig_threshold, wealth_factor, ag_factor, comm_scale, environmental_method, jobs_avail)
            #run model for ticks
            while (model.tick < model.ticks):
                model.model_step()
                model.data_collect()
                model.tick_up()
                
            last_data = model.last 
            
            data = pd.concat([data, last_data])
            Household.next_uid = 1
            Individual.next_uid = 1
        
        string_1 = "sens_numjobs_" + str(j) + "_" + str(x) +  ".csv"

        data.to_csv(string_1)
