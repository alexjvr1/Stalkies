# BUSCO Karyotyping

Checking on the order and presence of BUSCO genes in 1) our SR genome, and 2) Gerry's ST genome compared with D.melanogaster. 


I'm using Sam Whiteford's program to do this: [BUSCO Karyotyping](https://github.com/swomics/BUSCO_karyotyping)


First run a BUSCO analysis for all three genomes by modifing the [BUSCO.sh](https://github.com/alexjvr1/Stalkies/blob/main/Scripts/BUSCO.sh) script: 

*Note: adjust the time in the script. There took ~8 hours each*

1) Our reference genome will be D.melanogaster [GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001215.4/)

2) Gerry Wilkinson's genome: /SAN/ugi/StalkieGenomics/RefGenome/T.dalmanii_WilkinsonLab_2020/GCF_002237135.1_ASM223713v2_cds_from_genomic.fna.gz

3) Our SR genome: /SAN/ugi/StalkieGenomics/SRgenome/pomiankowski-tdalmanni.final.fasta

*Note1: BUSCO requires unzipped fasta inputs (.fasta, .fna)*

*Note2: If the database is specified (e.g. diptera_odb10), BUSCO will look for a it in the following path in your working dir: busco_downloads/lineages/diptera_odb10*



Sam's code didn't work, so I will try to create a similar plot to the Wilkinson paper in R. 

```
#Remove all the unplaced scaffolds

TdelW_overlap2 <- TdelW_overlap %>% filter(grepl("Chr", Sequence)) 

#Create a "Pos" column containing the relative position of the gene start for each species

ref
    Chr Genome      Size
1    2L   Dmel  23513712
2    2R   Dmel  25286936
3    3L   Dmel  28110227
4    3R   Dmel  32079331
5     4   Dmel   1348131
6     X   Dmel   3667352
7  Chr1 TdalSR 159530236
8  Chr2 TdalSR 148418288
9  ChrX TdalSR  92227466
10 Chr1  TdalW 235434165
11 Chr2  TdalW 246003176
12 ChrX  TdalW 102199558

TdelW_overlap$GeneStart <- as.numeric(TdelW_overlap$GeneStart)
TdelW_overlap_relativeStart <- TdelW_overlap %>% mutate(Pos=case_when(Sequence %in% "Chr1" ~ GeneStart, Sequence %in% "Chr2" ~ GeneStart+235434165, Sequence %in% "ChrX" ~ GeneStart+481437341))

TdelSR_overlap$GeneStart <- as.numeric(TdelSR_overlap$GeneStart)
TdelSR_overlap_relativeStart <- TdelSR_overlap %>% mutate(Pos=case_when(Sequence %in% "Chr1" ~ GeneStart, Sequence %in% "Chr2" ~ GeneStart+159530236, Sequence %in% "ChrX" ~ GeneStart+307948524))

Dmel_overlap$GeneStart <- as.numeric(Dmel_overlap$GeneStart)
Dmel_overlap_relativeStart <- Dmel_overlap %>% mutate(Pos=case_when(Sequence %in% "Chr2L" ~ GeneStart, Sequence %in% "Chr2R" ~ GeneStart+23513712, Sequence %in% "Chr3L" ~ GeneStart+48800648, Sequence %in% "Chr3R" ~ GeneStart+76910875, Sequence %in% "Chr4" ~ GeneStart+108990206, Sequence %in% "ChrX" ~ GeneStart+110338337))
Dmel_overlap_relativeStart2 <- Dmel_overlap_relativeStart
Dmel_overlap_relativeStart2$Pos <- as.numeric(Dmel_overlap_relativeStart$Pos*5)

TdelSR_Dmel_W_joined <- dplyr::bind_rows(TdelSR_overlap_relativeStart, Dmel_overlap_relativeStart, TdelW_overlap_relativeStart)

TdelSR_Dmel_W_joined2 <- TdelSR_Dmel_W_joined %>% filter(grepl("Chr", Sequence)) 
#Plot line graph: 

#To keep species order
#TdelSR_Dmel_W_joined2$Species <- factor(TdelSR_Dmel_W_joined2$Species, levels=c("Dmel", "TdelSR", "TdelW"))

ggplot(TdelSR_Dmel_W_joined2, aes(x=Species, y=RescaledPos))+geom_point()+geom_line(aes(group=Buscoid, colour=Sequence), alpha=0.4)

#Tdal X only
pdf("Tdal_BUSCO_ChrXaln.pdf")
ggplot(Tdel_joined[which(Tdel_joined$Sequence=="ChrX"),], aes(x=Species, y=GeneStart))+geom_point()+geom_line(aes(group=Buscoid, colour=Sequence), alpha=0.4)
dev.off()
```

![alt_txt][Fig1]

[Fig1]:https://user-images.githubusercontent.com/12142475/177119745-4166bb4b-5cbb-4964-808a-012eeddec050.png




Create a plot with all three species aligned: 
```
#rescale position
library(scales)
Dmel_overlap_relativeStart$RescaledPos <- rescale(Dmel_overlap_relativeStart$Pos, to =c(0,600))
TdelSR_overlap_relativeStart$RescaledPos <- rescale(TdelSR_overlap_relativeStart$Pos, to =c(0,600))
TdelW_overlap_relativeStart$RescaledPos <- rescale(TdelW_overlap_relativeStart$Pos, to =c(0,600))

#Create a joined dataframe
TdelSR_Dmel_W_joined <- dplyr::bind_rows(TdelSR_overlap_relativeStart, Dmel_overlap_relativeStart, TdelW_overlap_relativeStart)

#Keep only the chromosomes
TdelSR_Dmel_W_joined2 <- TdelSR_Dmel_W_joined %>% filter(grepl("Chr", Sequence))
TdelSR_Dmel_W_joined2$Species <- factor(TdelSR_Dmel_W_joined2$Species, levels=c("Dmel", "TdelSR", "TdelW"))

pdf("KaryotypePlot_Dmel_SR_STWilk.pdf")
ggplot(TdelSR_Dmel_W_joined2, aes(x=Species, y=RescaledPos))+geom_point()+geom_line(aes(group=Buscoid, colour=Sequence), alpha=0.4)
dev.off()
```


![alt_txt][Fig2]

[Fig2]:https://user-images.githubusercontent.com/12142475/177120955-2ad33290-f125-4d27-b7c7-b56940d86948.png
