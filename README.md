# ligand_pdb2pdbqt
Automated Windows pipeline that protonates ligand PDB files at pH 7.4 and converts them in bulk to AutoDock-ready PDBQT format using Open Babel 3 + MGLTools

# Ligand(PDB)-to-PDBQT Preparation Pipeline  
_Automated ligand cleanup & conversion for AutoDock Vina_

[![Made with Open Babel 3.1.1](https://img.shields.io/badge/OpenBabel-3.1.1-blue)](https://openbabel.org)
[![Made with MGLTools 1.5.7](https://img.shields.io/badge/MGLTools-1.5.7-blue)](https://ccsb.scripps.edu/mgltools/)

## Overview
This repository contains a Windows-centric batch script (`prepare_all_pdb_v2.bat`) that:

1. **Checks** you have Open Babel ≥ 3.1.1 and MGLTools 1.5.7 installed.  
2. **Batch-protonates** every `.pdb` file found in `.\lib\` at physiological pH 7.4.  
3. **Converts** the protonated models to AutoDock-compatible `.pdbqt` format via `prepare_ligand4.py`.  
4. **Drops** final files into `.\pdbqt-2\`.  
5. **Cleans up** all temporary scratch files.

> **Why?** Preparing hundreds of ligands manually is error-prone.  
> This script standardises protonation and file naming so downstream AutoDock Vina runs are reproducible.

---

## Quick start

```powershell
git clone https://github.com/SidSin0809/ligand_pdb2pdbqt.git

:: Place all ligand PDB files in .\lib\
prepare_all_pdb_v2.bat


| Dependency               | Version tested          | Install hint                                |
| ------------------------ | ----------------------- | ------------------------------------------- |
| Open Babel               | 3.1.1                   | [https://openbabel.org/]
| MGLTools (AutoDockTools) | 1.5.7                   | [https://ccsb.scripps.edu/mgltools/]
| Python                   | 3.9 (MGLTools-embedded) | Bundled inside MGLTools
| Windows                  | 10/11                   | Uses `cmd`-style batch syntax


Citation
If you use this pipeline in academic work, please cite:
O’Boyle et al. “Open Babel: An open chemical toolbox” J Cheminform 2011.
Morris GM et al. “AutoDockTools4: Automated docking tools” J Comput Chem 2009.

