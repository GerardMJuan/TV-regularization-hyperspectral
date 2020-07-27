function [ b ] = pfunction( y, v )
    p = v(y) - (1/y) * (sum(v(1:y) - 1));
    b = p > 0;
end
