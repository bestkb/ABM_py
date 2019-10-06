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
import pandas as pd

#initialize model
class ABM_Model:
    def __init__(self, N, wealth_factor, Xleng, Yleng):
        self.num_agents = N
        self.wealth_factor = wealth_factor
        init_time = 0
        self.tick = init_time
        self.migrations = 0 #Initialize number of overall migrations

        #grid of patches, initializing and creating grid
        self.patch_list = pd.DataFrame()
        self.grid = np.empty((Xleng, Yleng), dtype = np.uint)
        for i in range(Xleng):
            for j in range(Yleng):
                p = land(i, j) #creating patches here
                self.patch_list
                pdf = pd.DataFrame({'patch' : [p], 'id': [p.unique_id],
                                    'x': [i], 'y': [j],
                                    'owner': [p.owner]})
                self.patch_list = pd.concat((self.patch_list, pdf))
                self.grid[i, j] = p.unique_id #add patches to grid which will hold all patches
                if p.pidx > 5: #initializing river
                    p.island = 1
                    p.impacted = 0
                else:
                    p.island = 0
                    p.impacted = 1

        # Create agents
        self.agent_set = pd.DataFrame() #empty list to store agents created
        for i in range(self.num_agents):
            a = Agent()
            a.land_owned = a.assign_land(self.patch_list) #assign land ownership
             row = pd.DataFrame({'agent': [a], 'id': [a.unique_id], 'wtp': [a.wtp],
                               'wta': [a.wta], 'employer': [a.employer]})
            self.agent_set = pd.concat([self.agent_set, row])

        for a in self.agent_set['agent']:
            a.set_network()
            
    def model_step(self): #model step does each
        random_sched = np.random.permutation(self.num_agents)
        #random schedule each time

        for p in self.patch_list['patch']:
            p.visited = 0
            p.update_distance()
        for p in self.patch_list['patch']:
            p.erode(patch_list = self.patch_list) #erode patches at each step

        for i in random_sched: #these are the steps for each agent to go through
            #add seed
            agent_var = self.agent_set[self.agent_set.id == i].agent
            agent_var.check_network()
            agent_var.check_land()
            agent_var.look_for_work()
            agent_var.migrate()
            agent_var.update_wealth()

        self.tick += 1


    def data_collect: #use this eventually to collect model level data
        pass
