#set parameters of the problem


##c_x = 0.0 ;
##c_y = 0.0 ;
%c_s = 0.0 ;
%c_d = 0.0 ; 
SIM_LOOP = 70 ;

goal_tolerance = 0.105 ;

robot_radius = 0.105;

wx = 0.0:0.1:5.0 ;
wy = cos(wx/4+pi/2) ; 

obstacle = [ 1 ;
             cos(1/4+pi/2)] ;
