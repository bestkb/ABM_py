#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This is the actual model with scheduling and steps for
 ABM of environmental migration

@author: kelseabest
"""

#import packages
from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt
import pbd


#initialize model
class ABM_Model:
    def __init__(self, N, init_time = 0, wealth_factor, Xleng, Yleng):
        self.num_agents = N
        self.wealth_factor = wealth_factor
        global migrations
        global tick
        tick = init_time
        migrations = 0 #Initialize number of overall migrations

        # Create agents
        global agent_set
        agent_set = [] #empty list to store agents created
        for i in range(self.num_agents):
            a = Agent(i, self)
            a.land_owned = a.assign_land() #assign land ownership
            agent_set.append(a)

        #grid of patches, initializing and creating grid
        global grid
        grid = np.empty[Xleng, Yleng]
        for i in range(Xleng):
            for j in range(Yleng):
                p = land(i, j) #creating patches here
                grid[i, j] = p #add patches to grid which will hold all patches
                if p.pxid > 5: #initializing river
                    p.island = 1
                    p.impacted = 0
                else:
                    p.island = 0
                    p.impacted = 1
    return

    def model_step(self): #model step does each
        global tick
        random_sched = random.sample(range(N), N) #random schedule each time?

        for i in range(Xleng):
            for j in range(Yleng):
                p = grid[i, j]  #add patches to grid which will hold all patches
                p.visited = 0
                updated_dist = p.update_distance()
                p.distance_to_river = updated_dist[0]
                p.erosion_risk = updated_dist[1]
                p.productivity = udated_dist[2]
                eroded = p.erode() #erode patches at each step
                p.land = eroded[0]
                p.impacted = eroded[1]

        for a in range(N): #these are the steps for each agent to go through
            #add seed
            a_index = random_sched[a]
            agent_var = agent_set[a_index]
            agent_var.network_moves = agent_var.check_network()
            agent_var.check_land()
            agent_var.look_for_work()
            agent_var.migrate()
            agent_var.update_wealth()

        global tick = tick + 1

    return grid, tick, agent_set


    def data_collect: #use this eventually to collect model level data
        pass
