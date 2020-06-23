#make occupancy grid based on Frenet coordinates

function [M,N,gr]=makeGrid(wx,wy,obstacle,c_s,s_sample,d_sample)
  ds = s_sample;
  s_hor = 2.0;
  dmax = 0.75;
  dd = d_sample/2;
  M = s_hor/ds;
  N = (dmax)/dd;
  
  nb = -dmax:d_sample:dmax;
  
  gr = zeros(M,N);
  for obst = obstacle 
    %Convert from Frenet to matrix index
    [s,d] = getFrenet(obst(1),obst(2),wx,wy,0.0);
    for index = 1:length(nb)-1
      if nb(index) <= d && d<= nb(index+1)
        j = index;
        continue;
      endif
      

    endfor
    
    
    k = floor((s-c_s)/ds)+1;
    if (1<=j && j<=N && 1<=k && k<=M)
      for n=k-6:k+2
        for m = j-2:j+2   %can be put in a variable as dist_inflation
          if (n<1||n>N||m<1||m>M)
                continue
            endif
          gr(n,m) =  inf; 
        endfor
      endfor
      
    endif
    
  endfor
  

%  plot(gr,'x')
%  grid on;
%  xlim([0 2])
%  set(xticks , 0:0.1:2);
%  ylim([-0.75 0.75])
%  yticks = -0.75:0.5:0.75;
  
endfunction