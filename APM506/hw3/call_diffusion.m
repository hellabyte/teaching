%% Homework 3 -- Problem 3
% Solving diffusion equation with Neumann B.C.s of 1
%
clear all, close all, clc

Nc =  50; % Order of Cheb poly
Nf = 101; % Number of points for FD domain

disp(sprintf('Cheb Timing, num points: %d',Nc+1))
tic
[xc,tc,UC] = SM_Diff(Nc);
toc
disp(sprintf('Finite Difference timing, num points: %d',Nf))
tic
[xf,tf,UF] = FD_Diff(Nf);
toc

[XC,TC] = meshgrid(xc(2:end-1),tc);
[XF,TF] = meshgrid(xf(2:end-1),tf);

figure
h = surf(XC,TC,UC); set(h,'edgecolor','none')
xlabel('x'); ylabel('t'); zlabel('u');
title('Chebyshev Result')

figure
h = surf(XF,TF,UF); set(h,'edgecolor','none')
xlabel('x'); ylabel('t'); zlabel('u');
title('Finite Difference Result')

figure
maUC = max(abs(UC),[],2); maUF = max(abs(UF),[],2);
maer = abs(maUC-maUF);
semilogy(tc,maer,'k-')
xlabel('t'); ylabel('max error'); 
title('| ||UC(t)||_{max}-||UF(t)||_{max} |')

%% Spectral Code
% 
% <include>./SM_Diff.m</include>
%
%% Second Order Finite Difference Code
% 
% <include>./FD_Diff.m</include>
%
%  
% Doing this problem with the expressive linear algebra syntax shown in
% the spectral solver provides the following right hand side,
%
%    RHS = @(t,u) D2*u + (B/A)*([g0;gN]-C*u),
% 
% where 
%
%    A = D([1 end],[1 end]);
%    C = D([1 end],2:end-1);
%
% and |D| is the differental operator, which we have already defined
% within the interior with the second order central scheme, but now
% needs to be defined along the boundaries (along the first and last
% rows):
%
%    D([1 end],:) = [ -1 1 zeros(1,N-2); ...
%                     zeros(1,N-2) -1 1 ] / dx;
% 
% Also, since |B| is only nonzero in its upper left and lower right
% corner, implies that |B*inv(A)*C| is going to be nonzero only in its
% upper left and lower right corners as well.  Therefore, unlike the
% spectral collocation method, the final |Q| operator will benefit from
% a sparse representation (as it's tridiagonal).
%% 
% Notice above the use of Euler on boundaries (essentially just Taylor
% series expansions). The one step truncation error of these methods is
% second order, which is consistent with the second order central scheme
% used on the interior. That is,
%
%   u_0 = u_1 - dx*g0 
%       = u(-1+dx) - dx*g0 
%       = u_0 + dx u_0' + .5 dx^2 u_0'' + O(dx^3) - dx * g0
%       = u_0 + dx g0   + .5 dx^2 u_0'' + O(dx^3) - dx * g0
%       = u_0 + O(dx^2),
%
%   u_N = u_{N-1} + dx*gN = u(1-dx) + dx*gN = u_N + O(dx^2),
%
% since |g0 = u_x(-1)|, and |gN = u_x(1)|. This leads to the explicit
% right hand side for the interior field:
%
%   RHS = @(t,u) D2*u + B*[u(1)-dx*g0;u(end)+dx*gN].
% 
% However, the representation used by the code is about 9% more
% efficient when |Q| is not sparse, and 33% more efficient when it is
% sparse (running on mathpost.asu.edu):
%
%                 | avg time of 10 runs (N=100) (s)
%    -------------|---------------------------------
%     b explicit  |        1.2 
%     Q non sparse|        1.1 
%     Q sparse    |         .9  
%     
