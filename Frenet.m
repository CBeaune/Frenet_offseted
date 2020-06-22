####Frenet 2nd version 
clear all;
close all;

#get parameters 
SetParams;
n_lane = 0.0;
frenet_plan = FrenetPath;

yaw = 0.0;
c_s = 0.0;
c_d = 0.0;

[c_x,c_y] = getCartesian(c_s,c_d,wx,wy);

n_lane =0.0;
stop_plan = 0.0;
follow_offset = 0.0;
plot(obstacle(1,:),obstacle(2,:),'ko');
hold on;

local_plan = FrenetPath;

#Compute offseted trajectories
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);

#Compute security zones
index = ClosestWp(c_x,c_y,wx,wy,yaw);
x = wx(index);
y = wy(index);
if index< length(wx)
  dx = wx(index+1)-wx(index);
  dy = wy(index+1)-wy(index);
  yaw0 = atan2(dy,dx);
  else
  dx = wx(index)-wx(index-1);
  dy = wy(index)-wy(index-1);
  yaw0 = atan2(dy,dx);
  endif



A_x = -l*cos(yaw0)+h*sin(yaw0)+x;
A_y = -l*sin(yaw0)-h*cos(yaw0)+y;

B_x = -l*cos(yaw0)-h*sin(yaw0)+x;
B_y = -l*sin(yaw0)+h*cos(yaw0)+y;

C_x = (l+L)*cos(yaw0)-h*sin(yaw0)+x;
C_y = (l+L)*sin(yaw0)+h*cos(yaw0)+y;

D_x = (l+L)*cos(yaw0)+h*sin(yaw0)+x;
D_y = (l+L)*sin(yaw0)-h*cos(yaw0)+y;

AB0 = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "k");
B_C0 = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "k");
CD0 = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "k");
DA0 = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "k");

hold on;

A_x = -l*cos(yaw)+h*sin(yaw)+c_x;
A_y = -l*sin(yaw)-h*cos(yaw)+c_y;

B_x = -l*cos(yaw)-h*sin(yaw)+c_x;
B_y = -l*sin(yaw)+h*cos(yaw)+c_y;

C_x = (l+L)*cos(yaw)-h*sin(yaw)+c_x;
C_y = (l+L)*sin(yaw)+h*cos(yaw)+c_y;

D_x = (l+L)*cos(yaw)+h*sin(yaw)+c_x;
D_y = (l+L)*sin(yaw)-h*cos(yaw)+c_y;

AB = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "r");
B_C = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "r");
CD = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "r");
DA = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "r");

hold on;
j = plot(local_plan.x,local_plan.y);

while (hypot(c_x-wx(end),c_y-wy(end))>0.105 && !stop_plan)
 delete(j);
delete(AB0);delete(B_C0);delete(CD0);delete(DA0);
delete(AB);delete(B_C);delete(CD);delete(DA);

#Compute security zones
index = ClosestWp(c_x,c_y,wx,wy,yaw);
x = wx(index);
y = wy(index);
if index< length(wx)
  dx = wx(index+1)-wx(index);
  dy = wy(index+1)-wy(index);
  yaw0 = atan2(dy,dx);
  else
  dx = wx(index)-wx(index-1);
  dy = wy(index)-wy(index-1);
  yaw0 = atan2(dy,dx);
  endif



A_x = -l*cos(yaw0)+h*sin(yaw0)+x;
A_y = -l*sin(yaw0)-h*cos(yaw0)+y;

B_x = -l*cos(yaw0)-h*sin(yaw0)+x;
B_y = -l*sin(yaw0)+h*cos(yaw0)+y;

C_x = (l+L)*cos(yaw0)-h*sin(yaw0)+x;
C_y = (l+L)*sin(yaw0)+h*cos(yaw0)+y;

D_x = (l+L)*cos(yaw0)+h*sin(yaw0)+x;
D_y = (l+L)*sin(yaw0)-h*cos(yaw0)+y;

AB0 = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "k");
B_C0 = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "k");
CD0 = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "k");
DA0 = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "k");

hold on;

A_x = -l*cos(yaw)+h*sin(yaw)+c_x;
A_y = -l*sin(yaw)-h*cos(yaw)+c_y;

B_x = -l*cos(yaw)-h*sin(yaw)+c_x;
B_y = -l*sin(yaw)+h*cos(yaw)+c_y;

C_x = (l+L)*cos(yaw)-h*sin(yaw)+c_x;
C_y = (l+L)*sin(yaw)+h*cos(yaw)+c_y;

D_x = (l+L)*cos(yaw)+h*sin(yaw)+c_x;
D_y = (l+L)*sin(yaw)-h*cos(yaw)+c_y;

AB = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "r");
B_C = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "r");
CD = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "r");
DA = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "r");

hold on;


t = linspace(
0,2*pi,100)'; 
circsx = 0.105.*cos(t) + c_x; 
circsy = 0.105.*sin(t) + c_y; 
k =  plot(circsx,circsy,'r'); 
plot(c_x,c_y,'xr');
j = plot(local_plan.x,local_plan.y,'r',"Linewidth",2);


[bool_obstacle,closest_ob] = check_obstacle_global(c_s,c_x,c_y,yaw,local_plan,obstacle);

[n_lane,stop_plan] = choose_lane(c_d,closest_ob,wx,wy,n_lane);
 %tic();
[local_plan,local_plan.sp,local_plan.sp2] = calc_frenet_path(c_s,c_d,
    bool_obstacle,local_plan.sp,local_plan.sp2,n_lane);
stop_planning = check_obstacle_local(c_x,c_y,yaw,obstacle,closest_ob,n_lane);
if stop_planning == 1.0
  text (2, 0, "local plan stopped due to collisions conflicts");
  return;
endif

local_plan = calc_global_path(local_plan,wx,wy);

%toc();

c_x = local_plan.x(2);
c_y = local_plan.y(2);
yaw = local_plan.yaw(2);
c_s = local_plan.s(2);
c_d = local_plan.d(2);
%delete(j);
delete(k);
pause(0.1)





endwhile
%delete(p);

t = linspace(0,2*pi,100)'; 
circsx = 0.105.*cos(t) + wx(end); 
circsy = 0.105.*sin(t) + wy(end); 
 plot(circsx,circsy,'g'); 
 t = linspace(0,2*pi,100)'; 
%circsx = 0.105.*cos(t) + c_x; 
%circsy = 0.105.*sin(t) + c_y; 
% plot(circsx,circsy,'r');
% plot(c_x,c_y,'rx');


