"""
This code is for a Monte Carlo sensitivity analysis
of the ABM of environmental migration

@author: kelseabest
"""

#import packages
from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt


#define vars
N = 100 #number of individual agents
N_hh = 10 #number of households
run_time = 100 #steps to run
decision = "utility"

#current values
mig_threshold = 1000 #migration threshold
mig_util = 400 #utility to migrate
wealth_factor = 3000
ag_factor = 100

#these are for monte carlo
size_mc = 1000 #number of MC draws

mig_threshold_sd = 500 #standard deviation
mig_threshold_mc = np.random.normal(mig_threshold, mig_threshold_sd, size_mc)

mig_util_sd = 200 #standard deviation
mig_util_mc = np.random.normal(mig_util, mig_util_sd, size_mc)

wealth_sd = 1000 #standard deviation
wealth_factor_mc = np.random.normal(wealth_factor, wealth_sd, size_mc)

ag_sd = 20 #standard deviation
ag_factor_mc = np.random.normal(ag_factor, ag_sd, size_mc)


#here I can do a for loop to loop through MC
# initialize model

mig_mc = pd.DataFrame()

for i in mig_threshold_mc:
    model = ABM_Model(run_time, N_hh, N, decision, mig_util, i, wealth_factor, ag_factor)

    #run model for ticks
    while (model.tick < model.ticks):
        model.model_step()
        model.data_collect()
        model.tick_up()
    data = model.data_set  #data should be stored here
    migs = model.migrations

    final_migs = migs.iloc[-1, 1]
    row = pd.DataFrame({'mig_threshold': [i], 'migrations': [final_migs]})
    mig_mc = pd.concat([mig_mc, row])
