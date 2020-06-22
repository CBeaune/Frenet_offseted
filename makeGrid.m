#make occupancy grid based on Frenet coordinates

function gr=makeGrid(wx,wy,obstacle)
  ds = 0.1;
  s_hor = 2.0;
  dmax = 0.5;
  dd = 0.25;
  M = s_hor/ds;
  N = (dmax+dd)/dd;
  gr = zeros(M,N);
  for obst = obstacle 
    [s,d] = getFrenet(obst(1),obst(2),wx,wy,0.0)
    
    i = floor((d+dmax)/dd);
    j = floor(s/ds)+1;
    if (1<=i && i<=N && 1<=j && j<=M)
      gr(j,i)=inf;
    endif
    
  endfor
  

%  plot(gr,'x')
%  grid on;
%  xlim([0 2])
%  set(xticks , 0:0.1:2);
%  ylim([-0.75 0.75])
%  yticks = -0.75:0.5:0.75;
  
endfunction