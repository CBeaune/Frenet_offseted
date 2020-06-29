function closest_wp = closest_wps(s,d,wx,wy)
  maps_s = [0.0];
  for i=2:length(wx)
    si  = maps_s(i-1)+hypot(wx(i)-wx(i-1),wy(i)-wy(i-1));
    maps_s = [maps_s, si];
  endfor
%  maps_s
 
  closest_wp = length(wx);
 while(s > maps_s(closest_wp-length(wx)+1) && (closest_wp-length(wx)+1 < ...
    length(maps_s)))
	
		closest_wp++;
	endwhile
  
  if closest_wp >= length(wx)
    closest_wp=closest_wp-length(wx)+1;
  endif
  
  
  endfunction