# Genomic analysis of Stalk-eyed flies 

[Stalkie_GoogleDoc](https://docs.google.com/document/d/1TT5HuJuPho5OCNKg7C28hcHOtwxHuN2BFG5LlgKJFnE/edit)

Teleopsis dalmanni

Karyotype (like Drosophila): 3 chromosomes

~620Mb genome size

SR driving X-chromosomes found in 20-30% of wild indivs ([Reinhardt et al. 2014](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004362))

Sympatric cryptic species in the same area. 


Meiotic drive is ancestral but lost in the sister species

![alt_txt][Fig1]

[Fig1]:https://user-images.githubusercontent.com/12142475/136238893-1272665f-85ba-4eab-82ef-0924ef1b529b.png


## People 

[POM](https://www.ucl.ac.uk/biosciences/people/andrew-pomiankowski) - PI

[Sasha Bradshaw](https://london-nerc-dtp.org/profile/bradshaws/) - PhD student with POM

[Flo Camus](http://www.homepages.ucl.ac.uk/~ucbtmre/Labsite/Flo.html) - Drosophila biologist, mtDNA, UCL

[Helen Hipperson](https://www.sheffield.ac.uk/biosciences/people/academic-staff/helen-hipperson) - Sheffield. Leading analyses of genomic data

[Christophe Dessimoz](https://lab.dessimoz.org/people/christophe-dessimoz) - Uni Lausanne & SIB. [OMA database of orthologs](https://omabrowser.org/oma/about/) - potentially for annotation. 


## Available data

### 2 genomes available: 

1) from inbred males with SR genotype (based on genetic markers - not msats). 

PacBio sequences + HiC. Assembled by Phase Genomics

2) Wild type (ST) genome being generated in Liverpool (Terry Burke and Helen Hipperson). 

Raw data available. Needs assembly


A genome has been assembled by Jerry Wilkinson in 2020: [BioRxiv paper](https://www.biorxiv.org/content/10.1101/2020.09.23.310227v1.full)


### 100 WGS wild flies

50:50 SR:wild (based on genetic markers, but genetic markers were developed in inbred lab strains, so we're uncertain if all 50 are def SR). 

sampled over ~10 years within ~10km from each other. 


## Theories and questions: 

#### 1. Series of overlapping inversions?

US group working on Stalk-eyed flies: Gerald Wilkinson (Uni Maryland) 

-> Found a series of inversions (4-5; overlapping) on the X-chromosome that they think are linked to SR meiotic drive. 

1) Can we recover the same inversions? Do the inversions overlap?  (We'll be using a newly assembled genome 1 above, which is based on a more homozygous sample than the reference genome generated by UniMaryland)


#### 2. Are inversions in coding regions?

Inversions are likely large based on microsat data. 

2) Can we find the break points of the inversions? Are they in coding regions? 

(Need an annotated genome)

InvBFM


#### 3. Are inversions adaptive? 

There is an ~20% inversion rate in the wild. Recombination in these individuals will be reduced compared to the rest of the pop, so we expect an accumulation of mutations. 

Thus we expect these males to have a high mutational load and be poorer quality. BUT they have the same fecundity as normal flies. 

They have a smaller gap between the eyes, which is less attractive to females. Thus they have fewer mating opportunites. They don't deliver more sperm per insemination. But they have much bigger testes. 


3) Do we find an accumulation of mutations in the SR males? 

Estimate mutational load in each dataset. (for different polymorphism classes- SNPs, indels, inversions?)

Fst outlier analysis to find SNP differences between datasets. Is there more diversity within the SR males than between groups? 



#### 4. mtDNA?

Can we extract the mtDNA from the WGS dataset? And from the reference genome? 

Greg Hurst and Stefanos: mitogenome



## Possible tools

[InvBFM](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-020-6585-1): Machine learning approach using features collected from several SV analyses to predict locations of SV. 




