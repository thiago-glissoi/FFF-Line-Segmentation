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
`fdm_segmenter` is a signal segmentation script written in Matlab that allows for automatically and accurate segmentation of the printing lines. TODO: add references

# Statement of need

### Automatic

Current research on the FDM process utilizes different methods to segment the acoustic signals. However, all of these methods have a manual component,  like the printing time evaluation of each line through a video recording of the printing process, or manually selecting the printing lines in reference to amplitude variations in the time domain. These manual segmentation methods pose a serious challenge to adequate process monitoring, since they are time-consuming and prone to errors due to human mistakes. TODO: add references
`fdm_segmenter` takes a programming approach that allows for automatic  segmentation of the printing lines in a acoustic signal utilizing the direction control signal of the X and Y step motors axis of the FDM printer, and the signals sampling frequency. This feature allows for accurate segmentation of the contour and raster printing lines from other signal data, thus allowing the extraction of the relevant information for the process monitoring and control. TODO: add references
A consequence of this programming approach is that the FDM signal segmentation in `fdm_segmenter`, in contrast to other methods that have a manual component, is fully automatic and less prone to errors due to human mistakes. The process operator only needs to inputs the acoustic signal, the direction control signal of the X and Y step motors axis of the FDM printer, and the signals sampling frequency. In return, the operator receives the start and end points in number of samples for each printing line. TODO: add references

<!-- 
### Extensibile

In addition to its scalability, Openseize employs an extensible
object-oriented architecture. This feature, missing in many currently
available DSP packages, is crucial in neuroscience research for two reasons.
First, there are many different data file types in-use. Abstract base
classes [@GOF] help future developers integrate their file types into
Openseize by identifying required methods needed to create producers that
Openseize's algorithms can process. Second, DSP operations are strongly
interdependent. By identifying and abstracting common methods, the
algorithms in Openseize are smaller, more maintainable and above all, easier
to understand.  \autoref{fig:types} diagrams the currently available DSP
methods grouped by their abstract types or module names.

 ![Partial list of DSP classes and methods available in Openseize grouped by
abstract type and/or module (gray boxes). Each gray box indicates a point of
extensibility either through development of new concrete classes or
functions within a module.\label{fig:types}](types.png)

### Intuitive API

Finally, Openseize has an intuitive application programming interface (API).
While under the hood, Openseize is using a declarative programming approach,
from the end-user's perspective, the calling of its functions are similar
to Scipy's DSP call signatures. The main difference is that producers do not
return DSP processed values when created. Rather, the values are generated
when the producer is iterated over. To help new users understand the
implications of this, Openseize includes extensive in-depth discussions
about DSP algorithms and their iterative implementations in a series of
Jupyter notebooks [@jupyter]. Importantly, to maintain the clarity and
extensibility of Openseize's API, graphical user interfaces (GUIs) have been
avoided. This decision reflects the fact that many current DSP packages have
inconsistent APIs depending on whether the modules are invoked from the
command-line or a GUI.   

In summary, Openseize fulfills a need in neuroscience research for DSP tools
that scale to large EEG recordings, are extensible enough to handle new
data types and methods, and are accessible to both end-users and
developers.

![Teste.\label{fig:examples}](IMG_7577.png){width=100%}

-->

# Acknowledgements
We acknowledge support from the community 

# References