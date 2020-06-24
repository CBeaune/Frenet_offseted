


%-----Plotting------------------------------------------------------------------
ob = plot(obstacle(1,:),obstacle(2,:),'o','markersize',(robot_radius+...
    infl_dist_front)*28.35,'markerfacecolor','k','markeredgecolor','k');
    
[wxl,wyl,wxr,wyr] = ComputeTraj(wx,wy);

glob = plot(wx,wy,'b');
hold on;
right = plot(wxr,wyr,'c');
hold on;
left = plot(wxl,wyl,'g');
axis equal;

  A_x = -(infl_dist_back+robot_radius)*cos(yaw)+...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  A_y = -(infl_dist_back+robot_radius)*sin(yaw)-...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  B_x = -(infl_dist_back+robot_radius)*cos(yaw)-...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  B_y = -(infl_dist_back+robot_radius)*sin(yaw)+...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  C_x = (infl_dist_front+robot_radius)*cos(yaw)-...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  C_y = (infl_dist_front+robot_radius)*sin(yaw)+...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  D_x = (infl_dist_front+robot_radius)*cos(yaw)+...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  D_y = (infl_dist_front+robot_radius)*sin(yaw)-...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  AB = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "r");
  B_C = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "r");
  CD = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "r");
  DA = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "r");
  
  j = plot(0,0);
  k = plot(0,0);

################################################################################  

%-----Begin of the planning ----------------------------------------------------  
while hypot(c_x-wx(end),c_y-wy(end))>goal_tolerance
  
  %----- Compute local occupancy grid-------------------------------------------
  [M,N,gr] = makeGrid(wx,wy,obstacle,c_s,s_sample,d_sample,infl_dist_side,
  infl_dist_front,infl_dist_back,robot_radius);
  
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
  circsx = robot_radius.*cos(t) + c_x; 
  circsy = robot_radius.*sin(t) + c_y; 
  k =  plot(circsx,circsy,'r'); 
  l = plot(c_x,c_y,'xr');
  hold on;
  j = plot(local_plan.x,local_plan.y,'r-',"Linewidth",2);
  A_x = -(infl_dist_back+robot_radius)*cos(yaw)+...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  A_y = -(infl_dist_back+robot_radius)*sin(yaw)-...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  B_x = -(infl_dist_back+robot_radius)*cos(yaw)-...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  B_y = -(infl_dist_back+robot_radius)*sin(yaw)+...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  C_x = (infl_dist_front+robot_radius)*cos(yaw)-...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  C_y = (infl_dist_front+robot_radius)*sin(yaw)+...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  D_x = (infl_dist_front+robot_radius)*cos(yaw)+...
  (infl_dist_side+robot_radius)*sin(yaw)+c_x;
  D_y = (infl_dist_front+robot_radius)*sin(yaw)-...
  (infl_dist_side+robot_radius)*cos(yaw)+c_y;
  
  AB = line ([A_x B_x], [A_y B_y], "linestyle", "--", "color", "r");
  B_C = line ([B_x C_x], [B_y C_y], "linestyle", "--", "color", "r");
  CD = line ([C_x D_x], [C_y D_y], "linestyle", "--", "color", "r");
  DA = line ([D_x A_x], [D_y A_y], "linestyle", "--", "color", "r");
  
  hold on;
  legend([l j AB ob glob left right],{...
      'center of robot at eachiteration','frenet local plan'...
      ,'security zone around robot','obstacles',"global trajectory",...
      "global trajectory with an offset to the left side",...
      "global trajectory with an offset to the right side"},'Location',...
      'southwest');
      
  title(['Local planning start ! Speed is ',num2str(linear_vel),...
    ' m/s', ' (speed display x', num2str(speed_display), ')'])    
      
  pause(0.2/(speed_display*linear_vel));
endwhile
################################################################################
%-----End of the planning ------------------------------------------------------

text (2, 2, "GOAL REACHED !");