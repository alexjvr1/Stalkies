# Figures: Align contigs to chromosomes

We're using [Alvis](https://alvis.readthedocs.io/en/latest/usage/diagrams.html) to visualise the alignment of the contigs in the SR genome across the putative break points. 

I've mapped our SR genome against Wilkinson's ST genome and found some possible inversions: 

![alt_txt][fig1]

[fig1]:https://user-images.githubusercontent.com/12142475/174772283-f42ce9e0-39cc-4f24-b831-09a9fbf0083a.png


We need to check if the breakpoints fall within contigs. I've identified the names of the contigs mapped across the breakpoints: 


BP1: 

BP2:

BP3: 

BP4: 

BP5:

BP6:

BP7: 


```
pwd
/SAN/ugi/StalkieGenomics/SRgenome

export PATH=/share/apps/java/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/java/lib:$LD_LIBRARY_PATH

ALGNMENT=map_POM_SR_FULL_to_GCF_002237135.1_ASM223713v2_genomic.paf

java -jar alvis/dist/Alvis.jar -type contig -inputfmt paf -outputfmt svg \
-alignmentQueryName ctg33 -alignmentTargetName \
-in -outdir -out ContigAln_ctg33
```
