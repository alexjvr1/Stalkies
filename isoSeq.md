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



### 1. Assess the completeness with BUSCO

### 2. 


### 3. Assess cleaned dataset with BUSCO
