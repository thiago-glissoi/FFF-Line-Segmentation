classdef APP_User_Inputs < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        RunthesegmentationSwitchLabel  matlab.ui.control.Label
        ObtainautomaticmatfilesSwitchLabel  matlab.ui.control.Label
        RunthesegmentationSwitch       matlab.ui.control.Switch
        ObtainautomaticmatfilesSwitch  matlab.ui.control.Switch
        SavegraphicalvisualizationifobtainedLabel  matlab.ui.control.Label
        ObtaingraphicalvisualizationSwitchLabel  matlab.ui.control.Label
        SavegraphicalvisualizationifobtainedSwitch  matlab.ui.control.Switch
        ObtaingraphicalvisualizationSwitch  matlab.ui.control.Switch
        UnitforthePointssegmentationmodeButtonGroup  matlab.ui.container.ButtonGroup
        SecondsButton                  matlab.ui.control.RadioButton
        NumberofsamplesButton          matlab.ui.control.RadioButton
        ChooseButton_3                 matlab.ui.control.RadioButton
        SegmentationmodeButtonGroup    matlab.ui.container.ButtonGroup
        SegmentsButton                 matlab.ui.control.RadioButton
        PointsButton                   matlab.ui.control.RadioButton
        ChooseButton                   matlab.ui.control.RadioButton
        DirYidentificationEditField    matlab.ui.control.EditField
        DirYidentificationEditFieldLabel  matlab.ui.control.Label
        DirXidentificationEditField    matlab.ui.control.EditField
        DirXidentificationEditFieldLabel  matlab.ui.control.Label
        RawsignalidentificationEditField  matlab.ui.control.EditField
        RawsignalidentificationEditFieldLabel  matlab.ui.control.Label
        SamplingfrequencyEditField     matlab.ui.control.NumericEditField
        SamplingfrequencyEditFieldLabel  matlab.ui.control.Label
        SelectdataButton               matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: ObtaingraphicalvisualizationSwitch
        function ObtaingraphicalvisualizationSwitchValueChanged(app, event)
            value = app.ObtaingraphicalvisualizationSwitch.Value;
            if  strcmp(value,'Yes')
                value2 = 'Y';
            else
                value2 = 'N';
            end
            assignin('base', 'graphical', value2);
            
        end

        % Value changed function: 
        % SavegraphicalvisualizationifobtainedSwitch
        function SavegraphicalvisualizationifobtainedSwitchValueChanged(app, event)
            value = app.SavegraphicalvisualizationifobtainedSwitch.Value;
            if  strcmp(value,'Yes')
                value3 = 'Y';
            else
                value3 = 'N';
            end

            assignin('base', 'figureChoice', value3);
        end

        % Value changed function: ObtainautomaticmatfilesSwitch
        function ObtainautomaticmatfilesSwitchValueChanged(app, event)
            value = app.ObtainautomaticmatfilesSwitch.Value;
            if  strcmp(value,'Yes')
                value4 = 'Y';
            else
                value4 = 'N';
            end

            assignin('base', 'saveChoice', value4);
        end

        % Value changed function: SamplingfrequencyEditField
        function SamplingfrequencyEditFieldValueChanged(app, event)
            value = app.SamplingfrequencyEditField.Value;
            
            assignin('base', 'Fs', value);
        end

        % Selection changed function: SegmentationmodeButtonGroup
        function SegmentationmodeButtonGroupSelectionChanged(app, event)
            selectedButton = app.SegmentationmodeButtonGroup.SelectedObject;

            selectedButtonText = selectedButton.Text;

            assignin('base', 'Segmentation_choice', selectedButtonText);
        end

        % Button pushed function: SelectdataButton
        function SelectdataButtonPushed(app, event)
        [filename, pathname] = uigetfile('*.mat', 'Select a MAT-file');
        if isequal(filename, 0)
            disp('User selected Cancel');
        else
            fullpath = fullfile(pathname, filename);
            disp(['User selected ', fullpath]);
            assignin('base', 'Data_path', fullpath);
        end
        end

        % Value changed function: DirXidentificationEditField
        function DirXidentificationEditFieldValueChanged(app, event)
            value = app.DirXidentificationEditField.Value;
            
            assignin('base', 'DirXidentification', value);
        end

        % Value changed function: DirYidentificationEditField
        function DirYidentificationEditFieldValueChanged(app, event)
            value = app.DirYidentificationEditField.Value;
            
            assignin('base', 'DirYidentification', value);
        end

        % Value changed function: RawsignalidentificationEditField
        function RawsignalidentificationEditFieldValueChanged(app, event)
            value = app.RawsignalidentificationEditField.Value;


            assignin('base', 'signalIdentifier', value);

        end

        % Selection changed function: 
        % UnitforthePointssegmentationmodeButtonGroup
        function UnitforthePointssegmentationmodeButtonGroupSelectionChanged(app, event)
            selectedButton = app.UnitforthePointssegmentationmodeButtonGroup.SelectedObject;
            
            selectedButtonText = selectedButton.Text;

            assignin('base', 'xticksChoice', selectedButtonText);

        end

        % Value changed function: RunthesegmentationSwitch
        function RunthesegmentationSwitchValueChanged(app, event)
            value = app.RunthesegmentationSwitch.Value;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 432 491];
            app.UIFigure.Name = 'MATLAB App';

            % Create SelectdataButton
            app.SelectdataButton = uibutton(app.UIFigure, 'push');
            app.SelectdataButton.ButtonPushedFcn = createCallbackFcn(app, @SelectdataButtonPushed, true);
            app.SelectdataButton.Position = [43 436 100 23];
            app.SelectdataButton.Text = 'Select data ';

            % Create SamplingfrequencyEditFieldLabel
            app.SamplingfrequencyEditFieldLabel = uilabel(app.UIFigure);
            app.SamplingfrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.SamplingfrequencyEditFieldLabel.Position = [154 436 112 22];
            app.SamplingfrequencyEditFieldLabel.Text = 'Sampling frequency';

            % Create SamplingfrequencyEditField
            app.SamplingfrequencyEditField = uieditfield(app.UIFigure, 'numeric');
            app.SamplingfrequencyEditField.ValueChangedFcn = createCallbackFcn(app, @SamplingfrequencyEditFieldValueChanged, true);
            app.SamplingfrequencyEditField.Position = [281 436 100 22];

            % Create RawsignalidentificationEditFieldLabel
            app.RawsignalidentificationEditFieldLabel = uilabel(app.UIFigure);
            app.RawsignalidentificationEditFieldLabel.HorizontalAlignment = 'right';
            app.RawsignalidentificationEditFieldLabel.Position = [56 401 139 22];
            app.RawsignalidentificationEditFieldLabel.Text = 'Raw signal identification ';

            % Create RawsignalidentificationEditField
            app.RawsignalidentificationEditField = uieditfield(app.UIFigure, 'text');
            app.RawsignalidentificationEditField.ValueChangedFcn = createCallbackFcn(app, @RawsignalidentificationEditFieldValueChanged, true);
            app.RawsignalidentificationEditField.Position = [210 401 100 22];

            % Create DirXidentificationEditFieldLabel
            app.DirXidentificationEditFieldLabel = uilabel(app.UIFigure);
            app.DirXidentificationEditFieldLabel.HorizontalAlignment = 'right';
            app.DirXidentificationEditFieldLabel.Position = [92 371 103 22];
            app.DirXidentificationEditFieldLabel.Text = 'DirX identification ';

            % Create DirXidentificationEditField
            app.DirXidentificationEditField = uieditfield(app.UIFigure, 'text');
            app.DirXidentificationEditField.ValueChangedFcn = createCallbackFcn(app, @DirXidentificationEditFieldValueChanged, true);
            app.DirXidentificationEditField.Position = [210 371 100 22];

            % Create DirYidentificationEditFieldLabel
            app.DirYidentificationEditFieldLabel = uilabel(app.UIFigure);
            app.DirYidentificationEditFieldLabel.HorizontalAlignment = 'right';
            app.DirYidentificationEditFieldLabel.Position = [92 342 103 22];
            app.DirYidentificationEditFieldLabel.Text = 'DirY identification ';

            % Create DirYidentificationEditField
            app.DirYidentificationEditField = uieditfield(app.UIFigure, 'text');
            app.DirYidentificationEditField.ValueChangedFcn = createCallbackFcn(app, @DirYidentificationEditFieldValueChanged, true);
            app.DirYidentificationEditField.Position = [210 342 100 22];

            % Create SegmentationmodeButtonGroup
            app.SegmentationmodeButtonGroup = uibuttongroup(app.UIFigure);
            app.SegmentationmodeButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SegmentationmodeButtonGroupSelectionChanged, true);
            app.SegmentationmodeButtonGroup.Title = 'Segmentation mode';
            app.SegmentationmodeButtonGroup.Position = [43 215 123 106];

            % Create ChooseButton
            app.ChooseButton = uiradiobutton(app.SegmentationmodeButtonGroup);
            app.ChooseButton.Text = 'Choose';
            app.ChooseButton.Position = [12 58 64 22];
            app.ChooseButton.Value = true;

            % Create PointsButton
            app.PointsButton = uiradiobutton(app.SegmentationmodeButtonGroup);
            app.PointsButton.Text = 'Points';
            app.PointsButton.Position = [12 34 56 22];

            % Create SegmentsButton
            app.SegmentsButton = uiradiobutton(app.SegmentationmodeButtonGroup);
            app.SegmentsButton.Text = 'Segments';
            app.SegmentsButton.Position = [12 10 76 22];

            % Create UnitforthePointssegmentationmodeButtonGroup
            app.UnitforthePointssegmentationmodeButtonGroup = uibuttongroup(app.UIFigure);
            app.UnitforthePointssegmentationmodeButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @UnitforthePointssegmentationmodeButtonGroupSelectionChanged, true);
            app.UnitforthePointssegmentationmodeButtonGroup.Title = 'Unit (for the Points segmentation mode)';
            app.UnitforthePointssegmentationmodeButtonGroup.Position = [185 215 227 107];

            % Create ChooseButton_3
            app.ChooseButton_3 = uiradiobutton(app.UnitforthePointssegmentationmodeButtonGroup);
            app.ChooseButton_3.Text = 'Choose';
            app.ChooseButton_3.Position = [11 61 64 22];
            app.ChooseButton_3.Value = true;

            % Create NumberofsamplesButton
            app.NumberofsamplesButton = uiradiobutton(app.UnitforthePointssegmentationmodeButtonGroup);
            app.NumberofsamplesButton.Text = 'Number of samples';
            app.NumberofsamplesButton.Position = [11 36 127 22];

            % Create SecondsButton
            app.SecondsButton = uiradiobutton(app.UnitforthePointssegmentationmodeButtonGroup);
            app.SecondsButton.Text = 'Seconds';
            app.SecondsButton.Position = [11 10 69 22];

            % Create ObtaingraphicalvisualizationSwitch
            app.ObtaingraphicalvisualizationSwitch = uiswitch(app.UIFigure, 'slider');
            app.ObtaingraphicalvisualizationSwitch.Items = {'No', 'Yes'};
            app.ObtaingraphicalvisualizationSwitch.ValueChangedFcn = createCallbackFcn(app, @ObtaingraphicalvisualizationSwitchValueChanged, true);
            app.ObtaingraphicalvisualizationSwitch.Position = [81 174 45 20];
            app.ObtaingraphicalvisualizationSwitch.Value = 'No';

            % Create SavegraphicalvisualizationifobtainedSwitch
            app.SavegraphicalvisualizationifobtainedSwitch = uiswitch(app.UIFigure, 'slider');
            app.SavegraphicalvisualizationifobtainedSwitch.Items = {'No', 'Yes'};
            app.SavegraphicalvisualizationifobtainedSwitch.ValueChangedFcn = createCallbackFcn(app, @SavegraphicalvisualizationifobtainedSwitchValueChanged, true);
            app.SavegraphicalvisualizationifobtainedSwitch.Position = [288 174 45 20];
            app.SavegraphicalvisualizationifobtainedSwitch.Value = 'No';

            % Create ObtaingraphicalvisualizationSwitchLabel
            app.ObtaingraphicalvisualizationSwitchLabel = uilabel(app.UIFigure);
            app.ObtaingraphicalvisualizationSwitchLabel.HorizontalAlignment = 'center';
            app.ObtaingraphicalvisualizationSwitchLabel.Position = [24 137 162 22];
            app.ObtaingraphicalvisualizationSwitchLabel.Text = 'Obtain graphical visualization';

            % Create SavegraphicalvisualizationifobtainedLabel
            app.SavegraphicalvisualizationifobtainedLabel = uilabel(app.UIFigure);
            app.SavegraphicalvisualizationifobtainedLabel.HorizontalAlignment = 'center';
            app.SavegraphicalvisualizationifobtainedLabel.Position = [206 137 214 22];
            app.SavegraphicalvisualizationifobtainedLabel.Text = 'Save graphical visualization if obtained';

            % Create ObtainautomaticmatfilesSwitch
            app.ObtainautomaticmatfilesSwitch = uiswitch(app.UIFigure, 'slider');
            app.ObtainautomaticmatfilesSwitch.Items = {'No', 'Yes'};
            app.ObtainautomaticmatfilesSwitch.ValueChangedFcn = createCallbackFcn(app, @ObtainautomaticmatfilesSwitchValueChanged, true);
            app.ObtainautomaticmatfilesSwitch.Position = [85 75 45 20];
            app.ObtainautomaticmatfilesSwitch.Value = 'No';

            % Create RunthesegmentationSwitch
            app.RunthesegmentationSwitch = uiswitch(app.UIFigure, 'slider');
            app.RunthesegmentationSwitch.ValueChangedFcn = createCallbackFcn(app, @RunthesegmentationSwitchValueChanged, true);
            app.RunthesegmentationSwitch.FontSize = 18;
            app.RunthesegmentationSwitch.FontWeight = 'bold';
            app.RunthesegmentationSwitch.FontColor = [1 0 0];
            app.RunthesegmentationSwitch.Position = [268 66 91 40];

            % Create ObtainautomaticmatfilesSwitchLabel
            app.ObtainautomaticmatfilesSwitchLabel = uilabel(app.UIFigure);
            app.ObtainautomaticmatfilesSwitchLabel.HorizontalAlignment = 'center';
            app.ObtainautomaticmatfilesSwitchLabel.Position = [35 38 149 22];
            app.ObtainautomaticmatfilesSwitchLabel.Text = 'Obtain automatic .mat files';

            % Create RunthesegmentationSwitchLabel
            app.RunthesegmentationSwitchLabel = uilabel(app.UIFigure);
            app.RunthesegmentationSwitchLabel.HorizontalAlignment = 'center';
            app.RunthesegmentationSwitchLabel.FontSize = 18;
            app.RunthesegmentationSwitchLabel.FontColor = [1 0 0];
            app.RunthesegmentationSwitchLabel.Position = [223 27 182 24];
            app.RunthesegmentationSwitchLabel.Text = 'Run the segmentation';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = APP_User_Inputs

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end