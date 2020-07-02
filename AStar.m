%Anthony Chrabieh
%Bonus Problem
%A* Algorithm
%clear all
%clc
%clf

function path = AStar(MAP,c_d,c_s,M,N,s_sample,d_sample,wx,wy,dmax,curv,
  plot_type,curv_weight)
hold off;

%Define Number of Nodes
xmax = M;
ymax = N;
thres = 0.1;
%thetamax = pi;
%theta = -thetamax:5*pi/180:thetamax;
nb = -dmax:d_sample:dmax;

%Start and Goal
for index = 1:length(nb)-1
      if nb(index) <= c_d && c_d<= nb(index+1)
        start_d = index;
        continue;
      endif
    endfor
 

start = [1,start_d];
goal = [xmax,ceil(N/2)];

k = 0;
while ceil(N/2)+k < N && ceil(N/2)-k >1
  if MAP(xmax,ceil(N/2)-k)~= inf
    goal = [xmax,ceil(N/2)-k];
    break;
  elseif MAP(xmax,ceil(N/2)+k)~= inf
    goal = [xmax,ceil(N/2)+k];
    break;
  endif
  k++;
endwhile



%Nodes
%MAP = zeros(xmax,ymax);
%%To define objects, set their MAP(x,y) to inf
%MAP(10,1) = inf;
%MAP(5,1) = inf;
%MAP(5,2) = inf;
%MAP(6,2) = inf;
%MAP(35:40,15) = inf;
%MAP(35:40,25) = inf;

%Heuristic Weight%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
weight = sqrt(2); %Try 1, 1.5, 2, 2.5

alpha = 50.0;
beta = 10.0;
gamma = 1.0;
%Increasing weight makes the algorithm greedier, and likely to take a
%longer path, but with less computations.
%weight = 0 gives Djikstra algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Heuristic Map of all nodes
index = floor(c_s/s_sample);
for x = 1:size(MAP,1)
    for y = 1:size(MAP,2)
        
            H(x,y) = weight*hypot(x-goal(1),y-ceil(ymax/2)) ;
            if(index+x<length(curv))
              L(x,y) =  curv_weight*curv(index+x);
            else
              L(x,y) =  curv_weight*curv(end);
            endif
             H(x,y)=H(x,y)+L(x,y);
            G(x,y) = inf;
        
    endfor
endfor

%Plotting%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plot_type == "A"
    
    s = surf(H'+MAP');
  colormap(hot)
  view(2)
  hold all
  plot3(start(1),start(2),H(start(1),start(2)),'s','MarkerFaceColor','b')
  plot3(goal(1),goal(2),H(goal(1),goal(2)),'s','MarkerFaceColor','m')
endif

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%initial conditions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G(start(1),start(2)) = 0;
F(start(1),start(2)) = H(start(1),start(2));
closedNodes = [];
openNodes = [start G(start(1),start(2)) F(start(1),start(2)) 0]; %[x y G F cameFrom]
                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Solve
solved = false;
while(~isempty(openNodes))
%    
    pause(0.0001)
%    
    %find node from open set with smallest F value
    [A,I] = min(openNodes(:,4));
    
    %set current node
    current = openNodes(I,:);
    if plot_type == "A"
      plot3(current(1),current(2),H(current(1),current(2)),'o','color','g','MarkerFaceColor','g')
    endif
    
    
    %if goal is reached, break the loop
    if(current(1:2)==goal)
        closedNodes = [closedNodes;current];
        solved = true;
        break;
    endif
    
    %remove current node from open set and add it to closed set
    openNodes(I,:) = [];
    closedNodes = [closedNodes;current];
   % k = [];
    %for all neighbors of current node
    for x = current(1)-1:current(1)+1
        for y = current(2)-1:current(2)+1
      
            
            
            %if out of range skip
            if (x<1||x>xmax||y<1||y>ymax)
                continue
            endif
            
            
            %if object skip
            if (isinf(MAP(x,y)))
                continue
            endif
            
            %if current node skip
            if (x==current(1)&&y==current(2))
                continue
            endif
            
            R = 0;
            
%            %if curv>thres discard certain nodes

            if (L(x,y)>thres )
              if  length(closedNodes(:,1))>3
%x
%y
%current(1)
%current(2)
%closedNodes(end-1,1)
%closedNodes(end-1,2)

                if (closedNodes(end-1,1)-current(1)==-1 && closedNodes(end-1,2)-current(2)==1 || ...
                      closedNodes(end-1,1)-current(1)==1 && closedNodes(end-1,2)-current(2)==-1)
                  if x == current(1)+1 && y == current(2)+1
                 
                    R = 1/thres;
                    if plot_type == "A"
                      plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                      hold on;
                    endif;
                
                  elseif x == current(1)-1 && y == current(2)-1
               
                    R =1/thres;
                  
                    if plot_type == "A"
                    plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                    hold on;
                  endif
               endif
              
              
                
              elseif (closedNodes(end-1,1)-current(1)==-1 && closedNodes(end-1,2)-current(2)==-1 ||...
                closedNodes(end-1,1)-current(1)==1 && closedNodes(end-1,2)-current(2)==1)
                if x == current(1)-1  && y == current(2)+1
                 
                  R =1/thres;
                  if plot_type == "A"
                    plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                    hold on;
                  endif
                  
                elseif x == current(1)+1  && y == current(2)-1
                   
                  R =1/thres;
                  if plot_type == "A"
                  plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                  hold on;
                  endif
                endif
              
              
              
              
                
              elseif closedNodes(end-1,1)-current(1)==-1 && closedNodes(end-1,2)-current(2)==0
                if  y == current(2)+1
                 
                   R=1/thres;
                  if plot_type == "A"
                    plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                    hold on;
                  endif
                  
                elseif  y == current(2)-1
                   
                   R=1/thres;
                  if plot_type == "A"
                    plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                    hold on;
                  endif
                endif
             
              
                
              elseif closedNodes(end-1,1)-current(1)==0 && ...
                (closedNodes(end-1,2)-current()==-1 || closedNodes(end-1,2)-current(2)==1)
                if x == current(1)-1  
                 
                  R =1/thres;
                  if plot_type == "A"
                    plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                    hold on;
                  endif
                  
                elseif x == current(1)+1  
                   
                  R =1/thres;
                  if plot_type == "A"
                    plot3(x,y,H(x,y),'o','color','r','MarkerFaceColor','r')
                    hold on;
                  endif
                endif
              
             endif
          endif
        endif
        
          
            
            
            %if already in closed set skip
            skip = 0;
            for j = 1:size(closedNodes,1)
                if(x == closedNodes(j,1) && y==closedNodes(j,2))
                    skip = 1;
                    break;
                endif
            endfor
            if(skip == 1)
                continue
            endif
            
            A = [];
            %Check if already in open set
            if(~isempty(openNodes))
                for j = 1:size(openNodes,1)
                    if(x == openNodes(j,1) && y==openNodes(j,2))
                        A = j;
                        break;
                    endif
                endfor
            endif
          
            
            newG = G(current(1),current(2))+round(norm([current(1)-x,current(2)-y]))+R;
            
            
            %if not in open set, add to open set
            if(isempty(A))
                G(x,y) = newG;
                newF = G(x,y) + H(x,y);
                newNode = [x y G(x,y) newF size(closedNodes,1)];
                openNodes = [openNodes; newNode];
                if plot_type == "A"
                  if newG > 100
                    plot3(x,y,H(x,y),'s','color','r',"markerfacecolor",'r')
                  else
                    plot3(x,y,H(x,y),'x','color','b')
                  endif
                  
                endif
                
                continue
            endif
            
            %if no better path, skip
            if (newG >= G(x,y))
                continue
            endif
            
            G(x,y) = newG;
            newF = newG + H(x,y);
            openNodes(A,3:5) = [newG newF size(closedNodes,1)];
        endfor
      
      
    endfor
endwhile

if (solved)
  
    %Path plotting
    j = size(closedNodes,1);
    path = [];
    while(j > 0)
        x = closedNodes(j,1);
        y = closedNodes(j,2);
        j = closedNodes(j,5);
        path = [x,y;path];
    endwhile
    
    if plot_type == "A"   
      for j = 1:size(path,1)
        plot3(path(j,1),path(j,2),100,'s','color','m','MarkerFaceColor','m')

    endfor
    pause(0.1)
    endif
  
else
    disp('No Path Found')
endif



endfunction
