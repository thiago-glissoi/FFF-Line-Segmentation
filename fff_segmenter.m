function fff_segmenter
% function fff_segmenter(sensorSignal, dirX, dirY, Fs)
%   fff_segmenter Is the main function of the FFF Line Segmentation script.
%
%% READ ME
%   To verify the readmed, alonside a example run, check <a href="matlab:
%   web('https://github.com/thiago-glissoi/FFF-Line-Segmentation')">FFF-Line-Segmentation</a> for the FFF-Line-Segmentation script on Github.
%
% MIT License
% Copyright (c) 2023 Thiago Glissoi Lopes, Paulo Monteiro de Carvalho Monson, Paulo Roberto de Aguiar, Reinaldo Götz de Oliveira Junior, Pedro Oliveira Conceição Junior
%
% The function performs the following steps:
% 1. Obtains the output options based on user inputs.
% 2. Performs the main data segmentation operations.
% 3. Calls specific subfunctions to perform secondary tasks
%    necessary to complete the segmentation operations.
%
%   For more information regarding the segmentation logic, see <a href="matlab:
%   web('https://github.com/thiago-glissoi/FFF-Line-Segmentation/blob/main/Documentation.pdf')">Documentation</a> for the FFF-Line-Segmentation script on Github.
%
% Inputs:
% - sensorSignal (array): The acoustic signal obtained from the FFF process.
% - dirX (array): The signal obtained from the X-axis step motor control.
% - dirY (array): The signal obtained from the Y-axis step motor control.
% - Fs (double): The sampling frequency of the signals.
%
% Outputs:
% - The main outputs of the function are the segmentation results, which can be
%   the segmentation index (points), in seconds or in or the segments of signal (segments), based
%   on the user's choice. These segmentation results are stored in the user current
%   matlab workspace.
% - Additionally, if the user opted for it, the segmentation results can be automatically
%   saved in .mat files in the user current matlab directory. Also, if the user opted for it,
%   the function can generate a graphical visualization of the segmentation results and
%   automatically save it to the user current matlab directory.
%
% Called subfunctions (in alphabetical order):
% <a href="matlab: disp('adjustExternalPattern: Adjust the external pattern segmentation results for a specific scenario. Please read the comments under the subfunction for further details.') ">adjustExternalPattern</a>
% <a href="matlab: disp('adjustInternalPattern: Adjust the internal pattern segmentation results for a specific scenario. Please read the comments under the subfunction for further details.') ">adjustInternalPattern</a>
% <a href="matlab: disp('adjust_internal: Adjust the internal pattern segmentation results for a specific scenario. Please read the comments under the subfunction for further details.') ">adjust_internal</a>
% <a href="matlab: disp('cleanUpWS: Clean up the base workspace from the fff_segmenter variables.') ">cleanUpWS</a>
% <a href="matlab: disp('Compos3r: Compose a signal based on the original acoustic signal and on specific segmentation indexes. Please read the comments under the subfunction for further details.') ">Compos3r</a>
% <a href="matlab: disp('convUni: convUni Obtain a time (s) value based on a number of samples value, a reference signal, and on the sampling frequency. Please read the comments under the subfunction for further details.') ">convUni</a>
% <a href="matlab: disp('detectAnom: Detect the anomaly verified in the Test1.mat dataset. Please read the comments under the subfunction for further details.') ">detectAnom</a>
% <a href="matlab: disp('determin_separation_point: Determine the separation point based on the duration matrix and on a reference duration value. Please read the comments under the subfunction for further details.') ">determin_separation_point</a>
% <a href="matlab: disp('gen_graph: Generate the graphical visualization of the segmentation results. Please read the comments under the subfunction for further details.') ">gen_graph</a>
% <a href="matlab: disp('gen_signal_segments: Generate the signal segments based on the original signal and on specific segmentation indexes. Please read the comments under the subfunction for further details.') ">gen_signal_segments</a>
% <a href="matlab: disp('generate_standard_fig: Plot the graphics with the segmentation results in a predefined format. Please read the comments under the subfunction for further details.') ">generate_standard_fig</a>
% <a href="matlab: disp('isAbnormal: Obtain the duration matrix for the internal pattern in an abnormal segmentation situation. Please read the comments under the subfunction for further details.') ">isAbnormal</a>
% <a href="matlab: disp('isNormal: Obtain the duration matrix for the internal pattern in a normal segmentation situation. Please read the comments under the subfunction for further details.') ">isNormal</a>
% <a href="matlab: disp('Normaliz3r: Normalize the amplitude of a signal between -1 and 1. Please read the comments under the subfunction for further details.') ">Normaliz3r</a>
% <a href="matlab: disp('obtainDuration: Obtain the duration matrix based on the acoustic signal and on the step motor control signals. Please read the comments under the subfunction for further details.') ">obtainDuration</a>
% <a href="matlab: disp('obtainOutput: Obtain a formated output with the segmentation results. Please read the comments under the subfunction for further details.') ">obtainOutput</a>
% <a href="matlab: disp('obtain_time_vec: Obtain a time (s) vector based on the signal's number of samples length and on the sampling frequency. Please read the comments under the subfunction for further details.') ">obtain_time_vec</a>
% <a href="matlab: disp('saveFig: Save the graphical visualization of the segmentation results in a predefined format and resolution. Please read the comments under the subfunction for further details.') ">saveFig</a>
% <a href="matlab: disp('save_files: Save the segmentation results in .mat files. Please read the comments under the subfunction for further details.') ">save_files</a>
% <a href="matlab: disp('test_Minvariations: Test for the occurence of the variation problem observed for the Test1.mat data. Please read the comments under the subfunction for further details.') ">test_Minvariations</a>

if exist('OCTAVE_VERSION', 'builtin') == 0
    % Is not running in octave
    %% APP User Inputs
    
    app = APP_User_Inputs;
    while strcmp(app.RunthesegmentationSwitch.Value,'Off') == 1
        pause(0.5); % In order to avoid missuse of the CPU
    end
    
    % Verify presence of identifications
    signalIdentifier_exists = evalin('base', ['exist(''', 'signalIdentifier', ''', ''var'')']);
    DirXidentification_exists = evalin('base', ['exist(''', 'DirXidentification', ''', ''var'')']);
    DirYidentification_exists = evalin('base', ['exist(''', 'DirYidentification', ''', ''var'')']);
    
    if signalIdentifier_exists == 1 && DirXidentification_exists == 1 &&...
            DirYidentification_exists == 1
    else
        disp ('ATTENTION!')
        disp ('A necessary signal identification was not provided.');
        disp ('Please, run the function again and provide the proper signal identifications.');
        delete(app.UIFigure);
        cleanUpWS;
        return;
    end
    
    % Verify presence of segmentation choice and xticks choice
    Segmentation_choice_exists = evalin('base', ['exist(''', 'Segmentation_choice', ''', ''var'')']);
    
    if Segmentation_choice_exists == 0
        disp ('ATTENTION!')
        disp ('The segmentation mode was not selected.');
        disp ('The function will run with the default "Points" mode of segmentation');
        segmentationChoice = 'Points';
        xticksChoice_exists = evalin('base', ['exist(''', 'xticksChoice', ''', ''var'')']);
        if xticksChoice_exists == 0
            disp ('ATTENTION!')
            disp ('The unit was not selected.');
            disp ('The function will run with the default "Segments" unit');
            xticksChoice = 'number of samples';
        else
            xticksChoice = evalin('base', 'xticksChoice');
        end
    else
        segmentationChoice = evalin('base','Segmentation_choice');
        
        if strcmp(segmentationChoice,'Points')
            xticksChoice_exists = evalin('base', ['exist(''', 'xticksChoice', ''', ''var'')']);
            if xticksChoice_exists == 0
                disp ('ATTENTION!')
                disp ('The xticks mode was not selected.');
                disp ('The function will run with the default "Segments" unit');
                xticksChoice = 'number of samples';
            else
                xticksChoice = evalin('base', 'xticksChoice');
            end
            
        end
    end
    
    % Verify saveChoice
    saveChoice_exists = evalin('base', ['exist(''', 'saveChoice', ''', ''var'')']);
    if saveChoice_exists == 1
        saveChoice = evalin('base', 'saveChoice');
    else
        saveChoice = 'N';
    end
    
    % Verify graphical representation
    graphical_exists = evalin('base', ['exist(''', 'graphical', ''', ''var'')']);
    if graphical_exists == 1
        graphical = evalin('base','graphical');
        
        if strcmp(graphical, 'Y') == 1
            % Verify option to save figure
            figureChoice_exists = evalin('base', ['exist(''', 'figureChoice', ''', ''var'')']);
            if figureChoice_exists == 1
                figureChoice = evalin('base', 'figureChoice');
            else
                figureChoice = 'N';
            end
        end
    else
        graphical = 'N';
    end
    
    % Verify Sampling frequency
    Fs_exists = evalin('base', ['exist(''', 'Fs', ''', ''var'')']);
    if Fs_exists == 1
        Fs = evalin('base', 'Fs');
    else
        disp ('ATTENTION!')
        disp ('No numerical value attributed to Sampling frequency (Fs) field.');
        disp ('Please, run the function again and provide the proper Fs value.');
        delete(app.UIFigure);
        cleanUpWS;
        return;
    end
    
    signalIdentifier = evalin('base', 'signalIdentifier');
    DirXidentification = evalin('base', 'DirXidentification');
    DirYidentification = evalin('base', 'DirYidentification');
    
    % Verify data selection
    Data_path_exists = evalin('base', ['exist(''', 'Data_path', ''', ''var'')']);
    if Data_path_exists == 1
        Data_path = evalin('base', 'Data_path');
        temp = load(Data_path); %#ok<*LOAD>
        
        fields = fieldnames(temp);
        for i = 1:length(fields)
            assignin('caller', fields{i}, temp.(fields{i}));
        end
        clear temp fields i
    else
        if exist(signalIdentifier) && exist(DirXidentification) &&...
                exist(DirYidentification)
        else
            disp ('ATTENTION!')
            disp (['No data selected on the app or one of the signals named in the' ...
                ' identifications is not present in the current workspace']);
            delete(app.UIFigure);
            cleanUpWS;
            return;
        end
    end
    
    % Verify identification
    dirX_exists = evalin('caller', ['exist(''', DirXidentification, ''', ''var'')']);
    dirY_exists = evalin('caller', ['exist(''', DirYidentification, ''', ''var'')']);
    sensorSignal_exists = evalin('caller', ['exist(''', signalIdentifier, ''', ''var'')']);
    
    if dirX_exists == 1 && dirY_exists == 1 && sensorSignal_exists == 1
        dirX = evalin('caller',DirXidentification);
        dirY = evalin('caller',DirYidentification);
        sensorSignal = evalin('caller', signalIdentifier);
    else
        disp ('ATTENTION!')
        disp (['At least one of the signals identifications did not match the selected data' ...
            ' or existent workspace variable name.']);
        delete(app.UIFigure);
        cleanUpWS;
        return;
    end
    
    
    delete(app.UIFigure);
    disp (' ');
    
end

if exist('OCTAVE_VERSION', 'builtin') ~= 0
    % Is running in octave
    
    pkg load signal
    pkg load control
    
    dirX = evalin('base',input('Please enter the signal identification for the X axis: ', 's'));
    disp (' ');
    dirY = evalin('base',input('Please enter the signal identification for the Y axis: ', 's'));
    disp (' ');
    sensorSignal = input('Please enter the signal identification for the acoustic signal: ', 's');
    signalIdentifier = sensorSignal;
    sensorSignal = evalin('base',sensorSignal);
    disp (' ');
    Fs = str2double(input('Please enter the sampling frequency of the signals: '));
    disp (' ');
    segmentationChoice = input('Do you want the segmentation results in points or segments? (Points/Segments): ', 's');
    if strcmp(segmentationChoice,'Points') == 1
        xticksChoice = input('Do you want the xticks in seconds or in number of samples? (Seconds/Samples): ', 's');
    end
    disp (' ');
    saveChoice = input('Do you want to save the segmentation results? (Y/N): ', 's');
    disp (' ');
    graphical = input('Do you want to generate the graphical representation of the segmentation results? (Y/N): ', 's');
    if strcmp(graphical, 'Y') == 1
        figureChoice = input('Do you want to save the graphical representation of the segmentation results? (Y/N): ', 's');
    end
    disp (' ');
    
    % Verify user input
    
    if strcmp(segmentationChoice,'Points') == 0 && strcmp(segmentationChoice,'Segments') == 0
        disp ('ATTENTION!')
        disp ('The segmentation mode was not selected.');
        disp ('The function will run with the default "Points" mode of segmentation');
        segmentationChoice = 'Points';
        xticksChoice = 'number of samples';
    end
    
    if strcmp(saveChoice,'Y') == 0 && strcmp(saveChoice,'N') == 0
        disp ('ATTENTION!')
        disp ('The save choice was not selected.');
        disp ('The function will run with the default "N" mode of save');
        saveChoice = 'N';
    end
    
    if strcmp(graphical,'Y') == 0 && strcmp(graphical,'N') == 0
        disp ('ATTENTION!')
        disp ('The graphical choice was not selected.');
        disp ('The function will run with the default "N" mode of graphical representation');
        graphical = 'N';
    end
    
    if strcmp(figureChoice,'Y') == 0 && strcmp(figureChoice,'N') == 0
        disp ('ATTENTION!')
        disp ('The figure choice was not selected.');
        disp ('The function will run with the default "N" mode of figure save');
        figureChoice = 'N';
    end
end

disp ("Wait just a few moments while we segment your FFF signal...");
%#ok<*EXIST>

%% Attributing values that are due to the specific part geometry to necessary variables.

% Workpice specific variables
numofRasterLines = 55; % Number of raster lines
numofContourSides = 4; % Number of contour sides
numofContourLoops = 3; % Number of contour loops
numofContourLines = numofContourSides * numofContourLoops; % Number of contour lines

% Variables for the segmentation logic
lowRefTransRaster = Fs/25; % Lower Number of samples reference value for the transition raster

if exist('OCTAVE_VERSION', 'builtin') == 0
    uppRefTransRaster = round(Fs/22.2222,0); % Upper Number of samples reference value for the transition raster
    varDurRaster = round(Fs/18.1818,0); % Variation of the duration between raster lines
    adpDurTranRaster = round(Fs/23.8095,0); % Adopted duration for the transition raster
    durationReference = round(Fs/1.33333,0); % known duration for the last contour printing
    refminimum_sampleValue = round(Fs/4,0); % Minimum number of samples reference for the test_Minvariations subfunction
    middleRasterDuration = round(Fs/0.645161290322581,0); % Middle raster duration value
else
    uppRefTransRaster = round(Fs/22.2222); % Upper Number of samples reference value for the transition raster
    varDurRaster = round(Fs/18.1818); % Variation of the duration between raster lines
    adpDurTranRaster = round(Fs/23.8095); % Adopted duration for the transition raster
    durationReference = round(Fs/1.33333); % known duration for the last contour printing
    refminimum_sampleValue = round(Fs/4); % Minimum number of samples reference for the test_Minvariations subfunction
    middleRasterDuration = round(Fs/0.645161290322581); % Middle raster duration value
end
%#ok<*AGROW> % Suppress the warning for growing arrays in the code

%% Pre-processing

dirXAdjusted = zeros(size(dirX));
dirYAdjusted = zeros(size(dirY));

% 1° Normalize the X and Y step motor control signals between 0V and 5V
dirXAdjusted(dirX > 2) = 5;
dirXAdjusted(dirX < 2) = 0;
dirYAdjusted(dirY < 2) = 0;
dirYAdjusted(dirY > 2) = 5;

% 2° Normalize the acoustic signal, and the X and Y step motor control
% signals between -1 and 1 (acoustic signal) and 0 & 1 (step motor signals)

sensorSignalNormalized = Normaliz3r(sensorSignal);
dirYAdjustedNormalized = Normaliz3r(dirYAdjusted);
dirXAdjustedNormalized = Normaliz3r(dirXAdjusted);


% 3° Test for the occurence of the variation problem
resultProblem = test_Minvariations(sensorSignalNormalized, dirXAdjustedNormalized,...
    dirYAdjustedNormalized, lowRefTransRaster);
% \ 3°

clear dirXAdjusted dirX dirYAdjusted dirY sensorSignal

%% External pattern segmentation

% result_problem = 1; % % Necessary for the May/2023 data

% 4° Obtain the duration vector
Duration = obtainDuration(sensorSignalNormalized, dirXAdjustedNormalized,...
    dirYAdjustedNormalized, resultProblem, refminimum_sampleValue);


% 5° Find the separation point

for i = 1:length(Duration(:,1))
    
    resultSep = determin_separation_point(Duration, i, durationReference);
    
    if resultSep == 1
        patternVariationPoint = Duration(i,2);
        break;
    else
        clear resultSep
    end
end
% \ 5°

% 6° Contour lines obtaining
separationIndex = find(Duration(:,3) == patternVariationPoint);
externalLines = zeros(1,13);
duration3Length = 1;

for i = 1:13
    externalLines(1,i) = Duration(separationIndex-13+i,3);
end
for i = 1:length(externalLines)-1
    indexCountourTemp(duration3Length,1) = externalLines(i+1) - externalLines(i);
    indexCountourTemp(duration3Length,2) = externalLines(i);
    indexCountourTemp(duration3Length,3) = externalLines(i+1);
    duration3Length = duration3Length+1;
end
% \ 6 °

% 7° Repositioning evaluation and contour lines correction

% reposition 1
if exist('OCTAVE_VERSION', 'builtin') == 0
    meanCountourGroup1 = round(mean([indexCountourTemp(numofContourSides-2,1) indexCountourTemp(numofContourSides-1,1)...
        indexCountourTemp(numofContourSides,1)]),0);
else
    meanCountourGroup1 = round(mean([indexCountourTemp(numofContourSides-2,1) indexCountourTemp(numofContourSides-1,1)...
        indexCountourTemp(numofContourSides,1)]));
end

adjustedContourLine1(1,1) = meanCountourGroup1;
adjustedContourLine1(1,3) = indexCountourTemp(1,3);
adjustedContourLine1(1,2) = indexCountourTemp(1,3) - meanCountourGroup1;

if indexCountourTemp(1,1) - meanCountourGroup1 < 1
    repoToContour1(1,1) = abs(indexCountourTemp(1,1) - meanCountourGroup1);
    repoToContour1(1,3) = adjustedContourLine1(1,2);
    repoToContour1(1,2) = repoToContour1(1,3)...
        - repoToContour1(1,1);
else
    repoToContour1(1,1) = indexCountourTemp(1,1) - meanCountourGroup1;
    repoToContour1(1,3) = adjustedContourLine1(1,2);
    repoToContour1(1,2) = indexCountourTemp(1,2);
end

% reposition 2
if exist('OCTAVE_VERSION', 'builtin') == 0
    meanContourGroup2 = round(mean([indexCountourTemp(6,1) indexCountourTemp(7,1)...
        indexCountourTemp(8,1)]),0);
else
    meanContourGroup2 = round(mean([indexCountourTemp(6,1) indexCountourTemp(7,1)...
        indexCountourTemp(8,1)]));
end

adjustedContourLine2(1,1) = meanContourGroup2;
adjustedContourLine2(1,3) = indexCountourTemp(5,3);
adjustedContourLine2(1,2) = indexCountourTemp(5,3) - meanContourGroup2;

repoToContour2(1,1) = indexCountourTemp(5,1) - meanContourGroup2;
repoToContour2(1,3) = adjustedContourLine2(1,2);
repoToContour2(1,2) = indexCountourTemp(5,2);

% reposition 3
if exist('OCTAVE_VERSION', 'builtin') == 0
    meanContourGroup3 = round(mean([indexCountourTemp(10,1) indexCountourTemp(11,1)...
        indexCountourTemp(numofContourLines,1)]),0);
else
    meanContourGroup3 = round(mean([indexCountourTemp(10,1) indexCountourTemp(11,1)...
        indexCountourTemp(numofContourLines,1)]));
end

adjustedContourLine3(1,1) = meanContourGroup3;
adjustedContourLine3(1,3) = indexCountourTemp(9,3);
adjustedContourLine3(1,2) = indexCountourTemp(9,3) - meanContourGroup3;

repoToContour3(1,1) = indexCountourTemp(9,1) - meanContourGroup3;
repoToContour3(1,3) = adjustedContourLine3(1,2);
repoToContour3(1,2) = indexCountourTemp(9,2);

indexContour = indexCountourTemp;
indexContour(1,:) = adjustedContourLine1;
indexContour(5,:) = adjustedContourLine2;
indexContour(9,:) = adjustedContourLine3;

contourRepositions = [repoToContour1; repoToContour2; repoToContour3];
% \ 7°

%% Internal pattern segmentation

% 8° Obtaining first duration matrix for the internal pattern
% There is no need to check for the problem of too many consecutive transition lines here
% since there are very small line segments in the internal pattern. On the contrary,
% this could cause some issues. So the result_problem value is set to 0.
resultProblem = 0;

% Obtaining duration matrix
Duration = obtainDuration(sensorSignalNormalized, ...
    dirXAdjustedNormalized,...
    dirYAdjustedNormalized, ...
    resultProblem, refminimum_sampleValue);
% \ 8°

% 9° Obtaining second duration matrix for the internal pattern

% Filtering the duration matrix to remove the small line segments
indexValuesAbvRef = 1;
Duration2 = zeros(3);
alterationDuration = lowRefTransRaster;
for i = 1:length(Duration(:,1))
    if Duration(i,1) > alterationDuration
        Duration2(indexValuesAbvRef,:) = Duration(i,:);
        indexValuesAbvRef = indexValuesAbvRef + 1;
    end
end

clear Duration
% \ 9°

% 10° Obtaining third duration matrix for the internal pattern

linesUdrUppVal = find(Duration2(:,1) < uppRefTransRaster);
Duration3 = zeros(3);
previousPeak = 0;
previousPeak2 = 0;

for i = 1:length (linesUdrUppVal)
    if i == length (linesUdrUppVal)
        break;
    end
    initialIndex = linesUdrUppVal(i);
    finalIndex = linesUdrUppVal(i+1);
    result = detectAnom(initialIndex, finalIndex);
    previousPeak2 = previousPeak;
    previousPeak = Duration3(end-1,1);
    if  previousPeak < previousPeak2 % Change of behaviour from increasing to decreasing
        break;
    end
    if  previousPeak > middleRasterDuration % Is larger than the middle raster duration,
        % found the end of the increasing behaviour
        break;
    end
    if result == 1 % normal situation
        tempDuration= isNormal( ...
            Duration2, ...
            initialIndex, ...
            finalIndex, ...
            1);
        if Duration3(1,1) == 0
            Duration3 = tempDuration;
        else
            Duration3 = [Duration3(1:end-1,:); tempDuration];
        end
        clear tempDuration
    else % abnormal situation
        tempDuration = isAbnormal( ...
            Duration2, ...
            initialIndex, ...
            finalIndex, ...
            previousPeak, varDurRaster, adpDurTranRaster);
        Duration3 = [Duration3(1:end-1,:); tempDuration];
        clear tempDuration
    end
end

clear Duration2
% \ 10°

% 11° Obtaining fourth duration matrix for the internal pattern
indexPreviousPeak2 = find (Duration3(:,1) == previousPeak2);
Duration3_v2 = Duration3(1:end-(end-indexPreviousPeak2)+1,:);
% \ 11°

clear Duration3

% 12° Obtaining fifth duration matrix for the internal pattern
% Raster area mirroring

duration3Length = length(Duration3_v2(:,1));
Duration4 = Duration3_v2;

for i = 1:length(Duration3_v2(:,1))-2
    if i == 1
        Duration4(duration3Length,1) = Duration3_v2(length(Duration3_v2(:,1))-i-1,1);
        Duration4(duration3Length,3) = Duration3_v2(length(Duration3_v2(:,1))-i,2);
        Duration4(duration3Length,2) = Duration4(duration3Length,3) + Duration4(duration3Length,1);
        duration3Length = duration3Length + 1;
    end
    if i ~= 1
        Duration4(duration3Length,1) = Duration3_v2(length(Duration3_v2(:,1))-i-1,1);
        Duration4(duration3Length,3) = Duration4(duration3Length-1,2);
        Duration4(duration3Length,2) = Duration4(duration3Length,3) + Duration4(duration3Length,1);
        duration3Length = duration3Length + 1;
    end
end

clear Duration3_v2

% \ 12°

% 13° Obtaining sixth duration matrix for the internal pattern
% Obtain the first raster line and add to the beggining of the duraction matrix
Duration4_v2(1,2) = Duration4(1,3);
Duration4_v2(1,1) = Duration4(2,1)-varDurRaster;
Duration4_v2(1,3) = Duration4_v2(1,2) - Duration4_v2(1,1);
Duration4_v2(2:length(Duration4(:,1))+1,:) = Duration4;

% Obtain the last raster line and add to the end of the duraction matrix
Duration4_v2(length(Duration4(:,1))+2,3) = Duration4_v2(length(Duration4(:,1))+1,2);
Duration4_v2(length(Duration4(:,1))+2,1) = Duration4_v2(length(Duration4(:,1)),1)-varDurRaster;
Duration4_v2(length(Duration4(:,1))+2,2) = Duration4_v2(length(Duration4(:,1))+2,1) + Duration4_v2(length(Duration4(:,1))+2,3);

clear Duration4
% \ 13°

% 14° Obtaining the index values from the last duration matrix
rasterLineCount = 1;
transitionLineCount = 1;

for j = 1:length(Duration4_v2(:,1))
    if Duration4_v2(j,1) < lowRefTransRaster || Duration4_v2(j,1) > uppRefTransRaster
        index_raster(rasterLineCount,:) = Duration4_v2(j,:);
        rasterLineCount = rasterLineCount + 1;
    else
        index_trans_raster(transitionLineCount,:) = Duration4_v2(j,:);
        transitionLineCount = transitionLineCount + 1;
    end
end

contourToRasterReposition(1,3) = indexContour(numofContourLines,3);
contourToRasterReposition(1,2) = Duration4_v2(1,3);
contourToRasterReposition(1,1) = contourToRasterReposition(1,2) -...
    contourToRasterReposition(1,3);

contourToRasterRepositionAux = contourToRasterReposition;

contourToRasterReposition(1,2) = contourToRasterRepositionAux(1,3);
contourToRasterReposition(1,3) = contourToRasterRepositionAux(1,2);

indexContourAlt = indexContour;

for i = 1:1:numofContourLines
    indexContourAlt(i,2) = indexContour(i,2);
    indexContourAlt(i,3) = indexContour(i,3)-5;
end

if length(index_raster) < numofRasterLines
    [index_raster,index_trans_raster] =...
        adjust_internal(index_raster,index_trans_raster);
    
end

% Verify external pattern integrity

square1ExternalPattern = mean (indexContourAlt(1:numofContourSides,1));
square2ExternalPattern = mean (indexContourAlt((numofContourSides+1):(numofContourSides*2),1));

if abs(square2ExternalPattern - square1ExternalPattern) > (varDurRaster+4e3)
    [contourRepositions, indexContourAlt] = adjustExternalPattern(contourRepositions, indexContourAlt);
end

%

% Verify internal pattern integrity
rasterAuxMatrix = index_raster;
rasterAuxMatrix(1,numofContourSides) = 0;

for i = 2:length(index_raster(:,1))
    rasterAuxMatrix(i,numofContourSides) = abs(index_raster(i,(numofContourSides-1)) - index_raster(i-1,2));
end

maxRasterAux = max(rasterAuxMatrix(:,numofContourSides));

indexAdjust = find (rasterAuxMatrix(:,numofContourSides) > (varDurRaster-1e3));

if maxRasterAux > uppRefTransRaster
    [index_raster, index_trans_raster] = adjustInternalPattern(index_raster, index_trans_raster, indexAdjust);
end

%

signalReposition = Compos3r(sensorSignalNormalized,contourToRasterReposition(:,2:3))+...
    Compos3r(sensorSignalNormalized,contourRepositions(:,2:3));
signalRaster = Compos3r(sensorSignalNormalized, index_raster(:,2:3));
signalTransRaster = Compos3r(sensorSignalNormalized, index_trans_raster(:,2:3));
signalContour = Compos3r(sensorSignalNormalized, indexContourAlt(:,2:3));

% \ 14°

% 15° Obtain the segmentation results

testSegmentChoice = strcmp(segmentationChoice,'Points');

testxticksChoice = strcmp(xticksChoice,'Seconds');

if testSegmentChoice == 1
    resultReposition = [contourRepositions; contourToRasterReposition];
    resultContour = indexContourAlt;
    resultRaster = index_raster;
    resultTransitionRaster = index_trans_raster;
    resultWholeWorkpiece = [resultContour(1,2) resultRaster(numofRasterLines,2)];
    resultExternalPattern = [resultContour(1,2) resultContour(numofContourLines,3)];
    resultInternalPattern = [resultRaster(1,3) resultRaster(numofRasterLines,2)];
    
    if testxticksChoice == 1
        resultReposition = convUni(sensorSignalNormalized, resultReposition, Fs);
        resultContour = convUni(sensorSignalNormalized, resultContour, Fs);
        resultRaster = convUni(sensorSignalNormalized, resultRaster, Fs);
        resultTransitionRaster = convUni(sensorSignalNormalized, resultTransitionRaster, Fs);
        resultWholeWorkpiece = convUni(sensorSignalNormalized, resultWholeWorkpiece, Fs);
        resultExternalPattern = convUni(sensorSignalNormalized, resultExternalPattern, Fs);
        resultInternalPattern = convUni(sensorSignalNormalized, resultInternalPattern, Fs);
    end
    
    resultReposition = obtainOutput(resultReposition(:,1),...
        resultReposition(:,2), resultReposition(:,3));
    resultContour = obtainOutput(resultContour(:,1),...
        resultContour(:,2), resultContour(:,3));
    resultRaster = obtainOutput(resultRaster(:,1),...
        resultRaster(:,3), resultRaster(:,2));
    resultTransitionRaster = obtainOutput(resultTransitionRaster(:,1),...
        resultTransitionRaster(:,3), resultTransitionRaster(:,2));
    
    StartPoint = resultWholeWorkpiece(1);
    EndPoint = resultWholeWorkpiece(2);
    
    if exist('OCTAVE_VERSION', 'builtin') == 0
        resultWholeWorkpiece = table(StartPoint,EndPoint);
    else
        resultWholeWorkpiece = struct();
        resultWholeWorkpiece.StartPoint = StartPoint;
        resultWholeWorkpiece.EndPoint = EndPoint;
    end
    
    
    StartPoint = resultExternalPattern(1);
    EndPoint = resultExternalPattern(2);
    
    if exist('OCTAVE_VERSION', 'builtin') == 0
        resultExternalPattern = table(StartPoint,EndPoint);
    else
        resultExternalPattern = struct();
        resultExternalPattern.StartPoint = StartPoint;
        resultExternalPattern.EndPoint = EndPoint;
    end
    
    StartPoint = resultInternalPattern(1);
    EndPoint = resultInternalPattern(2);
    
    if exist('OCTAVE_VERSION', 'builtin') == 0
        resultInternalPattern = table(StartPoint,EndPoint);
    else
        resultInternalPattern = struct();
        resultInternalPattern.StartPoint = StartPoint;
        resultInternalPattern.EndPoint = EndPoint;
    end
    
end

testSegmentChoice = strcmp(segmentationChoice,'segments');

if testSegmentChoice == 1
    resultReposition = gen_signal_segments(sensorSignalNormalized,...
        contourRepositions);
    resultReposition(1,numofContourSides) = gen_signal_segments(sensorSignalNormalized,...
        contourToRasterReposition);
    resultContour = gen_signal_segments(sensorSignalNormalized, indexContour);
    resultRaster = gen_signal_segments(sensorSignalNormalized, index_raster);
    resultTransitionRaster = gen_signal_segments(sensorSignalNormalized, index_trans_raster);
    resultWholeWorkpiece = gen_signal_segments(sensorSignalNormalized, [resultContour(1,2) resultRaster(numofRasterLines,2)]);
    resultExternalPattern = gen_signal_segments(sensorSignalNormalized, [resultContour(1,2) resultContour(numofContourLines,3)]);
    resultInternalPattern = gen_signal_segments(sensorSignalNormalized, [resultRaster(1,3) resultRaster(numofRasterLines,2)]);
end

% \ 15°

% 16° Output and optionally save the results and optionally generate the graphs
assignin('base', 'resultReposition', resultReposition);
assignin('base', 'resultContour', resultContour);
assignin('base', 'resultRaster', resultRaster);
assignin('base', 'resultTransitionRaster', resultTransitionRaster);
assignin('base', 'resultWholeWorkpiece', resultWholeWorkpiece);
assignin('base', 'resultExternalPattern', resultExternalPattern);
assignin('base', 'resultInternalPattern', resultInternalPattern);
assignin('base', 'segmentationChoice', segmentationChoice);
assignin('base', 'signalIdentifier', signalIdentifier);

if saveChoice == 'Y'
    save_files(resultReposition, resultContour, resultRaster,...
        resultTransitionRaster, resultWholeWorkpiece, resultExternalPattern,...
        resultInternalPattern, segmentationChoice, signalIdentifier);
end

if graphical == 'Y'
    gen_graph(signalReposition, sensorSignalNormalized, Fs,...
        signalIdentifier, signalContour, signalRaster,...
        signalTransRaster, index_raster, figureChoice);
end

% \ 16°

cleanUpWS;

end

% SUB1
function result = detectAnom(initialPoint, lastPoint)
% detectAnom  Detects if an abnormal segmentation situation is present while in the internal
% printing pattern segmentation logic.
% The abnormal segmentation situation is verified where multiple low duration segments are verified between two
% high duration segments. In the case of the specific part geometry and sampling frequency employed
% for the three datasets of signals collected from a first layer 3D print, these abnormal low duration segments
% are below lowRefTransRaster samples.
%
%   result = detectAnom(initialPoint, lastPoint) test if the anomaly is present between the indexes
%   initialPoint and lastPoint.
%   The abnormal segmentation situation is present when the difference between lastPoint and initialPoint is not equal to 2.
%
%   result returns 1 if the abnormal segmentation situation is not present, and 0 if it is present.


if lastPoint - initialPoint == 2
    % Normal situation
    result = 1;
else
    % Abnormal situation
    result = 0;
end
end

% SUB2
function composedDuration = isNormal(originalDuration, ...
    initialPoint, lastPoint, ...
    indexDuration)
% isNormal  Obtain the duration matrix for the internal pattern in a normal segmentation situation.
% The normal segmentation situation is verified where a low duration segment is verified between two
% high duration segments. In the case of the specific part geometry and sampling frequency employed
% for the three datasets of signals collected from a first layer 3D print, the low duration segment
% is around lowRefTransRaster samples.
%
%   composedDuration = isNormal(originalDuration, initialPoint, lastPoint, indexDuration)
%
%   where composedDuration is the resulting duration matrix, originalDuration is the original duration matrix,
%   initialPoint is the initial index of interest in this segmentation logic, lastPoint is the last point of interest
%   in this segmentation logic, and indexDuration is the reference index of the duration matrix to be composed.

% Transition period (aprox lowRefTransRaster samples)
composedDuration(indexDuration, 3) =  originalDuration(initialPoint,3);
composedDuration(indexDuration, 2) =  originalDuration(initialPoint,2);
composedDuration(indexDuration, 1) =  composedDuration(indexDuration, 2)...
    - composedDuration(indexDuration, 3);

% Raster period (value above uppRefTransRaster samples, and that increases
% varDurRaster in relation to the previous fabrication period
composedDuration(indexDuration + 1, 3) =  originalDuration(initialPoint + 1,3);
composedDuration(indexDuration + 1, 2) =  originalDuration(initialPoint + 1,2);
composedDuration(indexDuration + 1, 1) =  composedDuration(indexDuration + 1, 2)...
    - composedDuration(indexDuration + 1, 3);

% Transition period (aprox lowRefTransRaster samples)
composedDuration(indexDuration + 2, 3) =  originalDuration(lastPoint, 3);
composedDuration(indexDuration + 2, 2) =  originalDuration(lastPoint, 2);
composedDuration(indexDuration + 2, 1) =  composedDuration(indexDuration + 2, 2)...
    - composedDuration(indexDuration + 2, 3);
end

% SUB3
function composedDuration = isAbnormal(originalDuration, ...
    initialPoint, lastPoint, ...
    previousPeak, varDurRaster, adpDurTranRaster)
% isAbnormal  Obtain the duration matrix for the internal pattern in an abnormal segmentation situation.
% The abnormal segmentation situation is verified where multiple low duration segments are verified between two
% high duration segments. In the case of the specific part geometry and sampling frequency employed
% for the three datasets of signals collected from a first layer 3D print, these abnormal low duration segments
% are below lowRefTransRaster samples.
%
%   composedDuration = isAbnormal(originalDuration, initialPoint, lastPoint, previousPeak, varDurRaster, adpDurTranRaste)
%
%   where composedDuration is the resulting duration matrix, originalDuration is the original duration matrix,
%   initialPoint is the initial index of interest in this segmentation logic, lastPoint is the last point of interest
%   in this segmentation logic, previousPeak is the duration value from the last high duration segment,
%   varDurRaster is the observed duration raster for the specific part geometry with the Fs of 200kHz,
%   and adpDurTranRaster is the adopted duration for the transition raster in regard to for the specific part geometry
%   with the Fs of 200kHz.

cont = 1;
for i = initialPoint:2:lastPoint
    if lastPoint - i == 1 || lastPoint == i
        if lastPoint - initialPoint > 3
            % normal transition
            % Transition period (aprox lowRefTransRaster samples)
            composedDuration(cont, 3) =  composedDuration(cont-1, 2);
            composedDuration(cont, 2) =  originalDuration(lastPoint, 2);
            composedDuration(cont, 1) =  composedDuration(cont, 2)...
                - composedDuration(cont, 3);
            if composedDuration(cont, 1) < 0 % overlap the treshold
                aux = length(composedDuration(:,1));
                composedDuration2(:,:) = composedDuration(1:aux-2,:);
                clear composedDuration
                composedDuration =  composedDuration2;
                clear composedDuration2
                aux = length(composedDuration(:,1));
                if isscalar(aux)
                    break;
                end
                cont = cont-2;
                composedDuration(cont, 3) =  composedDuration(cont-1, 2);
                composedDuration(cont, 2) =  originalDuration(lastPoint, 2);
                composedDuration(cont, 1) =  composedDuration(cont, 2)...
                    - composedDuration(cont, 3);
                if composedDuration(cont, 1) < 0 && cont > 3% overlap the treshold
                    aux = length(composedDuration(:,1));
                    composedDuration2(:,:) = composedDuration(1:aux-2,:);
                    clear composedDuration
                    composedDuration =  composedDuration2;
                    clear composedDuration2
                    cont = cont-2;
                    composedDuration(cont, 3) =  composedDuration(cont-1, 2);
                    composedDuration(cont, 2) =  originalDuration(lastPoint, 2);
                    composedDuration(cont, 1) =  composedDuration(cont, 2)...
                        - composedDuration(cont, 3);
                end
            end
            break;
        end
    end
    if i == initialPoint % If it is the first case
        % Transition period (aprox lowRefTransRaster samples)
        composedDuration(cont, 3) =  originalDuration(i,3);
        composedDuration(cont, 2) =  originalDuration(i,2);
        composedDuration(cont, 1) =  composedDuration(cont, 2)...
            - composedDuration(cont, 3);
        cont = cont +1;
    else % Normal transition
        composedDuration(cont, 3) =  composedDuration(cont-1, 2);
        composedDuration(cont, 2) =  composedDuration(cont, 3) +...
            adpDurTranRaster;
        composedDuration(cont, 1) =  composedDuration(cont, 2)...
            - composedDuration(cont, 3);
        cont = cont +1;
    end
    % Transition period (aprox lowRefTransRaster samples), and that grows
    % varDurRaster in relation to the previous fabrication period
    composedDuration(cont, 3) =  composedDuration(cont-1, 2);
    composedDuration(cont, 2) =  composedDuration(cont, 3) +...
        previousPeak + varDurRaster;
    composedDuration(cont, 1) =  composedDuration(cont, 2)...
        - composedDuration(cont, 3);
    previousPeak = composedDuration(cont, 1);
    cont = cont +1;
    
    % Normal transition
    composedDuration(cont, 3) =  composedDuration(cont-1, 2);
    composedDuration(cont, 2) =  composedDuration(cont, 3) +...
        adpDurTranRaster;
    composedDuration(cont, 1) =  composedDuration(cont, 2)...
        - composedDuration(cont, 3);
end
end

% SUB4
function duration = obtainDuration ( ...
    sensor_signal_normalized, ...
    Dir_X_adjusted_normalized,...
    Dir_Y_adjusted_normalized, ...
    result_problem, refminimum_sampleValue)
% obtainDuration  Obtain the duration matrix from the acoustic signal and the X and Y step motor control signals.
%
%   duration = obtainDuration (sensor_signal_normalized, Dir_X_adjusted_normalized, Dir_Y_adjusted_normalized, result_problem, refminimum_sampleValue)
%
%   where duration is the resulting duration matrix, sensor_signal_normalized is the normalized acoustic signal,
%   Dir_X_adjusted_normalized is the normalized X step motor control signal, Dir_Y_adjusted_normalized is the normalized Y step motor control signal,
%   result_problem is a boolean value that indicates if the anomaly that the detectAnom function verifies is present, and refminimum_sampleValue is
%   the reference minimum sample value for the duration matrix in regard to the to the specific part geometry and with the Fs of 200 kHz.

x_value = 0;
y_value = 0;
last_change = 0;
if result_problem == 1
    minimum_sampleValue = refminimum_sampleValue;
else
    minimum_sampleValue = 0;
end

change_index = zeros(size(sensor_signal_normalized))';

for i = 1:length(sensor_signal_normalized)
    if Dir_X_adjusted_normalized(i) ~= x_value &&...
            i - last_change >= minimum_sampleValue
        x_value = Dir_X_adjusted_normalized(i);
        change_index(i) = 1;
        last_change = i;
    else
        if Dir_Y_adjusted_normalized(i) ~= y_value &&...
                i - last_change >= minimum_sampleValue
            y_value = Dir_Y_adjusted_normalized(i);
            change_index(i) = 1;
            last_change = i;
        else
            change_index(i) = 0;
        end
    end
end

flag = 0;
position_Initial = 0;
position_Final = 0;
cont = 1;

for i = 1:length(change_index)
    if change_index(i) == 1 && flag == 0
        position_Initial = i;
        flag = 1;
    else
        if change_index(i) == 1 && flag == 1
            position_Final = i;
            flag = 2;
        end
    end
    if flag == 2
        duration(cont,1) = position_Final - position_Initial; %#ok<*SAGROW>
        duration(cont,2) = position_Final;
        duration(cont,3) = position_Initial;
        cont = cont+1;
        flag = 1;
        position_Initial = position_Final;
    end
end
end

% SUB5
function result_problem = test_Minvariations(sensor_signal_normalized, Dir_X_adjusted_normalized,...
    Dir_Y_adjusted_normalized, lowRefTransRaster)
% test_Minvariations  detects the anomaly verified in the Test1.mat dataset. The anomaly present in the Test1.mat dataset
% was that of unexpected low duration segments appearing throughout the dirX signal. This was caused by interference, and was fixed
% for the Test2.mat and Test3.mat datasets printing procedures.
%
%   result_problem = test_Minvariations(sensor_signal_normalized, Dir_X_adjusted_normalized, Dir_Y_adjusted_normalized, lowRefTransRaster)
%
%       where result_problem returns the boolean value 1 if the anomaly is present, 0 if it is not, and lowRefTransRaster is the reference
%       low duration raster for the specific part geometry and with the Fs of 200 kHz.

x_value = 0;
y_value = 0;
last_change = 0;
minimum_sampleValue = 0;

change_index = zeros(size(sensor_signal_normalized))';

for i = 1:length(sensor_signal_normalized)
    if Dir_X_adjusted_normalized(i) ~= x_value &&...
            i - last_change >= minimum_sampleValue
        x_value = Dir_X_adjusted_normalized(i);
        change_index(i) = 1;
        last_change = i;
    else
        if Dir_Y_adjusted_normalized(i) ~= y_value &&...
                i - last_change >= minimum_sampleValue
            y_value = Dir_Y_adjusted_normalized(i);
            change_index(i) = 1;
            last_change = i;
        else
            change_index(i) = 0;
        end
    end
end

% Now we will obtain a duration vector, which will express, in number of
% samples, the duration between each change of direction.

flag = 0;
position_Initial = 0;
position_Final = 0;
cont = 1;

for i = 1:length(change_index)
    if change_index(i) == 1 && flag == 0
        position_Initial = i;
        flag = 1;
    else
        if change_index(i) == 1 && flag == 1
            position_Final = i;
            flag = 2;
        end
    end
    if flag == 2
        duration(cont,1) = position_Final - position_Initial; %#ok<*SAGROW>
        duration(cont,2) = position_Final;
        duration(cont,3) = position_Initial;
        cont = cont+1;
        flag = 1;
        position_Initial = position_Final;
    end
end

cont_low_dur = 0;

for i = 1:length(duration(:,1))
    if duration(i,1) < lowRefTransRaster
        cont_low_dur = cont_low_dur + 1;
    end
end

if cont_low_dur > (varDurRaster/220) % indicates the presence of the anomaly
    result_problem = 1;
else
    result_problem = 0;
end

end

% OP1
function gen_graph(signal_reposition, sensor_signal, Fs,...
    signal_identifier, signal_contour, signal_raster,...
    signal_trans_raster, index_raster, figure_choice)
% gen_graph  Generate the graphical visualization of the segmentation results. The graphical visualization is generated
% in a figure using predefined ploting parameters in order to represent the segmentation results.
%
%   gen_graph(signal_reposition, sensor_signal, Fs, signal_identifier, signal_contour, signal_raster,
%   signal_trans_raster, index_raster, figure_choice)
%
%   where signal_reposition is the signal for the reposition geometrical element, sensor_signal is the acoustic signal,
%   Fs is the sampling frequency of the signals, signal_identifier is the identifier of the figure (used for naming purposes),
%   signal_contour is the signal for the contour geometrical element, signal_raster is the signal for the raster geometrical element,
%   signal_trans_raster is the signal for the transition raster geometrical element, index_raster is the index values for the raster geometrical element,
%   and figure_choice is indicator of the choice of saving the figure in a predifed format and resolution.

sensor_signal = Normaliz3r(sensor_signal);

% Segment signals for the zoom window

sensor_signal_segmented =...
    sensor_signal(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_contour_segmented =...
    signal_contour(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_reposition_segmented =...
    signal_reposition(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_raster_segmented =...
    signal_raster(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

signal_trans_raster_segmented =...
    signal_trans_raster(index_raster(1,3)-(2.0*Fs):index_raster(1,3)+(1.5*Fs));

t_segmented = obtain_time_vec(sensor_signal_segmented,Fs);

%

t = obtain_time_vec(sensor_signal,Fs);

sensor_signal = decimate(sensor_signal,10);
signal_reposition = decimate(signal_reposition,10);

t_decimated = obtain_time_vec(sensor_signal,Fs/10);

%Obtain the last point of the external pattern index in the time domain
a = index_raster(1,3)/Fs;
xlim_min = a - 2.0;
xlim_max = a + 1.5;

if exist('OCTAVE_VERSION', 'builtin') == 0
    ticks = round(xlim_min:1:xlim_max,1);
    ticks = num2str(ticks');
else
    ticks = num2str(1:1:6);
end

figure;
subplot (2,3,1:2);
generate_standard_fig(t_decimated, sensor_signal, 1, 2,...
    'Acoustic signal', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_contour, 1, 2,...
    'Contour lines', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_decimated, signal_reposition, 1, 2,...
    'Reposition', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_raster, 1, 2,...
    'Raster lines', 0, 'Time (s)', 'Normalized amplitude', 0, 0, ...
    0, 100, -1.1, 1.1,...
    4, 'Times New Roman', 16);


% zoom
subplot (2,3,3);
generate_standard_fig(t_segmented, sensor_signal_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_contour_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_reposition_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_raster_segmented, 1, 2,...
    0, 0, 0, 0, 0:1:3.5, 0, ...
    0, length(signal_raster_segmented)/Fs, 0, 1.1,...
    5, 'Times New Roman', 16);
legend('off');
grid minor;

if exist('OCTAVE_VERSION', 'builtin') == 0
    xticklabels (ticks);
end

subplot (2,3,4:5);
generate_standard_fig(t_decimated, sensor_signal, 1, 2,...
    'Acoustic signal', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_contour, 1, 2,...
    'Contour lines', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_decimated, signal_reposition, 1, 2,...
    'Reposition', 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t, signal_trans_raster, 1, 2,...
    'Transition between raster lines',...
    0, 'Time (s)', 'Normalized amplitude', 0, 0, ...
    0, 100, -1.1, 1.1,...
    4, 'Times New Roman', 16);

%zoom
subplot (2,3,6);
generate_standard_fig(t_segmented, sensor_signal_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_contour_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_reposition_segmented, 1, 2,...
    0, 0, 0, 0, 0, 0, ...
    0, 0, -1.1, 1.1,...
    2, 'Times New Roman', 16);
generate_standard_fig(t_segmented, signal_trans_raster_segmented, 1, 2,...
    0, 0, 0, 0, 0:1:3.5, 0, ...
    0, length(signal_trans_raster_segmented)/Fs, 0, 1.1,...
    5, 'Times New Roman', 16);
legend('off');
grid minor;

if exist('OCTAVE_VERSION', 'builtin') == 0
    xticklabels (ticks);
end

if figure_choice == 'Y'
    checkFolder = isfolder('Segmentation results');
    if checkFolder == 0
        mkdir('Segmentation results');
    end
    oldFolder = cd('Segmentation results/');
    
    signal_identifier2 = ['Segmentation results ',signal_identifier, '.png'];
    saveFig(gca,'centimeters',[13 11]*1.8,600,signal_identifier2)
    cd(oldFolder);
end

end

% OP2
function save_files(result_reposition, result_contour, result_raster,...
    result_transition_raster, resultWholeWorkpiece, resultExternalPattern,...
    resultInternalPattern, segmentation_choice, signal_identifier)
% save_files  Save the segmentation results in a .mat file on the user current directory.
%
%   save_files(result_reposition, result_contour, result_raster,...
%   result_transition_raster, resultWholeWorkpiece, resultExternalPattern,...
%   resultInternalPattern, segmentation_choice, signal_identifier)
%
%   where result_reposition is the segmentation results for the reposition geometrical element, result_contour is the segmentation results for the contour geometrical element,
%   result_raster is the segmentation results for the raster geometrical element, result_transition_raster is the segmentation results for the transition raster geometrical element,
%   resultWholeWorkpiece is the segmentation results for the whole workpiece, resultExternalPattern is the segmentation results for the external pattern,
%   resultInternalPattern is the segmentation results for the internal pattern, segmentation_choice is the choice of segmentation logic,
%   and signal_identifier is the identifier of the signal (for naming purposes).

checkFolder = isfolder('Segmentation results');
if checkFolder == 0
    mkdir('Segmentation results');
end
oldFolder = cd('Segmentation results/');
save ([segmentation_choice,' segmentation results ',signal_identifier],...
    'result_reposition', 'result_contour',...
    'result_raster', 'result_transition_raster',...
    'resultWholeWorkpiece', 'resultExternalPattern',...
    'resultInternalPattern');
cd(oldFolder);
end

% AUX1
function generate_standard_fig(xaxis, yaxis, type, new_or_superimpose,...
    leg, tit, xaxis_label, yaxis_label, x_ticks, y_ticks, ...
    x_limit1, x_limit2, y_limit1, y_limit2,...
    legend_type, font_type, font_size)
% generate_standard_fig  Generate the figure for the graphical visualization using predefined ploting parameters. The figure is generated
% using predefined ploting parameters in order to represent the segmentation results in a standardized way, making it easy to spot segmentation
% inconsistencies.
%
%   generate_standard_fig(xaxis, yaxis, type, new_or_superimpose, leg, tit, xaxis_label, yaxis_label, x_ticks, y_ticks, x_limit1, x_limit2,
%   y_limit1, y_limit2, legend_type, font_type, font_size)
%
%   where xaxis is the signal that will be plotted in the X axis of the figure, yaxis is the signal that will be plotted in the Y axis of the figure,
%   type is the type of the figure, new_or_superimpose is the indicator if the plot will be new or superimposed to a existing figure,
%   leg is the legend for the figure, tit is the title for the figure, xaxis_label is the x axis label, yaxis_label is the y axis label, x_ticks
%   are the ticks of the figure's x axis, y_ticks are the ticks of the figure's y axis, x_limit1 is the lower limit in the x axis for the figure,
%   x_limit2 is the upper limit in the x axis for the figure, y_limit1 is the lower limit in the y axis for the figure, y_limit2 is the upper limit
%   in the y axis for the figure

if (new_or_superimpose == 1)
    figure;
end

if (new_or_superimpose == 2)
    hold on;
end

if (type == 1)
    if leg ~= 0
        p = plot (xaxis, yaxis, 'DisplayName', leg);
    else
        p = plot(xaxis, yaxis);
    end
    if exist('OCTAVE_VERSION', 'builtin') == 0
        p.LineWidth = 1;
    end
end

if (type == 2)
    if (leg ~= 0)
        bar (xaxis, yaxis,'DisplayName', leg)
    else
        bar (xaxis, yaxis)
    end
end
if (type == 3)
    if (leg ~= 0)
        stem (xaxis, yaxis,'DisplayName', leg)
    else
        stem (xaxis, yaxis)
    end
end

if (tit ~= 0)
    title (tit);
end

if (xaxis_label ~= 0)
    xlabel (xaxis_label);
end

if (yaxis_label ~= 0)
    ylabel (yaxis_label);
end

if (leg ~= 0)
    legend ('show');
end

aux_x_ticks = length(x_ticks);

if (aux_x_ticks ~= 1)
    xticks (x_ticks);
end

aux_y_ticks = length(y_ticks);

if (aux_y_ticks ~= 1)
    yticks (y_ticks);
end

if (x_limit2 ~= 0)
    xlim ([x_limit1 x_limit2]);
end

if (y_limit2 ~= 0)
    ylim ([y_limit1 y_limit2]);
end

if (font_type ~= 0)
    set(gca,'fontname', font_type, 'fontsize', font_size);
end

if (leg ~= 0)
    if (legend_type == 1)
        legend('Location','best');
    end
    
    if (legend_type == 2 || legend_type == 0)
        legend('Location','northeast');
    end
    
    if (legend_type == 3)
        legend('Location','northwest');
    end
    
    if (legend_type == 4)
        legend('Location','southwest');
    end
    
    if (legend_type == 5)
        legend('Location','southeast');
    end
end

set(gcf, 'Position', get(0, 'Screensize'));
grid on;
grid minor;

if (new_or_superimpose == 2)
    hold on;
    numb_fig = size(allchild(gca));
    numb_fig_v = numb_fig(1,1);
    if exist('OCTAVE_VERSION', 'builtin') == 0
        numb_col = round(numb_fig_v/4,0);
    else
        numb_col = round(numb_fig_v/4);
    end
    if numb_col == 0
        numb_col = 1;
    end
    legend('NumColumns',numb_col);
    
    ordem_cor = [0.00,0.45,0.74; 0.85,0.33,0.10; 0.93,0.69,0.13;...
        0.49,0.18,0.56; 0.47,0.67,0.19; 0.30,0.75,0.93;...
        0.64,0.08,0.18; 0.85,0.85,0.35; 0.07,0.62,1.00;...
        1.00,0.55,0.00; 0.39,0.83,0.07; 0.72,0.27,1.00;...
        0.41,0.82,0.82; 1.00,0.07,0.65; 1.00,0.00,0.00;...
        0.65,0.65,0.65; 0.00, 1.00,0.00; 0.00,0.00, 1.00;...
        0.00,0.00,0.00];
    if exist('OCTAVE_VERSION', 'builtin') == 0
        colororder(ordem_cor(1:numb_fig_v,:));
    end
end

end

% AUX2
function saveFig(hFigure, unit, size, res, fileName)
% saveFig  Save the graphical visualization figure in a predetermined format and resolution on the user current directory.
%
%   saveFig(hFigure, unit, size, res, fileName)
%
%   where hFigure is the handler of the figure, unit is the unit of the figure, size is the size of the figure, res is the resolution of the figure,
%   and fileName is the name of the file that the figure will be saved.

try
    if strcmp(get(hFigure,'Type'),'axes')
        hFigure = get(hFigure,'Parent');
    elseif ~strcmp(get(hFigure,'Type'),'figure')
        error('Error:saveFig','The informed handler is not of type ''figure''.')
    end
catch me
    error('Error:saveFig','The informed handler is not valid.')
end

unitVal = strcmp(unit, {'normalized' 'inches' 'centimeters' 'points'});
if sum(unitVal) == 0
    error('Error:saveFig', ['The informed unit is not valid.\nValores aceitos:\n\t- normalized'...
        '\n\t- points\n\t- centimeters\n\t- inches']);
elseif sum(unitVal) > 1
    error('Error:saveFig', 'Please, inform only one unit.')
end

if isa(res,'double')
    res = ['-r' num2str(res)];
elseif strncmp('-r', res, 2) == 0
    error('Error:saveFig', 'The value informed for the resolution is not valid.')
end

pos_ = [0 0 size(1) size(2)];

set(hFigure, 'PaperUnits', unit);
set(hFigure, 'PaperSize', size);
set(hFigure, 'PaperOrientation', 'portrait');
set(hFigure, 'PaperPositionMode', 'manual');
set(hFigure, 'PaperPosition', pos_);

print(hFigure, '-loose', res, '-djpeg', fileName);

end

% AUX3
function vector_normalized = Normaliz3r (original_vector)
% vector_normalized  Normalize the amplitude of a signal between -1 and 1, or between 0 and 1 (if its an
% signal which the amplitude variates between 0 and 1).
%
%   vector_normalized = Normaliz3r (original_vector)
%
%   where vector_normalized is the normalized signal, and original_vector is the original signal.

aux1 = max(original_vector);
aux2 = original_vector*-1;
aux3 = max(aux2);

if aux3 >= aux1
    aux1 = aux3;
end

vector_normalized = original_vector/aux1;

end

% AUX4
function vector_t = obtain_time_vec(signal,Fs)
% obtain_time_vec  Obtain a time (s) vector based on the signal's number of samples length and on the sampling frequency.
%
%   vector_t = obtain_time_vec(signal,Fs)
%
%   where vector_t is the time vector (in seconds), signal is the reference signal, and Fs is the sampling frequency of the reference signal.


vector_t = 0:(1/Fs):(length(signal)-1)/Fs;
end

% AUX6
function composedSignal = Compos3r(original_signal, position_matrix)
% Compos3r  Compose a signal based on the original acoustic signal and on specific segmentation indexes.
%
%   composedSignal = Compos3r(original_signal, position_matrix)
%
%   where composedSignal is the resulting composed signal, original_signal is the original signal, and
%   position_matrix holds the specific segmentation indexes.

aux = zeros(length(original_signal),1);

if position_matrix(1,1) > position_matrix(1,2)
    low_column = 2;
    high_column = 1;
else
    low_column = 1;
    high_column = 2;
end

min_situation = [1,2];

for i = 1:length(position_matrix)
    aux(position_matrix(i,low_column):position_matrix(i,high_column)) = 1;
    if size(position_matrix) == min_situation %#ok<BDSCI>
        break;
    end
end
composedSignal = aux;
end

% AUX7
function result_sep = determin_separation_point(Duration, i,...
    duration_reference)
% determin_separation_point  Determine the separation point between internal and external patterns based on the
% duration matrix and on a reference duration value.
%
%   result_sep = determin_separation_point(Duration, i, duration_reference)
%
%   where result_sep is the separation point between internal and external patterns, Duration is the duration matrix,
%   i is the index of the duration matrix, and duration_reference is the reference duration value

current_value = Duration(i,1);
next_value1 = Duration(i+1,1);
next_value2 = Duration(i+2,1);
next_value3 = Duration(i+3,1);
next_value4 = Duration(i+4,1);
next_value5 = Duration(i+5,1);

next_sub1 = current_value - next_value1;
next_sub2 = current_value - next_value2;
next_sub3 = current_value - next_value3;
next_sub4 = current_value - next_value4;
next_sub5 = current_value - next_value5;

if next_sub1 >= duration_reference && ...
        next_sub2 >= duration_reference && ...
        next_sub3 >= duration_reference && ...
        next_sub4 >= duration_reference && ...
        next_sub5 >= duration_reference && ...
        next_value1 < duration_reference && ...
        next_value2 < duration_reference && ...
        next_value3 < duration_reference && ...
        next_value4 < duration_reference && ...
        next_value5 < duration_reference
    result_sep = 1;
else
    result_sep = 0;
end
end

% AUX8
function signal_segments = gen_signal_segments(raw_signal, index_matrix)
% gen_signal_segments  Generate the signal segments based on the original signal and on specific segmentation indexes.
%
%   signal_segments = gen_signal_segments(raw_signal, index_matrix)
%
%   where signal_segments is the resulting signal segments, raw_signal is the original signal, and index_matrix holds
%   the specific segmentation indexes.

num_interactions = size (index_matrix,1);

if index_matrix(1,2) > index_matrix(1,3)
    low_column = 3;
    high_column = 2;
else
    low_column = 2;
    high_column = 3;
end

for var_num_interactions = 1:num_interactions
    signal_segments{:,var_num_interactions} = ...
        raw_signal(index_matrix(var_num_interactions,low_column)...
        :index_matrix(var_num_interactions,high_column));
end

end

% AUX9

function [index_raster_alt,index_trans_raster_alt] =...
    adjust_internal(index_raster,index_trans_raster)
% adjust_internal Adjust the internal pattern segmentation results for a specific scenario. The adjustment is made
% when small duration segments are present at the beggining or end of the internal printing pattern, which would affect
% the number of raster lines and the overall segmentation process in regard to the internal printing pattern.
%
%   [index_raster_alt,index_trans_raster_alt] = adjust_internal(index_raster,index_trans_raster)
%
%   where index_raster_alt is the adjusted raster line, index_trans_raster_alt is the adjusted transition raster line,
%   index_raster is the original raster line, and index_trans_raster is the original transition raster line.

index_trans_raster_alt = index_trans_raster;

id_index_raster = 0;

for i = 2:length(index_raster)
    if (abs(index_raster(i,1)-index_raster(i-1,1))) > 12e3
        qnt = floor(abs((index_raster(i,1)-index_raster(i-1,1)))/varDurRaster);
        id_index_raster(i,1) = qnt-1;
    else
        id_index_raster(i,1) = 0;
    end
end

ind_id = find(id_index_raster > 0);

aux1 = 1;
index_raster_alt = [0 0 0];

for j = 1:length(ind_id)
    
    index_raster_alt = [index_raster_alt;...
        index_raster(aux1:ind_id(j)-1,1:3)];
    
    last_peak = index_raster_alt(end,1:3);
    
    for k = 1:id_index_raster(ind_id(j))
        
        if ind_id(j) < 27
            temp_mat(k,1) = last_peak(1,1) + varDurRaster;
            temp_mat(k,3) = last_peak(1,2) + adpDurTranRaster;
            temp_mat(k,2) = temp_mat(k,3) + temp_mat(k,1);
        else
            temp_mat(k,1) = last_peak(1,1) - varDurRaster;
            temp_mat(k,3) = last_peak(1,2) + adpDurTranRaster;
            temp_mat(k,2) = temp_mat(k,3) + temp_mat(k,1);
            
        end
        last_peak = temp_mat(end,1:3);
        
    end
    index_raster_alt = [index_raster_alt;...
        temp_mat];
    clear temp_mat last_peak
    
    aux1 = ind_id(j);
    
    if j == length(ind_id)
        index_raster_alt = [index_raster_alt;...
            index_raster(aux1:end,1:3)];
    end
    
    
end

index_raster_alt = index_raster_alt(2:end,:);
b = find(index_raster_alt(:,1)==max(index_raster_alt(:,1)));
index_raster_alt = index_raster_alt(1:b,:);

% mirror in the middle
middle = length(index_raster_alt);

for i = 1:middle
    if i < middle
        index_raster_alt_2(i,1) = index_raster_alt(middle-i,1);
    else
        break;
    end
    if i == 1
        index_raster_alt_2(i,3) =...
            index_raster_alt(middle,2)+...
            adpDurTranRaster;
    else
        index_raster_alt_2(i,3) =...
            index_raster_alt_2(end-1,2) + adpDurTranRaster;
    end
    index_raster_alt_2(i,2) =...
        index_raster_alt_2(i,1)+index_raster_alt_2(i,3);
    
end

index_raster_alt = [index_raster_alt;index_raster_alt_2];

end

% AUX10

function [contourRepositions_corr, indexContour_corr] =...
    adjustExternalPattern(contourRepositions, indexContour)
% adjustExternalPattern Adjust the external pattern segmentation results for a specific scenario. The adjustment is made
% when small duration segments are present between the movements without deposition (reposition), which would affect the identification of
% the contours geometrical features in regard to the movements without deposition and the overall segmentation process in regard
% to the external printing pattern.
%
%   [contourRepositions_corr, indexContour_corr] = adjustExternalPattern(contourRepositions, indexContour)
%
%   where contourRepositions_corr is the adjusted reposition geometrical element, indexContour_corr is the adjusted index of the contour geometrical element,
%   contourRepositions is the original reposition geometrical element, and indexContour is the original index of the contour geometrical element.

med_quad_ext = mean(indexContour((numofContourSides+1):(numofContourSides*2),1));

dif_quad = indexContour((numofContourSides*2),1) - indexContour((numofContourSides+1),1);

dif_ini = med_quad_ext - dif_quad;

correct_square = zeros(numofContourSides,3);

correct_square(numofContourSides,3) = contourRepositions(numofContourSides-2,2);
correct_square(numofContourSides,2) = floor(correct_square(numofContourSides,3) - dif_ini);
correct_square(numofContourSides,1) = floor(abs(correct_square(numofContourSides,2) - correct_square(numofContourSides,3)));

correct_square(numofContourSides-1,3) = correct_square(numofContourSides,2) - numofContourSides;
correct_square(numofContourSides-1,2) = floor(correct_square(numofContourSides-1,3) - dif_ini - (numofContourSides+1));
correct_square(numofContourSides-1,1) = floor(abs(correct_square(numofContourSides-1,2) - correct_square(numofContourSides-1,3)));

correct_square(numofContourSides-2,3) = correct_square(numofContourSides-1,2) - numofContourSides;
correct_square(numofContourSides-2,2) = floor(correct_square(numofContourSides-2,3) - dif_ini - numofContourSides-1);
correct_square(numofContourSides-2,1) = floor(abs(correct_square(numofContourSides-2,2) - correct_square(numofContourSides-2,3)));

correct_square(numofContourSides-3,3) = correct_square(numofContourSides-2,2) - numofContourSides;
correct_square(numofContourSides-3,2) = floor(correct_square(numofContourSides-3,3) - dif_ini + numofContourSides);
correct_square(numofContourSides-3,1) = floor(abs(correct_square(numofContourSides-3,2) - correct_square(numofContourSides-3,3)));

contourRepositions(numofContourSides-3,3) = correct_square(numofContourSides-3,2) - numofContourSides;
contourRepositions_corr(1,2) = floor(contourRepositions(1,3) - contourRepositions(1,1));

indexContour_corr(1:numofContourSides,:) = correct_square;

end

% AUX11

function [index_raster, index_trans_raster] =...
    adjustInternalPattern(index_raster, index_trans_raster, indexAdjust)
% adjustInternalPattern Adjust the internal pattern segmentation results for a specific scenario. The adjustment is made
% when there are multiple small duration segments mixed with the middle raster duration segmenter and both previous and subsequent
% transition raster , which would affect the identification of the middle raster index in regard to the previous and subsequent transition
% between raster and the overall segmentation process in regard to the internal printing pattern.
%
%   [index_raster, index_trans_raster] = adjustInternalPattern(index_raster, index_trans_raster, indexAdjust)
%
%   where index_raster is the adjusted raster index, index_trans_raster is the adjusted transition raster index,
%   index_raster is the original raster index, index_trans_raster is the original transition raster index, and indexAdjust is a reference index of adjustment.

index_rasterAdj = index_raster;
index_trans_rasterAdj = index_trans_raster;

for i = indexAdjust(1):indexAdjust(end)
    
    index_rasterAdj(i,3) = index_rasterAdj(i-1,2) + index_trans_rasterAdj(i-1,1);
    index_rasterAdj(i,2) = index_rasterAdj(i,3) + index_rasterAdj(i,1);
    
    index_trans_rasterAdj(i-1,3) = index_rasterAdj(i-1,2);
    index_trans_rasterAdj(i-1,2) = index_trans_rasterAdj(i-1,3) + index_trans_rasterAdj(i-1,1);
    
end

index_raster = index_rasterAdj;
index_trans_raster = index_trans_rasterAdj;

end

% AXU12

function valueSeconds = convUni(Ref, valueNumberofSamples, Fs)
% convUni Obtain a time (s) value based on a number of samples value, a reference signal, and on the sampling frequency.
%
%   valueSeconds = convUni(Ref, valueNumberofSamples, Fs)
%
%   where valueSeconds is the time value (in seconds), Ref is the reference signal, valueNumberofSamples is the number of samples value,
%   and Fs is the sampling frequency of the reference signal.

lengthRef = length(Ref);
duration = lengthRef/Fs;

valueSeconds = ((duration*valueNumberofSamples)/lengthRef);

end

% AUX13

function resultingOutput = obtainOutput(DurationMat, startPointMat, endPointMat)
% resultingOutput Obtain a formated output with the segmentation results.
%
%   resultingOutput = obtainOutput(DurationMat, startPointMat, endPointMat)
%
%   where resultingOutput is the obtained formated ouput, DurationMat is the duration matrix, startPointMat is the start point matrix,
%   and endPointMat is the end point matrix.

Duration = DurationMat;
StartPoint = startPointMat;
EndPoint = endPointMat;

if exist('OCTAVE_VERSION', 'builtin') == 0
    resultingOutput = table(Duration,StartPoint,EndPoint);
else
    resultingOutput = struct();
    resultingOutput.Duration = Duration;
    resultingOutput.StartPoint = StartPoint;
    resultingOutput.EndPoint = EndPoint;
end
end

% AUX14

function cleanUpWS
% cleanUpWS Clean up the 'base' workspace from the fff_segmenter algorithm variables.

clear segmentationChoice;
varargin = ({'DirXidentification', 'DirYidentification', 'figureChoice', 'Fs',...
    'graphical', 'saveChoice', 'Segmentation_choice', 'segmentationChoice',...
    'signalIdentifier', 'xticksChoice'});
for i = 1:length(varargin)
    varName = varargin{i};
    evalin('base', ['clear ', varName]);
end



end
