#set parameters of the problem

l = 0.5;
L = 1;
h = 0.210;


##c_x = 0.0 ;
##c_y = 0.0 ;
%c_s = 0.0 ;
%c_d = 0.0 ; 
SIM_LOOP = 70 ;

goal_tolerance = 0.105 ;

robot_radius = 0.105;


wx = 0.0:1:5 ;
wy = cos(1-wx/4); 
[wx,wy] = getGlobalPlan(wx,wy); 

obstacle = [  2 2.5 ;
              cos(1-2/4)+0.1  cos(1-2.5/4)-0.1] ;
             
           
%obstacle = [ 2  2  2;
%            cos(1-2/4) cos(1-2/4)-0.5  cos(1-2/4)+0.5] ;
