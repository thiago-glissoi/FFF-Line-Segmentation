function fff_segmenter(sensorSignal, dirX, dirY, Fs)
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
% <a href="matlab: disp('Compos3r: Compose a signal based on the original acoustic signal and on specific segmentation indexes. Please read the comments under the subfunction for further details.') ">Compos3r</a>
% <a href="matlab: disp('convUni: convUni Obtain a time (s) value based on a number of samples value, a reference signal, and on the sampling frequency. Please read the comments under the subfunction for further details.') ">convUni</a>
% <a href="matlab: disp('detectAnom: Detect the anomaly verified in the Test1.mat dataset. Please read the comments under the subfunction for further details.') ">detectAnom</a>
% <a href="matlab: disp('determin_separation_point: Determine the separation point based on the duration matrix and on a reference duration value. Please read the comments under the subfunction for further details.') ">determin_separation_point</a>
% <a href="matlab: disp('gen_graph: Generate the graphical visualization of the segmentation results. Please read the comments under the subfunction for further details.') ">gen_graph</a>
% <a href="matlab: disp('gen_signal_segments: Generate the signal segments based on the original signal and on specific segmentation indexes. Please read the comments under the subfunction for further details.') ">gen_signal_segments</a>
% <a href="matlab: disp('generate_standard_fig: Plot the graphics with the segmentation results in a predefined format. Please read the comments under the subfunction for further details.') ">generate_standard_fig</a>
% <a href="matlab: disp('isAnormal: Obtain the duration matrix for the internal pattern in an abnormal segmentation situation. Please read the comments under the subfunction for further details.') ">isAnormal</a>
% <a href="matlab: disp('isNormal: Obtain the duration matrix for the internal pattern in a normal segmentation situation. Please read the comments under the subfunction for further details.') ">isNormal</a>
% <a href="matlab: disp('Normaliz3r: Normalize the amplitude of a signal between -1 and 1. Please read the comments under the subfunction for further details.') ">Normaliz3r</a>
% <a href="matlab: disp('obtainDuration: Obtain the duration matrix based on the acoustic signal and on the step motor control signals. Please read the comments under the subfunction for further details.') ">obtainDuration</a>
% <a href="matlab: disp('obtainTable: Obtain a table with the segmentation results. Please read the comments under the subfunction for further details.') ">obtainTable</a>
% <a href="matlab: disp('obtain_time_vec: Obtain a time (s) vector based on the signal's number of samples length and on the sampling frequency. Please read the comments under the subfunction for further details.') ">obtain_time_vec</a>
% <a href="matlab: disp('saveFig: Save the graphical visualization of the segmentation results in a predefined format and resolution. Please read the comments under the subfunction for further details.') ">saveFig</a>
% <a href="matlab: disp('save_files: Save the segmentation results in .mat files. Please read the comments under the subfunction for further details.') ">save_files</a>
% <a href="matlab: disp('test_Minvariations: Test for the occurence of the variation problem observed for the Test1.mat data. Please read the comments under the subfunction for further details.') ">test_Minvariations</a>


%% Input prompts
clc;
disp ("Provide the signal identification");
prompt = "Signal name: ";
signalIdentifier = input(prompt,"s");
if isempty(signalIdentifier)
    signalIdentifier = 'segmentation results';
end
clear prompt
clc;

disp ("Would you like to obtain the segmentation index (points) or the segments of signal (segments)? ");
prompt = "Response points/segments [points]: ";
segmentationChoice = input(prompt,"s");
if isempty(segmentationChoice)
    segmentationChoice = 'points';
end

testSegmentChoicePoints = strcmp(segmentationChoice,'points');
testSegmentChoiceSegments = strcmp(segmentationChoice,'segments');

if testSegmentChoicePoints ~= 1 && testSegmentChoiceSegments ~= 1
    segmentationChoice = 'points';
end

clear prompt
clc;

testSegmentChoice = strcmp(segmentationChoice,'points');

if testSegmentChoice == true
    disp ("Would you like to obtain the segmentation index (points)");
    disp ("in number of samples or in seconds? ");
    prompt = "Response number of samples/seconds [number of samples]: ";
    xticksChoice = input(prompt,"s");
    if isempty(xticksChoice)
        xticksChoice = 'number of samples';
    end
    testxticksChoiceNumber = strcmp(xticksChoice,'number of samples');
    testxticksChoiceSeconds = strcmp(xticksChoice,'seconds');
    if testxticksChoiceNumber ~= 1 && testxticksChoiceSeconds ~= 1
        xticksChoice = 'number of samples';
    end

end

clear prompt
clc;

disp ("Would you like to obtain graphical visualization of the segmentation?");
prompt = "Response Y/N [Y]: ";
graphical = input(prompt, "s");
if isempty(graphical)
    graphical = 'Y';
end

testGraphicalChoiceY = strcmp(graphical,'Y');
testGraphicalChoiceN = strcmp(graphical,'N');

if testGraphicalChoiceY ~= 1 && testGraphicalChoiceN ~= 1
    segmentationChoice = 'Y';
end

clear prompt
clc;
if graphical == 'Y'
    disp("Would you like to autosave the figures?");
    prompt = "Response Y/N [Y]: ";
    figureChoice = input(prompt, "s");
    if isempty(figureChoice)
        figureChoice = 'Y';
    end

    testFigureChoiceY = strcmp(figureChoice,'Y');
    testFigureChoiceN = strcmp(figureChoice,'N');

    if testFigureChoiceY ~= 1 && testFigureChoiceN ~= 1
        figureChoice = 'Y';
    end

    clc;
    clear prompt
end

disp("Would you like to obtain automatic .mat files of the segmentation results?");
prompt = "Response Y/N [Y]: ";
saveChoice = input(prompt,'s');
if isempty(saveChoice)
    saveChoice = 'Y';
end

testSaveChoiceY = strcmp(saveChoice,'Y');
testSaveChoiceN = strcmp(saveChoice,'N');

if testSaveChoiceY ~= 1 && testSaveChoiceN ~= 1
    saveChoice = 'Y';
end

clc;
clear prompt

disp ("Choices");
disp ("Signal name: ");
disp (signalIdentifier);
disp ("Segmentation choice: ");
disp (segmentationChoice);

testSegmentChoice = strcmp(segmentationChoice,'points');

if testSegmentChoice == true
disp ("xticksChoice: ");
disp (xticksChoice);
end

disp ("Graphical choice: ");
disp (graphical);
if graphical == 'Y'
    disp ("Save figure choice: ");
    disp (figureChoice);
end
disp ("Save data choice: ");
disp (saveChoice);
disp ("Wait just a few moments while we segment your FFF signal...");

%% Pre-processing

dirXAdjusted = zeros(size(dirX));
dirYAdjusted = zeros(size(dirY));

% 1° Normalize the X and Y step motor control signals between 0V and 5V
for i = 1:length(dirX)
    if dirX(i) > 2
        dirXAdjusted(i) = 5;
    else
        dirXAdjusted(i) = 0;
    end
end

for i = 1:length(dirY)
    if dirY(i) > 2
        dirYAdjusted(i) = 5;
    else
        dirYAdjusted(i) = 0;
    end
end

% 2° Normalize the acoustic signal, and the X and Y step motor control
% signals between -1 and 1 (acoustic signal) and 0 & 1 (step motor signals)

sensorSignalNormalized = Normaliz3r(sensorSignal);
dirYAdjustedNormalized = Normaliz3r(dirYAdjusted);
dirXAdjustedNormalized = Normaliz3r(dirXAdjusted);


% 3° Test for the occurence of the variation problem
resultProblem = test_Minvariations(sensorSignalNormalized, dirXAdjustedNormalized,...
    dirYAdjustedNormalized);
% \ 3°

clear dirXAdjusted dirX dirYAdjusted dirY sensorSignal

%% External pattern segmentation

% result_problem = true; % % Necessary for the May/2023 data

% 4° Obtain the duration vector
Duration = obtainDuration(sensorSignalNormalized, dirXAdjustedNormalized,...
    dirYAdjustedNormalized, resultProblem);


% 5° Find the separation point
durationReference = 150e3; % known duration for the last contour printing

for i = 1:length(Duration(:,1))

    resultSep = determin_separation_point(Duration, i, durationReference);

    if resultSep == true
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

% 7° Repositioning evaluation and contour lines correction

% reposition 1
meanCountourGroup1 = round(mean([indexCountourTemp(2,1) indexCountourTemp(3,1)...
    indexCountourTemp(4,1)]),0);

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
meanContourGroup2 = round(mean([indexCountourTemp(6,1) indexCountourTemp(7,1)...
    indexCountourTemp(8,1)]),0);

adjustedContourLine2(1,1) = meanContourGroup2;
adjustedContourLine2(1,3) = indexCountourTemp(5,3);
adjustedContourLine2(1,2) = indexCountourTemp(5,3) - meanContourGroup2;

repoToContour2(1,1) = indexCountourTemp(5,1) - meanContourGroup2;
repoToContour2(1,3) = adjustedContourLine2(1,2);
repoToContour2(1,2) = indexCountourTemp(5,2);

% reposition 3
meanContourGroup3 = round(mean([indexCountourTemp(10,1) indexCountourTemp(11,1)...
    indexCountourTemp(12,1)]),0);

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
% since there are very small line segments in the internal pattern. On the cobtrary,
% this could cause some issues. So the result_problem value is set to false.
resultProblem = false;

% Obtaining duration matrix
Duration = obtainDuration(sensorSignalNormalized, ...
    dirXAdjustedNormalized,...
    dirYAdjustedNormalized, ...
    resultProblem);

% 9° Obtaining second duration matrix for the internal pattern

% Filtering the duration matrix to remove the small line segments
indexValuesAbv8000 = 1;
Duration2 = zeros(3);
alterationDuration = 8000;
for i = 1:length(Duration(:,1))
    if Duration(i,1) > alterationDuration
        Duration2(indexValuesAbv8000,:) = Duration(i,:);
        indexValuesAbv8000 = indexValuesAbv8000 + 1;
    end
end

clear Duration

% 10° Obtaining third duration matrix for the internal pattern

linesUdr9000 = find(Duration2(:,1) < 9000);
Duration3 = zeros(3);
previousPeak = 0;
previousPeak2 = 0;
middleRasterDuration = 310e3;

for i = 1:length (linesUdr9000)
    if i == length (linesUdr9000)
        break;
    end
    initialIndex = linesUdr9000(i);
    finalIndex = linesUdr9000(i+1);
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
    if result == true % normal situation
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
        tempDuration = isAnormal( ...
            Duration2, ...
            initialIndex, ...
            finalIndex, ...
            previousPeak);
        Duration3 = [Duration3(1:end-1,:); tempDuration];
        clear tempDuration
    end
end

clear Duration2

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
% \ 12°

clear Duration3_v2



% 13° Obtaining sixth duration matrix for the internal pattern
% Obtain the first raster line and add to the beggining of the duraction matrix
Duration4_v2(1,2) = Duration4(1,3);
Duration4_v2(1,1) = Duration4(2,1)-11e3;
Duration4_v2(1,3) = Duration4_v2(1,2) - Duration4_v2(1,1);
Duration4_v2(2:length(Duration4(:,1))+1,:) = Duration4;

% Obtain the last raster line and add to the end of the duraction matrix
Duration4_v2(length(Duration4(:,1))+2,3) = Duration4_v2(length(Duration4(:,1))+1,2);
Duration4_v2(length(Duration4(:,1))+2,1) = Duration4_v2(length(Duration4(:,1)),1)-11e3;
Duration4_v2(length(Duration4(:,1))+2,2) = Duration4_v2(length(Duration4(:,1))+2,1) + Duration4_v2(length(Duration4(:,1))+2,3);
% \ 13°

clear Duration4


% 14° Obtaining the index values from the last duration matrix
rasterLineCount = 1;
transitionLineCount = 1;

for j = 1:length(Duration4_v2(:,1))
    if Duration4_v2(j,1) < 8000 || Duration4_v2(j,1) > 9000
        index_raster(rasterLineCount,:) = Duration4_v2(j,:);
        rasterLineCount = rasterLineCount + 1;
    else
        index_trans_raster(transitionLineCount,:) = Duration4_v2(j,:);
        transitionLineCount = transitionLineCount + 1;
    end
end

contourToRasterReposition(1,3) = indexContour(12,3);
contourToRasterReposition(1,2) = Duration4_v2(1,3);
contourToRasterReposition(1,1) = contourToRasterReposition(1,2) -...
    contourToRasterReposition(1,3);

contourToRasterRepositionAux = contourToRasterReposition;

contourToRasterReposition(1,2) = contourToRasterRepositionAux(1,3);
contourToRasterReposition(1,3) = contourToRasterRepositionAux(1,2);

indexContourAlt = indexContour;

for i = 1:1:12
    indexContourAlt(i,2) = indexContour(i,2);
    indexContourAlt(i,3) = indexContour(i,3)-5;
end

if length(index_raster) < 55
    [index_raster,index_trans_raster] =...
        adjust_internal(index_raster,index_trans_raster);

end

% Verify external pattern integrity

square1ExternalPattern = mean (indexContourAlt(1:4,1));
square2ExternalPattern = mean (indexContourAlt(5:8,1));

if abs(square2ExternalPattern - square1ExternalPattern) > 15e3
    [contourRepositions, indexContourAlt] = adjustExternalPattern(contourRepositions, indexContourAlt);
end

%

% Verify internal pattern integrity
rasterAuxMatrix = index_raster;
rasterAuxMatrix(1,4) = 0;

for i = 2:length(index_raster(:,1))
    rasterAuxMatrix(i,4) = abs(index_raster(i,3) - index_raster(i-1,2));
end

maxRasterAux = max(rasterAuxMatrix(:,4));

indexAdjust = find (rasterAuxMatrix(:,4) > 10e3);

if maxRasterAux > 9e3
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

testSegmentChoice = strcmp(segmentationChoice,'points');

testxticksChoice = strcmp(xticksChoice,'seconds');

if testSegmentChoice == true
    resultReposition = [contourRepositions; contourToRasterReposition];
    resultContour = indexContourAlt;
    resultRaster = index_raster;
    resultTransitionRaster = index_trans_raster;
    resultWholeWorkpiece = [resultContour(1,2) resultRaster(55,2)];
    resultExternalPattern = [resultContour(1,2) resultContour(12,3)];
    resultInternalPattern = [resultRaster(1,3) resultRaster(55,2)];

    if testxticksChoice == true
        resultReposition = convUni(sensorSignalNormalized, resultReposition, Fs);
        resultContour = convUni(sensorSignalNormalized, resultContour, Fs);
        resultRaster = convUni(sensorSignalNormalized, resultRaster, Fs);
        resultTransitionRaster = convUni(sensorSignalNormalized, resultTransitionRaster, Fs);
        resultWholeWorkpiece = convUni(sensorSignalNormalized, resultWholeWorkpiece, Fs);
        resultExternalPattern = convUni(sensorSignalNormalized, resultExternalPattern, Fs);
        resultInternalPattern = convUni(sensorSignalNormalized, resultInternalPattern, Fs);
    end

    resultReposition = obtainTable(resultReposition(:,1),...
        resultReposition(:,2), resultReposition(:,3));
    resultContour = obtainTable(resultContour(:,1),...
        resultContour(:,2), resultContour(:,3));
    resultRaster = obtainTable(resultRaster(:,1),...
        resultRaster(:,3), resultRaster(:,2));
    resultTransitionRaster = obtainTable(resultTransitionRaster(:,1),...
        resultTransitionRaster(:,3), resultTransitionRaster(:,2));

    StartPoint = resultWholeWorkpiece(1);
    EndPoint = resultWholeWorkpiece(2);
    resultWholeWorkpiece = table(StartPoint,EndPoint);

    StartPoint = resultExternalPattern(1);
    EndPoint = resultExternalPattern(2);
    resultExternalPattern = table(StartPoint,EndPoint);

    StartPoint = resultInternalPattern(1);
    EndPoint = resultInternalPattern(2);
    resultInternalPattern = table(StartPoint,EndPoint);

end

testSegmentChoice = strcmp(segmentationChoice,'segments');

if testSegmentChoice == true
    resultReposition = gen_signal_segments(sensorSignalNormalized,...
        contourRepositions);
    resultReposition(1,4) = gen_signal_segments(sensorSignalNormalized,...
        contourToRasterReposition);
    resultContour = gen_signal_segments(sensorSignalNormalized, indexContour);
    resultRaster = gen_signal_segments(sensorSignalNormalized, index_raster);
    resultTransitionRaster = gen_signal_segments(sensorSignalNormalized, index_trans_raster);
    resultWholeWorkpiece = gen_signal_segments(sensorSignalNormalized, [resultContour(1,2) resultRaster(55,2)]);
    resultExternalPattern = gen_signal_segments(sensorSignalNormalized, [resultContour(1,2) resultContour(12,3)]);
    resultInternalPattern = gen_signal_segments(sensorSignalNormalized, [resultRaster(1,3) resultRaster(55,2)]);
end

% \ 15°

% 16° Save the results and generate the graphs

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

end

% SUB1
function result = detectAnom(initialPoint, lastPoint)
% detectAnom  Detects if an anormal segmentation situation is present while in the internal 
% printing pattern segmentation logic. 
    % The anormal segmentation situation is verified where multiple low duration segments are verified between two
    % high duration segments. In the case of the specific part geometry and sampling frequency employed 
    % for the three datasets of signals collected from a first layer 3D print, these anormal low duration segments
    % are below 8000 samples.
%   
%   result = detectAnom(initialPoint, lastPoint) test if the anomaly is present between the indexes 
%   initialPoint and lastPoint. 
%   The anormal segmentation situation is present when the difference between lastPoint and initialPoint is not equal to 2.
%
%   result returns true if the anormal segmentation situation is not present, and false if it is present.


if lastPoint - initialPoint == 2
    % Normal situation
    result = true;
else
    % Anormal situation
    result = false;
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
    % is around 8000 samples.
%
%   composedDuration = isNormal(originalDuration, initialPoint, lastPoint, indexDuration) 
%
%   where composedDuration is the resulting duration matrix, originalDuration is the original duration matrix,
%   initialPoint is the initial index of interest in this segmentation logic, lastPoint is the last point of interest
%   in this segmentation logic, and indexDuration is the reference index of the duration matrix to be composed.

% Transition period (aprox 8000 samples)
composedDuration(indexDuration, 3) =  originalDuration(initialPoint,3);
composedDuration(indexDuration, 2) =  originalDuration(initialPoint,2);
composedDuration(indexDuration, 1) =  composedDuration(indexDuration, 2)...
    - composedDuration(indexDuration, 3);

% Raster period (value above 9000 samples, and that increases
% 11e3 in relation to the previous fabrication period
composedDuration(indexDuration + 1, 3) =  originalDuration(initialPoint + 1,3);
composedDuration(indexDuration + 1, 2) =  originalDuration(initialPoint + 1,2);
composedDuration(indexDuration + 1, 1) =  composedDuration(indexDuration + 1, 2)...
    - composedDuration(indexDuration + 1, 3);

% Transition period (aprox 8000 samples)
composedDuration(indexDuration + 2, 3) =  originalDuration(lastPoint, 3);
composedDuration(indexDuration + 2, 2) =  originalDuration(lastPoint, 2);
composedDuration(indexDuration + 2, 1) =  composedDuration(indexDuration + 2, 2)...
    - composedDuration(indexDuration + 2, 3);
end

% SUB3
function composedDuration = isAnormal(originalDuration, ...
    initialPoint, lastPoint, ...
    previousPeak)
    % isAnormal  Obtain the duration matrix for the internal pattern in an anormal segmentation situation.
    % The anormal segmentation situation is verified where multiple low duration segments are verified between two
    % high duration segments. In the case of the specific part geometry and sampling frequency employed 
    % for the three datasets of signals collected from a first layer 3D print, these anormal low duration segments
    % are below 8000 samples.
%
%   composedDuration = isAnormal(originalDuration, initialPoint, lastPoint, previousPeak) 
%
%   where composedDuration is the resulting duration matrix, originalDuration is the original duration matrix,
%   initialPoint is the initial index of interest in this segmentation logic, lastPoint is the last point of interest
%   in this segmentation logic, and previousPeak is the duration value from the last high duration segment.

cont = 1;
for i = initialPoint:2:lastPoint
    if lastPoint - i == 1 || lastPoint == i
        if lastPoint - initialPoint > 3
            % normal transition
            % Transition period (aprox 8000 samples)
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
                if aux == 1
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
        % Transition period (aprox 8000 samples)
        composedDuration(cont, 3) =  originalDuration(i,3); %#ok<*AGROW>
        composedDuration(cont, 2) =  originalDuration(i,2);
        composedDuration(cont, 1) =  composedDuration(cont, 2)...
            - composedDuration(cont, 3);
        cont = cont +1;
    else % Normal transition
        composedDuration(cont, 3) =  composedDuration(cont-1, 2);
        composedDuration(cont, 2) =  composedDuration(cont, 3) +...
            8.4e3;
        composedDuration(cont, 1) =  composedDuration(cont, 2)...
            - composedDuration(cont, 3);
        cont = cont +1;
    end
    % Transition period (aprox 8000 samples), and that grows
    % 11e3 in relation to the previous fabrication period
    composedDuration(cont, 3) =  composedDuration(cont-1, 2);
    composedDuration(cont, 2) =  composedDuration(cont, 3) +...
        previousPeak + 11e3;
    composedDuration(cont, 1) =  composedDuration(cont, 2)...
        - composedDuration(cont, 3);
    previousPeak = composedDuration(cont, 1);
    cont = cont +1;

    % Normal transition
    composedDuration(cont, 3) =  composedDuration(cont-1, 2);
    composedDuration(cont, 2) =  composedDuration(cont, 3) +...
        8.4e3;
    composedDuration(cont, 1) =  composedDuration(cont, 2)...
        - composedDuration(cont, 3);
end
end

% SUB4
function duration = obtainDuration ( ...
    sensor_signal_normalized, ...
    Dir_X_adjusted_normalized,...
    Dir_Y_adjusted_normalized, ...
    result_problem)
    % obtainDuration  Obtain the duration matrix from the acoustic signal and the X and Y step motor control signals.
%
%   duration = obtainDuration (sensor_signal_normalized, Dir_X_adjusted_normalized, Dir_Y_adjusted_normalized, result_problem) 
%
%   where duration is the resulting duration matrix, sensor_signal_normalized is the normalized acoustic signal,
%   Dir_X_adjusted_normalized is the normalized X step motor control signal, Dir_Y_adjusted_normalized is the normalized Y step motor control signal,
%   and result_problem is a boolean value that indicates if the anomaly that the detectAnom function verifies is present.

x_value = 0;
y_value = 0;
last_change = 0;
if result_problem == true
    minimum_sampleValue = 50e3;
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
    Dir_Y_adjusted_normalized)
% test_Minvariations  detects the anomaly verified in the Test1.mat dataset. The anomaly present in the Test1.mat dataset
% was that of unexpected low duration segments appearing throughout the dirX signal. This was caused by interference, and was fixed
% for the Test2.mat and Test3.mat datasets printing procedures.
%   
%   result_problem = test_Minvariations(sensor_signal_normalized, Dir_X_adjusted_normalized, Dir_Y_adjusted_normalized)
%
%   where result_problem returns the boolean value true if the anomaly is present, and false if it is not.

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
    if duration(i,1) < 8e3
        cont_low_dur = cont_low_dur + 1;
    end
end

% % DEBUG - POI-5 - why the min value of 50?
%
% generate_standard_fig(1:length(duration(:,1)), duration(:,1), 1, 1,...
%     'Duration', 'DEBUG - POI-5', 'Segment',...
%     'Duration (number of samples)', 0, 0, ...
%     0, 0, 0, 0,...
%     2, 'Times New Roman', 16);
%
% DEBUG_ID = 'POI-5.png';
% saveFig(gca,'centimeters',[13 8]*1.8,600,DEBUG_ID);
%
% % \ DEBUG - POI-5

if cont_low_dur > 50
    result_problem = true;
else
    result_problem = false;
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

t_segmented = obtain_time_vec(sensor_signal_segmented,200e3);

%

t = obtain_time_vec(sensor_signal,Fs);

sensor_signal = decimate(sensor_signal,10);
signal_reposition = decimate(signal_reposition,10);

t_decimated = obtain_time_vec(sensor_signal,Fs/10);

%Obtain the last point of the external pattern index in the time domain
a = index_raster(1,3)/Fs;
xlim_min = a - 2.0;
xlim_max = a + 1.5;

ticks = round(xlim_min:1:xlim_max,1);
ticks = num2str(ticks');

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

xticklabels (ticks);

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

xticklabels (ticks);

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
    p.LineWidth = 1;
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
    numb_col = round(numb_fig_v/4,0);
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

    colororder(ordem_cor(1:numb_fig_v,:));
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

if strcmp(class(res),'double') %#ok<STISA>
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
    result_sep = true;
else
    result_sep = false;
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
        qnt = floor(abs((index_raster(i,1)-index_raster(i-1,1)))/11e3);
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
            temp_mat(k,1) = last_peak(1,1) + 11e3;
            temp_mat(k,3) = last_peak(1,2) + 8.4e3;
            temp_mat(k,2) = temp_mat(k,3) + temp_mat(k,1);
        else
            temp_mat(k,1) = last_peak(1,1) - 11e3;
            temp_mat(k,3) = last_peak(1,2) + 8.4e3;
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
            8.4e3;
    else
        index_raster_alt_2(i,3) =...
            index_raster_alt_2(end-1,2) + 8.4e3;
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

med_quad_ext = mean(indexContour(5:8,1));

dif_quad = indexContour(8,1) - indexContour(9,1);

dif_ini = med_quad_ext - dif_quad;

correct_square = zeros(4,3);

correct_square(4,3) = contourRepositions(2,2);
correct_square(4,2) = floor(correct_square(4,3) - dif_ini);
correct_square(4,1) = floor(abs(correct_square(4,2) - correct_square(4,3)));

correct_square(3,3) = correct_square(4,2) - 4;
correct_square(3,2) = floor(correct_square(3,3) - dif_ini - 6);
correct_square(3,1) = floor(abs(correct_square(3,2) - correct_square(3,3)));

correct_square(2,3) = correct_square(3,2) - 4;
correct_square(2,2) = floor(correct_square(2,3) - dif_ini - 3);
correct_square(2,1) = floor(abs(correct_square(2,2) - correct_square(2,3)));

correct_square(1,3) = correct_square(2,2) - 4;
correct_square(1,2) = floor(correct_square(1,3) - dif_ini + 4);
correct_square(1,1) = floor(abs(correct_square(1,2) - correct_square(1,3)));

contourRepositions(1,3) = correct_square(1,2) - 4;
contourRepositions_corr(1,2) = floor(contourRepositions(1,3) - contourRepositions(1,1));

indexContour_corr(1:4,:) = correct_square;

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

function resultTable = obtainTable(DurationMat, startPointMat, endPointMat)
    % resultTable Obtain a table with the segmentation results.
%
%   resultTable = obtainTable(DurationMat, startPointMat, endPointMat)
%
%   where resultTable is obtained table, DurationMat is the duration matrix, startPointMat is the start point matrix, 
%   and endPointMat is the end point matrix.

Duration = DurationMat;
StartPoint = startPointMat;
EndPoint = endPointMat;

resultTable = table(Duration,StartPoint,EndPoint);

end
