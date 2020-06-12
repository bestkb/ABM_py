#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This runs the ABM of environmental migration

@author: kelseabest
"""

#import packages
from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt
import pbd

#define vars
N = 100 #number of individual agents
N_hh = 10 #number of households
mig_threshold = 50 #migration threshold
run_time = 100 #steps to run
decision = "utility"

agent_states = []  # list for storing model output

# initialize model
model = ABM_Model(self, run_time, N_hh, N, decision, mig_threshold)

#run model for ticks
while (model.tick < model.ticks):
    model.model_step()
    model.data_collect()
