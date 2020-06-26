function k = calc_curvature(local_path)
  k = [];
  for i=1:length(local_path.x)-1
    ds = local_path.s(i+1)-local_path.s(i);
    dalpha = local_path.yaw(i+1)-local_path.yaw(i);
    k = [k, dalpha/ds];
  endfor
  
endfunction

