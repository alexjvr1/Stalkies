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
