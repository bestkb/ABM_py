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

class Individual :
    next_uid = 1

    def __init__(self, evaluation_method): #initialize utilities
        self.unique_id = Agent.next_uid
        Agent.next_uid += 1
        self.age = np.random.normal(44, 12)
        gend_arr = ['M', 'F']
        self.gender = np.random.choice(gend_arr, 1)
        self.hh = None
        self.employment = None
        self.salary = 0
        self.utility = 0
        pass

    def age(self):
        self.age = self.age + 1


    def find_work(self, hh_set): #how will this connect to community later?
        #look for ag in own land first
        my_hh = hh_set['household' == self.hh]
        if my_hh.land_impacted == False:
            self.employment = "SelfAg"
            self.salary = my_hh.land_owned * 10 #random productivity value here

        #then consider working in agriculture for someone else
        poss_employers = []
        for a in hh_set['household']:
            if a.wtp >= self.wta and a.land_impacted == False:
                poss_employers.append(a)
            if len(poss_employers) != 0:
                employer = random.choice(poss_employers)
                self.employer = employer
                self.salary = (self.wta + employer.wtp)/2
                self.employment = "OtherAg"
                pay = self.salary
                employer.employees.append(self)
                employer.payments.append(pay)

    def calc_utility(self):
        if self.employment == "SelfAg":
            self.utility = self.salary + 10
        if self.employment == "OtherAg":
            self.utility = self.salary - 10 
