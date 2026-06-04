# Grid-Forming Converter DC-link Control — EMT Case Study

This repository contains the Simulink model and supporting files used to reproduce the EMT (Electromagnetic Transient) case study presented in the article:

> **Grid-Forming Converter DC-link Control Considering the Primary Energy Source**  
> Carlo De Paolis Robles, Andrés Tomás-Martín, Ignacio Egido, Aurelio García-Cerrada  
> Institute for Research in Technology (IIT), Comillas Pontifical University — ICAI

The case study implements a Grid-Forming Voltage-Source Converter (GFM-VSC) with explicit Primary Energy Source (PES) dynamics and the proposed DC-link supervisory control strategy.

## How to run the case

The main entry point is `VFlexP_small.slx`. This Simulink model opens the GFM-VSC case with PES dynamics and DC-link control as described in the article (Section 4 — Detailed Full-Order Model Validation).

The remaining files in the repository are supporting elements: initialization scripts, the case configuration file `GFr_vs_IG.xlsx` (loaded by the tool), and additional auxiliary files required by the VFlexP framework.

## About the simulation tool

The case study is built on top of **VFlexP** (*Vector-Based Flexible-Complexity Power System Tool*), developed by **Andrés Tomás-Martín** at the Institute for Research in Technology (IIT), Comillas Pontifical University — ICAI. The tool itself is described in:

> A. Tomás-Martín et al., *A vector-based flexible-complexity tool for simulation and small-signal analysis of hybrid AC/DC power systems*, Sustainable Energy, Grids and Networks, 2025.

VFlexP repository: <https://github.com/atomasmartin/VFlexP>

In this work, I have acted exclusively as a user of VFlexP to implement and simulate the case study and the proposed DC-link control strategy presented in the article.

## Citation

If you use this case study, please cite the article above.
