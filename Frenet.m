####Frenet 2nd version 

#get parameters 
SetParams;
n_lane = 0.0;
local_plan = [];
c_x = 0.0;c_y =0.0;
ctr =0;

#Compute offseted trajectories
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);

while ctr<SIM_LOOP
switch n_lane
  case 0.0  #we are on middle lane
    #do something
    [bool_obstacle, closest_ob] = check_obstacle(c_x,c_y,obstacle);
    if bool_obstacle == 0.0
      #do something
     local_plan = follow_global_plan(c_x,c_y,wx,wy);
      break;
    else
      #do something
      n_lane = choose_direction(closest_ob,wx,wy);
      [local_plan(1,:),local_plan(2,:)] = computeSpline(c_x,c_y,wx,wy,closest_ob);
      
      
    end
    
    #----------------------------------------------------------------------
  case 1.0  #we are on left lane
      #do something
      
      
  case -1.0  #we are on right lane
        #do something
        
        [bool_obstacle, closest_ob] = check_obstacle(c_x,c_y,obstacle);
        
  case "mid_to_left"
        #do something
        
        n_lane = 1.0;
        
  case "mid_to_right"
    #do something
        
        n_lane = -1.0;
    
  case "left_to_mid"
    #do something
    
  case "right_to_mid"
    #do something
    
  case "stop_planning"
    #do something
    
    
end
c_x = local_plan(1,2)
c_y = local_plan(2,2)
plot(local_plan(1,:),local_plan(2,:));
hold on;
ctr ++;
endwhile