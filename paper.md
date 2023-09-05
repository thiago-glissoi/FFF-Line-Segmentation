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
    orcid: 0000-0002-9934-4465
    affiliation: 1
    corresponding: true
  - name: Reinaldo Götz de Oliveira Junior
    orcid: 0000-0002-2843-528X
    affiliation: 1
  - name: Pedro Oliveira Conceição Junior 
    orcid: 0000-0002-8476-3333
    affiliation: 2

affiliations:
  - name: Department of Electrical Engineering, São Paulo State University, Brazil
    index: 1

  - name: Department of Electrical and Computer Engineering, Sao Carlos School of Engineering (EESC),University of Sao Paulo (USP), Sao Carlos 13566-590, Sao Paulo, Brazil
    index: 2

date: 5 September 2023 
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
`fff_segmenter` takes a programming approach that allows for the automatic segmentation of the printing lines in an acoustic signal, utilizing the direction control signal of the X and Y step motor axes of the FFF printer, and the signal's sampling frequency. This feature allows for accurate segmentation of the contour and raster printing lines from the acoustic signal data, thus enabling the extraction of relevant information for process monitoring and control.
A consequence of this programming approach is that the FFF signal segmentation in `fff_segmenter`, in contrast to other methods that have a manual component, is fully automatic and less prone to errors due to human mistakes. The process operator only needs to input the acoustic signal, the direction control signal of the X and Y step motor axes of the FFF printer, and the signal's sampling frequency. In return, the operator receives the start and end points in the number of samples for each printing line, along with other relevant process information. 

![Segmentation example with `fff_segmenter`. (a) signal with raster lines; (b) signal with transition between raster lines](images/segmentationImage.png){width=100%}

### Result orientated

In addition to its automatic feature, `fff_segmenter` is result-oriented. Firstly, the segmentation results can be presented in graphical windows, such as the one presented in Figure 1, that allow for a quick visual inspection of the segmentation results. This feature allows for a quick and accurate evaluation of the script's performance. Secondly, the segmentation results can be autosaved in predefined workspace data formats. These formats allow for the easy import of segmentation results into other MATLAB analyses. Figure 2 reveals the input options for the process operator, and the obtained output information. 
Figure 1 shows the segmentation results obtained by applying the `fff_segmenter` script to an acoustic signal. It is possible to observe that the acoustic signal presents many periods that are not of interest for monitoring purposes and, therefore, are not segmented. Further analysis of Figure 1 allows for the identification of contour lines, raster lines, and the transition period between printing patterns. During the transition period between printing patterns, the printer extruder repositions itself without depositing filament. The observation of the transition period analysis window (a.1) in Figure 1(a) confirms an important property of the raster lines printing pattern, which is the fact that the duration of the lines increases, and the raster lines are always separated by a transition period that presents the same duration. These transitions between raster lines, presented in Figure 1(b) analysis window (b.1), are periods of the signal during which there is deposition of filament.
Due to being developed with the part's feature in focus, the algorithms in fff_segmenter are more direct, maintainable, and, above all, easier to understand with respect to the printer deposition movements.

### Scalable

The algorithms in `fff_segmenter` were developed with a focus on cartesian [RepRap](https://reprap.org/wiki/RepRap)-based FFF printers. This is due to the fact that cartesian [RepRap](https://reprap.org/wiki/RepRap)-based FFF printers are commonly used for research purposes [@Lopes2022; @Carmo2020; @Wu2015; @Liu2018b]. Additionally, the segmentation algorithms were developed to segment the contour and raster printing lines of rectangular-shaped monolayer parts. The STL file of the part was sliced to G-code following standard printing parameters provided by the printer manufacturer. The documentation of `fff_segmenter` provides a detailed explanation of the segmentation algorithms and how they were developed to address the particularities of the cartesian [RepRap](https://reprap.org/wiki/RepRap)-based FFF printer and the rectangular-shaped monolayer part, providing a scalable framework for the segmentation of parts with different shapes and printing parameters.

In summary, `fff_segmenter` fulfills the need in FFF process monitoring research for a signal segmentation script that is automatic, result-oriented, and scalable, as well as providing a framework for the community to scale the script to cater to other FFF printers and parts.

# Acknowledgements
The authors are thankful to the National Council for Scientific and Technological Development (CNPq) for supporting this research under the Grant # 306774/2021-6, and to the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior – Brasil (CAPES) – Finance Code 001

# References