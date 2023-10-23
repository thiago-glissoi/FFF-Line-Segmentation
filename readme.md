# Definition
The fff_segmenter algorithm is used to segment a acoustic signal obtained from a first layer 3D print into multiple acoustic blocks related to specific geometrical elements of the printed part, such as contour lines, raster lines, and transition between raster lines. The fff_segmenter algorithm uses the direction control signal of the X and Y axis stepper motors. In order to use the fff_segmenter algorithm, the acoustic signal must be collected synchronously with the X and Y direction control signals at a specified sampling frequency. The folder [Data](Data/) presents three datasets of signals collected from a first layer 3D print. 
We strongly encourage the user to read the [Documentation](Documentation.pdf) pdf file in order to completely comprehend the fff_segmenter algorithm inner workings, and how it was built with a specific part geometry and sampling frequency in consideration.

# Clone the repository
git clone https://github.com/thiago-glissoi/FFF-Line-Segmentation.git

# Example (run in Matlab)
Let's load the [Test1.mat](Data/Test1.mat) dataset into the Matlab workspace

```Matlab
load("Data/Test1.mat");
```

Now, we run the fff_segmenter algorithm using the workspace variables of Test1.mat and the sampling frequency of 200 kHz

```Matlab
fff_segmenter(Acoustic_signal,Dir_X,Dir_Y,200e3);
```
After running the fff_segmenter algorithm, the user will be prompted to provide the signal identification.
```Provide the signal identification```
```Matlab 
Signal name
```

After that, the user will be prompted to choose the segmentation mode.
```Would you like to obtain the segmentation index (points) or the segments of signal (segments)?```

```Matlab
Response points/segments [points]
```

After that, if the user opted for the points mode of segmentation, the user will be prompted to choose between obtaining the segmentation index in number of samples or in seconds.
```Would you like to obtain the segmentation index (points) in number of samples or in seconds??```

```Matlab
Response number of samples/seconds [number of samples]
```

After that, the user will be prompted to choose between obtaining a graphical visualization of the segmentation. 
```Would you like to obtain graphical visualization of the segmentation?```

```Matlab
Response Y/N [Y]
```

If the users respond 'Y', the user will be prompted to choose if the graphical visualization of the segmentation will be automatically saved in the current folder with a predetermined resolution and formatting. 
```Would you like to autosave the figures?```

```Matlab
Response Y/N [Y]
```
Next, the user will be prompted to choose if it would like to automatically save the segmentation results. 
```Would you like to autosave the figures?```
```Matlab
Response Y/N [Y]
```

After this last prompt, the fff_segmentation algorithm will run with the defined parameters. 

In this example, default parameters are utilized in response to the prompts. The signal is designated as ```Test1``` to correspond with the Test1 dataset.

The fff_segmentation algorithm will take between 30 seconds and 90 seconds to run.
As a result of running the fff_segmentation algorithm with default parameters, two new files were generated in the ```Segmentation results``` folder, which was created in the Matlab's current path. The first, named 'points segmentation results 'Test1'.mat', holds the results of the segmentation in the index format. Figure 1 demonstrate the contents of the 'points segmentation results 'Test1'.mat' in the Matlab workspace.

![Figure 1 - Points segmentation results in the workspace](Example/Segmentation%20index%20mode%20workspace.png)

Opening each table, it is possible to observe that the point segmentation mode generates three columns for each geometric feature, and two columns for the pattern's separation. In regard to the geometric features tables, the first column is the ```duration``` of the feature fabrication, the second column is the first instant index, identified as ```StartPoint```, of the feature fabrication, and the third column is the ```EndPoint``` of the feature fabrication.

![Figure 2 - Points segmentation results](Example/Segmentation%20index%20mode%20results.png)

The second file, named 'Segmentation results 'Test1'.png', is the automatically saved figure with the predetermined resolution and formatting. The image obtained for this example is represented in Figure 3.

![Figure 3 - Saved figure](Example/Segmentation%20results%20'Test1'.png){width=100%}

As a result of using the fff_segmenter algorithm, the user now possess the ability to more precisely examine the acoustic signal in specified moments. An example of such application is represented in Figure 4, where the frequency content of the complete acoustic signal is represented in comparison to the frequency content of the acoustic signal related to just the middle raster line of the internal infill pattern. 

![Figure 4 - Application example](Example/Application%20example.tiff)