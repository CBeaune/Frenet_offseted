#getCartesianfunction
function [x,y] = getCartesian(s,d,wx,wy)
  maps_s = [0.0];
  for i=2:length(wx)
    si  = maps_s(i-1)+hypot(wx(i)-wx(i-1),wy(i)-wy(i-1));
    maps_s = [maps_s, si];
  endfor
 
  prev_wp = length(wx);
 while(s > maps_s(prev_wp-length(wx)+1) && (prev_wp-length(wx)+1 < length(maps_s)))
	
		prev_wp++;
	endwhile
  
  if prev_wp >= length(wx)
    prev_wp=prev_wp-length(wx)+1;
  endif
  
  wp2 = mod((prev_wp+1),length(maps_s))+1;

	heading = atan2((wy(wp2)-wy(prev_wp)),(wx(wp2)-wx(prev_wp)));
	# the x,y,s along the segment
	seg_s = (s-maps_s(prev_wp));

	seg_x = wx(prev_wp)+seg_s*cos(heading);
	seg_y = wy(prev_wp)+seg_s*sin(heading);

	perp_heading = heading-pi/2;

	x = seg_x + d*cos(perp_heading);
	y = seg_y + d*sin(perp_heading);

endfunction
	
	
  
  