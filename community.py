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
    def __init__(self):
        self.impacted = False
        self.scale = 0 #scale of env impact
    #environmental shock
    def shock(self):
        if random.random() < 0.2:
            self.impacted = True
            self.scale = random.random()

#origin community
class origin(community):
    def __init__(self):
        super(origin, self).__init__()
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
