    function diver = div(v1,v2)

diver =   [v1(:,1,:), v1(:,2:end-1,:) - v1(:,1:end-2,:), -v1(:,end-1,:)]...
        +[v2(1,:,:); v2(2:end-1,:,:) - v2(1:end-2,:,:); -v2(end-1,:,:)];