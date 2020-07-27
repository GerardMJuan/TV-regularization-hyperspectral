function [ux, uy] = grad(u)

ux = [u(:,2:end,:) - u(:,1:end-1,:),zeros(size(u,1),1)];
uy = [u(2:end,:,:) - u(1:end-1,:,:);zeros(1,size(u,2))];