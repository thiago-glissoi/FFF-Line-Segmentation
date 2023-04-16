---
title: 'fff_segmenter: A signal segmentation script for acoustic FFF fabrication data in Matlab'

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
The Fused Deposition Modeling (FFF) process deals with the manufacturing of parts by adding multiple layers of fused thermoplastics in pre-defined printing lines [@Wendt2017]. 
The monitoring of the FFF process via acoustic signals has been successfully used to detect the occurrence of defects in the printing process [@Wu2015; @Liu2018b; @Lopes2022]. 
Mechanistically, acoustic signals obtained from the FFF process are non-stationary time-series that capture alterations in the acoustic field arising from the material deposition [@Lopes2022]. 
The signal segmentation is a fundamental step in the process monitoring of FFF, since it allows the identification of the printing lines and the extraction of the relevant information for the process monitoring and control. However, due to stochastic acoustic interferences arising from the FFF process an accurate manual segmentation may not be possible to achieve [@Lopes2022].
`fff_segmenter` is a signal segmentation script written in Matlab that allows for automatically and accurate segmentation of the different printing lines.

# Statement of need

### Automatic

Current research on the FFF process utilizes different methods to segment the acoustic signals. However, all of these methods have a manual component,  like the printing time evaluation of each line through a video recording of the printing process, or manually selecting the printing lines in reference to amplitude variations in the time domain. These manual segmentation methods pose a serious challenge to adequate process monitoring, since they are time-consuming and prone to errors due to human mistakes [@Lopes2022; @Lopes2021].
`fff_segmenter` takes a programming approach that allows for automatic  segmentation of the printing lines in a acoustic signal utilizing the direction control signal of the X and Y step motors axis of the FFF printer, and the signals sampling frequency. This feature allows for accurate segmentation of the contour and raster printing lines from other signal data, thus allowing the extraction of the relevant information for the process monitoring and control. 
A consequence of this programming approach is that the FFF signal segmentation in `fff_segmenter`, in contrast to other methods that have a manual component, is fully automatic and less prone to errors due to human mistakes. The process operator only needs to inputs the acoustic signal, the direction control signal of the X and Y step motors axis of the FFF printer, and the signals sampling frequency. In return, the operator receives the start and end points in number of samples for each printing line. 

### Result orientated

In addition to its automatic feature, `fff_segmenter` is result orientated. Firstly, the segmentation results can be presented in graphical windows that allows for a quick visual inspection of the segmentation results. This feature allows for a quick and accurate evaluation of the script performance. Secondly, the segmentation results can be autosaved following predefined workspace data formats. These formats allow for the easy import of the segmentation results into other Matlab analysis. By identifying and abstracting common segmentation methods, the algorithms in `fff_segementer` are more direct, maintainable and above all, easier to understand in regard to the printer deposition movements.

### Scalable

The algorithms in `fff_segmenter` were developed with a cartesian [RepRap](https://reprap.org/wiki/RepRap) based FFF printer in focus. This is due to the fact that cartesian [RepRap](https://reprap.org/wiki/RepRap) based FFF printers are commonly used for research purposes [@Lopes2022; @Carmo2020; @Wu2015; @Liu2018b].
Also, the segmentation algorithms were developed in order to segment the contour and raster printing lines of a rectangular shape monolayer part. The stl file of the part was sliced to g-code following standard printing parameters provided by the printer manufacturer. The documentation of `fff_segmenter` provides a detailed explanation of the segmentation algorithms and how they were developed to attend the particularities of the cartesian RepRap based FFF printer and the rectangular shape monolayer part, which provides a scalable framework for the segmentation of other parts with different shapes and printing parameters. 

In summary, `fff_segmenter` fulfills a need in the FFF process monitoring research for a signal segmentation script that is automatic, result orientated and scalable.

![Teste.\label{fig:examples}](IMG_7577.png){width=100%}

# Acknowledgements
We acknowledge support from the community 

# References