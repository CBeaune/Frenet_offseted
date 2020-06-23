#test AStar Frenet coordinates

SetParams;

%-----Compute offseted trajectories---------------------------------------------
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);
hold on;
c_s = 0.0;
c_d = 0.0;
c_x = 0.0;
c_y = 0.0;
yaw = 0.0;
SIM_TIME = 20;
ctr=0;
s_sample = 0.1;
d_sample = 0.1; % max d_sample = 0.5 si on a mis les offsets à 0.5m
dmax = 0.75;    % d_max = 0.75 si on a mis les offsets à 0.5m

%-----Plotting------------------------------------------------------------------
plot(obstacle(1,:),obstacle(2,:),'ko');

  A_x = -2*s_sample*cos(yaw)+robot_radius*sin(yaw)+c_x;
  A_y = -2*s_sample*sin(yaw)-robot_radius*cos(yaw)+c_y;
  
  B_x = -2*s_sample*cos(yaw)-robot_radius*sin(yaw)+c_x;
  B_y = -2*s_sample*sin(yaw)+robot_radius*cos(yaw)+c_y;
  
  C_x = 6*s_sample*cos(yaw)-robot_radius*sin(yaw)+c_x;
  C_y = 6*s_sample*sin(yaw)+robot_radius*cos(yaw)+c_y;
  
  D_x = 6*s_sample*cos(yaw)+robot_radius*sin(yaw)+c_x;
  D_y = 6*s_sample*sin(yaw)-robot_radius*cos(yaw)+c_y;
  
  AB = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "r");
  B_C = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "r");
  CD = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "r");
  DA = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "r");
  
  j = plot(0,0);
  k = plot(0,0);

################################################################################  

%-----Begin of the planning ----------------------------------------------------  
while hypot(c_x-wx(end),c_y-wy(end))>0.2
  
  %----- Compute local occupancy grid-------------------------------------------
  [M,N,gr] = makeGrid(wx,wy,obstacle,c_s,s_sample,d_sample);
  %----- use A* algorithm to pass the obstacle ---------------------------------
  path = AStar(gr,c_d,M,N,d_sample,dmax);
  
  %-----Convert from matrix index to Frenet coordinates-------------------------
  for i = 1:length(path)
     path(i,2) = -dmax+d_sample/2*(2*path(i,2)-1);
     path(i,1) = path(i,1)*s_sample+c_s;
  endfor
  
  local_plan = FrenetPath;
  
  %-----Smooth the path --------------------------------------------------------
%  sspline = c_s:0.03:c_s+2.0;
%  dspline = spline(path(:,1),path(:,2),sspline);
%  path = [ssplie
  path = PathSmoothing(path);
  sspline = path(1,1):s_sample:path(end,1);
  dspline = spline(path(:,1),path(:,2),sspline);
  
  
  local_plan.s = sspline;
  c_s = local_plan.s(2);
  local_plan.d = -dspline;
  c_d = -local_plan.d(2);
  
  %-----Compute from Frenet coordinates to Cartesian coordinates----------------
  local_plan = calc_global_path(local_plan,wx,wy);
  c_x = local_plan.x(2);
  c_y = local_plan.y(2);
  yaw = local_plan.yaw(2);
  
  %-----Plotting----------------------------------------------------------------
  
  delete(j);delete(k);
  delete(AB);delete(B_C);delete(CD);delete(DA);
  t = linspace(0,2*pi,100)'; 
  circsx = 0.105.*cos(t) + c_x; 
  circsy = 0.105.*sin(t) + c_y; 
  k =  plot(circsx,circsy,'r'); 
  plot(c_x,c_y,'xr');
  hold on;
  j = plot(local_plan.x,local_plan.y,'r-',"Linewidth",2);
  A_x = -2*s_sample*cos(yaw)+robot_radius*sin(yaw)+c_x;
  A_y = -2*s_sample*sin(yaw)-robot_radius*cos(yaw)+c_y;
  
  B_x = -2*s_sample*cos(yaw)-robot_radius*sin(yaw)+c_x;
  B_y = -2*s_sample*sin(yaw)+robot_radius*cos(yaw)+c_y;
  
  C_x = 6*s_sample*cos(yaw)-robot_radius*sin(yaw)+c_x;
  C_y = 6*s_sample*sin(yaw)+robot_radius*cos(yaw)+c_y;
  
  D_x = 6*s_sample*cos(yaw)+robot_radius*sin(yaw)+c_x;
  D_y = 6*s_sample*sin(yaw)-robot_radius*cos(yaw)+c_y;
  
  AB = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "r");
  B_C = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "r");
  CD = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "r");
  DA = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "r");
  
  hold on;

  pause(0.05);
endwhile
################################################################################
%-----End of the planning ------------------------------------------------------

text (2, 0, "GOAL REACHED !");