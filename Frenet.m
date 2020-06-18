####Frenet 2nd version 
clear all;
close all;

#get parameters 
SetParams;
n_lane = 0.0;
frenet_plan = FrenetPath;
c_x = 0.0;
c_y = 0.0;
yaw = 0.0;
c_s = 0.0;
c_d = 0.0;


n_lane =0.0;
stop_plan = 0.0;
plot(obstacle(1,:),obstacle(2,:),'ko');
hold on;

local_plan = FrenetPath;

#Compute offseted trajectories
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);
t = linspace(0,2*pi,100)'; 
circsx = 0.5.*cos(t) + c_x; 
circsy = 0.5.*sin(t) + c_y; 
p = plot(circsx,circsy,'k--'); 
 
while (hypot(c_x-wx(end),c_y-wy(end))>0.105 && !stop_plan)
 
 delete(p);
  circsx = 0.5.*cos(t) + c_x; 
  circsy = 0.5.*sin(t) + c_y; 
  p = plot(circsx,circsy,'k--');

j = plot(local_plan.x,local_plan.y,'r--');

t = linspace(0,2*pi,100)'; 
circsx = 0.105.*cos(t) + c_x; 
circsy = 0.105.*sin(t) + c_y; 
k =  plot(circsx,circsy,'r'); 
plot(c_x,c_y,'xr');
[bool_obstacle,closest_ob] = check_obstacle(c_x,c_y,local_plan,obstacle);
[n_lane,stop_plan] = choose_lane(c_d,closest_ob,wx,wy,n_lane);
 %tic();
[local_plan,local_plan.sp,local_plan.sp2] = calc_frenet_path(c_s,c_d,
    bool_obstacle,local_plan.sp,local_plan.sp2,n_lane);
local_plan = calc_global_path(local_plan,wx,wy);
%toc();

c_x = local_plan.x(2);
c_y = local_plan.y(2);
c_s = local_plan.s(2);
c_d = local_plan.d(2);
pause(0.01)
delete(j);
delete(k)





endwhile
delete(p);

t = linspace(0,2*pi,100)'; 
circsx = 0.105.*cos(t) + wx(end); 
circsy = 0.105.*sin(t) + wy(end); 
 plot(circsx,circsy,'g'); 
 t = linspace(0,2*pi,100)'; 
circsx = 0.105.*cos(t) + c_x; 
circsy = 0.105.*sin(t) + c_y; 
 plot(circsx,circsy,'r');
 plot(c_x,c_y,'rx');
 circsx = 0.5.*cos(t) + c_x; 
  circsy = 0.5.*sin(t) + c_y; 
  p = plot(circsx,circsy,'k--');