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



This is elevated because we've included all the unplaced contigs in the SR genome. If we look at the mean divergence within each chromosome the values are close to what we expect: 

```
by_q <- aggregate(dv ~ qname, data=ali, FUN=mean)
knitr::kable(by_q)

|PGA_scaffold_1__52_contigs__length_159530236 | 0.0432848|
|PGA_scaffold_2__15_contigs__length_148418288 | 0.0422783|
|PGA_scaffold_3__41_contigs__length_92227466  | 0.0699706|
```


Filter
```
prim_alignment <- filter_secondary_alignments(ali)
nrow(ali) - nrow(prim_alignment)
[1] 1056   ##removed 1056 secondary alignments

nrow(prim_alignment)
[1] 8716   ##number of primary alignments

##Keep only long, high quality alignments: 
long_ali <- subset(prim_alignment, alen > 1e4 & mapq > 40)
long_ali

pafr object with 4873 alignments (461Mb)
 136 query seqs
 116 target seqs
 6 tags: tp, cm, s1, s2, dv, rl
```


Plot the alignment
```
dotplot(long_ali, label_seqs=TRUE, order_by="qstart") + theme_bw()
```

![alt_txt][Fig2]

[Fig2]:https://user-images.githubusercontent.com/12142475/177125072-a6fcdc4d-9e66-4703-b60a-6e4bff105741.png


# X chr

Our SR X chr is based on 41 scaffolded contigs. To see exactly where these map (across inversions?): 

1) extract the fasta sequences of the contigs from the SR genome (pomiankowski-tdalmanni.final.fasta)

2) map these to the WilkST genome using minimap. 

```
POMSR_Xcontigs_vs_T.dalmaniiST_Wilk2020.minimap.aln.paf
```

3) Rename the 41 contigs with their ctg names in the mapped paf file for easier plotting. Find the names here

```
/SAN/ugi/StalkieGenomics/SRgenome/SRgenome_contigs_ctgonly.bed
```


And plot using the synteny function from pafr: 
```
pdf("syntenyplot_SRX.pdf")
plot_synteny(long_ali, q_chrom="ctg29", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg33", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg6", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg12", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg26", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg59", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg97", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_synteny(long_ali, q_chrom="ctg106", t_chrom="NC_051848.1", centre=T, rc=F)+theme_bw()
plot_coverage(aliX_intContigs, fill="qname")
dev.off()

```


These are the 8 contigs that show convincing inversions. As an example: 

![alt_txt][Fig3]

[Fig3]:https://user-images.githubusercontent.com/12142475/177124031-923df5da-89df-4ffe-8997-96471fdb82d6.png




