x = 1:100;
A = cos(2*pi*0.05*x+2*pi*rand) + 0.5*randn(1,100);
B = smoothCurve(A);

##
##close all;
test_path = [0.30000   0.00000;
   0.40000   0.00000;
   0.50000   0.00000;
   0.60000   0.00000;
   0.70000   0.10000;
   0.80000   0.20000;
   0.90000   0.30000;
   1.00000   0.30000;
   1.10000   0.30000;
   1.20000   0.30000;
   1.30000   0.30000;
   1.40000   0.30000;
   1.50000   0.30000;
   1.60000   0.30000;
   1.70000   0.20000;
   1.80000   0.10000;
   1.90000   0.00000;
   2.00000   0.00000;
   2.10000   0.00000;
   2.20000   0.00000]
   
wx = test_path(:,1);
wy = test_path(:,2);

figure(1);
y = smoothCurve(wy);
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','Smoothed Data konno ohmachi')

figure(2);
y = smoothCurve(wy,"method",'boxcar');
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','Smoothed Data boxcar ')

figure(3);
y = smoothCurve(wy,"method",'hamming');
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','Smoothed Data hamming')

figure(4);
y = smoothCurve(wy,"method",'hann');
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','hann')

figure(5);
y = smoothCurve(wy,"method",'parzen');
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','parzen')

figure(6);
y = smoothCurve(wy,"method",'triang');
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','triang')

figure(6);
y = smoothCurve(wy,"method",'gaussian');
plot(wx,wy,'-o',wx,y,'-x')
legend('Original Data','gaussian')

