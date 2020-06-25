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

mig_threshold = 1000 #migration threshold
mig_util = 400 #utility to migrate
wealth_factor = 3000
ag_factor = 100

#these are for monte carlo
size_mc = 1000 #number of MC draws

mig_threshold_mean = 1000
mig_threshold_sd = 500
mig_threshold_mc = np.random.normal(mig_threshold_mean, mig_threshold_sd, size_mc)

mig_util_mean = 400
mig_util_sd = 200
mig_util_mc = np.random.normal(mig_util_mean, mig_util_sd, size_mc)

wealth_mean = 3000
wealth_sd = 1000
wealth_factor_mc = np.random.normal(wealth_mean, wealth_sd, size_mc)


ag_mean = 100
ag_sd = 20
ag_factor_mc = np.random.normal(ag_mean, ag_sd, size_mc)


#here I can do a for loop to loop through MC 
# initialize model
model = ABM_Model(run_time, N_hh, N, decision, mig_util, mig_threshold, wealth_factor, ag_factor)

#run model for ticks
while (model.tick < model.ticks):
    model.model_step()
    model.data_collect()
    model.tick_up()
data = model.data_set  #data should be stored here
migs = model.migrations
