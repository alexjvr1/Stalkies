# Assembly of mito Genome 

I'm using the STgenome raw data (PacBio HiFi reads) to assemble the mitochondrial genome using [MitoHiFi](https://github.com/marcelauliano/MitoHiFi)

Dependencies

|Software|Version|Path|
|:-:|:-:|:-:|
|BlastN|2.10|/share/apps/genomics/blast-2.10.0+/bin/blastn |
|MitoFinder|1.4.1|/SAN/ugi/StalkieGenomics/software/MitoFinder/mitofinder|
|Biopython||*part of python3 site-packages*|
|Pandas||*part of python3 site-packages*|
|MAFFT|7.453|/share/apps/genomics/mafft-7.453/bin/mafft|
|HiFiasm|0.16.1-r375|/SAN/ugi/StalkieGenomics/software/hifiasm/hifiasm|
|CD-HIT|v.4.6.8|/share/apps/genomics/cd-hit-v4.6.8-2017-0621/cd-hit|
|samtools|1.9|*see below*|
|Minimap2|2-2.24|/SAN/ugi/StalkieGenomics/software/minimap2-2.24_x64-linux/minimap2|

samtools
```
export PATH=/share/apps/genomics/samtools-1.9/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/genomics/samtools-1.9/lib:$LD_LIBRARY_PATH
```

python
```
export PATH=/share/apps/python-3.8.5-shared/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/python-3.8.5-shared/lib:$LD_LIBRARY_PATH

```

Run MitoHiFi: 
```
python3 mitohifi.py --help
```

Download the relevant mitochondrial genomes: 
```
findMitoReference.py --species "Teleopsis dalmanni" --email a.jvrensburg@ucl.ac.uk --outfolder /SAN/ugi/StalkieGenomics/RefGenomes --min_length 16000

Looking for mitochondrion for Teleopsis dalmanni
Mito for the same species is not found
Looking among close species
output is written to /SAN/ugi/StalkieGenomics/RefGenomes/NC_059897.1.[gb,fasta]
```

MitoHiFi has selected the mitogenome of Nothybus sumatranus (Diptera:Nothybidae)

I'm not sure this is the best genome, but we'll try it out. 


Run MitoHiFi
```
python3 mitohifi.py -r ../../STgenome_rawdata/HiFi/m64157e_210730_141553.hifi_reads.fasta.gz ../../STgenome_rawdata/HiFi/m64157e_211024_013127.hifi_reads.fasta.gz -f ../../RefGenomes/mtDNA_TdalWilk_Dmel.fas -o 5 -d

```
