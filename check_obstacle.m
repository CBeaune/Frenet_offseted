#check obstacle collision
function [bool_obstacle, closest_ob] = check_obstacle(c_x,c_y,local_plan,obstacle)
  SetParams;
  
  %if isempty(local_plan.x) ==1
    dist_to_obst = 1000;
   for ob = obstacle
     if (hypot(c_x-ob(1),c_y-ob(2))<dist_to_obst)
        
        dist_to_obst = hypot(c_x-ob(1),c_y-ob(2));
        closest_ob = ob;
      endif
      
   endfor
       
     if (abs(c_x-closest_ob(1))<=1.0 && abs(c_y-closest_ob(2))<=0.55)
       bool_obstacle = 1.0;
       return;
     endif
     
  
%  else 
%    for ob = obstacle
%      for i=1:length(local_plan.x)
%         if (hypot(local_plan.x(i)-ob(1),local_plan.y(i)-ob(2))<0.5)
%          bool_obstacle = 1.0;
%          closest_ob = ob;
%          return;
%         else
%          bool_obstacle = 0.0;
%         endif
%      endfor
%    endfor
%    
    
    
    bool_obstacle = 0.0;
    closest_ob = 0.0;
  
  %endif

endfunction
