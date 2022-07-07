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

### 1. Assess the completeness with BUSCO

### 2. 


### 3. Assess cleaned dataset with BUSCO
