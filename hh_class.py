#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Working definition of agent class (household) for ABM
 of environmental migration

@author: kelseabest
"""

#import packages
from decisions import *
from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd



#object class Agent
class Household :
    next_uid = 1
    def __init__(self, wealth_factor): #initialize agents
        #needs to move to a patch with island = 1
        self.unique_id = Household.next_uid
        Household.next_uid += 1

        #radomly initialize wealth
        self.wealth = random.expovariate(wealth_factor)

        self.hh_size = random.randint(2, 10)
        self.individuals = pd.DataFrame() #initialize DF to hold individuals
        self.head = None
        self.land_owned = random.randint(0, 14)

        #look at these later
        self.network = []
        self.network_moves = 0
        self.someone_migrated = 0
        self.history = []
        self.success = []
        self.land_impacted = False
        self.wta = self.wealth / 10
        self.wtp = self.wealth / 10
        self.employees = []
        self.payments = []
        self.expenses = 0
        self.total_utility = 0
        self.total_util_w_migrant = 0
        self.num_shocked = 0


#assign individuals to a household
    def gather_members(self, individual_set):
        ind_no_hh = individual_set[individual_set['hh'].isnull()]
        if len(ind_no_hh) > self.hh_size:
            self.individuals = pd.concat([self.individuals, ind_no_hh.sample(self.hh_size)])
        else:
            self.individuals = pd.concat([self.individuals, ind_no_hh.sample(len(ind_no_hh))])
        #update information for hh and individual
        self.individuals['ind'].hh = self.unique_id
        individual_set.loc[(individual_set.id.isin(self.individuals['id'])), 'hh'] = self.unique_id
        for i in individual_set.loc[(individual_set.hh == self.unique_id), 'ind']:
            i.hh = self.unique_id
        self.individuals['hh'] = self.unique_id

    def assign_head(self, individual_set):
        my_individuals = individual_set.loc[(individual_set['hh'] == self.unique_id)]
        males = my_individuals[my_individuals['gender']== 'M']
        females = my_individuals[my_individuals['gender']== 'F']
        if (len(males) == 0 and len(females) == 0):
            head_hh = None
        elif (len(males) != 0):
            head_hh = males[males['age'] == max(males['age'])]
        else:
            head_hh = females[females['age'] == max(females['age'])]

        self.head = head_hh
        head_hh['ind'].head = True
        #replace in individual set
        individual_set.loc[(individual_set.id.isin(head_hh['id'])), 'ind'] = head_hh

        #unit test
        assert len(self.head) <= 1, "Too many HH heads"


    def check_land(self, community, comm_scale):
        if community.impacted == True:
            if random.random() < comm_scale:
                self.land_impacted = True
                self.num_shocked += 1

    def migrate(self, method, individual_set, mig_util, mig_threshold):
        util_migrate = mig_util #how do I define these?

        my_individuals = individual_set.loc[(individual_set['hh'] == self.unique_id, 'ind')]
        can_migrate = []
        for i in my_individuals:
            if i.can_migrate == True and i.migrated == False:
                can_migrate.append(i)
        if len(can_migrate) != 0:
            migrant = np.random.choice(can_migrate, 1)
        else:
            return

        if method == 'utility' and self.wealth > mig_threshold:
            self.total_util_w_migrant = self.total_utility - migrant[0].salary + util_migrate
            decision = utility_max()
            decision.decide(self)
            if decision.outcome == True:
                self.someone_migrated += 1
                migrant[0].migrated = True
                individual_set.loc[(individual_set.id == migrant[0].unique_id), 'ind'] = migrant[0]
        else:
            pass


#different kinds of decisionmaking can go here

    #this is where hh will sum utility over each individual
    #seems complicated
    def sum_utility(self, individual_set):
        my_individuals = individual_set.loc[(individual_set['hh'] == self.unique_id, 'ind')]
        sum_util = 0
        for i in my_individuals:
            sum_util = sum_util + i.salary
        self.total_utility = sum_util

    def update_wealth(self, individual_set):
        #update wealth here
        my_individuals = individual_set.loc[(individual_set['hh'] == self.unique_id, 'ind')]
        sum_wealth = 0
        for i in my_individuals:
            sum_wealth = sum_wealth + i.salary
        self.wealth = sum_wealth - self.expenses - np.sum(self.payments)

        #reset these values
        self.land_impacted = False
        self.wta = self.wealth / 10
        self.wtp = self.wealth / 10



#####################################################################
#to work on these later
    def set_network(self, agent_set, network_structure, network_size):
        if network_structure == 'random':
            self.network = agent_set.sample(network_size)
            for a in self.network:
                a.network.append(self) #add self to other person's network

    def check_network(self):
        for a in self.network:
            if a.someone_migrated == 1:
                self.network_moves += 1
