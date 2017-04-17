function [x,T,U] = FD_Diff(N)
  x  = linspace(-1,1,N); % get dat domain
  dx = x(2)-x(1);        % get dat spatial stepsize
  D2 = (1/dx^2)*toeplitz([ -2 1 zeros(1,N-2) ]');% 2nd order central
  u0 = cos(pi*x)+0.2*cos(5*pi*x)+1; % init distribution
  g0 = 1; gN = 1; gBC=[g0;gN]; % Seinfeld's least fav. BC
  B  = D2(2:end-1,[1 end]);    % To B D2,
  D2 = D2(2:end-1,2:end-1);    % or not D2 D2.
  A = [-1 0; 0 1]/dx;          % Fix D for ODE and optimize comp.
  C = [1 zeros(1,N-3); zeros(1,N-3) -1]/dx;
  BiA= B/A;
  b  = BiA*gBC;
  Q  = sparse(D2 - BiA*C); % This is still a tridiagonal matrix
  RHS = @(t,u) Q*u+b;
  t = 0:0.001:2;
  [T,U] = ode45(RHS, t, u0(2:end-1));
end
