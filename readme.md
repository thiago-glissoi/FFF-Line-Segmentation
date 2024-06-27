# Definition
The `fff_segmenter` algorithm is used to segment a acoustic signal obtained from a first layer 3D print into multiple acoustic blocks related to specific geometrical elements of the printed part, such as contour lines, raster lines, and transition between raster lines. The fff_segmenter algorithm uses the direction control signal of the X and Y axis stepper motors. In order to use the fff_segmenter algorithm, the acoustic signal must be collected synchronously with the X and Y direction control signals at a specified sampling frequency. The folder [Data](Data/) presents three datasets of signals collected from a first layer 3D print. 
We `strongly encourage` the user to read the [Documentation](Documentation.pdf) pdf file in order to completely comprehend the fff_segmenter algorithm inner workings, and how it was built with a specific part geometry and sampling frequency in consideration.

# Clone the repository
git clone https://github.com/thiago-glissoi/FFF-Line-Segmentation.git

# Dependencies
Before using the fff_segmenter script, verify if the following dependencies are installed and available in your Matlab or Octave environment.

</details>
<details>
  <summary><strong>Matlab dependencies</strong></summary>

 -> [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html)
  </details>

  </details>
<details>
  <summary><strong>Octave dependencies</strong></summary>

 -> [Signal Package](https://octave.sourceforge.io/signal/)

 -> [Control Package](https://octave.sourceforge.io/control/)
  </details>

# How to use
Verify the example for Matlab or for Octave.

</details>
<details>
  <summary><strong>Matlab example</strong></summary>

Make sure that the listed [Dependencies](#Dependencies) are installed and loaded into Matlab.

Run the `fff_segmenter` script by typing directly into the command window followed by the press of the Enter on the keyboard, or by clicking in the run button of the Matlab text editor.

```Matlab
fff_segmenter
```
After running the fff_segmenter algorithm, the user will be provided with the graphical interface displayed below.

<img src="Example/Matlab%20input%20GUI.png" alt="Figure 1 - Input interface" width="420">

For the purpose of this example, the `Select data` button will be used to load the `Test1.mat` file from the `Data` folder. The `Select data` button will open a file explorer window, where the user can navigate to the `Data` folder and select the `Test1.mat` file. The rest of the input fields will be filled with the values in regard to the `Test1.mat` dataset, with default values for the `Segmentation mode` and `Unit` segmentation options, and with all of the available outputs toggled to `Yes`.

<img src="Example/Matlab%20input%20GUI%20filled.png" alt="Figure 2 - Input interface filled with values" width="420">


When the user toggle to `On` the `Run the segmentation` button, the graphical input interface will be closed and the fff_segmentation algorithm will run with the defined parameters. 

As a result of running the fff_segmentation algorithm with default parameters, two new files were generated in the ```Segmentation results``` folder, which was created in the Matlab's current path. The first, named `Points segmentation results Acoustic_signal`, holds the results of the segmentation in the `Points` segmentation choice, saved in table format. The output data file name follows a definition that is based on the `Segmentation mode` choice, in this case `Points`, and the identification of the sensor signal in the dataset, in this case `Acoustic_signal`.   
The figure below demonstrate the contents of the [Points segmentation results Acoustic_signal](<Segmentation results/Points segmentation results Acoustic_signal.mat>) in the Matlab workspace. 

<img src="Example/Matlab%Segmentation%20index%20mode%20workspace.png" alt="Figure 3 - Points segmentation results in the workspace" width="420">

Opening each table in Matlab, it is possible to observe that the point segmentation mode generates three columns for each geometric feature, and two columns for the pattern's separation. In regard to the geometric features tables, the first column is the ```Duration``` of the feature fabrication, the second column is the first instant index, identified as ```StartPoint```, of the feature fabrication, and the third column is the ```EndPoint``` of the feature fabrication in the default number of samples mode.

![Figure 4 - Points segmentation results](Example/Matlab%Segmentation%20index%20mode%20results.png)

The second file, named `Segmentation results Acoustic_signal`, is the automatically saved figure with the predetermined resolution and formatting. The image obtained for this example is represented in the figure below.

![Figure 5 - Saved figure](Example/Matlab%Segmentation%20results%20'Test1'.png)

</details>

<details>
  <summary><strong>Octave example</strong></summary>

Make sure that the listed [Dependencies](#Dependencies) are installed and loaded into Octave.

Run the `fff_segmenter` script by typing directly into the command window followed by the press of the Enter on the keyboard, or by clicking in the run button of the Octave text editor.

```Octave
fff_segmenter
```
After running the fff_segmenter algorithm, a open a file explorer window. The user must navigate to, find, and select the .mat data file that holds the acoustic signal and the X and Y direction control signals.
For the purpose of this example, the user can navigate to the `Data` folder and select the `Test1.mat` file.


<img src="example/Octave%20file%20navigation.png" alt="Figure 6 - Octave file selection" width="420">

After selecting the data file, the user will be provided with the graphical interface displayed below. The filled values in the input fields are the default values for the `Segmentation mode` and `Unit` segmentation options, and with all of the available outputs toggled to `No`.


<img src="example/Octave%20input%20GUI.png" alt="Figure 7 - Octave input GUI" width="420">


The user will fill the fields with the values in regard to the `Test1.mat` dataset, with default values for the `Segmentation mode` and `Unit` segmentation options, and with all of the available outputs toggled to `Yes`.


<img src="example/Octave%20input%20GUI%20filled.png" alt="Figure 8 - Octave input GUI filled" width="420">


When the the user press `Enter` on the keyboard, the graphical input interface will be closed and the fff_segmentation algorithm will run with the defined parameters. 

As a result of running the fff_segmentation algorithm with default parameters, two new files were generated in the ```Segmentation results``` folder, which was created in the Octave's current path. The first, named `Points segmentation results Acoustic_signal`, holds the results of the segmentation in the `Points` segmentation choice, saved in struct format. The output data file name follows a definition that is based on the `Segmentation mode` choice, in this case `Points`, and the identification of the sensor signal in the dataset, in this case `Acoustic_signal`.   
The figure below demonstrate the contents of the `Points segmentation results Acoustic_signal` in the Octave workspace. 


<img src="Example/Octave%20Segmentation%20index%20mode%20workspace.png" alt="Figure 9 - Points segmentation results in the workspace" width="420">


Opening each struct in Matlab, it is possible to observe that the point segmentation mode generates three columns for each geometric feature, and two columns for the pattern's separation. In regard to the geometric features tables, the first column is the ```Duration``` of the feature fabrication, the second column is the first instant index, identified as ```StartPoint```, of the feature fabrication, and the third column is the ```EndPoint``` of the feature fabrication in the default number of samples mode.


![Figure 10 - Points segmentation results](Example/Octave%20Segmentation%20index%20mode%20results.png)


The second file, named `Segmentation results Acoustic_signal`, is the automatically saved figure with the predetermined resolution and formatting. The image obtained for this example is represented in the figure below.


![Figure 11 - Saved figure](Example/Octave%20Segmentation%20results%20'Test1'.png)



</details>


# Application example
As a result of using the fff_segmenter algorithm, the user now possess the ability to more precisely examine the acoustic signal of the FFF fabrication in specified moments. An example of such application is represented in Figure 4, where the frequency content of the complete acoustic signal is represented in comparison to the frequency content of the acoustic signal related to just the middle raster line of the internal infill pattern fabrication period. 

![Figure 12 - Application example](Example/Application%20example.tiff)