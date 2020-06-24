%Anthony Chrabieh
%Bonus Problem
%A* Algorithm
%clear all
%clc
%clf

function path = AStar(MAP,c_d,M,N,d_sample,dmax)

%Define Number of Nodes
xmax = M;
ymax = N;
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
  if MAP(xmax,ceil(N/2)+k)~= inf
    goal = [xmax,ceil(N/2)+k];
    break;
  elseif MAP(xmax,ceil(N/2)-k)~= inf
    goal = [xmax,ceil(N/2)-k];
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
weight = sqrt(2.5); %Try 1, 1.5, 2, 2.5
%Increasing weight makes the algorithm greedier, and likely to take a
%longer path, but with less computations.
%weight = 0 gives Djikstra algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Heuristic Map of all nodes
for x = 1:size(MAP,1)
    for y = 1:size(MAP,2)
        if(MAP(x,y)~=inf)
            %H(x,y) = weight*norm(goal-[x,y]);
            %For d_sample = 0.25, a good heuristic is :
            H(x,y) = weight*(abs(ceil(ymax/2)-y) + abs(goal(1)-x));
            
            
            G(x,y) = inf;
        endif
    endfor
endfor
%Plotting%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%surf(MAP')
%colormap(gray)
%view(2)
%hold all
%plot(start(1),start(2),'s','MarkerFaceColor','r')
%plot(goal(1),goal(2),'s','MarkerFaceColor','m')
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
    
    pause(0.001)
    
    %find node from open set with smallest F value
    [A,I] = min(openNodes(:,4));
    
    %set current node
    current = openNodes(I,:);
%    plot(current(1),current(2),'o','color','g','MarkerFaceColor','g')
    
    %if goal is reached, break the loop
    if(current(1:2)==goal)
        closedNodes = [closedNodes;current];
        solved = true;
        break;
    endif
    
    %remove current node from open set and add it to closed set
    openNodes(I,:) = [];
    closedNodes = [closedNodes;current];
    
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
            
            
            newG = G(current(1),current(2)) + round(norm([current(1)-x,current(2)-y]));
            
            %if not in open set, add to open set
            if(isempty(A))
                G(x,y) = newG;
                newF = G(x,y) + H(x,y);
                newNode = [x y G(x,y) newF size(closedNodes,1)];
                openNodes = [openNodes; newNode];
%                plot(x,y,'x','color','b')
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
    
%    for j = 1:size(path,1)
%        plot(path(j,1),path(j,2),'x','color','r')
%        pause(0.01)
%    endfor
else
    disp('No Path Found')
endif

%figure(2)
%xspline = 2:0.1:xmax;
%yspline = spline(path(:,1),path(:,2),xspline);
%plot(xspline,yspline,'ro')

endfunction
