#check obstacle collision
function [bool_obstacle, closest_ob] = check_obstacle(c_x,c_y,obstacle)
  SetParams;
  for ob = obstacle
    if ((0<=ob(1)-c_x<=8) | (0<=c_x - ob(1)<= 2)) & abs(ob(2)-c_y )<2 
      bool_obstacle = 1.0;
      closest_ob = ob;
      break;
    else
      bool_obstacle = 0.0;
      endif
    endfor
  
endfunction
