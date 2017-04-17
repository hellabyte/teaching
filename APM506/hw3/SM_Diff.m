function [x,T,U] = SM_Diff(N)
  %% u_t = u_xx -1<x<1, with Neumann boundary conditions
  [D,x] = cheb(N);
  x = -x;   % Reverse order of x so x(1) = -1.
  D = -D;   % D is affected by reorder.
  D2 = D^2; % Thank Chebyshev for this wonderful property.
  u0 = cos(pi*x)+0.2*cos(5*pi*x)+1; % initial distribution.
  g0 = 1; gN = 1; gBC = [g0;gN];  % Neumann boundary conditions.
  B  = D2(2:end-1,[1 end]);  % u0 and uN still want to party,
  D2 = D2(2:end-1,2:end-1);  % but they werent invited to D2.
  A  = D([1 end],[1,end]);   % Dem no flux conditions
  C  = D([1 end],2:end-1);   % allow us to rewrite B*[u0;uN]
  % Solving on interior of field:
  %    RHS = @(t,u) D2*u + B*inv(A)*(gBC - C*u)
  % These are constant matrices! Compute them ONLY once.
  BiA   = B/A;
  Q     = D2 - BiA*C; 
  b     = BiA*gBC;
  RHS   = @(t,u) Q*u+b; % I like this RHS better than the first one.
  t     = 0:0.001:2;
  [T,U] = ode45(RHS, t, u0(2:end-1));
end 
