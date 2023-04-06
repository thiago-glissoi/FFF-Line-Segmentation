---
title: 'FFF fabrication lines segmentation'

tags:
  - fused filament fabrication
  - signal processing
  - additive manufacturing
  - process monitoring
  - engineering

authors:
  - name: Thiago Glissoi Lopes
    orcid: 0000-0002-8860-2748
    affiliation: 1
  - name: Paulo Monteiro de Carvalho Monson
    orcid: 0000-0002-7093-1754
    affiliation: 1
  - name: Paulo Roberto de Aguiar
    TODO orcid:
    affiliation: 1
    corresponding: true
  - name: Reinaldo Götz de Oliveira Junior
    orcid: 0000-0002-2843-528X
    affiliation: 1

affiliations:
  - name: Department of Electrical Engineering, São Paulo State University, Brazil
    index: 1

date: 06 April 2023 
bibliography: paper.bib 

---

# Summary
"The Matlab script `fdm_segmenter` processes X and Y axis direction command signals obtained from the FDM printer control board to generate the period segmentation of contour and raster lines. `fdm_segmenter` aims to provide a reproducible and fully open-source implementation of the period segmentation of contour and raster lines for signal processing purposes."
TODO /Review

# Statement of need
The Fused Deposition Modeling Process (FDM), also known as 3D Printing, deals with the manufacturing of parts by adding multiple layers of fused plastic filament following a specific printing pattern. The printing pattern is defined by the process operator in the slicing process performed in a postprocessing FDM software.
TODO /Review

There are several printing patterns, which vary in the number of contours and raster lines. Some printing parameters defined in the slicing process, such as the layer width, have a direct influence on the outcome of the print pattern with respect to the number of contour and raster lines.
TODO /Review

The monitoring of the FDM process by means of signal processing of acoustic data has been a very prominent subject of research. There are several types of defects that can be detected during the fabrication of the first layer in the FDM process. The first layer is considered to be a crucial period in the process, where if a defect is detected, the whole process can be terminated. Thus, avoiding the costs regarding a incorrect part fabrication. 
TODO /Review

The raw acoustic signal obtained from the FDM process monitoring is usually hard to accurately segment regarding the different phenomena that composes a first layer fabrication. It has been reported that the difficulties only increases when the goal is to segment into the different fabrication lines [@Lopes2022]. This is due to the fact that the acoustic signal obtained possess a lot of process noise alongside the deposition phenomena. We present the Matlab script `fdm_segmenter`: a fully open-source script for automatic segmentation of contour and raster lines through the use of the X and Y axis direction command signals.
TODO /Review

[comment]: <> (Several research articles highlighted the importance of an accurate segmentation of the contour and raster lines in order to evaluate geometrical and surface defects on the printing part.)

Commission under grant ID: [FP6-IST 026932](https://cordis.europa.eu/project/id/026932).

summit para testar

# Design


# Proof of concept 


# Example

![Teste.\label{fig:examples}](IMG_7577.png){width=100%}

# Acknowledgements
We acknowledge support from the community 

# References