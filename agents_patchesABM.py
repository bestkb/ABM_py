#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of agent and patch classes for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt
import pbd


#object class Agent
class Agent :
    next_uid = 1
    def __init__(): #initialize agents
        #needs to move to a patch with island = 1
        self.unique_id = Agent.next_uid
        Agent.next_uid += 1
        self.wealth = np.random.exponental(50)
        self.age_head = np.random.normal(44, 12)
        self.hh_size = np.random.normal(5, 2)
        self.nonworkers = randrange(0, self.hh_size, 1)
        self.land_owned = randrange(0, 14, 1)
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
        slef.employees = []
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



class land :
    next_uid = 1

    def __init__(pidx, pidy):
        self.unique_id = next_uid
        next_uid += 1
        self.pidx = pidx #id of patch <- how do I set grid?
        self.pidy = pidy
        self.distance_to_river = 0
        self.erosion_risk = 0
        self.productivity = 0
        self.impacted = 1
        self.visited = 0
        self.island = 0
        self.owner = None

    def update_distance(self, grid): #only looking in x right now
    #distance to nearest island = 0 patch
        y = self.pidy
        x = self.pidx
        dists = [] #temporarily store distances
        if self.island = 1:
            for i in range(x):
                p = grid(i, y)
                if p.island = 0:
                    d = x - i
                    dists.append(d)
            self.distance_to_river = min(dists)
        else:
            self.distance_to_river = 0

        if self.distance_to_river != 0:
            self.erosion_risk = 1/self.distance_to_river
            self.productivity = self.distance_to_river / 100
        return [self.distance_to_river, self.erosion_risk, self.productivity]

    def erode(self, grid):
        if self.island = 0:
            for i in range(self.pidx - 1, self.pidx): #looks at nearest in x
                for j in range(self.pidy + 1, self.pidy + 1) #neighbors in y
                p = grid(i,  j) #select neighbor patch stored in grid
                if p.island = 1 & p.visited = 0:
                    p.visited = 1
                    if random.random  < p.erosion_risk:
                        p.land = 0
                        p.impacted = 1
                        p.distance_to_river = 0
                        p.erode()
    return [p.land, p.impacted, p.distance_to_river]
        #how do I return these values?
