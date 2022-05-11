# Assembly of mito Genome 

I'm using the STgenome raw data (PacBio HiFi reads) to assemble the mitochondrial genome using [Organelle_PBA](https://github.com/aubombarely/Organelle_PBA)

Dependencies

|:-:|:-:|:-:|
|Software|Version|Path|
|BioPerl|||
|Seqtk|1.3-r106|/share/apps/genomics/seqtk/seqtk|
|BlastN|2.10|/share/apps/genomics/blast-2.10.0+/bin/blastn |
|BlasR|||
|samtools|1.9|*see below*|
|bedtools|2.30.0|/share/apps/genomics/bedtools-2.30.0/bin/bedtools|
|sprai|||
|WGS-assembler|||
|SSPACE-Long|||

samtools
```
export PATH=/share/apps/genomics/samtools-1.9/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/genomics/samtools-1.9/lib:$LD_LIBRARY_PATH

```
