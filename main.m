################################################################################
######### Main file for Frenet local planner ###################################
#  HOW TO USE :                                                               ##
#  - set all parameters in the file SetParams                                 ##
#  - run this script                                                          ##
################################################################################
################################################################################

clear all;
close all;

%---- set all parameters -------------------------------------------------------
SetParams;  

%---- Compute offseted trajectories --------------------------------------------
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);  
hold on;

%---- Compute local path and plot ---------------------------------------------
FrenetLocalPlanner;

