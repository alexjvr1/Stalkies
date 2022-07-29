# LR Alignment with calling SVs with Sniffles

We're following the [Sedlazeck et al 2018](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5990442/) paper to map long reads and call structural variants. 

This method was specifically developed to call SVs from long read data using 1) NGMLR as a long read aligner, and 2) Sniffles to call structural variants. 


## Nested inversions

Sniffles is one of the only programs to detect nested inversions. 

Nested inversions 


Extract inversions and visualise with IGV and samplot
```
#vcf from SNIFFLES containing all variants
grep -vr "\./\." AllSR_minimap_sniffles_NC_051848.1.vcf.recode.vcf | grep "COVERAGE=" > X_allvariants


#Separate some of the columns and extract the ones we're interested in: 
sed -i 's:,:\t:g' X_allvariants
sed -i 's:;:\t:g' X_allvariants
sed -i 's:=:\t:g' X_allvariants
sed -i 's/:/\t/g' X_allvariants

awk -F "\t" '{print $1, $2, $3, $4, $6, $7, $8, $10, $12, $14, $16, $18, $19, $20,$21, $22, $24, $26, $35, $36, $37, $38}' X_allvariants > X_allvariants_clean

#There are some "BND" variants which show the breakpoints of contigs(? - I think). We don't want these. 
grep INS X_allvariants_clean > X_allvariants2
grep INV X_allvariants_clean >> X_allvariants2
grep DEL X_allvariants_clean >> X_allvariants2

wc -l X_allvariants2
31566 X_allvariants2

##READ into R
test <- read.table("X_allvariants2", header=F)
colnames(test) <- c("Chr", "Start", "Name", "Ref", "QUAL", "FILTER", "PRECISE", "SVTYPE", "SVLEN", "END", "SUPPORT", "COV.UPSTREAM", "COV.START", "COV.MIDDLE", "COV.END", "COV.DOWNSTREAM", "STRAND", "AF", "DR", "DV", "GT", "GQ")

```
