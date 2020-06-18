function [n_lane,stop_plan] = choose_lane(c_d,obstacle,wx,wy,n_lane)
  stop_plan = 0.0;
  if obstacle == 0.0
    n_lane =0.0;
    return;
  endif
  
  
  [~,d_obst] = getFrenet(obstacle(1),obstacle(2),wx,wy,0.0);
  prev_n_lane = n_lane;
  if d_obst<c_d
    n_lane = -1;
  else
    n_lane = 1;
  endif
  
%  if prev_n_lane == -n_lane
%    stop_plan = 1.0;
%    return;
% 
%  endif
  
    
  
  endfunction