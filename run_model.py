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
init_time = 0
wealth_factor = 50
run_time = 100 #steps to run

agent_states = []  # list for storing model output

# initialize model
model = ABM_Model(self, N_hh, N, init_time, wealth_factor)

    # save initial patch and agent state variables in agent_states
init_agent_states = []

for j in range(N):
    init_agent_states.append([])

# run simulation
for i in range(runtime):
    model.model_step()
    agent_states_now = []  # list for agent state variables at current time step
    agent_states.append(agent_states_now)
    model_attributes = model.data_collect()
return agent_states, model_attributes
