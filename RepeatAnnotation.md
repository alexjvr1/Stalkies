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
NINJA=/SAN/ugi/StalkieGenomics/software/NINJA-0.95-cluster_only/NINJA/Ninja_new

#RepeatMasker
#This comes with a library of repeat elements, but a much better version is available online. 
#This took 3.5 days to download ~350Gb 
#RepeatMasker needs perl to run

wget -r -nH -np --reject="index.html*" --cut-dirs=1 https://www.dfam.org/releases/Dfam_3.6/
du -sch /SAN/ugi/StalkieGenomics/software/RepeatMasker/Dfam_3.6

export PATH=/share/apps/perl-5.30.0/bin:$PATH

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


NINJA
```
export PATH=/share/apps/gcc-9.2.0/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/gcc-9.2.0/lib64:$LD_LIBRARY_PATH

/SAN/ugi/StalkieGenomics/software/NINJA-0.95-cluster_only/NINJA/Ninja_new --help
```

