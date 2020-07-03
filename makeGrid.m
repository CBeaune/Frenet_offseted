#make occupancy grid based on Frenet coordinates

function [M,N,gr]=makeGrid(wx,wy,obstacle,c_s,s_sample,d_sample,infl_dist_side,
  infl_dist_front,infl_dist_back,robot_radius)
  
  ds = s_sample;
  s_hor = 2.0;
  dmax = 0.75;
  dd = d_sample/2;
  M = s_hor/ds;
  N = (dmax)/dd;
  
  n_infl_side = ceil((infl_dist_side+robot_radius)/d_sample);
  n_infl_front = ceil((infl_dist_front+robot_radius)/ds);
  n_infl_back = ceil((infl_dist_back+robot_radius)/ds);
  
  nb = -dmax:d_sample:dmax;
  
%   size(theta)
   gr = zeros(M,N);
  %gr = zeros(M,N);
  for obst = obstacle 
    %Convert from Frenet to matrix index
    [s_obst,d_obst] = getFrenet(obst(1),obst(2),wx,wy,0.0);
    if abs(d_obst)>dmax
      continue
    endif
    
    for index = 1:length(nb)-1
      if nb(index) <= d_obst && d_obst<= nb(index+1)
        y = index;
        continue;
      endif
      

    endfor
    
    
    x = floor((s_obst-c_s)/ds)+1;
    if (1<=y && y<=N && 1<=x && x<=M)
      
      gr(x,y) =  inf; 
      for d = y-n_infl_side:y+n_infl_side
        for s = x-n_infl_front:x+n_infl_back  
          if (d<1||d>N||s<1||s>M)
                continue
              else
                gr(s,d) =  inf; 
            endif
          
        endfor
      endfor
      
    endif
    
  endfor
 
% gr =gr

%  plot(gr,'x')
%  grid on;
%  xlim([0 2])
%  set(xticks , 0:0.1:2);
%  ylim([-0.75 0.75])
%  yticks = -0.75:0.5:0.75;
  
endfunction