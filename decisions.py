#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of decision class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt

class decision :
    #method decide returns True or False
    #subclass of decisions
    def __init__(self): #initialize utilities
        pass
    def decide(self):
        pass

class utility_max(decision):
    def __init__(self): #initialize utilities
        super().__init__()
    def decide(self, probability, utility):
        pass

class tpb(decision):
    def __init__(self): #initialize utilities
        super().__init__()
    def decide(self, probability, utility):
        pass

class pmt(decision):
    def __init__(self): #initialize utilities
        super().__init__()

    def decide(self, probability, utility):
        pass

class mobility_potential(decision):
    def __init__(self): #initialize utilities
        super().__init__()
    def decide(self, probability, utility):
        pass
