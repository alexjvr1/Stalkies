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

[alt_txt][kmerdist]

[kmerdist]:https://user-images.githubusercontent.com/12142475/169043417-a27424e3-ab04-4fc5-ba0e-c4f983791627.png


See [Issue 93](https://github.com/chhylp123/hifiasm/issues/93): This Kmer distribution can be caused either by high heterozygosity, or contamination. 

Suggestions: 

1) Use [Genomescope](https://bioinformaticsworkbook.org/dataAnalysis/GenomeAssembly/genomescope.html#gsc.tab=0) to plot the kmer distribution after estimating it with Jellyfish. 

2) Estimate the levels of contamination with Blobtools

3) Extract mitochondrial reads (I'm using MitoHiFi for this). 

