# Definition
The fff_segmenter algorithm is used to segment a acoustic signal obtained from a first layer 3D print into multiple acoustic blocks related to specific geometrical elements of the printed part, such as contour lines, raster lines, and transition between raster lines. The fff_segmenter algorithm uses the direction control signal of the X and Y axis stepper motors. In order to use the fff_segmenter algorithm, the acoustic signal must be collected synchronously with the X and Y direction control signals at a specified sampling frequency. We strongly encourage the user to read the ```Documentation``` pdf file in order to completely comprehend the fff_segmenter algorithm inner workings, and how it was built with a specific part geometry in consideration.

# Clone the repository
git clone https://github.com/thiago-glissoi/FDM-Line-Segmentation.git

# Example (run in Matlab)
Let's load the data into the Matlab workspace

```Matlab
load("Data/Test1.mat");
```

Now, we run the fff_segmenter algorithm using the workspace variables of Test1.mat and a sampling frequency of 200 kHz

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

For this example, i will use the default parameters as response to the prompts, and call the signal as ```'Test1'```, since I am using the Test1 data.

The fff_segmentation algorithm will take between 30 seconds and 90 seconds to run.
As a result of running the fff_segmentation algorithm with default parameters, I have obtained two new files in my current folder. The first, named 'points segmentation results 'Test1'.mat', holds the results of the segmentation in the index format. Figure 1 demonstrate the contents of the 'points segmentation results 'Test1'.mat' in the Matlab workspace.

![Figure 1 - Points segmentation results in the workspace](Example/Segmentation%20index%20mode%20workspace.png){width=100%}

Opening each matrix, we can see that the point segmentation mode generates three columns for each geometric feature. The first column is the ```duration``` of the feature fabrication, the second column is the ```first instant index``` of the feature fabrication, and the third column is the ```final instant index``` of the feature fabrication.

![Figure 2 - Points segmentation results](Example/Segmentation%20index%20mode%20results.png){width=100%}

The second file, named 'Segmentation results 'Test1'.png', is the automatically saved figure with the predetermined resolution and formatting. The image obtained for this example is represented in Figure 3.

![Figure 3 - Saved figure](Example/Segmentation%20results%20'Test1'.png){width=100%}

As a result of using the fff_segmenter algorithm, the user now possess the ability to more precisely examine the acoustic signa in specified moments. An example of such application is represented in Figure 4, where the frequency content of the complete acoustic signal is represented in comparison to the frequency content of the acoustic signal related to just the middle raster line of the internal infill pattern. 

![Figure 4 - Application example](Example/Application%20example.tiff){width=100%}