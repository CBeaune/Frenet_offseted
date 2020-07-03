#global plan --> get a waypoint every ds = 0.1 m 

function [s,wpx,wpy] = getGlobalPlan(wx,wy);
wpx = [wx(1)];
wpy = [wy(1)];
s = [0.0];

ds = hypot(diff(wx),diff(wy));
for i=1:length(ds)
  s = [s,sum(ds(1:i))];
endfor

for i=2:length(wx)
  x_0 = wx(i-1);
  x_1 = wx(i);
  y_0 = wy(i-1);
  y_1 = wy(i);
  if(hypot(x_1-x_0,y_1-y_0)>0.1)
      alpha  = atan2(y_1-y_0,x_1-x_0);
      ds = 0.1;
      x_1p = ds*cos(alpha)+x_0;
      y_1p = ds*sin(alpha)+y_0;
      %s = [s, s(end)+hypot(x_0-x_0p,y_0-y_0p)];
      x_1 = x_1p;
      y_1 = y_1p;
  endif
      wpx = [wpx,x_1];
      wpy = [wpy,y_1];
      
  
endfor
s;
%plot(wpx,wpy,'ro');
endfunction
