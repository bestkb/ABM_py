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
from joblib import Parallel, delayed

#create latin hypercube 

lhc_params = lhsmdu.sample(2, 100, randomSeed = 10) 
lhc_params = np.array(lhc_params)
pd.DataFrame(lhc_params).to_csv("lhc_params_nov2020.csv")
comm_list = [0, 0.05, 0.1, 0.2, 0.4, 0.6, 0.8, 1]
ag_fact = [1000, 5000, 10000]
mc_runs = 10 #number of runs in MC 


mods = []
for n in range(0, 99):
    N = 700 #number of individual agents
    N_hh = 100 #number of households
    mig_threshold = lhc_params[0, n] * 70707569 #migration threshold
    mig_util =  lhc_params[1, n] * 30000 #utility to migrate
    wealth_factor = 50000 #initialization of wealth factor
    run_time = 20 #steps to run
    decision = "utility" #will also try "push_threshold" here
    env_shock = "slow_onset"
    for j in comm_list: 
        comm_scale =  j  
        for ag in ag_fact:
            ag_factor = ag #land productivity factor
            for run in range(0, mc_runs):
                mod = ABM_Model(run_time, N_hh, N, decision, mig_util, mig_threshold, wealth_factor, ag_factor, comm_scale, env_shock)
                mods.append(mod)
                Household.next_uid = 1
                Individual.next_uid = 1


def parallel_parser(model):
    while (model.tick < model.ticks):
        model.model_step()
        model.data_collect()
        model.tick_up()
    last_data = model.last
    return last_data

results = Parallel(n_jobs=50)(delayed(parallel_parser)(mod) for mod in mods)

df = pd.DataFrame()
df = pd.concat(results)
    
df.to_csv("lhs_results_slow_Dec2020.csv")