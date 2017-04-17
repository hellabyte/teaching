%% Jason Yalim
% =====================================================================
%  my_ls_eval.m
%  least squares eval algo
% ---------------------------------------------------------------------
%  Assumes coefficients indices are increasing,
%
%     $$ y_j = y(x_j;c) = \sum_{k=0}^{N-1} c_k x_j^k, $$
%
%  where $N$ is the length of the coefficient vector, $c$. 
% ---------------------------------------------------------------------

function [y] = my_ls_eval(c,x)
  X = zeros(length(x),length(c));
  for k = 0:length(c)-1
    X(:,k+1) = x.^k;
  end
  % $c$ must be a column vector
  [m,n] = size(c);
  if m > n
    y = X*c; 
  else
    y = X*c';
  end
end 
% [x] Party Button
