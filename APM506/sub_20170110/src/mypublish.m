%% mypublish.m
% =====================================================================
% A function to publish specified script with pdf as the default output.
% ---------------------------------------------------------------------

function mypublish(target_script)
  options = struct(     ...
       'format','pdf',  ...
    'outputDir',  '.'   ...
  );
  publish(target_script,options);
end
