#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of community class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt

class community(self):
    def __init__(self):
        self.impacted == False
    #environmental shock
    def shock(self):
        if random.random() < 0.2:
            self.impacted == True

#origin community
class origin(community):
    def __init__(self):
        super().__init__()

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
