##follow global plan
function [local_plan,sp,sp2]= calc_frenet_path(c_s,c_d, bool_collision,sp,sp2,
  n_lane)


  s0 = c_s;
  sf = s0+sqrt(2);
  local_plan = FrenetPath;
  local_plan.s = s0:0.1:sf;
  df = 0.5*n_lane; %put in a param file
  
  
  if bool_collision == 0  
    if abs(c_d)<0.01
      local_plan.d = zeros(1,length(local_plan.s));
      sp = [];
      sp2 = [];
    elseif isempty(sp2)==1 
      df = 0;
      sp2 = spline([s0,s0+0.1,sf,sf+0.1],[c_d,c_d-0.01,df,df],local_plan.s);
      local_plan.d = sp2;
    else  #already a local plan that has been computed --> just 
    #follow offset
    [val,index] = min(abs(sp2-c_d));
    df = sp2(end);
    #get previous plan
    local_plan.d = sp2(index : end); 
    #add new endpoints
      while length(local_plan.d)<length(local_plan.s)
        local_plan.d = [local_plan.d,df];
      endwhile
    endif
    
  
else
  
  if isempty(sp) == 0   #already a local plan that has been computed --> just 
    [val,index] = min(abs(sp-c_d));
    df = sp(end);
    #get previous plan
    local_plan.d = sp(index : end); 
    #add new endpoints
    
    
    while length(local_plan.d)<length(local_plan.s)
      local_plan.d = [local_plan.d,df];
    endwhile
    
    
  else  ##calc new local plan avoiding obstacles
    df = 0.5*n_lane;
    sp = spline([s0,s0+0.1,sf,sf+0.1,sf+0.2,sf+0.3],[c_d,c_d+0.01,df,df,df,df],local_plan.s);
    local_plan.d = sp;
    
  endif
  
  endif
endfunction
