#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of agent class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt


#object class Agent
class Agent :
    next_uid = 1
    def __init__(self): #initialize agents
        #needs to move to a patch with island = 1
        self.unique_id = Agent.next_uid
        Agent.next_uid += 1
        self.wealth = random.expovariate(50)
        self.age_head = np.random.normal(44, 12)
        self.hh_size = random.randint(0, 7)
        self.nonworkers = random.randint(0, self.hh_size)
        self.land_owned = random.randint(0, 14)
        self.land_original = self.land_owned
        self.employment = 0
        self.network = [] #this one is n-of 5 turtles in NetLogo
        self.network_moves = 0
        self.moves_internal = 0
        self.someone_migrated = 0
        self.history = []
        self.success = []
        self.land_inundated = 0
        self.patches_owned = []
        self.wta = self.wealth / 10
        self.wtp = self.wealth / 10
        self.employees = []
        self.employer = 0
        self.salary = 0
        self.payments = []
        self.prob_migrate = 0
        self.attitude = 0
        self.norm = 0
        self.control = 0


    def assign_land(self): #a bit stuck here
        # set vacant_patches to patches on the grid with no owner
        self.patches_owned.append(random.choice(vacant_patches, k = self.land_owned))
        for p in self.patches_owned:
            p.owner = self
        return self
         #ask turtles [
    #set patches_owned (n-of land_owned patches in-radius 5 with [land? and owner = nobody])
    #;set land
     # ask patches_owned [
      #set owner [who] of myself
      #set pcolor [color] of myself
      #]
 # ]

    def check_land(self):
        pass

    def check_network(self):
        pass

    def look_for_work(self):
        pass

    def seek_employment(self):
        pass

    def migrate(self):
        pass

    def set_attitude(self):
        pass

    def set_norm(self):
        pass

    def set_control(self):
        pass

    def update_wealth(self):
        pass
