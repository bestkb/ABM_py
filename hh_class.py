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
        self.unique_id = Household.next_uid
        Household.next_uid += 1

        #radomly initialize wealth
        self.wealth = random.expovariate(50)

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
        self.expenses = 50
        self.total_utility = 0
        self.total_util_w_migrant = 0


#assign individuals to a household
    def gather_members(self, individual_set):
        ind_no_hh = individual_set[individual_set['hh'].isnull()]
        ind_no_hh_id = ind_no_hh['id']
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
        head_hh = males[males['age'] == max(males['age'])]
        self.head = head_hh
        head_hh['ind'].head = True
        #replace in individual set
        individual_set.loc[(individual_set.id.isin(head_hh['id'])), 'ind'] = head_hh

    def check_land(self, community):
        if community.impacted == True:
            if random.random() < community.scale:
                self.land_impacted == True

    def migrate(self, method, individual_set):
        my_individuals = self.individuals['ind']
        can_migrate = []
        for i in my_individuals:
            if i.can_migrate == True and i.migrated == False:
                can_migrate.append(i)
        migrant = np.random.choice(can_migrate, 1)
        util_migrate = 10 #how do I define these?

        if method == 'utility':
            self.total_utility_w_migrant = self.total_utility - migrant[0].salary + util_migrate
            decision = utility_max()
            decision.decide(self)
        else:
            pass

        #if true, someone migrated, remove that individual from model
        if decision.outcome == True:
            self.someone_migrated = self.someone_migrated + 1
            migrant[0].migrated = True

        individual_set.loc[(individual_set.id == migrant[0].unique_id), 'ind'] = migrant[0]

#different kinds of decisionmaking can go here

    #this is where hh will sum utility over each individual
    #seems complicated
    def sum_utility(self, individual_set):
        my_individuals = self.individuals['ind']
        sum_util = 0
        sum_util_w_mig = 0
        for i in my_individuals:
            sum_util = sum_util + i.salary
        self.total_utility = sum_util

    def update_wealth(self):
        #update wealth here
        my_individuals = self.individuals['ind']
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
