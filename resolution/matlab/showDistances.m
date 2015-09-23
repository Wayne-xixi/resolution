function showDistances(data, T, columns, init)
%This function receives data loaded from the output files of 
%the test battery of testbed_CATEC in the format:
%traj{1}=[x1 y1 z1; x2 y2 z2...]; 
%traj{2}=[x1 y1 z1; x2 y2 z2...]; 
%
% Each traj may have different size.
% Write the name of the .m ('soltraj' may be)
% Then call with the name of the cell matrix (traj may be)
% > soltraj;
% > showDistances(traj);
% It shows distances from each UAV center to the others:
% blue: euclidean distance 
% red: distance in the xy plane 
% black: distance in the z axis 
% Note that none of this are the real minimum distance.
% Remember that the dimension of the quads are :
% 50*50*20cm aprox.
%

if nargin<3
  columns = 1:3;
end
if nargin<4
  init = ones(1,length(data));
end
n_uavs= length(data);


        
for i=1:n_uavs-1
    for j=i+1:n_uavs
      figure;
        %subplot(n_uavs-1,n_uavs-1,(i-1)*(n_uavs-1)+j-1);
        
      aux1 = data{i}(init(i):, columns);
      aux2 = data{j}(:, columns);
      
	t = 0:T:T*(length(aux1) - 1);
	plotiploti=matDist(aux1, aux2);
	size(plotiploti)
%          hold on;
    plot(t, plotiploti)
        
        
%          plot(xyDist(aux1 ,aux2),'r');
%          plot(zDist(aux1 ,aux2),'k');
    xlabel(['Distance from UAV ' num2str(i) ' to UAV ' num2str(j)]);
    hold off;
  end
end

    function d=xyDist(mat1,mat2)
        %Receives two matrix with x,y,z in rows
        %Returns a vector of distances between each row
        %Matrices can have different sizes. Final state of the minimum is repeated then.
        max_size=max(size(mat1,1),size(mat2,1));
        min_size=min(size(mat1,1),size(mat2,1));
        
        d=zeros(max_size,1);
        for n=1:min_size
            auxvec=mat1(n,1:2)-mat2(n,1:2);
            auxvec=auxvec.*auxvec;
            d(n)=sum(auxvec);
            d(n)=sqrt(d(n));
        end
        for n=min_size+1:max_size
            d(n)=d(min_size);
        end
            
    end

    function d=zDist(mat1,mat2)
        %Receives two matrix with x,y,z in rows
        %Returns a vector of distances between each row
        %Matrices can have different sizes. Final state is repeated then.
        max_size=max(size(mat1,1),size(mat2,1));
        min_size=min(size(mat1,1),size(mat2,1));
        d=zeros(max_size,1);
        for n=1:min_size
            auxvec=mat1(n,3)-mat2(n,3);
            auxvec=auxvec.*auxvec;
            d(n)=sum(auxvec);
            d(n)=sqrt(d(n));
        end
        for n=min_size+1:max_size
            d(n)=d(min_size);
        end
            
    end


    

    function d=matDist(mat1,mat2)
        %Receives two matrix with x,y,z in rows
        %Returns a vector of distances between each row
        %Matrices can have different sizes. Final state is repeated then.
        max_size=max(size(mat1,1),size(mat2,1));
        min_size=min(size(mat1,1),size(mat2,1));
        d=zeros(max_size,1);
        for n=1:min_size
            auxvec=mat1(n,:)-mat2(n,:);
            auxvec=auxvec.*auxvec;
            d(n)=sum(auxvec);
            d(n)=sqrt(d(n));
        end
        for n=min_size+1:max_size
            d(n)=d(min_size);
        end
            
    end
end