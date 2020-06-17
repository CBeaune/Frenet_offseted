function [wxl,wyl,wxr,wyr] = ComputeTraj(wx,wy)
  wxl=[];
  wxr = [];
  wyl=[];
  wyr = [];
  for i=1:length(wx)-1
    theta = atan2(wy(i+1)-wy(i),wx(i+1)-wx(i));
    wxl = [wxl,wx(i)+1*sin(theta)];
    wxr = [wxr,wx(i)-1*sin(theta)];
    wyl = [wyl, wy(i)-1*cos(theta)];
    wyr = [wyr, wy(i)+1*cos(theta)];
    
  endfor
  
  theta = atan2(wy(end)-wy(end-1),wx(end)-wx(end-1));;
    wxl = [wxl,wx(end)+1*sin(theta)];
    wxr = [wxr,wx(end)-1*sin(theta)];
    wyl = [wyl, wy(end)-1*cos(theta)];
    wyr = [wyr, wy(end)+1*cos(theta)];
    
    
  plot(wx,wy);
  hold on;
  plot(wxr,wyr);
  hold on;
  plot(wxl,wyl);
  axis equal;
  
  endfunction