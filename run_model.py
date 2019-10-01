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
N = 100 #number of agents
init_time = 0
wealth_factor = 50
Xleng = 50
Yleng = 50
run_time = 100 #steps to run

 agent_states = []  # list for storing model output

# initialize model
    model = ABM_Model(self, N, init_time, wealth_factor, Xleng, Yleng)

    # save initial patch and agent state variables in agent_states
    init_agent_states = []
    init_patch_states = []
    
    for j in range(N):
        init_agent_states.append([])
    for cell in model.grid.coord_iter():
        cell_content, x, y = cell
        if type(cell_content) == Household:
            # collect agent state variables
            init_agent_states[x].append((cell_content.flood_damage, cell_content.inundation,
                                        cell_content.adaptive_capacity, cell_content.resistance,
                                        cell_content.accommodation, cell_content.attachment, cell_content.p_action,
                                        cell_content.p_resist, cell_content.p_accommodate, cell_content.p_retreat,
                                        cell_content.relative_elevation, cell_content.retreated))
        else:
            init_agent_states[x].append(np.nan)
    agent_states.append(init_agent_states)

    model.datacollector.collect(model)  # collect initial model state variables

    # run simulation
    for i in range(runtime):
        model.model_step()
        agent_states_now = []  # list for agent state variables at current time step
        agent_states.append(agent_states_now)
        model_attributes = model.data_collect
    return agent_states, model_attributes
