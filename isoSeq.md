# isoSeq data

Assess and clean the isoSeq data sequenced at the CGR in Liverpool. Initial bioinformatics run by CGR: 

```
28/06/2022
CGR LIMS27752 Update
Lenzi, Luca <L.Lenzi@liverpool.ac.uk>
⚠ Caution: External sender


Hi Helen and all,

I moved all the results at the following link:
https://cgr.liv.ac.uk/pbio/LIMS27752IsoSeq_08ebf325e8366c31/

The folder 'RAW' contains the raw data obtained form the SMRTlink application.

The folder REPORTS contain the reports for each cell obtained form the SMRTlink application.

The folder "ISOFORMS" contains the results for the IsoSeq pipleine run via the SMRTlink app.

The 'IsoSeq' folder includes the results for the pipeline I run manually, you will be find a folder for each sample, each containing 3 files:

'Sample1.polished.hq.fasta.gz' is the result of the IsoSeq3 pipeline run after selecting for cells with quality above or equal 90. 

'Sample1.collapsed.fasta' contains the Isoforms obtained by collapsing the above using the IsoSeq3 'collapse' function. This function performs the collapsing of the isoforms on the bases of their mapping location (which I obtained by aligning them onto the reference in my previous email.) 

'Sample1_collapsed_cdhit.0.97.fasta.gzip' is the result of further collapsing the isoform purely on similarity by using cd-hit-est, with a similarity thresholds of 97% or above (however included a minimum length for the match to be valid to avoid spurious collapsing).

In any case where possible I also included the sorted and aligned files, for your conveniences.


Please let me know for any query you may have.

Best wishes,

Luca

```

Madeleine suggests: 
```
If you are getting more than double the expected transcripts, then I would guess that there are redundant transcripts in there. I think isoseq3 does generate some of the highest isoform content out of different long read assemblers - and sometimes generates more novel than reference match isoforms.

I would use something like BUSCO to assess the completeness of your assembled transcripts. If you have read data - it would also be worth mapping these and looking at the coverage per transcript to see whether all 100k transcripts actually get read alignments. 

And I think I would also try to some additional optimisation past the isoseq3 "polish" step to collapse and remove redundant transcripts/isoforms. Things have already moved on quite a bit from when I've done assemblies, but I've had a look and it seems like TAMA (https://github.com/GenomeRIK/tama) is best if you have a reference genome (not sure..?) and if not then you can use package called cogent (https://github.com/Magdoll/Cogent/wiki/Tutorial%3A-Using-Cogent-to-collapse-redundant-transcripts-in-absence-of-genome) which is designed to work with PacBio data and looks like it performs well.

Had a bit of a read through different studies using isoseq3 assembly - and they show that performing an additional transcript collapse after the isoseq3 pipeline - with something like TAMA or cogent improves assembly completeness - assessed using BUSCO.

It is also probably worth using NCBI blast to double check for contamination before running the collapse step. Just using BLASTn against the NCBI nucleotide database - and removing any transcripts that don't have significant sequence similarity to Diptera.

```

## Samples

```
#Sample1: SR
For SR (there is a pile of SR homozygotes, and I assume that there are SR/Y males)
1. 3 adult SR hom females
2. 3 adult SR/Y males
3. 6 unknown sex late stage larvae that should contain SR/Y males***


#Sample2: ST
For ST
1. 3 adult males
2. 3 adult females
3. 6 late stage larvae (probably should avoid pupae)


** adults should not be old worn out moron flies - young and frisky
*** We produce SR/Y larvae from the cross SR/SR female x wildtype male - half are SR/Y and half are SR/X - I am not sure whether this cross is in operation right now. Can you find out. If this cross has not been enacted ….
```

Sample1: 
```
#Nr of transcripts from UoLiv: 85,645
#After tama: 66167

/SAN/ugi/StalkieGenomics/isoSeq/LIMS27752IsoSeq_08ebf325e8366c31/IsoSeq/Sample1

/share/apps/genomics/samtools-1.14/bin/samtools flagstat Sample1.collapsed.cdhit.0.97.srt.bam
97690 + 0 in total (QC-passed reads + QC-failed reads)
70978 + 0 primary
24581 + 0 secondary
2131 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
97681 + 0 mapped (99.99% : N/A)
70969 + 0 primary mapped (99.99% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

```

Sample2
```
#Nr of transcripts from UoLiv: 113,461
#After tama: 88239

/SAN/ugi/StalkieGenomics/isoSeq/LIMS27752IsoSeq_08ebf325e8366c31/IsoSeq/Sample2

/share/apps/genomics/samtools-1.14/bin/samtools flagstat Sample2.collapsed.cdhit.0.97.srt.bam
129884 + 0 in total (QC-passed reads + QC-failed reads)
94961 + 0 primary
32376 + 0 secondary
2547 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
129740 + 0 mapped (99.89% : N/A)
94817 + 0 primary mapped (99.85% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```



### 1. Assess the completeness with BUSCO


### 2a. [TAMA](https://github.com/GenomeRIK/tama)

Find unique isoforms with a genome. I'll use our SR genome for Sample2

```
export PATH=/share/apps/python-3.10.0-shared/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/python-3.10.0-shared/lib:$LD_LIBRARY_PATH

#make sure biopython and pysam are installed

python -c "import biopython"
python -c "import pysam"

#if not available, import
pip install biopython
pip install pysam
```

Edit of tama_collapse.py
```
#There's been a change in the naming system for the StringIO module. Tama assumes python2, but if python3 is being used we need to add the third line to the script: 

  from StringIO import StringIO ## for Python 2
except ImportError:
  from io import StringIO ## for Python 3
```

Convert bam to sam  
```
#tama by default takes a sam input file. bam can be specified (-b), but this didn't work for me. 
#Convert bam to sam

$samtools view -h file.bam > file.sam


```

submit the [tama.sh](https://github.com/alexjvr1/Stalkies/blob/main/tama.sh) script after modifying the input. 

I'm using the Wilkinson genome initially as reference. 

script runs in 6-7 minutes. 




### 3. Assess cleaned datasets with BUSCO

Cogent dataset

Tama dataset
