function k = calc_curvature(local_plan)
  k = [];
  for i=2:length(local_plan.x)-1
    
    X0 = [local_plan.x(i-1),local_plan.y(i-1),0.0];
    X1 = [local_plan.x(i),local_plan.y(i),0.0];
    X2 = [local_plan.x(i+1),local_plan.y(i+1),0.0];
    
    R = circumcenter(X0,X1,X2);
    k =[k, 1/R];

  
%    ds = local_plan.s(i+1)-local_plan.s(i);
%    dalpha = local_plan.yaw(i+1)-local_plan.yaw(i);
%    if dalpha>pi/2
%      dalpha-=pi;
%    elseif dalpha<-pi/2
%      dalpha+=pi;
%
%    endif
%    
%    k = [k, dalpha/ds];
  endfor
  
endfunction

