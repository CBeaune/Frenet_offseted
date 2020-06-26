#set parameters of the problem

%------- Set robot intrinsic parameters ----------------------------------------

linear_vel = 0.22;      %linear velocity of the robot (m/s)
robot_radius = 0.105;   % radius (m)
max_curvature = 5.0;    % max curvature (1/m)

%------- Set global trajectory -------------------------------------------------

wx = 0.0:1:5 ;                      %cartesian x coordinates (m)
wy = cos(1-wx/4);                   %cartesian y coordinates (m)
[wx,wy] = getGlobalPlan(wx,wy);     % compute a waypoint every ds = 0.1m


%------- Initial pose and Frenet coordinates -----------------------------------

c_x = wx(1);                                 %set x_init (m)
c_y = wy(1);                                 %set y_init (m)
yaw = 0.0;                                   %set yaw_init (rad)
[c_s,c_d] = getFrenet(c_x,c_y,wx,wy,yaw) ;   %compute Frenet coordinates of pose


%------- Set Goal Tolerance ----------------------------------------------------

goal_tolerance = 0.105 ;     %set goal_tolerance (m)


%------- Set occupancy grid  ---------------------------------------------------

s_sample = 0.1;              % set size of horizontal cells
d_sample = 0.1;              % set size of vertical cells
dmax = 0.75;                 % d_max = 0.75 si on a mis les offsets à 0.5m


%------- Set inflation distance parameters -------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           infl_dist_front                                                
%               <-------->                                                 
%    ---------------------  ^
%    |                   |  | 
%    |       |           |  | infl_dist_side
%    |     --x--         |  
%    |       |           |
%    |                   |
%    ---------------------
%    <---->
%  infl_dist_back
%
% x is the center of the robot with a radius called "robot_radius"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


infl_dist_side = 0.08; 
             %dist to obstacle from side should be robot_radius+infl_dist_side
infl_dist_front = 0.1;
             %dist to obstacle from front should be robot_radius+infl_dist_front
infl_dist_back = 0.1; 
             %dist to obstacle from back should be robot_radius+infl_dist_back
n_s_local = s_sample/2 ;
             %interval between two values in local plan             
               
%------- Set obstacles along the global trajectory -----------------------------


obstacle = [1 1.1 1.2 4 ;                           
            cos(1-1/4)-0.1  cos(1-1.1/4) cos(1-1.2/4) cos(1-4/4)+0.1] ;  
            
            
%------- Plotting parameters ---------------------------------------------------

speed_display = 4;
