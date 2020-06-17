#go back global
function local_plan = go_back_global(prev_plan,closest_ob, wx,wy)
  local_plan = [];
  
  #spline interpolation
  [c_s,c_d] = getFrenet(prev_plan(1,end),prev_plan(2,end),wx,wy,0.0); 
 
  idx = ClosestWp(closest_ob(1)+2,prev_plan(2,end),wx,wy);
  [sf,df] = getFrenet(closest_ob(1)+2, wy(idx),wx,wy,0.0);
  sf = c_s + 1;
  df = 0.0;
  
  sspline = c_s:0.05:sf;
  S = [c_s,sf];
  
  D = [c_d,df];
  X=[];Y=[];
  
  
  dspline = spline(S,D,sspline);
  hold off;
  for i= 1:length(sspline)
    [x,y] = getCartesian(sspline(i),dspline(i),wx,wy);
    X = [X,x];
    Y = [Y,y];
    
  endfor
  
  local_plan = [X;Y];
  endfunction