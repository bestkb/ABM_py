#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of community class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages
import random
import math
import numpy as np
import matplotlib.pyplot as plt

class community :
    def __init__(self, n_hh):
        self.impacted = False
        self.n_hh = n_hh   
        self.avail_jobs = round(self.n_hh / 10)
    #environmental shock
    def shock(self):
        if random.random() < 0.2:
            self.impacted = True
            self.avail_jobs = round(self.n_hh / 20) 
            #self.scale = random.random()

#origin community
class origin(community):
    def __init__(self, n_hh):
        super(origin, self).__init__(n_hh)
    def shock(self):
        super(origin, self).shock()

#destinations
class dhaka(community):
    def __init__(self):
        super().__init__()

class khulna(community):
    def __init__(self):
        super().__init__()

class rural(community):
    def __init__(self):
        super().__init__()
