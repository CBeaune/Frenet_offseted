##follow global plan
function local_plan= follow_global_plan(c_x,c_y,wx,wy)
  SetParams;
  local_plan = [];
  i = NextWp(c_x,c_y,wx,wy,0.0);
  for idx = i:i+8
    if idx<length(wx)-8
      local_plan = [local_plan, [wx(idx);wy(idx)]];
    else
      
      break;
    endif
    
  endfor
  
endfunction
