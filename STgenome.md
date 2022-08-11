# ST genome

PacBio HiFi reads x 2 SMRT cells


Software: Using [HiFiasm](https://github.com/chhylp123/hifiasm#hifionly) to assemble the genome. 

[HiFiasm tutorial](https://hifiasm.readthedocs.io/en/latest/pa-assembly.html)

Using the [HiFiasm4.sh](https://github.com/alexjvr1/Stalkies/blob/main/Scripts/HiFiasm4.sh) script specifying 4 threads, 20 hours, and 8 Gb RAM. The final time and computing resources needed was: 
```
[M::main] Version: 0.16.1-r375
[M::main] CMD: /SAN/ugi/StalkieGenomics/software/hifiasm/hifiasm -o /SAN/ugi/StalkieGenomics/STgenome/STgenome_220510.asm -t 4 --primary /SAN/ugi/StalkieGenomics/STgenome_rawdata/HiFi/m64157e_211024_013127.hifi_reads.fastq.gz /SAN/ugi/StalkieGenomics/STgenome_rawdata/HiFi/m64157e_210730_141553.hifi_reads.fastq.gz
[M::main] Real time: 70485.004 sec; CPU: 111946.371 sec; Peak RSS: 24.832 GB

real	1174m55.122s
user	1799m8.122s
sys	66m40.244s



[M::purge_dups] homozygous read coverage threshold: 49
[M::purge_dups] purge duplication coverage threshold: 62
```


## Assess the output: 

```
/SAN/ugi/StalkieGenomics/STgenome

ls STgenome_220510.asm.*
STgenome_220510.asm.a_ctg.gfa         STgenome_220510.asm.ovlp.source.bin  STgenome_220510.asm.p_utg.lowQ.bed
STgenome_220510.asm.a_ctg.lowQ.bed    STgenome_220510.asm.p_ctg.gfa        STgenome_220510.asm.p_utg.noseq.gfa
STgenome_220510.asm.a_ctg.noseq.gfa   STgenome_220510.asm.p_ctg.lowQ.bed   STgenome_220510.asm.r_utg.gfa
STgenome_220510.asm.ec.bin            STgenome_220510.asm.p_ctg.noseq.gfa  STgenome_220510.asm.r_utg.lowQ.bed
STgenome_220510.asm.ovlp.reverse.bin  STgenome_220510.asm.p_utg.gfa        STgenome_220510.asm.r_utg.noseq.gfa
```


The gfa files are graphs of the output. We can visualise these using [Bandage](https://rrwick.github.io/Bandage/) downloaded onto my mac. 

Convert gfa to fas using [gfatools](https://github.com/lh3/gfatools)

```
for i in $(ls *gfa); do ../software/gfatools/gfatools gfa2fa $i > $i.fas; done
```


# Kmer distribution

HiFiasm prints out the Kmer distribution as estimated with Jellyfish. This can be found in the log file. 

![alt_txt][kmerdist]

[kmerdist]:https://user-images.githubusercontent.com/12142475/169043417-a27424e3-ab04-4fc5-ba0e-c4f983791627.png


See [Issue 93](https://github.com/chhylp123/hifiasm/issues/93): This Kmer distribution can be caused either by high heterozygosity, or contamination. 

Suggestions: 

1) Use [Genomescope](https://bioinformaticsworkbook.org/dataAnalysis/GenomeAssembly/genomescope.html#gsc.tab=0) to plot the kmer distribution after estimating it with Jellyfish. 

2) Estimate the levels of contamination with Blobtools

3) Extract mitochondrial reads (I'm using MitoHiFi for this). 


# Busco

Results suggest that there is still duplicates in the assembly. 

According to the HiFiasm developers the inbuilt purge_dup is not always effective with high heterozygosity. See Heng Li's comments [here](https://github.com/chhylp123/hifiasm/issues/70)

Try to run purge_dups after running HiFiasm. 




## Blobtools

Required files

1) Assembly (.fna) - DONE

2) Coverage estimate (.bam): 
```
##For a de novo assembly this is created by mapping the raw reads back to the de novo assembly using a long read mapper like minimap2

## pwd
/SAN/ugi/StalkieGenomics/STgenome/

## 1) Index the reference genome
../software/minimap2-2.24_x64-linux/minimap2 STgenome_220510.asm.p_ctg.fas -d STgenome_220510.asm.p_ctg.fas.fai
[M::mm_idx_gen::23.300*1.59] collected minimizers
[M::mm_idx_gen::27.878*1.82] sorted minimizers
[M::main::32.083*1.71] loaded/built the index for 2932 target sequence(s)
[M::mm_idx_stat] kmer size: 15; skip: 10; is_hpc: 0; #seq: 2932
[M::mm_idx_stat::32.758*1.69] distinct minimizers: 43723498 (57.61% are singletons); average occurrences: 2.822; average spacing: 5.331; total length: 657806061
[M::main] Version: 2.24-r1122
[M::main] CMD: ../software/minimap2-2.24_x64-linux/minimap2 -d STgenome_220510.asm.p_ctg.fas.fai STgenome_220510.asm.p_ctg.fas
[M::main] Real time: 33.701 sec; CPU: 55.783 sec; Peak RSS: 4.017 GB


## 2) Map all the raw reads back to the genome. Multiple input can either be mapped separately and bams concatenated after, all fasta files can be concatenated and then mapped. Or they can all be mapped simultaneously. 

## minimap_STgenome_vs_HiFi.sh

time $minimap2 -ax map-hifi $REF -d $REF.fai \
$INPUTREADS/m64157e_210730_141553.hifi_reads.fasta.gz \
$INPUTREADS/m64157e_210730_141553.hifi_reads.fastq.gz \
$INPUTREADS/m64157e_211024_013127.hifi_reads.fasta.gz \
$INPUTREADS/m64157e_211024_013127.hifi_reads.fastq.gz > $OUT.aln.paf

```

3) Hits file

Blast 

## Purge duplicates

purge_dups


