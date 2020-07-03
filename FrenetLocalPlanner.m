

K=[];
%-----Plotting------------------------------------------------------------------
if plot_type == "F"
  ob = plot(obstacle(1,:),obstacle(2,:),'o','markersize',(robot_radius+...
      infl_dist_front)*28.35,'markerfacecolor','k','markeredgecolor','k');
      
  [wxl,wyl,wxr,wyr] = ComputeTraj(wx,wy);
  
  X=[];
  Y=[];
  
  glob = plot(wx,wy,'b');
  hold on;
  right = plot(wxr,wyr,'c');
  hold on;
  left = plot(wxl,wyl,'g');
  axis equal;
  hold on;
  start = plot(wx(1),wy(1),'ro','markerfacecolor','r');
  goal = plot(wx(end),wy(end),'go','markerfacecolor','g');
  hold on
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
endif

################################################################################  
%-----Begin of the planning ----------------------------------------------------  
reroute =0;
while hypot(c_x-wx(end),c_y-wy(end))>goal_tolerance && reroute~=1
  
  
  %----- Compute local occupancy grid-------------------------------------------
  [M,N,gr] = makeGrid(wx,wy,obstacle,c_s,s_sample,d_sample,infl_dist_side,
  infl_dist_front,infl_dist_back,robot_radius);
  curv = calc_curvature(wx,wy);
  

    
  
  %----- use A* algorithm to pass the obstacle ---------------------------------
%  path = AStar(gr,c_d,M,N,d_sample,dmax);
%  

%for offset =0:8;
offset=0;
 path = AStar(gr,c_d,c_s,M,N,s_sample,d_sample,wx,wy,dmax,curv,plot_type,...
      curv_weight,mod(offset+8,9)-8);  
      
  %-----Convert from matrix index to Frenet coordinates-------------------------
  for i = 1:length(path)
     path(i,2) = -dmax+d_sample/2*(2*path(i,2)-1);
     path(i,1) = path(i,1)*s_sample+c_s;
  endfor
  test_path = path;
  local_plan = FrenetPath;
  if length(path)==0
    continue
  endif
  
  
  
  %-----Smooth the path --------------------------------------------------------

  path = PathSmoothing(path);
  sspline = path(1,1):n_s_local:path(end,1);
  dspline = spline(path(:,1),path(:,2),sspline);

  
  index = ceil(1/n_s_local*s_sample)+1;
  local_plan.s = sspline;
  c_s = local_plan.s(index);
  local_plan.d = dspline;
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
 % X = [X,c_x];
  c_y = local_plan.y(index);
  %Y = [Y,c_y];
  yaw = local_plan.yaw(index); %heading(index);

 %-----Calc curvature for the local path --------------------------------------

  curvature = calc_curvature(local_plan.x,local_plan.y);
  local_plan.curv = curvature;
  %q = quiver(local_plan.x',local_plan.y',vect(:,1),vect(:,2));
  
  max_curv = max(abs(local_plan.curv));
  K = [K;max_curv];
%if max_curv<max_curvature
%  break;
%  
%endif
%
%if offset == 8
%  reroute=1;
%endif
%
%endfor

%  %-----Plotting----------------------------------------------------------------

if plot_type == "F" &&reroute~=1
  delete(j);
  delete(k);
  delete(r);
  hold on;
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
  
%  legend([l j AB ob glob left right start goal],{...
%      'center of robot at eachiteration','frenet local plan'...
%      ,'security zone around robot','obstacles',"global trajectory",...
%      "global trajectory with an offset to the left side",...
%      "global trajectory with an offset to the right side", "start position"...
%      "goal position"},'Location','southwest');
      

  title(['Local planning start ! Speed is ',num2str(linear_vel),...
    ' m/s', ' (speed display x', num2str(speed_display), ')'])    
   

  if abs(max_curv)>max_curvature 
    r = text (2, 2.5, ["max local curvature = ",num2str(max_curv),...
    " >  max curvature =  " ,num2str(max_curvature),"    offset is : ",...
    num2str(offset)],'Color', 'r' ); 
    
  else
    r = text (2, 2.5, ["max local curvature is : ",num2str(max_curv),"    offset is : ",...
    num2str(offset)] );

  endif

  hold on;
  pause(0.05);

endif
  %K = [K, max_curv];



endwhile
if reroute ==1
  text(2, 2, "No feasible trajectory found");
else
   %-----End of the planning -----------------------------------------------------

text (2, 2, "GOAL REACHED !");
disp("goal reached !");
figure(2)
plot(K,"ro-");
title(["max curvature with curv weight = ",num2str(curv_weight)]);
endif

################################################################################
