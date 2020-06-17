### First trial of Frenet local planner with "offseted" global path

#----set initial pose and parameters of the problem
SetParams;

#----Is pose within goal tolerance and/or iterations < SIM_LOOP ?
ctr =0.0;
theta = 0.0;
c_x = 0.0;
c_y = 0.0;
 wx = main_route_x;
 wy = main_route_y;
plot(obstacle(1),obstacle(2),'xk');
plot(main_route_x,main_route_y,'g');
hold on;
non_new_plan = 1;
endpoint_reached = 0;
while hypot(c_x-main_route_x(end),c_y-main_route_y(end))>goal_tolerance && ctr<SIM_LOOP
  
  
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
     
   elseif bool_obstacle == 1
     if non_new_plan ==1
       
     [xSpline,ySpline] = computeSpline(c_x,c_y,wx,wy,obstacle,theta);
     plot(xSpline,ySpline,'b--')
     wx = xSpline;
     wy = ySpline;
     [local_plan,endpoint_reached] = follow_global_plan(c_x,c_y,wx,wy);
     non_new_plan = 0;
     
%   else
%     if endpoint_reached == 0
%      [local_plan,endpoint_reached] = follow_global_plan(c_x,c_y,wx,wy);
%     else
%      bool_obstacle = 0;
%      non_new_plan = 1;
%      endpoint_reached =0;
%      wx = main_route_x;
%      wy = main_route_y;
%    endif
    
       
       
   endif
   
     
  endif
  
  prev_x = c_x;
  prev_y = c_y;
  plot(c_x,c_y,'ro');
  hold on;
  plot(local_plan(1,2:end),local_plan(2,2:end),'b-');
  hold on;
  c_x = local_plan(1,2);
  c_y = local_plan(2,2);
  theta = atan2(c_x-prev_x,c_y-prev_y);
 ctr++;
endwhile




