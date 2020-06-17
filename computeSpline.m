function [X,Y] = computeSpline(c_x,c_y,wx,wy,closest_ob)
  local_plan = [];
  #spline interpolation
  [c_s,c_d] = getFrenet(c_x,c_y,wx,wy,0.0);
  [s1 , d1] = getFrenet(closest_ob(1),closest_ob(2),wx,wy,0.0);

  if d1<0
    d1=-1;
  else
    d1=1;
  endif
  
  
  
  
%  idx = ClosestWp(closest_ob(1)+2,c_y,wx,wy)
%  [sf,df] = getFrenet(closest_ob(1)+2, wy(idx),wx,wy,0.0);
%  df = 0.0;
  
  sspline = c_s:0.05:s1;
  S = [c_s,c_s+0.1,s1,s1+0.1];
  
  D = [c_d,c_d,d1,d1];
  X=[];Y=[];
  
  
  dspline = spline(S,D,sspline);
  for i= 1:length(sspline)
    [x,y] = getCartesian(sspline(i),dspline(i),wx,wy);
    X = [X,x];
    Y = [Y,y];
    
  endfor
  

endfunction