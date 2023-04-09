function salvarFigura(hFigure, unit, size, res, fileName)




try
    if strcmp(get(hFigure,'Type'),'axes')
        hFigure = get(hFigure,'Parent');
    elseif ~strcmp(get(hFigure,'Type'),'figure')
        error('Error:salvarFigura','O handler informado não é do tipo ''figure''.')
    end
catch me
    error('Error:salvarFigura','O handler informado não é válido.')
end

unitVal = strcmp(unit, {'normalized' 'inches' 'centimeters' 'points'});
if sum(unitVal) == 0
    error('Error:salvarFigura', ['A unidade informada não é válida.\nValores aceitos:\n\t- normalized'...
        '\n\t- points\n\t- centimeters\n\t- inches']);
elseif sum(unitVal) > 1
    error('Error:salvarFigura', 'Deve ser informada apenas uma unidade.')
end

if strcmp(class(res),'double') %#ok<*STISA>
    res = ['-r' num2str(res)];
elseif strncmp('-r', res, 2) == 0
    error('Error:salvarFigura', 'O valor informado para a resolução não é válido.')
end

pos_ = [0 0 size(1) size(2)];

% oldPaperUnits = get(hFigure,'PaperUnits');
% oldPaperSize = get(hFigure,'PaperSize');
% oldPaperOrientation = get(hFigure,'PaperOrientation');
% oldPaperPositionMode = get(hFigure,'PaperPositionMode');
% oldPaperPosition = get(hFigure,'PaperPosition');

set(hFigure, 'PaperUnits', unit);
set(hFigure, 'PaperSize', size);
set(hFigure, 'PaperOrientation', 'portrait');
set(hFigure, 'PaperPositionMode', 'manual');
set(hFigure, 'PaperPosition', pos_);

print(hFigure, '-loose', res, '-djpeg', fileName);
%print(hFigure, '-loose', res, '-dtiff', fileName);

% set(hFigure, 'PaperUnits', oldPaperUnits);
% set(hFigure, 'PaperSize', oldPaperSize);
% set(hFigure, 'PaperOrientation', oldPaperOrientation);
% set(hFigure, 'PaperPositionMode', oldPaperPositionMode);
% set(hFigure, 'PaperPosition', oldPaperPosition);

end