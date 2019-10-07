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
                p_frame = patches[patches['x']== i]
                for p in p_frame['patch']:
                    if p.island == 0:
                        d = x - i
                        dists.append(d)
            self.distance_to_river = min(dists)
        else:
            self.distance_to_river = 0
        if self.distance_to_river != 0:
            self.erosion_risk = 1/(self.distance_to_river + 0.25)
            self.productivity = self.distance_to_river / 10

    def erode(self, patch_list):
        if self.island == 0:
            for i in range(self.pidx -1, self.pidx +2): #looks at nearest in x
                for j in range(self.pidy -1, self.pidy +1):
                    for p in patch_list.loc[(patch_list['x'] == i) & (patch_list['y'] == j)]['patch']:
                        if p.island == 1 and p.visited == 0:
                            p.visited = 1
                            if (random.random() < p.erosion_risk): #this is where it's stuck
                                p.island = 0
                                p.impacted = 1
                                p.distance_to_river = 0
                                p.erode(patch_list)
