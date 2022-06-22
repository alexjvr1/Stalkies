# SRgenome: Assessment of alignment with WilkST and Dmel

Use [pafr](https://cran.r-project.org/web/packages/pafr/vignettes/Introduction_to_pafr.html) to visualise alignments and divergence between genomes: 


```
#Working on AJvRs Mac
pwd 
/Users/alexjvr/2022ResearchAssoc/Stalkie/PlotPAF

library(pafr)
ali <- read_paf("map_POM_SR_FULL_to_GCF_002237135.1_ASM223713v2_genomic.paf")
ali
pafr object with 9772 alignments (487.1Mb)
 361 query seqs
 603 target seqs
 6 tags: tp, cm, s1, s2, dv, rl
```

The paf alignment tags are defined in the [minimap2 manual](https://lh3.github.io/minimap2/minimap2.html)

|Tag|Description|
|--|--|
|tp|Type of aln: P/primary, S/secondary and I,i/inversion|
|cm|Number of minimizers on the chain|
|s1|Chaining score|
|s2|Chaining score of the best secondary chain|
|dv|Approximate per-base sequence divergence|
|rl|Length of query regions harboring repetitive seeds|

```

```
