function u = gradientProjectionTv(img, alph, iter, mode)

[n,m,c]= size(img);
img = img(:);

singleChannelXderivative = createSparseMatrixFrom1dSeperableKernel(1, [0 -1 1],n,m);
singleChannelYderivative = createSparseMatrixFrom1dSeperableKernel([0 -1 1],1,n,m);
K = [singleChannelXderivative;singleChannelYderivative];

q = zeros(size(K,1),1);
tau = 1/4;

fig = figure;
for i=1:iter
    gradDir = K*(K'*q-img/alph);
    q = (q - tau*gradDir);
    if strcmp(mode, 'aniso')
        q = max(min(q, 1),-1);
    elseif strcmp(mode, 'iso')
        temp = sqrt(q(1:size(q,1)/2).^2 + q(1+size(q,1)/2:end).^2);
        q = q./repmat(max(temp, 1), [2,1]);
    end
    imshow(reshape(img - alph*K'*q, [n,m,c])), title(['Iteration ', num2str(i)]), drawnow;
end

u = reshape(img - alph*K'*q, [n,m,c]);
close(fig);



