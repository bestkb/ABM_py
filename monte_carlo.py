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

#variables for monte carlo-
#wealth factor, migration threshold, migration utility,
#utilities


#define vars
N = 100 #number of individual agents
N_hh = 10 #number of households
run_time = 100 #steps to run
decision = "utility"

#these are for monte carlo
mig_threshold = 1000 #migration threshold
mig_util = 400 #utility to migrate
wealth_factor = 3000
ag_factor = 100

# initialize model
model = ABM_Model(run_time, N_hh, N, decision, mig_util, mig_threshold, wealth_factor, ag_factor)

#run model for ticks
while (model.tick < model.ticks):
    model.model_step()
    model.data_collect()
    model.tick_up()


data = model.data_set  #data should be stored here
