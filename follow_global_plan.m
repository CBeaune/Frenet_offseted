##follow global plan
function local_plan = follow_global_plan(c_x,c_y,wx,wy)
  SetParams;
  local_plan = [];
  for x = c_x:0.1:8
    x
    if x<wx(end)
      [val,i] = min(abs(x-wx));
      local_plan = [local_plan, [wx(i);wy(i)]];
    else
      break;
    endif
    
  endfor
  
endfunction
