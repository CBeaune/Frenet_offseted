


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

start = plot(wx(1),wy(1),'ro','markerfacecolor','r');
goal = plot(wx(end),wy(end),'go','markerfacecolor','g');

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

  r = text (2, 2.5, ["max curvature is : 0"] );

################################################################################  
%-----Begin of the planning ----------------------------------------------------  
while hypot(c_x-wx(end),c_y-wy(end))>goal_tolerance
  
  
  %----- Compute local occupancy grid-------------------------------------------
  [M,N,gr] = makeGrid(wx,wy,obstacle,c_s,s_sample,d_sample,infl_dist_side,
  infl_dist_front,infl_dist_back,robot_radius);
  
  
  %----- use A* algorithm to pass the obstacle ---------------------------------
%  path = AStar(gr,c_d,M,N,d_sample,dmax);
%  
  path = AStar(gr,c_d,c_s,yaw,M,N,s_sample,d_sample,wx,wy,dmax,max_curvature);
  %path(3)
  
  %-----Convert from matrix index to Frenet coordinates-------------------------
  for i = 1:length(path)
     path(i,2) = -dmax+d_sample/2*(2*path(i,2)-1);
     path(i,1) = path(i,1)*s_sample+c_s;
  endfor
  test_path = path;
  local_plan = FrenetPath;
  
  
  %-----Smooth the path --------------------------------------------------------
%  sspline = c_s:0.03:c_s+2.0;
%  dspline = spline(path(:,1),path(:,2),sspline);
%  path = [ssplie

  path = PathSmoothing(path);
  sspline = path(1,1):n_s_local:path(end,1);
  dspline = spline(path(:,1),path(:,2),sspline);

  
  index = ceil(1/n_s_local*s_sample)+1;
  local_plan.s = sspline;
  c_s = local_plan.s(index);
  local_plan.d = -dspline;
  c_d = -local_plan.d(index);
  
% heading  =[];
%  for i=1:length(local_plan.d)-1
%    delta = atan2(-local_plan.d(i+1)+local_plan.d(i),local_plan.s(i+1)-...
%          local_plan.s(i));
%    NextWps = closest_wps(local_plan.s(i+1),local_plan.d(i+1),wx,wy);
%    PrevWps = closest_wps(local_plan.s(i),local_plan.d(i),wx,wy);
%    theta = atan2(wy(NextWps)-wy(PrevWps),wx(NextWps)-wx(PrevWps));
%    heading = [heading,delta+ theta];
%  endfor
%  
%  heading = [heading, heading(end)];
  
  
  %-----Compute from Frenet coordinates to Cartesian coordinates----------------
  local_plan = calc_global_path(local_plan,wx,wy);
%  local_plan.yaw = heading;
  c_x = local_plan.x(index);
  c_y = local_plan.y(index);
  yaw = local_plan.yaw(index); %heading(index);

 %-----Calc curvature for the local path --------------------------------------

  [curvature,vect] = calc_curvature(local_plan);
  local_plan.curv = curvature;
  %q = quiver(local_plan.x',local_plan.y',vect(:,1),vect(:,2));
  max_curv = max(local_plan.curv);
  
  
  %-----Plotting----------------------------------------------------------------
  
  delete(j);delete(k);delete(r);
  delete(AB);delete(B_C);delete(CD);delete(DA);
  t = linspace(0,2*pi,100)'; 
  circsx = robot_radius.*cos(t) + c_x; 
  circsy = robot_radius.*sin(t) + c_y; 
  k =  plot(circsx,circsy,'r'); 
  l = plot(c_x,c_y,'xr');
  hold on;

  j = plot(local_plan.x,local_plan.y,'r-o',"Linewidth",2,'markerfacecolor','r');

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
  legend([l j AB ob glob left right start goal],{...
      'center of robot at eachiteration','frenet local plan'...
      ,'security zone around robot','obstacles',"global trajectory",...
      "global trajectory with an offset to the left side",...
      "global trajectory with an offset to the right side", "start position"...
      "goal position"},'Location','southwest');
      

  title(['Local planning start ! Speed is ',num2str(linear_vel),...
    ' m/s', ' (speed display x', num2str(speed_display), ')'])    
   

  if max_curv>max_curvature 
    r = text (2, 2.5, ["max local curvature = ",num2str(max_curv),...
    " >  max curvature =  " ,num2str(max_curvature)],'Color', 'r' ); 
    
  else
    r = text (2, 2.5, ["max local curvature is : ",num2str(max_curv)] );

  endif

      
  
%  delete(q);

endwhile
################################################################################
 %-----End of the planning -----------------------------------------------------

text (2, 2, "GOAL REACHED !");