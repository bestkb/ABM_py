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
class Agent :
    next_uid = 1
    def __init__(self): #initialize agents
        #needs to move to a patch with island = 1
        self.unique_id = Agent.next_uid
        Agent.next_uid += 1
        self.wealth = random.expovariate(50)
        self.age_head = np.random.normal(44, 12)
        self.hh_size = random.randint(0, 10)
        self.individuals = [] #initialize empty array to hold individuals


        #look at these later
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
        self.expenses = 50

#assign individuals to a household
    def gather_members(self, individual_set)
        ind_no_hh = individual_set['hh'] == None
        self.individuals.append(ind_no_hh.sample(self.hh_size))
        for p in self.individuals:
            p.hh = self

#assign land to a household
    def assign_land(self, patches): 
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

    def set_network(self, agent_set, network_structure, network_size):
        if network_structure == 'random':
            self.network = agent_set.sample(network_size)
            for a in self.network:
                a.network.append(self) #add self to other person's network

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

    def migrate(self, decision, mig_threshold, migrations):
        if self.employment == 0 and self.land_owned <= 0: #different kinds of mig
            if decision == 'wealth':
                intercept = -1.3
                age_factor = 0
                beta_size = 0
                beta_network = 0
                linear = intercept + beta_wealth * self.wealth +
                                beta_size * (self.nonworkers/ self.household_size)+
                                beta_network * self.network_moves + age_factor
            if decision == 'size':
                intercept = -1.3
                age_factor = 0
                beta_size = 1
                beta_network = 0
                linear = intercept + beta_wealth * self.wealth +
                                beta_size * (self.nonworkers/ self.household_size)+
                                beta_network * self.network_moves + age_factor

            if decision == 'network':
                intercept = -1.3
                age_factor = 0
                beta_size = 1
                beta_network = 0.5
                linear = intercept + beta_wealth * self.wealth +
                                beta_size * (self.nonworkers/ self.household_size)+
                                beta_network * self.network_moves + age_factor

            if decision == 'age':
                if self.age_head > 15 and self.age_head < 40:
                    intercept = -1.3
                    age_factor = 0.25
                    beta_size = 1
                    beta_network = 0.5
                    linear = intercept + beta_wealth * self.wealth +
                                    beta_size * (self.nonworkers/ self.household_size)+
                                    beta_network * self.network_moves + age_factor
                else:
                    intercept = -1.3
                    age_factor = -0.25
                    beta_size = 1
                    beta_network = 0.5
                    linear = intercept + beta_wealth * self.wealth +
                                    beta_size * (self.nonworkers/ self.household_size)+
                                    beta_network * self.network_moves + age_factor

            if decision == 'planned':
                attitude_weight = 1
                control_weight = 1
                norm_weight = 1
                self.set_attitude()
                self.set_norm()
                self.set_control()
                intention = attitude_weight * self.attitude + norm_weight * self.norm +
                            control_weight + self.control
                linear = intention

        #logistic function with prob_migrate
        self.prob_migrate = (exp(linear) / (1+ exp(linear)))

        if random.random() < self.prob_migrate and self.wealth >= mig_threshold:
            self.someone_migrated = 1
            migrations += 1
            #right now the agent just leaves the model


    def update_wealth(self):
        if self.land_owned > 0:
            prod = 0
            for p in self.patches_owned:
                prod = prod + p.productivity
            self.wealth = self.wealth - sum(self.payments) + prody
            self.wtp = self.wtp * (1- (len(self.employees)/10))
        if self.wealth < 0:
                self.wealth = 0
        elif self.employment == 1:
            self.wealth = self.wealth + self.salary
            self.wtp = 0
            if self.wealth < 0:
                self.wealth = 0
        elif self.someone_migrated == 0:
            self.wealth = self.wealth - self.expenses
            selt.wtp = 0
            self.wta = self.wta * 0.9
            if self.wealth < 0:
                self.wealth = 0

    def set_attitude(self):
        if self.age_head > 15 and self.age_head < 40:
            self.attitude = 0.5
        else:
            self.attitude = 0.25

    def set_norm(self):
        self.norm = (self.land_original + self.network_moves)/ 10

    def set_control(self):
        self.control = self.wealth / 100
