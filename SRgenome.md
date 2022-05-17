# SR genome processing

## Data

PacBio CLR data assembled by Helen Hipperson

Hi-C to scaffold the contigs sequenced and scaffolded by Phase Genomics




## 1. Assess assembly completeness and quality


### 1.1. Blobtools: 

Blobtools2 was installed following their [github page: Blobtools1](https://github.com/DRL/blobtools), and [Blobtools2](https://github.com/blobtoolkit/blobtoolkit)

Paper [here: Challis et al. 2020](https://doi.org/10.1534/g3.119.400908)

Tutorial [here](https://blobtoolkit.genomehubs.org/blobtools2/blobtools2-tutorials/getting-started-with-blobtools2/) 


```
~/.local/bin/blobtools --help
usage: blobtools [<command>] [<args>...] [-h|--help] [--version]

~/.local/bin/blobtools --version
blobtoolkit v3.1.6
```


Create a folder with initial stats: 
```
/SAN/ugi/StalkieGenomics/SRgenome

 ~/.local/bin/blobtools create --fasta POM_SR_FULL.fasta SR_Assembly_Blobtools
Loading sequences from POM_SR_FULL.fasta
```






