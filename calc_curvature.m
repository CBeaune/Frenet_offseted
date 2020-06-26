function k = calc_curvature(local_path)
  k = [];
  for i=1:length(local_path.x)-1
    ds = local_path.s(i+1)-local_path.s(i);
    dalpha = local_path.yaw(i+1)-local_path.yaw(i);
    if dalpha > pi/2
      dalpha-= pi;
    elseif dalpha< -pi/2
      dalpha +=pi;
    endif
    
    k = [k, dalpha/ds];
  endfor
  
endfunction

