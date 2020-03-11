#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of individual class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt

class individual :
    def __init__(self): #initialize utilities
        self.age = np.random.normal(44, 12)
        gend_arr = ['M', 'F']
        self.gender = np.random.choice(gend_arr, 1)
        pass


    def assign_hh(self, agent_set):
        pass


    def age(self):
        self.age = self.age + 1
