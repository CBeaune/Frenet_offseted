#test curvature
close all;
clear all;

x = 0.0:0.1:6 ;                      %cartesian x coordinates (m)
y = cos(1-x/2);  

X = [x',y'];

[L,R,k] = curvature(X);
curv =[];

figure;
h = plot(x,y); grid on; axis equal
set(h,'marker','.');
xlabel x
ylabel y
title('2D curve with curvature vectors')
hold on
quiver(x',y',k(:,1),k(:,2));
hold on;


#Compute line for our trajectory
x_start = x(1) ;
y_start = y(1) ;
x_goal = x(end);
y_goal =  y(end);
ds= 0.1;
N=sqrt((x_goal-x_start)**2+(y_goal-y_start)**2)/ds;
dx = (-x_start+x_goal)/N;
dy = (-y_start+y_goal)/N;
wx =[x_start];
wy = [y_start];

for i=2:N+1
  wx = [wx, wx(i-1)+dx];
  wy = [wy, wy(i-1)+dy];
endfor


wx = [wx,x_goal];
wy = [wy,y_goal];
  
plot(wx,wy,'r-.');


#Calc Frenet coordinates and calc derivate
theta = [];
for i = 1 : length(x)-1
  theta = [theta, atan2(y(i+1)-y(i),x(i+1)-x(i))];
endfor
theta = [theta, theta(end)];
S=[];D=[];
%for i = 1 : length(x)-1
%  [s,d] = getFrenet(x(i),y(i), wx,wy,theta(i));
%  S = [S,s];
%  D = [D,d];
%endfor

d_to_glob =[];
for i=2:length(x)-1
  [s_1,d_1] = getFrenet(x(i-1),y(i-1), wx,wy,theta(i));
  [s0,d0] = getFrenet(x(i),y(i), wx,wy,theta(i));
  [s1,d1] = getFrenet(x(i+1),y(i+1), wx, wy,theta(i));
  d_to_glob = [d_to_glob, d0-(d1-d_1)];
endfor

figure;
for i=2:length(R)-1
  curv = [curv,(1/(R(i)))];
endfor
plot(curv,'r-o')
title('Curvature radius (in red) vs. dd/ds (in blue)')
xlabel waypoints

hold on;
plot(d_to_glob,'b-o');

%figure;
%%plot(curv,dd_ds,'r-o');
%hold on ;
%plot(dd_ds-curv);
