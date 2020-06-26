
function k = calc_curvature(local_plan)
  k = [];
  for i=1:length(local_plan.x)-1

    ds = local_plan.s(i+1)-local_plan.s(i);
    dalpha = local_plan.yaw(i+1)-local_plan.yaw(i);
    if dalpha>pi/2
      dalpha-=pi;
    elseif dalpha<-pi/2
      dalpha+=pi;
    endif
    
    k = [k, dalpha/ds];
  endfor
  
endfunction

