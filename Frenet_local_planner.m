### First trial of Frenet local planner with "offseted" global path

#----set initial pose and parameters of the problem
SetParams;

#----Is pose within goal tolerance and/or iterations < SIM_LOOP ?
ctr =0.0;
while hypot(c_x-wx(end),c_y-wy(end))>goal_tolerance && ctr<SIM_LOOP
  
  
  ## the buffer zone around the robot is : 
  ##  
  ##     <----2m----><-------8m----------->
  ##     ^                                |
  ##     |                                |
  ##     |          ---                   |
  ##  4*radius     ( x )                  |
  ##     |          ---                   |
  ##     |                                |
  ##     <-------------------------------->
  ##
  ##  x : center of the robot 
  
  
  # Is there an obstacle in the global path ?
  [bool_obstacle,closest_ob] = check_obstacle(c_x,c_y,obstacle);
  
  if bool_obstacle == 0
     #no --> follow global plan 
     local_plan = follow_global_plan(c_x,c_y,wx,wy);
     
   else
     #yes --> compute local plan
     local_plan = frenet_local_plan(c_x,c_y,wx,wy,closest_ob);
     
     for position = local_plan
       #check if there is any obstacle in the local path
       ok_path = check_obstacle(position(1),position(2),obstacle);
       
       if ok_path == 0
         #no ---> follow local plan
         
       else
         #yes ---> compute another local plan
         local_plan = new_local_plan(c_x,c_y,wx,wy);
         
       endif
     endfor
  endif
  c_x = local_plan(2,1);
  c_y = local_plan(2,2);
 ctr++;
endwhile



