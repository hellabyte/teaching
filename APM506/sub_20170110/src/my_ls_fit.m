%% Jason Yalim
% =====================================================================
%  my_ls_fit.m
%  least squares fitting algo
% ---------------------------------------------------------------------
%  The Vandermonde matrix, $X$, is defined as,
%
%  $$ X_{jk} = x_j^k, $$
% 
%  thus the input data and output coefficients have the following
%  relationship,
%
%  $$ y_j = \sum_{k=0}^{N} c_k x_j^k, $$
%
%  which expressed with matrices and performing a least squares,
%  
%  $$  Xc = y \implies    X'Xc = X'y,                $$
%  $$ QRc = y \implies R'Q'QRc = R'Q'y,              $$
%  $$                        c = inv(R)inv(R')R'Q'y, $$
%  $$                        c = inv(R)Q'y.          $$
% ---------------------------------------------------------------------

function [c] = my_ls_fit(x,y,order)
  % generating Vandermonde matrix
  X = ones(length(x),order+1);
  for k = 0:order
    X(:,k+1) = x.^k;
  end
  % performing tall factorization of $X$, such that $R$ is square.
  [Q,R] = qr(X,0);
  % Ensure that $c$ is a column vector
  [m,n] = size(y);
  if m > n
    c = inv(R)*Q'*y;
  else
    c = inv(R)*Q'*y';
  end
end 
% [x] Party button
