#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This is the actual model with scheduling and steps for
 ABM of environmental migration

@author: kelseabest
"""

#import packages
from matplotlib.colors import LinearSegmentedColormap
import random
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#initialize model
class ABM_Model:
    def __init__(self, ticks, N_hh, N_ind, decision, mig_util):
        self.decision = decision #set decision type
        self.mig_util = mig_util #wealth threshold to migrate
        #self.network_structure = network_structure
        self.num_hh = N_hh #households
        self.num_individuals = N_ind
        init_time = 0
        self.tick = init_time
        self.ticks = ticks
        self.migrations = 0 #Initialize number of overall migrations

        #create community and initialize opportunities
        self.origin_comm = origin()
        self.data_set = pd.DataFrame()

        #create individuals
        self.individual_set = pd.DataFrame()
        for i in range(self.num_individuals):
            ind = Individual()
            row = pd.DataFrame({'ind': [ind], 'id': [ind.unique_id],
                                'age': [ind.age], 'hh': [ind.hh],
                               'gender': [ind.gender]})
            self.individual_set = pd.concat([self.individual_set, row])

        # Create households
        self.hh_set = pd.DataFrame() #empty list to store agents created
        for i in range(self.num_hh):
            a = Household()
            a.gather_members(self.individual_set)
            a.assign_head(self.individual_set)
            #a.set_network()
            row = pd.DataFrame({'household': [a], 'hh_id': [a.unique_id],
                                            'wtp': [a.wtp],
                                           'wta': [a.wta]})
            self.hh_set = pd.concat([self.hh_set, row])

    def model_step(self): #model step does each

            #random schedule each time
        random_sched_hh = np.random.permutation(range(1, self.num_hh+ 1))
        random_sched_ind = np.random.permutation(range(1, self.num_individuals+ 1))

            #environmental shock in origin
        self.origin_comm.shock()

            #households need to check land
        for i in random_sched_hh: #these are the steps at each tick for hh
            agent_var = self.hh_set[self.hh_set.hh_id == i].household
            agent_var[0].check_land(self.origin_comm)

            #individuals look for work
        for j in random_sched_ind: #steps for individuals
            ind_var = self.individual_set[self.individual_set.id == j].ind
            ind_var[0].check_eligibility()
            ind_var[0].find_work(self.hh_set, self.mig_util)

            #households decide to send a migrant or not and update wealth
        for i in random_sched_hh: #these are the steps at each tick for hh
            agent_var = self.hh_set[self.hh_set.hh_id == i].household
            #agent_var.check_network()
            agent_var[0].sum_utility(self.individual_set)
            agent_var[0].migrate(self.decision, self.individual_set, self.mig_util)
            agent_var[0].update_wealth(self.individual_set)

            #tick and reset key values
        self.tick += 1
        self.origin_comm.impacted = False

            #age everyone 1 year
        for j in range(1, self.num_individuals + 1):
            ind_var = self.individual_set[self.individual_set.id == j].ind
            ind_var[0].age_up()


    #work on this
    def data_collect(self): #use this eventually to collect model level data
    #household level data
        for j in range(1, self.num_hh + 1):
            hh_var = self.hh_set[self.hh_set.hh_id == j].household
            hh = hh_var[0]
            row = pd.DataFrame({'hh_id': [hh.unique_id], 'migrations': [hh.someone_migrated],
                                'wealth': [hh.wealth], 'num_shocked':[hh.num_shocked],
                                'tick': [self.tick]})
            self.data_set = pd.concat([self.data_set, row])

        self.migrations = self.data_set.iloc[:,1].sum(axis=0)
