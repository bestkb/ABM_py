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

list = [0, 0.2, 0.4, 0.6, 0.8, 1]
#define vars
for scale in list:
    N = 700 #number of individual agents
    N_hh = 100 #number of households
    mig_threshold = 40000 #migration threshold (not “asset poor”) 
    mig_util =  30000 #utility to migrate
    ag_factor = 10000 #land productivity factor
    wealth_factor = 50000 #initialization of wealth factor
    run_time = 20 #steps to run
    decision = "push_threshold"
    comm_scale = scale
    mc_runs = 50 #number of runs in MC 
 
    data = pd.DataFrame()

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
        Household.next_uid = 1
        Individual.next_uid = 1

    string_1 = "push_threshold_oct_test_" + str(scale) + ".csv"
    data.to_csv(string_1)


