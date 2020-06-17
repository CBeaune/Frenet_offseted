####Frenet 2nd version 

#get parameters 
SetParams;
n_lane = 0.0;

#Compute offseted trajectories
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);

switch n_lane
  case 0.0  #we are on middle lane
    #do something
    [bool_obstacle, closest_ob] = check_obstacle(c_x,c_y,obstacle);
    if bool_obstacle == 0.0
      #do something
      follow_plan(c_x,c_y,closest_ob);
      break;
    else
      #do something
      n_lane = choose_direction(c_x,c_y,closest_ob);
      break;
    end
    
    #----------------------------------------------------------------------
  case 1.0  #we are on left lane
      #do something
      
  case -1.0  #we are on right lane
        #do something
        
  case "mid_to_left"
        #do something
        
  case "mid_to_right"
    #do something
    
  case "left_to_mid"
    #do something
    
  case "right_to_mid"
    #do something
    
  case "stop_planning"
    #do something
    
    
end