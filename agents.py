#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of agent class for ABM
 of environmental migration

@author: kelseabest
"""

#import packages

from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt


#object class Agent
class Agent :
    next_uid = 1
    def __init__(self): #initialize agents
        #needs to move to a patch with island = 1
        self.unique_id = Agent.next_uid
        Agent.next_uid += 1
        self.wealth = random.expovariate(50)
        self.age_head = np.random.normal(44, 12)
        self.hh_size = random.randint(0, 7)
        self.nonworkers = random.randint(0, self.hh_size)
        self.land_owned = random.randint(0, 14)
        self.land_original = self.land_owned
        self.employment = 0
        self.network = []
        self.network_moves = 0
        self.moves_internal = 0
        self.someone_migrated = 0
        self.history = []
        self.success = []
        self.land_inundated = 0
        self.patches_owned = []
        self.wta = self.wealth / 10
        self.wtp = self.wealth / 10
        self.employees = []
        self.employer = None
        self.salary = 0
        self.payments = []
        self.prob_migrate = 0
        self.attitude = 0
        self.norm = 0
        self.control = 0

    def assign_land(self, patches): #a bit stuck here
        vacant_patches = patches['owner'] == None
        self.patches_owned.append(vacant_patches.sample(self.land_owned))
        for p in self.patches_owned:
            p.owner = self

    def check_land(self, patches):
        my_land = patches['owner'] == self
        for p in my_land:
            if p.island == 0:
                self.land_owned -= 1
                self.land_inundated = 1
                self.patches_owned.remove(p)

    def set_network(self, agent_set): #this is new, this can change network
        pass

    def check_network(self):
        for a in self.network:
            if a.someone_migrated == 1:
                self.network_moves += 1

    def look_for_work(self, agent_set):
        if self.land_owned <= 0:
            self.employees = []
            for a in agent_set(['employer'] == self)['agent']:
                a.employment = 0
                a.employer = None
            if self.emmployment == 0:
                self.seek_employment(agent_set)
                self.moves_internal += 1

    def seek_employment(self, agent_set):
        poss_employers = []
        for a in agent_set['agent']:
            if a.wtp >= self.wta and a.land_owned > 0:
                poss_employers.append(a)
        if len(poss_employers) != 0:
            employer = random.choice(poss_employers)
            self.employer = employer
            self.salary = (self.wta + employer.wtp)/2
            self.employment = 1
            pay = self.salary
            employer.employees.append(self)
            employer.payments.append(pay)

    def migrate(self):
        pass

    def update_wealth(self):
        pass

    def set_attitude(self):
        if self.age_head > 15 and self.age_head < 40:
            self.attitude = 0.5
        else:
            self.attitude = 0.25

    def set_norm(self):
        self.norm = (self.land_original + self.network_moves)/ 10

    def set_control(self):
        self.control = self.wealth / 100
