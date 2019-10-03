#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of patch class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt


class land :
    next_uid = 1

    def __init__(self, pidx, pidy):
        self.unique_id = land.next_uid
        land.next_uid += 1
        self.pidx = pidx #id of patch <- how do I set grid?
        self.pidy = pidy
        self.distance_to_river = 0
        self.erosion_risk = 0
        self.productivity = 0
        self.impacted = 1
        self.visited = 0
        self.island = 0
        self.owner = None

    def update_distance(self): #only looking in x right now
    #distance to nearest island = 0 patch
        y = self.pidy
        x = self.pidx
        dists = [] #temporarily store distances
        if self.island == 1:
            for i in range(x):
                p = grid(i, y)
                if p.island == 0:
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
        if self.island == 0:
            for i in range(self.pidx - 1, self.pidx): #looks at nearest in x
                for j in range(self.pidy - 1, self.pidy + 1) #error here
                p = grid(i,  j) #select neighbor patch stored in grid
                if p.island == 1 & p.visited == 0:
                    p.visited = 1
                    if random.random  < p.erosion_risk:
                        p.land = 0
                        p.impacted = 1
                        p.distance_to_river = 0
                        p.erode()
    return [p.land, p.impacted, p.distance_to_river]
        #how do I return these values?
