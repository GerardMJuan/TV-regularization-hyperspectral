% Implementing a variational method in MATLAB for image smoothing
% Gerard Mart� Juan
function [ Uln_bar ] = VariationalMethodTest( tau, i, F, lambda, sigma)

[m,n] = size(F);

% Grad and div
e = ones(n,1);
yDerMat = spdiags([-e e], 0:1, n, n);
yDerMat(end) =0;
e = ones(m,1);
xDerMat = spdiags([-e e], 0:1, m, m)';
xDerMat(end)=0;
K = [kron(xDerMat',speye(n,n)); kron(speye(m,m), yDerMat)];

%% Initiating algorithm %%

% Initial parameters
Yn = zeros(size(K,1),1);
F = F(:);
Un = F;
% Starting loop 
% Finish condition: number of iterations (better way?)
for i = 1:200
    UnOld = Un;
    Un = (tau*lambda*F - tau*K'*Yn + Un)/(1+lambda*tau);    
    Uln_bar = 2*Un - UnOld; 
    temp = Yn + sigma*K*Uln_bar;
    Yn = sign(temp) .* min(abs(temp), 1);
    % imshow(reshape(Un, [n,m])), title(['Iteration ', num2str(i)]), drawnow;
end
    Uln_bar = reshape(Uln_bar, [n,m]);


end







