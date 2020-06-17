local_plan = change_lane(0.0,0.0,wx,wy,[1,1],0.0);
figure(1)
plot(local_plan(1,:),local_plan(2,:),'ro');
new_plan = go_back_global(local_plan,[1,0.5], wx,wy);
hold on ;
plot(1,1,'xk')
hold on;
plot(wx,wy,'b')
hold on;


plot(new_plan(2,:),new_plan(1,:),'bo');
hold on;

