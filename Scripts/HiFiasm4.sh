#!/bin/bash
#$ -S /bin/bash
#$ -N ST4.HiFiasm  ##job name
#$ -l tmem=8G #RAM
#$ -l h_vmem=8G #enforced limit on shell memory usage
#$ -l h_rt=20:00:00 ##wall time.  
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -pe smp 4
#$ -R y

#Run on working directory
cd $SGE_O_WORKDIR 

#Variables
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SHAREDPATH=/SAN/ugi/StalkieGenomics
ST=STgenome

#Call software
HIFIASM=/SAN/ugi/StalkieGenomics/software/hifiasm/hifiasm

#Run
##echo "time $HIFIASM -o $SHAREDPATH/$ST/STgenome_220510.asm --write-paf --write-ec /dev/null \
##--primary $SHAREDPATH/STgenome_rawdata/HiFi/m64157e_211024_013127.hifi_reads.fastq.gz \
##$SHAREDPATH/STgenome_rawdata/HiFi/m64157e_210730_141553.hifi_reads.fastq.gz" > hifiasm_$TIMESTAMP.log

time $HIFIASM -o $SHAREDPATH/$ST/STgenome_220510.asm -t 4 \
--primary $SHAREDPATH/STgenome_rawdata/HiFi/m64157e_211024_013127.hifi_reads.fastq.gz \
$SHAREDPATH/STgenome_rawdata/HiFi/m64157e_210730_141553.hifi_reads.fastq.gz 
