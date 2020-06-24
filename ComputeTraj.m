function [wxl,wyl,wxr,wyr] = ComputeTraj(wx,wy)
  wxl=[];
  wxr = [];
  wyl=[];
  wyr = [];
  for i=1:length(wx)-1
    theta = atan2(wy(i+1)-wy(i),wx(i+1)-wx(i));
    wxr = [wxr,wx(i)+0.5*sin(theta)];
    wxl = [wxl,wx(i)-0.5*sin(theta)];
    wyr = [wyr, wy(i)-0.5*cos(theta)];
    wyl = [wyl, wy(i)+0.5*cos(theta)];
    
  endfor
  
  theta = atan2(wy(end)-wy(end-1),wx(end)-wx(end-1));;
    wxr = [wxr,wx(end)+0.5*sin(theta)];
    wxl = [wxl,wx(end)-0.5*sin(theta)];
    wyr = [wyr, wy(end)-0.5*cos(theta)];
    wyl = [wyl, wy(end)+0.5*cos(theta)];
    
    
  
  
  
  endfunction