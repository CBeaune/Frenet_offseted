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
hold on;

%---- Compute local path and plot ---------------------------------------------
pause(1.0);
FrenetLocalPlanner;

################################################################################
################################################################################