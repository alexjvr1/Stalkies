# Blobtools with Snakemake pipeline

I'm setting up a SnakeMake pipeline to run Blobtools on both genomes. 


This worked
```
#Create a Snakemake folder
blobtools create \
--fasta STBlob_dir/STgenome_220510.asm.p_ctg.fasta \
--meta STBlob_dir/STgenome_220510.asm.p_ctg.yaml \
--taxdump STBlob_dir/taxdump STBlob_dir

#Run in a python virtual environment: 
#These are all stored in my home directory, and contain all the dependencies for Blobtoolkit: 
/home/ajansen/.conda/envs

conda activate btk_env
/SAN/ugi/StalkieGenomics/Blobtools_STgenome

#Define variables
export CONDA_DIR=/home/ajansen/.conda/envs/btk_env/bin
export WORKDIR=/SAN/ugi/StalkieGenomics/Blobtools_STgenome/STBlob_dir
export ASSEMBLY=STgenome_220510.asm.p_ctg
export THREADS=8
export PIPELINE=/SAN/ugi/StalkieGenomics/software/blobtoolkit/insdc-pipeline/


#Run snakemake
~/.local/bin/snakemake -p \
--use-conda \  
--conda-prefix $CONDA_DIR \
--directory $WORKDIR/ \
--configfile $WORKDIR/$ASSEMBLY.yaml \
--latency-wait 60 \
--rerun-incomplete \
--stats $ASSEMBLY.snakemake.stats \
-j $THREADS \
-s $PIPELINE/Snakefile
```

Where Snakefile looks like this: 
```
##### Target rules #####

rule all:
	input:
	"STgenome_220510.asm.p_ctg.fasta"

```

# ISSUES TO CORRECT

See [here](https://github.com/blobtoolkit/pipeline/issues/13) for correcting the "KeyError" 

What version of blobtoolkit are we using? 


