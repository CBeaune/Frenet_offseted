function k = calc_curvature(x,y)
%  k = [0.0];
%  for i=2:length(x)-1
%    
%    X0 = [x(i-1),y(i-1),0.0];
%    X1 = [x(i),y(i),0.0];
%    X2 = [x(i+1),y(i+1),0.0];
%    
%%    X = [local_plan.x',local_plan.y'];
%%    [L,R,curv] = curvature(X);
%%    k =[k, hypot(curv(i,1),curv(i,2)) ];
%    R = circumcenter(X0,X1,X2);
%
%%  
%%    ds = local_plan.s(i+1)-local_plan.s(i);
%%    dalpha = local_plan.yaw(i+1)-local_plan.yaw(i);
%%    if dalpha>pi/2
%%      dalpha-=pi;
%%    elseif dalpha<-pi/2
%%      dalpha+=pi;
%%
%%    endif
%%    
%    k = [k, 1/R];
%  endfor
%  k = [k,k(end)];
Dx = gradient(x,0.1);
Dy = gradient(y,0.1);
Dx_2 = gradient(Dx);
Dy_2 = gradient(Dy);
k = sqrt(Dx_2.^2+Dy_2.^2);
  
endfunction

