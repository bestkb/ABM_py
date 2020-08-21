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
N = 700 #number of individual agents
N_hh = 100 #number of households
mig_threshold = 1000 #migration threshold
mig_util = 400 #utility to migrate
ag_factor = 100 #land productivity factor
wealth_factor = 3000 #initialization of wealth factor
run_time = 20 #steps to run
decision = "utility"
comm_scale = 0.8
mc_runs = 50 #number of runs in MC 

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

data.to_csv("comm_impact_test08_100hh_auction2.csv")
data2.to_csv("comm_impact_test08_100hh_auction_totals2.csv")
