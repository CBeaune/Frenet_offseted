Dx = gradient(local_plan.x);
Dy = gradient(local_plan.y);
Dx_2 = gradient(Dx);
Dy_2 = gradient(Dy);
k = (1/0.1)*sqrt(Dx_2.^2+Dy_2.^2)
for i=1:length(k)
  R(i)=1/k(i);
endfor
R