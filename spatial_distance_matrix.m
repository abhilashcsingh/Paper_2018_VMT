% This code calculates the spatial weight matrices using household lat-long
% coordinates and census tract number
clear all;
data = xlsread('coordinates.xlsx',1,'A2:I3001');
dist_matrix = zeros(size(data,1) , (size(data,1)+4));


% census_tract_matrix = zeros(size(data,1),size(data,1));

lat_long = data(:,2:3);
measure = data(:,6);
% y=data(:,4);



% census_tracts = data(:,2);
count=0;
count2=0;
% Compute distance matrix
for i=1:3000
    for j=1:3000
        if i==j
            dist_matrix(i,j)= 0.00;
        elseif ((data(i,7) == data(j,7)) && (data(i,8) == data(j,8)) && (data(i,9) == data(j,9)))
            dist_matrix(i,j)= 1;
%             if ((data(i,7) == dist_matrix(i,3001)) && (data(i,8) == dist_matrix(i,3002)) && (data(i,9) == dist_matrix(i,3003)))
%                 dist_matrix(i,3004)=dist_matrix(i,3004)+1;
%             end
%             for k=1:5
%                 for l=1:4
%                     for m=1:4
%                         if ((data(i,7) == k) && (data(i,8) == l) && (data(i,9) == m))
%                             dist_matrix(i,3004)=dist_matrix(i,3004)+1;
%                         end
%                     end
%                 end
%             end           
            %dist_matrix(i,j)= 0.6200*(pos2dist(lat_long(i,1),lat_long(i,2),lat_long(j,1),lat_long(j,2),1));
            %if dist_matrix(i,j)== 0
             %   dist_matrix(i,j) = measure(i,1);
              %  count=count+1;
            %end
            %if dist_matrix(i,j)<0.1
             %   dist_matrix(i,j)=0.1; count2=count2+1;            %end
        end
    end
end

i=1;
%for k=1:5
    for l=1:4
        for m=1:4
           %dist_matrix(i,3001)= k;
           dist_matrix(i,3002)= l;
           dist_matrix(i,3003)= m;
           for o=1:3000
              if ((data(o,8) == l) && (data(o,9) == m))
                 dist_matrix(i,3004)=dist_matrix(i,3004)+1;
              end             
           end
        i=i+1;
        end
    end
%end 

sum = zeros(3000,1);
for i=1:3000
    for j=1:3000
        sum(i)=sum(i)+dist_matrix(i,j);
    end
    for j=1:3000
        dist_matrix(i,j)= (dist_matrix(i,j)/sum(i));
    end
end


% % Compute minimum, maximum and mean
% for i=1:3000
%         if i==1
%             dist_matrix(i,3001)= dist_matrix(i,2);
%         elseif i>1 
%             dist_matrix(i,3001)= dist_matrix(i,1);
%         end
%     for j=1:3000
%         if i==j
%             dist_matrix(i,3001)= dist_matrix(i,3001);
%             dist_matrix(i,3002)= dist_matrix(i,3002);
%             dist_matrix(i,3003)= dist_matrix(i,3003);
%         else
%             dist_matrix(i,3003)=dist_matrix(i,3003)+ dist_matrix(i,j);
%             if dist_matrix(i,j)< dist_matrix(i,3001)
%                 dist_matrix(i,3001)= dist_matrix(i,j);
%             elseif dist_matrix(i,j)> dist_matrix(i,3002)
%                 dist_matrix(i,3002)= dist_matrix(i,j);
%             end
%         end
%     end
%     dist_matrix(i,3003)= dist_matrix(i,3003)/2999;
% end

% for i=1:3000
%      for j=1:3000
%             if dist_matrix(i,j) < 0.5
%                 dist_matrix(i,3004)= dist_matrix(i,3004)+1;
%             end
%             if dist_matrix(i,j) < 1     
%                 dist_matrix(i,3005)= dist_matrix(i,3005)+1;
%             end
%             if dist_matrix(i,j) < 5    
%                 dist_matrix(i,3006)= dist_matrix(i,3006)+1;
%             end
%             if dist_matrix(i,j) < 10    
%                 dist_matrix(i,3007)= dist_matrix(i,3007)+1;
%             end
%             if dist_matrix(i,j) < 15    
%                 dist_matrix(i,3008)= dist_matrix(i,3008)+1;
%             end
%             if dist_matrix(i,j) < 20
%                 dist_matrix(i,3009)= dist_matrix(i,3009)+1;
%             end
%             if dist_matrix(i,j) < 25    
%                 dist_matrix(i,3010)= dist_matrix(i,3010)+1;
%             end
%             if dist_matrix(i,j) < 30    
%                 dist_matrix(i,3011)= dist_matrix(i,3011)+1;
%             end
%             if dist_matrix(i,j) < 40    
%                 dist_matrix(i,3012)= dist_matrix(i,3012)+1;
%             end
%             if dist_matrix(i,j) < 50
%                 dist_matrix(i,3013)= dist_matrix(i,3013)+1;
%             end
%      end
% end

% for i=1:3000
%     dist_matrix(i,3014)= (dist_matrix(i,3004)/3000)*100;
%     dist_matrix(i,3015)= (dist_matrix(i,3005)/3000)*100;
%     dist_matrix(i,3016)= (dist_matrix(i,3006)/3000)*100;
%     dist_matrix(i,3017)= (dist_matrix(i,3007)/3000)*100;
%     dist_matrix(i,3018)= (dist_matrix(i,3008)/3000)*100;
%     dist_matrix(i,3019)= (dist_matrix(i,3009)/3000)*100;
%     dist_matrix(i,3020)= (dist_matrix(i,3010)/3000)*100;
%     dist_matrix(i,3021)= (dist_matrix(i,3011)/3000)*100;
%     dist_matrix(i,3022)= (dist_matrix(i,3012)/3000)*100;
%     dist_matrix(i,3023)= (dist_matrix(i,3013)/3000)*100;  
% end
% 

csvwrite('distance_matrix2.csv',dist_matrix);
%Rectifying extremely low values (<100m set 400m and (100,500) set as 500m
