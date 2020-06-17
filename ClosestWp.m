#ClosestWp function

function closestWaypoint = ClosestWp(x,y,wx,wy)
  
  closestLen = 100000;
	closestWaypoint = 1;

	for i = 1:length(wx)
	
		map_x = wx(i);
		map_y = wy(i);
		dist = hypot(x-map_x,y-map_y);
		if dist < closestLen 
		
			closestLen = dist;
			closestWaypoint = i;
		endif

	endfor

  
  
  endfunction