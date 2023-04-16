---
title: 'fdm_segmenter: A signal segmentation script for acoustic FDM fabrication data in Matlab'

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

date: 13 April 2023 
bibliography: paper.bib 

---

# Summary
The Fused Deposition Modeling (FDM) process deals with the manufacturing of parts by adding multiple layers of fused material in predetermined printing lines. TODO: add references
The monitoring of the FDM process via acoustic signals has been successfully used to detect the occurrence of defects in the printing process. TODO: add references
Mechanistically, acoustic signals obtained from the FDM process are non-stationary time-series that capture alterations in the acoustic field arising from the material deposition. TODO: add references
The signal segmentation is a fundamental step in the process monitoring of FDM, since it allows the identification of the printing lines and the extraction of the relevant information for the process monitoring and control. However, due to many acoustic interferences arising from the FDM process an accurate manual segmentation may not be possible to achieve TODO: add references
`fdm_segmenter` is a signal segmentation script written in Matlab that allows for automatically and accurate segmentation of the different printing lines. TODO: add references

# Statement of need

### Automatic

Current research on the FDM process utilizes different methods to segment the acoustic signals. However, all of these methods have a manual component,  like the printing time evaluation of each line through a video recording of the printing process, or manually selecting the printing lines in reference to amplitude variations in the time domain. These manual segmentation methods pose a serious challenge to adequate process monitoring, since they are time-consuming and prone to errors due to human mistakes [@Lopes2022].
`fdm_segmenter` takes a programming approach that allows for automatic  segmentation of the printing lines in a acoustic signal utilizing the direction control signal of the X and Y step motors axis of the FDM printer, and the signals sampling frequency. This feature allows for accurate segmentation of the contour and raster printing lines from other signal data, thus allowing the extraction of the relevant information for the process monitoring and control. TODO: add references
A consequence of this programming approach is that the FDM signal segmentation in `fdm_segmenter`, in contrast to other methods that have a manual component, is fully automatic and less prone to errors due to human mistakes. The process operator only needs to inputs the acoustic signal, the direction control signal of the X and Y step motors axis of the FDM printer, and the signals sampling frequency. In return, the operator receives the start and end points in number of samples for each printing line. TODO: add references

### Result orientated

In addition to its automatic feature, `fdm_segmenter` is result orientated. Firstly, the segmentation results can be presented in graphical windows that allows for a quick visual inspection of the segmentation results. This feature allows for a quick and accurate evaluation of the script performance. Secondly, the segmentation results can be autosaved following predefined workspace data formats. These formats allow for the easy import of the segmentation results into other Matlab analysis. By identifying and abstracting common segmentation methods, the algorithms in `fdm_segementer` are more direct, maintainable and above all, easier to understand in regard to the printer deposition movements.

### Scalable

The algorithms in `fdm_segmenter` were developed with a cartesian [RepRap](https://reprap.org/wiki/RepRap) based FDM printer in focus. This is due to the fact that cartesian RepRap based FDM printers are commonly used for research purposes. TODO: add references
Also, the segmentation algorithms were developed in order to segment the contour and raster printing lines of a rectangular shape monolayer part. The stl file of the part was sliced to g-code following standard printing parameters provided by the printer manufacturer. The documentation of `fdm_segmenter` provides a detailed explanation of the segmentation algorithms and how they were developed to attend the particularities of the cartesian RepRap based FDM printer and the rectangular shape monolayer part, which provides a scalable framework for the segmentation of other parts with different shapes and printing parameters. 

In summary, `fdm_segmenter` fulfills a need in the FDM process monitoring research for a signal segmentation script that is automatic, result orientated and scalable.

![Teste.\label{fig:examples}](IMG_7577.png){width=100%}

# Acknowledgements
We acknowledge support from the community 

# References