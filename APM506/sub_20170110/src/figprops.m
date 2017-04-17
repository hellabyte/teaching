%% figprops.m
% =====================================================================
% A script to adjust the look of plots, in an attempt to improve
% formatting.
% 
% Finish plotting, then call figprops.m (this script). E.g.,
% 
%     x = linspace(-1,1,101)'; y = x.^2; figure(1), clf
%     plot(x,y), title('example'), xlabel('x'), ylabel('x^2'), figprops
% 
% Modified by Jason Yalim, from APM 505, Professor Rosie Renaut, F13.
% ---------------------------------------------------------------------
%  text properties: 
%    https://www.mathworks.com/help/matlab/ref/text-properties.html
%  axes properties: 
%    https://www.mathworks.com/help/matlab/ref/axes-properties.html
% ---------------------------------------------------------------------
% 

opts = {                        ...
  { 'line', {                   ...    % line Options
       'MarkerSize', 9,         ...
        'LineWidth', 1,         ... 
     },                         ... 
  },                            ...
  { 'text', {                   ...    % text options
       'FontWeight', 'normal',  ...    % bold
        'FontAngle', 'normal',  ...    % italic
            'Color',      'k',  ...   
     },                         ... 
  },                            ...
  {'axes', {                    ...    % axes options
         'FontSize',       16,  ...    
       'FontWeight', 'normal',  ...    % bold
        'FontAngle', 'normal',  ...    % italic
            'Color',      'w',  ...   
     },                         ... 
  },                            ...
  {'title', {                   ...    % title options
         'FontSize',       18,  ...    
       'FontWeight',   'bold',  ...    % normal
        'FontAngle', 'normal',  ...    % italic
            'Color',      'k',  ...   
     },                         ... 
  }                             ...
};

gca_FontWeight = 'normal'; % bold
gca_FrameWidth = 1.2; 

if exist('a'), aold=a; end
if exist('h'), ho=h;   end

%axis tight
axis(axis);

h=gcf; %handles of the figure
a=gca; %axes handle

% This makes the text on the axis bold and the x or y label bold and the title
set(gca,'FontWeight',gca_FontWeight); 
set(  a, 'LineWidth',gca_FrameWidth);   % This makes the width of the axis box wider

% note that it seems to matter that we do titles etc after setting to bold
for k = 1:length(opts)
  names = {}; values = {}; count = 1;
  for j = 1:2:length(opts{k}{2})
    names{count}  = opts{k}{2}{j};
    values{count} = opts{k}{2}{j+1};
    count = count + 1;
  end
  set(findobj('Type',opts{k}{1}),names,values);
end

if exist('aold'), a=aold; end
if exist('ho'  ), h=ho;   end
hold off
