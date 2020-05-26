#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of agent class (household) for ABM
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
class Household :
    next_uid = 1
    def __init__(self): #initialize agents
        #needs to move to a patch with island = 1
        self.unique_id = Agent.next_uid
        Agent.next_uid += 1
        self.wealth = random.expovariate(50)
        self.age_head = np.random.normal(44, 12)
        self.hh_size = random.randint(0, 10)
        self.individuals = [] #initialize empty array to hold individuals
        self.patches_owned = []
        self.land_owned = random.randint(0, 14)
        self.land_original = self.land_owned

        #look at these later
        self.nonworkers = random.randint(0, self.hh_size) #don't need?
        self.employment = 0 #or should this be at individual?
        self.network = []
        self.network_moves = 0
        self.moves_internal = 0
        self.someone_migrated = 0
        self.history = []
        self.success = []
        self.land_impacted = 0
        self.wta = self.wealth / 10
        self.wtp = self.wealth / 10
        self.employees = []
        self.employer = None
        self.salary = 0
        self.payments = []
        self.prob_migrate = 0
        self.expenses = 50


#assign individuals to a household
    def gather_members(self, individual_set):
        ind_no_hh = individual_set['hh'] == None
        self.individuals.append(ind_no_hh.sample(self.hh_size))
        for p in self.individuals:
            p.hh = self

#assign land to a household
    def assign_land(self): #need to edit
        vacant_patches = patches['owner'] == None
        self.patches_owned.append(vacant_patches.sample(self.land_owned))
        for p in self.patches_owned:
            p.owner = self

    def check_land(self):
        pass

    def set_network(self, agent_set, network_structure, network_size):
        if network_structure == 'random':
            self.network = agent_set.sample(network_size)
            for a in self.network:
                a.network.append(self) #add self to other person's network

    def check_network(self):
        for a in self.network:
            if a.someone_migrated == 1:
                self.network_moves += 1


    def migrate(self, method):
        if method == 'utility':
            utility_max.decide(self.agent_var)
        else:
            pass
#different kinds of mig

    #this is where each individual will assess utilty
    def sum_utility(self, individual_set):
        my_individuals = individual_set['hh'] == self
        for p in my_individuals:
            p.assess_utility


    def update_wealth(self):
        pass 
