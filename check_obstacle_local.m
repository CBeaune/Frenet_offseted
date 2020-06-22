

function stop_planning = check_obstacle_local(c_x,c_y,yaw,obstacle,closest_ob,n_lane)
  if n_lane != 0.0
    dist_to_obst = 1000;
    [i,j] = find(obstacle==closest_ob);
    obstacle(i(1),j(1))=1000;
    obstacle(i(2),j(2))=1000;
    for ob = obstacle
      if (hypot(c_x-ob(1),c_y-ob(2))<dist_to_obst)
        
          dist_to_obst = hypot(c_x-ob(1),c_y-ob(2));
          closest_ob = ob;
        endif
      
    endfor
   
l = 0.5;
L = 1;
h = 0.210;

 
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
      
    if inpolygon(x,y,[A_x B_x C_x D_x],[A_y B_y C_y D_y])%%((0<=dot(BM,BC)<=dot(BC,BC))&&(0<=dot(BM,BA)<=dot(BA,BA)))
       %if(abs(x-c_x)<L && abs(y-c_y)<h)
       stop_planning = 1.0;
       return;
     endif
    
  endif
  
      stop_planning = 0.0;
  endfunction