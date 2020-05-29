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
    def __init__(self, N_hh, N_ind, decision, mig_threshold):
        self.decision = decision #set decision type
        self.mig_threshold = mig_threshold #wealth threshold to migrate
        #self.network_structure = network_structure
        self.num_hh = N_hh #households
        self.num_individuals = N_ind
        init_time = 0
        self.tick = init_time
        self.migrations = 0 #Initialize number of overall migrations

        #create community and initialize opportunities
        self.origin_comm = origin()


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
            a.individuals = a.gather_members(self.individual_set)
            a.head = a.set_head(self.individual_set)
            row = pd.DataFrame({'household': [a], 'hh_id': [a.unique_id],
                                'wtp': [a.wtp],
                               'wta': [a.wta], 'employer': [a.employer]})
            self.hh_set = pd.concat([self.hh_set, row])
            #a.set_network()

    def model_step(self): #model step does each
        random_sched_hh = np.random.permutation(self.num_hh)
        random_sched_ind = np.random.permutation(self.num_individuals)
        #random schedule each time

        #environmental shock in origin
        origin_comm.shock()

        for j in random_sched_ind: #steps for individuals
            ind_var = self.individual_set[self.individual_set.id == j].ind
            ind_var.find_work(self.hh_set)

        for i in random_sched_hh: #these are the steps at each tick for hh
            agent_var = self.hh_set[self.hh_set.hh_id == i].household
            #agent_var.check_network()
            agent_var.check_land(self.origin_comm)
            agent_var.sum_utility(self.individual_set)
            agent_var.migrate(self.decision, self.individual_set)
            agent_var.update_wealth()

        #tick and reset key values
        self.tick += 1
        self.origin_comm.impacted = False

        #age everyone 1 year
        for j in range(self.num_individuals):
            ind_var = self.individual_set[self.individual_set.id == j].ind
            ind_var.age()


    #work on this
    def data_collect: #use this eventually to collect model level data
        pass
