%% Example Script by Jason Yalim
% Publishing Matlab code:
%
% * <https://mathpost.asu.edu/~jyalim/publishing/matlab/mat275/2014/09/15/publishing-matlab.html my_advice>  
% * <https://www.mathworks.com/help/matlab/matlab_prog/publishing-matlab-code.html mathworks_code>  
% * <https://www.mathworks.com/help/matlab/matlab_prog/specifying-output-preferences-for-publishing.html specifying_output_preferences_for_publishing>  
%
% Publish doc:
%
% * <https://www.mathworks.com/help/matlab/ref/publish.html mathworks_publish>  
%
% Publish Markdown doc:
%
% * <https://www.mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html mathworks_markup>  
%

%% Example 1
% External code called by script
% NOTE THAT THERE MUST BE LINE BREAKS BEFORE AND AFTER include TAG LINE
% AND NO SPACES WITHIN TAG.
%
% <include>src/my_ls_fit.m</include>
%
% <include>src/my_ls_eval.m</include>
%
% <include>src/figprops.m</include>
%

% Section init
clear all, close all

% Problem init
x = linspace(-1,1,11)';   % transpose to column vectors
q = linspace(-1,1,101)';
y = x.^3;
c1= my_ls_fit(x,y,1);
c3= my_ls_fit(x,y,3);
y1= my_ls_eval(c1,q);
y3= my_ls_eval(c3,q);

figure(1), clf
plot(q,y1,'-'), hold on
plot(q,y3,'-')
plot(x,y,'ko')
title('Example Plots')
xlabel('x')
ylabel('y')
figprops

%% Example 2

% Section init
clear all, close all

whos          % Show workspace
a = 5;        
whos          % Show workspace

ls            % Display files/directories from working directory

a = { ones(5), 2, 'three' } % Cell Array
a(1)          % Object is shown
a{1}          % Value is shown
% Note where the output from the code is placed in the publish
