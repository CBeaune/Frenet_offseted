function PathSmoothingSample(path)
%PathSmoothingSample() パス平滑化用MATLABサンプルコード

clear all;
close all;

%スムージング前のパス

  
optPath=PathSmoothing(path);
  
plot(path(:,1),path(:,2));
hold on;
plot(optPath(:,1),optPath(:,2),'-or');
hold on;
axis([-1 7 -2 6])
legend('Before','After');
title('Path Smoothing');
grid on;

end

