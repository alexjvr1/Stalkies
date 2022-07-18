# RepeatAnnotation

Characterise the repeat elements across the genome. 

Are there more TEs around the inversions in the X chromosome? This is what is suggested by the Wilkinson paper. 

Example papers: 
https://royalsocietypublishing.org/doi/full/10.1098/rstb.2021.0207


Possible tools: 
[xTea](https://www.nature.com/articles/s41467-021-24041-8)

[PALMER](https://academic.oup.com/nar/article/48/3/1146/5680708?login=false)

[RepeatModeler](https://www.pnas.org/doi/10.1073/pnas.1921046117)

I'm following the methods in [this paper](https://onlinelibrary.wiley.com/doi/full/10.1111/pbi.13493) 


1. TE discovery using [RepeatModeler2](https://github.com/Dfam-consortium/RepeatModeler). This builds a repeat element library based on the genome supplied. 

2. Discover and cluster known TEs in the genome using [RepeatMasker]()

3. Catagorise the unknown TEs using [TEclass]()



Circos figure1 in [this](https://onlinelibrary.wiley.com/doi/epdf/10.1111/1755-0998.13240?saml_referrer) paper is good. 


## Installation & Dependencies

Install RepeatModeler and dependencies as described [here](http://www.repeatmasker.org/RepeatModeler/)



```
#perl
export PATH=/share/apps/perl-5.30.0/bin:$PATH
#RMBLAST
export PATH=/SAN/ugi/StalkieGenomics/software/rmblast-2.11.0/bin:$PATH

RECON=/SAN/ugi/StalkieGenomics/software/RECON-1.08/scripts/recon.pl 
RepeatScout=/SAN/ugi/StalkieGenomics/software/RepeatScout/RepeatScout
TRF=/SAN/ugi/StalkieGenomics/software/trf409.linux64 
LTRRETRIEVER=/SAN/ugi/StalkieGenomics/software/LTR_retriever-2.9.0/LTR_retriever
MAFFT=/share/apps/genomics/mafft-7.453/bin/mafft
CD_HIT=/share/apps/genomics/cd-hit-v4.6.8-2017-0621/cd-hit
ABBLAST=/SAN/ugi/StalkieGenomics/software/ab-blast-20200317-linux-x64/ab-blastn

#NINJA
export PATH=/share/apps/gcc-9.2.0/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/gcc-9.2.0/lib64:$LD_LIBRARY_PATH
NINJA=/SAN/ugi/StalkieGenomics/software/NINJA-0.95-cluster_only/NINJA/Ninja_new --help


#RepeatMasker
#This comes with a library of repeat elements, but a much better version is available online. 
#This took 3.5 days to download ~350Gb 
#Repbase can also be used, but this is behind a paywall of >$1500/annum
#RepeatMasker needs perl to run

wget -r -nH -np --reject="index.html*" --cut-dirs=1 https://www.dfam.org/releases/Dfam_3.6/
du -sch /SAN/ugi/StalkieGenomics/software/RepeatMasker/Dfam_3.6

export PATH=/share/apps/perl-5.30.0/bin:$PATH

#ucscTools
rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ /SAN/ugi/StalkieGenomics/software/ucscTools
```

ERRORS: 
```


#Genometools install error
/SAN/ugi/StalkieGenomics/software/genometools-1.5.9
make threads=yes
[compile canvas_cairo.o]
In file included from src/annotationsketch/canvas_cairo.c:34:0:
/SAN/ugi/StalkieGenomics/software/genometools-1.5.9/src/annotationsketch/graphics_cairo_api.h:21:19: fatal error: cairo.h: No such file or directory
 #include <cairo.h>
                   ^
compilation terminated.
make: *** [obj/src/annotationsketch/canvas_cairo.o] Error 1
```


Once all the dependencies are installed, we can modify the config file before installing RepeatModeler: 
```
#Add paths to all the software before running config
/SAN/ugi/StalkieGenomics/software/RepeatModeler-2.0.3/RepModelConfig.pm 

#To configure we need perl
export perl=/share/apps/perl-5.30.0/bin

#This presented an error about a missing package JSON. 
#Install perl packages locally with cpanm Module::name

cpanm JSON

###OUTPUT message:
(base) [ajansen@pchuckle RepeatModeler-2.0.3]$ cpanm JSON
!
! Can't write to /share/apps/perl-5.30.0/lib/site_perl/5.30.0 and /share/apps/perl-5.30.0/bin: Installing modules to /home/ajansen/perl5
! To turn off this warning, you have to do one of the following:
!   - run me as a root or with --sudo option (to install to /share/apps/perl-5.30.0/lib/site_perl/5.30.0 and /share/apps/perl-5.30.0/bin)
!   - Configure local::lib in your existing shell to set PERL_MM_OPT etc.
!   - Install local::lib by running the following commands
!
!         cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
!
JSON is up to date. (4.07)
#############
#This tells us that the package was installed locally to my home directory. 
#We need to configure our paths to point to the local library. This is the default code, but modify for the server to point to our actual home directory: 
#cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm --local-lib=/home/ajansen/perl5 local::lib && eval $(perl -I /home/ajansen/perl5/lib/perl5/ -Mlocal::lib)

```



## Install without cairo

The cairo issue stops me from installing LTRHarvester. This is used for an extension of the RepeatModeler pipeline which identifies LTRs (long terminal repeats) much more effectively than the core program.

To test out the program in the meantime I've configured it without this extension. 

Run the program (in qrsh to build the database and test the run): 
```
/SAN/ugi/StalkieGenomics/Map_repeats

/SAN/ugi/StalkieGenomics/software/RepeatModeler-2.0.3/BuildDatabase -name StalkieSR /SAN/ugi/StalkieGenomics/SRgenome/pomiankowski-tdalmanni.final.fasta

##The database builds in ~2 minutes
Building database StalkieSR:
  Reading /SAN/ugi/StalkieGenomics/SRgenome/pomiankowski-tdalmanni.final.fasta...
Number of sequences (bp) added to database: 3 ( 400176092 bp )
```

Test the run before creating a script: 
```
## This works, but I need to add -pa (number of parallel jobs). 
../software/RepeatModeler-2.0.3/RepeatModeler -database StalkieSR   

```

Script to submit
```
#!/bin/bash
#$ -S /bin/bash
#$ -N RepeatModeler_SR  ##job name
#$ -l tmem=64G #RAM
#$ -l h_vmem=64G #enforced limit on shell memory usage
#$ -l h_rt=40:00:00 ##wall time.
#$ -j y  #concatenates error and output files (with prefix job1)
#$ -l tscratch=100G
#$ -l avx2=yes
#$ -pe mpi 40
#$ -R y

#Run on working directory
cd $SGE_O_WORKDIR 

#Software
SOFTPATH=/SAN/ugi/StalkieGenomics/RepeatModeler-2.0.3
WD=/SAN/ugi/StalkieGenomics/Map_repeats
THREADS=30

#Script
time $SOFTPATH/RepeatModeler -database $WD/StalkieSR -pa 40

```
