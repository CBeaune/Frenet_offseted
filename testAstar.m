#test AStar Frenet coordinates
SetParams;
#Compute offseted trajectories
[wxl,wyl,wxr,wlr] = ComputeTraj(wx,wy);

gr=makeGrid(wx,wy,obstacle);
path = AStar(gr,0.0);
local_plan = FrenetPath;
xspline = 0.0:0.1:2;
yspline = spline(path(:,1),path(:,2),xspline);

local_plan.s = xspline;
local_plan.d = yspline;
local_plan = calc_global_path(local_plan,wx,wy);

plot(wx,wy,'b');
hold on;
plot(obstacle(1,:),obstacle(2,:),'ko');
hold on;
plot(local_plan.x,local_plan.y,'ro');