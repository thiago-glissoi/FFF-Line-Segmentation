function Validate_segmentation
%   ATTENTION!
%
%   THIS IS NOT the main segmentation function. This is a validation function that should be run when
%   a verification is required to confirm that the segmentation is being performed correctly and there is
%   no different behaviours due to different Matlab/Octave versions or operating systems.
%   
%   The main segmentation function is fff_segmenter.m
%
% Validate_segmentation  This validation function run the main function and compare with known output.
% 
%
%#ok<*LOAD>
%#ok<*USENS>

disp (' ');
disp ('ATTENTION!');
disp ('This is a validation script that should be run when a verification is required to confirm ');
disp ('that the segmentation is being performed correctly and there is no different behaviours due ');
disp ('to different Matlab/Octave versions or operating systems.');
disp ('/ATTENTION!');
disp (' ');

load("Segmentation results/points segmentation results Test1.mat"); 
load ("data/Test1.mat");

fff_segmenter(Acoustic_signal, Dir_X, Dir_Y, 200e3);

importBaseWorkspaceVariables;

variablesToTest = {'resultReposition', 'resultContour', 'resultRaster', ...
                   'resultExternalPattern', 'resultInternalPattern', ...
                   'resultTransitionRaster', 'resultWholeWorkpiece'};

for k = 1:length(variablesToTest)

    varName = variablesToTest{k};
    validationVarName = [varName, '_validation'];
    
    sizeResult = size(eval(varName));
    
    flag_validation = 1;
    
    for i = 1:sizeResult(1)
        for j = 1:sizeResult(2)
            if (abs(eval([validationVarName, '{i,j}']) - eval([varName, '{i,j}'])) < 1e-10) == 0
                flag_validation = 0;
                break;
            end
        end
        if flag_validation == 0
            break;
        end
    end
    
    if flag_validation == 1
        disp(['Contour match test reference for ', varName])
    else
        disp(['Test failed when comparing contour for ', varName])
    end
end


end

function importBaseWorkspaceVariables()
    vars = evalin('base', 'who');
    
    for i = 1:length(vars)
        varName = vars{i};
        assignin('caller', varName, evalin('base', varName));
    end
    
end