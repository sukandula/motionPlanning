function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag = true;

edge = P1(1,:) - P1 (2,:); % get an edge from the vector
if computeNormalVectorAndDoProjection(edge, P1, P2) == false
    flag = false;
end

edge = P1(1,:) - P1 (3,:); % get an edge from the vector
if flag == true && computeNormalVectorAndDoProjection(edge, P1, P2) == false
    flag = false;
end

edge = P1(2,:) - P1 (3,:); % get an edge from the vector
if flag == true && computeNormalVectorAndDoProjection(edge, P1, P2) == false
    flag = false;
end
    
edge = P2(1,:) - P2(2,:); % get an edge from the vector
if flag == true && computeNormalVectorAndDoProjection(edge, P1, P2) == false
    flag = false;
end

edge = P2(1,:) - P2(3,:); % get an edge from the vector
if flag == true && computeNormalVectorAndDoProjection(edge, P1, P2) == false
    flag = false;
end

edge = P2(2,:) - P2(3,:); % get an edge from the vector
if  flag == true && computeNormalVectorAndDoProjection(edge, P1, P2) == false
    flag = false;
end   
    
% *******************************************************************
end

function flag = computeNormalVectorAndDoProjection(edge, P1, P2)

flag = false;

normalAxis = getNormalVector(edge); % get the corresponding normal vector
proj1 = getMinMaxProjection(normalAxis, P1);
proj2 = getMinMaxProjection(normalAxis, P2);
if checkOverlapOfProjections(proj1, proj2) == true
    flag = true;
end

end

%
% params: edge: is a 1x2 vector representing an edge between 2 vertices.
% return normalVecotr is a 1X2 vector  that is normal to the edge.
function normalVector = getNormalVector(edge)
  normalVector(1,1) = edge(1,2) * -1;
  normalVector (1,2) = edge (1,1);
end

%
% params:
%      edge:  1X2  normal axis on which we are projecting all the
%              vertices.
%       P1 :  3X2 triangle matrix to project
% return :
%        projvector : 1x2 that corresponds to the min and max projection points
%        for all vertices.
function  projvector = getMinMaxProjection(edge, P1)
   min = dot(P1(1,:),edge(1,:));
   max = min;
  
 for i = 2:3   
   intercept = dot(P1(i,:),edge(1,:));
   if intercept < min
       min = intercept;
   elseif intercept > max
       max = intercept;
   end
   
 end  
   
 projvector = [min, max];
 
end



%
% params:
%      proj1:  1X2 vector that corresponds to minimum and maximum values
%              of values of projected points for shape1               
%      proj2:  1X2 vector that corresponds to minimum and maximum values
%              of values of projected points for shape 2               
% return : flag:  projections overlap (true or false)

function  flag = checkOverlapOfProjections(proj1, proj2)
    flag = false;    
    
    if (proj2(1,1) >= proj1(1,1) && proj2(1,1) <= proj1(1,2))
            flag = true;
    elseif (proj2(1,2) >= proj1(1,1) && proj2(1,2) <= proj1(1,2))
        flag = true;
    elseif (proj1(1,1) >= proj2(1,1) && proj1(1,1) <= proj2(1,2))
            flag = true;
    elseif (proj1(1,2) >= proj2(1,1) && proj1(1,2) <= proj2(1,2))
        flag = true;
    end
end