#!/bin/bash
#$ -S /bin/bash
#$ -N updateNCBI_nt  ##job name
#$ -l tmem=16G #RAM
#$ -l h_vmem=16G #enforced limit on shell memory usage
#$ -l h_rt=10:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)

#############################################################
# Update NCBI nt database to the latest version
# This runs well in screen without submitting to the server
#############################################################

## Change to the directory with NCBI nt database:

WD=/SAN/ugi/StalkieGenomics/Blobtools_STgenome/ncbi_nt
cd $WD


## Add Blast and perl to PATH

export PATH=/share/apps/perl-5.28.0/bin:$PATH
export PATH=/share/apps/genomics/blast-2.10.0+/bin:$PATH

## Update and decompress nt database

update_blastdb.pl --decompress nt
