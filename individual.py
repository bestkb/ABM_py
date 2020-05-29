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

    def __init__(self): #initialize
        self.unique_id = Individual.next_uid
        Individual.next_uid += 1
        self.age = random.randrange(1, 80, 1)
        gend_arr = ['M', 'F']
        self.gender = np.random.choice(gend_arr, 1)
        self.hh = None
        self.employment = None
        self.salary = 0
        self.employer = None
        self.can_migrate  = False
        self.head = False
        self.migrated = False
        pass

    def age_up(self):
        self.age = self.age + 1


    def find_work(self, hh_set): #how will this connect to community later?
        #look for ag in own land first
        poss_employers = []
        my_hh = hh_set['household'] == self.hh

        #could this person migrate (age, sex)?
        if self.age >= 14 and self.gender == 'M':
            self.can_migrate = True
        #too young to work?
        if self.age < 14 and self.gender != 'M':
            self.emmployment = 'None'
            self.salary = 0
        #work in ag on own land
        elif my_hh.land_impacted == False:
            self.employment = "SelfAg"
            self.salary = my_hh.land_owned * 10 #random productivity value here
        else: #otherwise look for ag employment in community
            for a in hh_set['household']:
                if a.wtp >= my_hh.wta and a.land_impacted == False:
                    poss_employers.append(a)
                if len(poss_employers) != 0:
                    employer = random.choice(poss_employers)
                    self.employer = employer
                    self.salary = (my_hh.wta + employer.wtp)/2
                    self.employment = "OtherAg"
                    pay = self.salary
                    employer.employees.append(self)
                    employer.payments.append(pay)
