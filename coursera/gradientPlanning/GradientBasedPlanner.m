function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f);

%%% All of your code should be between the two lines of stars.
% *******************************************************************
%route = zeros(max_its, 2);
current = start_coords;
dir = 0; %0: up, 1: down , 2: left, 3:right

route(1,1) =  start_coords(1);
route(1,2) =  start_coords(2);
[n,m] = size(gx)

for i = 1:max_its
    a = gx(current(1,1), current(1,2));
    b = gy(current(1,1), current(1,2));
    aggGradient = a+b;
    dir = -1;
    
    if (current(1,1) + 1) <= m && (current(1,1)+1) >= 1 
        if gx(current(1,2), current(1,1)+1) + gy(current(1,2), current(1,1)+1) < aggGradient
            dir = 3;
            next = [current(1,1)+1, current(1,2)];
            aggGradient = gx(current(1,2), current(1,1)+1) + gy(current(1,2), current(1,1)+1);
        end
    end

    if (current(1,2) + 1) <= n && (current(1,1)+1) >= 1 
       if gx( current(1,2)+1, current(1,1)) + gy(current(1,2)+1, current(1,1)) < aggGradient
            dir = 1;
            next = [current(1,1), current(1,2)+1];
            aggGradient = gx( current(1,2)+1, current(1,1)) + gy(current(1,2)+1, current(1,1));
       end
    end
    
    
   if (current(1,2) - 1) >= 1 && (current(1,2)-1) <= n 
       if gx(current(1,2)-1, current(1,1)) + gy(current(1,2)-1, current(1,1)) < aggGradient
            dir = 0;
            next = [current(1,1), current(1,2)-1];
            aggGradient = gx(current(1,2)-1, current(1,1)) + gy(current(1,2)-1, current(1,1));
       end
   end
    
   if (current(1,1) - 1) >= 1 && (current(1,1)-1) <= m 
   if gx( current(1,2), current(1,1)-1) + gy( current(1,2), current(1,1)-1) < aggGradient
        dir = 2;
        next = [current(1,1)-1, current(1,2)];
        aggGradient = gx( current(1,2), current(1,1)-1) + gy( current(1,2), current(1,1)-1);
   end
   end
   
   route(i+1,1) =  next(1);
   route(i+1,2) =  next(2);
      
   if dir == -1
       fprintf('Error');
   end
   
   dist = end_coords - next;

   if(abs(dist(1)) + abs(dist(2)) < 2)
       break;
   end
    
   current = next;
end



% *******************************************************************
end
