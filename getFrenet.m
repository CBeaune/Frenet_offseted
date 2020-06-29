#getFrenet function
function [frenet_s,frenet_d] = getFrenet(x,y,wx,wy,theta)
    next_wp =  NextWp(x,y,wx,wy,theta);
	  prev_wp = next_wp-1;
	if next_wp == 1
	
		prev_wp  = length(wx);
  elseif next_wp >= length(wx)
    next_wp = length(wx);
    prev_wp  = 1;
	endif

	   n_x = wx(next_wp)-wx(prev_wp);
	   n_y = wy(next_wp)-wy(prev_wp);
	   x_x = x - wx(prev_wp);
	   x_y = y - wy(prev_wp);

	 # find the projection of x onto n
	   proj_norm = (x_x*n_x+x_y*n_y)/(n_x*n_x+n_y*n_y);
	   proj_x = proj_norm*n_x;
	   proj_y = proj_norm*n_y;

	   frenet_d = hypot(x_x-proj_x,x_y-proj_y);

	 #see if d value is positive or negative by comparing it to a center point

	   center_x = 1000-wx(prev_wp);
	   center_y = 2000-wy(prev_wp);
	   centerToPos = hypot(center_x-x_x,center_y-x_y);
	   centerToRef = hypot(center_x-proj_x,center_y-proj_y);

	if centerToPos >= centerToRef
	
		frenet_d = -frenet_d;
	endif

	 # calculate s value
	   frenet_s = 0;
	if(next_wp!=1)
	for i = 2:prev_wp
	
		frenet_s += hypot(wx(i)-wx(i-1),wy(i)-wy(i-1));
	endfor
  frenet_s += hypot(proj_x,proj_y);
elseif prev_wp==length(wx)
  frenet_s = 0.0;
endif
 
  endfunction