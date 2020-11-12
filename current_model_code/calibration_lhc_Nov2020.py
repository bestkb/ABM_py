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
import lhsmdu

#create latin hypercube 

lhc_params = lhsmdu.sample(2, 40, randomSeed = 10) 
lhc_params = np.array(lhc_params)
pd.DataFrame(lhc_params).to_csv("lhc_params_nov2020.csv")
list = [0, 0.2, 0.4, 0.6, 0.8, 1]
#define vars
for n in range(0, 49):
    N = 700 #number of individual agents
    N_hh = 100 #number of households
    mig_threshold = lhc_params[0, n] * 80000 #migration threshold
    mig_util =  lhc_params[1, n] * 50000 #utility to migrate
    ag_factor = 10000 #land productivity factor
    wealth_factor = 50000 #initialization of wealth factor
    run_time = 20 #steps to run
    decision = "utility"
    mc_runs = 20 #number of runs in MC 

    for j in list: 
        comm_scale =  j  

        #now run through MC loop 
        data = pd.DataFrame()
        data2 = pd.DataFrame()
        for i in range(mc_runs):
            # initialize model
            model = ABM_Model(run_time, N_hh, N, decision, mig_util, mig_threshold, wealth_factor, ag_factor, comm_scale)
            #run model for ticks
            while (model.tick < model.ticks):
                model.model_step()
                model.data_collect()
                model.tick_up()
            
            last_data = model.last 
            final_migs = model.migrations.tail(1)  #data should be stored here
            data = pd.concat([data, last_data])
            data2 = pd.concat([data2, final_migs])
            print(i)
            Household.next_uid = 1
            Individual.next_uid = 1

        string_1 = "lhs_test_" + str(n) + "_" + str(j) + ".csv"
    # string_2 = "util_test_totals_" + str(n) + ".csv"
        data.to_csv(string_1)
    # data2.to_csv(string_2)


