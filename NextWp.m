#NextWp 
function closestWaypoint = NextWp(x,y,wx,wy,theta)
  closestWaypoint = ClosestWp(x,y,wx,wy);

	  map_x = wx(closestWaypoint);
	  map_y = wy(closestWaypoint);

	  heading = atan2( (map_y-y),(map_x-x) );

	  angle = abs(theta-heading);

	if angle > pi/4
	
		closestWaypoint++;
	endif;
endfunction