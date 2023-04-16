---
title: 'fff_segmenter: A signal segmentation script for acoustic FFF fabrication data in MATLAB'

tags:
  - fused deposition modeling
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

date: 16 April 2023 
bibliography: paper.bib 

---

# Summary
The Fused Filament Fabrication (FFF) process involves the manufacturing of parts by adding multiple layers of fused thermoplastics in pre-defined printing lines [@Wendt2017].
The monitoring of the FFF process via acoustic signals has successfully detected defects in the printing process [@Wu2015; @Liu2018b; @Lopes2022].
Mechanistically, acoustic signals obtained from the FFF process are non-stationary time-series that capture alterations in the acoustic field arising from material deposition [@Lopes2022].
Signal segmentation is a fundamental step in the process monitoring of FFF, as it allows the identification of printing lines and extraction of relevant information for process monitoring and control. However, due to stochastic acoustic interferences arising from the FFF process, accurate manual segmentation may not be possible [@Lopes2022].
`fff_segmenter` is a signal segmentation script written in MATLAB that allows for automatic and accurate segmentation of different printing lines.

# Statement of need

### Automatic

Current research on the FFF process utilizes different methods to segment the acoustic signals. However, all of these methods have a manual component, such as the evaluation of printing time for each line through video recordings of the printing process, or manually selecting the printing lines based on amplitude variations in the time domain. These manual segmentation methods pose a serious challenge to adequate process monitoring, since they are time-consuming and prone to errors due to human mistakes [@Lopes2022; @Lopes2021].
`fff_segmenter` takes a programming approach that allows for the automatic segmentation of the printing lines in an acoustic signal, utilizing the direction control signal of the X and Y step motor axes of the FFF printer, and the signal's sampling frequency. This feature allows for accurate segmentation of the contour and raster printing lines from other signal data, thus enabling the extraction of relevant information for process monitoring and control.
A consequence of this programming approach is that the FFF signal segmentation in `fff_segmenter`, in contrast to other methods that have a manual component, is fully automatic and less prone to errors due to human mistakes. The process operator only needs to input the acoustic signal, the direction control signal of the X and Y step motor axes of the FFF printer, and the signal's sampling frequency. In return, the operator receives the start and end points in the number of samples for each printing line.

![Segmentation example with ``fff_segmenter``{fig:Automatic}](Sinal_exemplo.tiff){width=100%}

### Result orientated

In addition to its automatic feature, `fff_segmenter` is result-oriented. Firstly, the segmentation results can be presented in graphical windows that allow for a quick visual inspection of the segmentation results. This feature allows for a quick and accurate evaluation of the script's performance. Secondly, the segmentation results can be autosaved in predefined workspace data formats. These formats allow for the easy import of segmentation results into other MATLAB analyses. By identifying and abstracting common segmentation methods, the algorithms in fff_segementer are more direct, maintainable, and, above all, easier to understand with respect to the printer deposition movements.

![``fff_segmenter`` Input & Output\label{fig:Result orientated}](Detalhamento_inputs_e_outputs.png){width=100%}

### Scalable

The algorithms in `fff_segmenter` were developed with a focus on cartesian RepRap-based FFF printers. This is due to the fact that cartesian RepRap-based FFF printers are commonly used for research purposes [@Lopes2022; @Carmo2020; @Wu2015; @Liu2018b]. Additionally, the segmentation algorithms were developed to segment the contour and raster printing lines of rectangular-shaped monolayer parts. The STL file of the part was sliced to G-code following standard printing parameters provided by the printer manufacturer. The documentation of `fff_segmenter` provides a detailed explanation of the segmentation algorithms and how they were developed to address the particularities of the cartesian RepRap-based FFF printer and the rectangular-shaped monolayer part, providing a scalable framework for the segmentation of parts with different shapes and printing parameters.

In summary, `fff_segmenter` fulfills the need in FFF process monitoring research for a signal segmentation script that is automatic, result-oriented, and scalable, as well as providing a framework for the community to scale the script to cater to other FFF printers and parts.

# Acknowledgements
We acknowledge support from ...

# References