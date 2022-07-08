#!/bin/bash
#$ -S /bin/bash
#$ -N tama_ST  ##job name
#$ -l tmem=32G #RAM
#$ -l h_vmem=32G #enforced limit on shell memory usage
#$ -l h_rt=10:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)

#Run on working directory
cd $SGE_O_WORKDIR 

#Environment
export PATH=/share/apps/python-2.7.16-shared/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/python-2.7.16-shared/lib:$LD_LIBRARY_PATH


#Variables
SHAREDPATH=/SAN/ugi/StalkieGenomics/
ISOSEQPATH=isoSeq/LIMS27752IsoSeq_08ebf325e8366c31/IsoSeq/Sample1
TAMA=$SHAREDPATH/software/tama 
INPUT=$SHAREDPATH/$ISOSEQPATH/Sample1.collapsed.cdhit.0.97.srt.sam
REF=$SHAREDPATH/RefGenome/T.dalmanii_WilkinsonLab_2020/GCF_002237135.1_ASM223713v2_genomic.fna
PREFIX=Sample1_cdhit_tamacollapsed
CAP=no_cap


python $TAMA/tama_collapse.py -s $INPUT -f $REF -p $PREFIX -x $CAP
