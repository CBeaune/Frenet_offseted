#check obstacle collision
function [bool_obstacle, closest_ob] = check_obstacle(c_x,c_y,yaw,local_plan,
  obstacle)
  SetParams;
  
  %if isempty(local_plan.x) ==1
    dist_to_obst = 1000;
   for ob = obstacle
     if (hypot(c_x-ob(1),c_y-ob(2))<dist_to_obst)
        
        dist_to_obst = hypot(c_x-ob(1),c_y-ob(2));
        closest_ob = ob;
      endif
      
   endfor
   
index = ClosestWp(c_x,c_y,wx,wy,yaw);
c_x = wx(index);
c_y = wy(index);
if index< length(wx)
  dx = wx(index+1)-wx(index);
  dy = wy(index+1)-wy(index);
  yaw = atan2(dy,dx);
  else
  dx = wx(index)-wx(index-1);
  dy = wy(index)-wy(index-1);
  yaw = atan2(dy,dx);
  endif
 
A_x = -l*cos(yaw)+h*sin(yaw)+c_x;
A_y = -l*sin(yaw)-h*cos(yaw)+c_y;

B_x = -l*cos(yaw)-h*sin(yaw)+c_x;
B_y = -l*sin(yaw)+h*cos(yaw)+c_y;

D_x = (l+L)*cos(yaw)+h*sin(yaw)+c_x;
D_y = (l+L)*sin(yaw)-h*cos(yaw)+c_y;

C_x = (L+l)*cos(yaw)-h*sin(yaw)+c_x;
C_y = (l+L)*sin(yaw)+h*cos(yaw)+c_y;

x = closest_ob(1)  ;
y = closest_ob(2) ; 



BM = [x - B_x ; y - B_y];
BC = [C_x - B_x ; C_y - B_y];
BA = [A_x - B_x; A_y - B_y ];


%yAB = (B_y - A_y)/(B_x-A_x)*closest_ob(1)+B_y-B_x*((B_y-A_y)/(B_x-A_x));
%yBC = (C_y - B_y)/(C_x-B_x)*closest_ob(1)+C_y-C_x*((C_y-B_y)/(C_x-B_x));
%yCD = (D_y - C_y)/(D_x-C_x)*closest_ob(1)+D_y-D_x*((D_y-C_y)/(D_x-C_x));
%yDA = (A_y - D_y)/(A_x-D_x)*closest_ob(1)+A_y-A_x*((A_y-D_y)/(A_x-D_x));

 
    if inpolygon(x,y,[A_x B_x C_x D_x],[A_y B_y C_y D_y])%%((0<=dot(BM,BC)<=dot(BC,BC))&&(0<=dot(BM,BA)<=dot(BA,BA)))
       %if(abs(x-c_x)<L && abs(y-c_y)<h)
       bool_obstacle = 1.0;
       return;
     endif
     

      bool_obstacle = 0.0;
      closest_ob = 0.0;
   
  

endfunction
