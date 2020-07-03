function local_plan = calc_global_path(local_plan,wx,wy)
  maps_s = [0.0];
  for i=1:length(wx)-1
    si  = maps_s(i)+hypot(wx(i+1)-wx(i),wy(i+1)-wy(i));
    maps_s = [maps_s, si];
  endfor
  
  
  for i=1:length(local_plan.s)-1
    
    if local_plan.s(i)>maps_s(end)
      %disp("too long");
      break;
    endif
    
    [x,y,heading] = getCartesian(local_plan.s(i),local_plan.d(i),wx,wy);
    local_plan.x = [local_plan.x, x];
    local_plan.y = [local_plan.y, y];
  endfor
  
  for i=1:length(local_plan.x)-1
    dx = local_plan.x(i+1)-local_plan.x(i);
    dy = local_plan.y(i+1)-local_plan.y(i);
    yaw = atan2(dy,dx);
    local_plan.yaw = [local_plan.yaw, yaw];
    
  endfor
  
  yaw = local_plan.yaw(end);
  local_plan.yaw = [local_plan.yaw, yaw];
  
  
  
  
  endfunction