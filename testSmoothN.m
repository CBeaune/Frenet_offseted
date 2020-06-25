close all;
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

y = smoothn(wy);

##
##y1 = fastsmooth(wy,2,1,1);
##y2 = fastsmooth(wy,3,1,1);
##y3 = fastsmooth(wy,5,1,1);
##
##subplot(2,3,1);
##p0 = plot(wx,wy,'o-');
##hold on; 
##p1 = plot(wx,y1,'o-');
##hold on;
##p2 = plot(wx,y2,'o-');
##hold on;
##
##grid on;
##title("type=1, rectangular (sliding-average or boxcar) ");
##legend([p0, p1,p2,p3],{"none","window = 2","window = 3","window = 5"},...
##'location','southoutside', 'orientation','vertical');
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##
##y1 = fastsmooth(wy,2,2,1);
##y2 = fastsmooth(wy,3,2,1);
##y3 = fastsmooth(wy,5,2,1);
##
##subplot(2,3,2);
##p0 = plot(wx,wy,'o-');
##hold on;
##p1 = plot(wx,y1,'o-');
##hold on;
##p2 = plot(wx,y2,'o-');
##hold on;
##p3 = plot(wx,y3,'o-');
##title("type=2, triangular (2 passes of sliding-average)");
##legend([p0, p1,p2,p3],{"none","window = 2","window = 3","window = 5"},...
##'location','southoutside', 'orientation','vertical');
##grid on;
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##
##y1 = fastsmooth(wy,2,3,1);
##y2 = fastsmooth(wy,3,3,1);
##y3 = fastsmooth(wy,5,3,1);
##
##subplot(2,3,3);
##p0 = plot(wx,wy,'o-');
##hold on;
##p1 = plot(wx,y1,'o-');
##hold on;
##p2 = plot(wx,y2,'o-');
##hold on;
##p3 = plot(wx,y3,'o-');
##title("type=3, pseudo-Gaussian (3 passes of sliding-average)");
##legend([p0, p1,p2,p3],{"none","window = 2","window = 3","window = 5"},...
##'location','southoutside', 'orientation','vertical');
##grid on;
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##
##y1 = fastsmooth(wy,2,4,1);
##y2 = fastsmooth(wy,3,4,1);
##y3 = fastsmooth(wy,5,4,1);
##
##subplot(2,3,4);
##p0 = plot(wx,wy,'o-');
##hold on;
##p1 = plot(wx,y1,'o-');
##hold on;
##p2 = plot(wx,y2,'o-');
##hold on;
##p3 = plot(wx,y3,'o-');
##title("type=4, pseudo-Gaussian (4 passes of same sliding-average)");
##legend([p0, p1,p2,p3],{"none","window = 2","window = 3","window = 5"},...
##'location','southoutside', 'orientation','vertical');
##grid on;
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##
##y1 = fastsmooth(wy,2,5,1);
##y2 = fastsmooth(wy,3,5,1);
##y3 = fastsmooth(wy,5,5,1);
##
##subplot(2,3,5);
##p0 = plot(wx,wy,'o-');
##hold on;
##p1 = plot(wx,y1,'o-');
##hold on;
##p2 = plot(wx,y2,'o-');
##hold on;
##p3 = plot(wx,y3,'o-');
##title("type=5, multiple-width (4 passes of different sliding-average)");
##legend([p0, p1,p2,p3],{"none","window = 2","window = 3","window = 5"},...
##'location','southoutside', 'orientation','vertical');
##grid on;

