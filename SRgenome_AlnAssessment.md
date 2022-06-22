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
#Plot the per base sequence divergence vs alignment length

ggplot(ali, aes(alen, dv)) + 
    geom_point(alpha=0.6, colour="steelblue", size=2) + 
    scale_x_continuous("Alignment length (kb)", label =  function(x) x/ 1e3) +
    scale_y_continuous("Per base divergence") + 
    theme_pubr()

```


![alt_txt][Fig1]

[Fig1]:https://user-images.githubusercontent.com/12142475/174992267-63b57fe0-c15a-4eab-9e32-6de6b52d15d5.png


