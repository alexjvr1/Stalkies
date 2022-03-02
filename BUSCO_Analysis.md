# BUSCO analysis of First Stalkie Genome


[BUSCO](https://busco.ezlab.org/busco_userguide.html) has been installed locally in the shared folder using the setup.py script provided with busco. I also installed biopython locally: 


```
/SAN/ugi/StalkieGenomics/software/busco

pip3 install biopython
```

To run it, we need python3
```
export PATH=/share/apps/python-3.6.4-shared/bin:$PATH
export LD_LIBRARY_PATH=/share/apps/python-3.6.4-shared/lib:$LD_LIBRARY_PATH

busco --version
BUSCO 5.2.2
```

Libraries to use: 
```
#See a list of all the available databases
busco --list-datasets

insecta_odb10
diptera_odb10
```

The script to use is here: [BUSCO.sh](https://github.com/alexjvr1/Stalkies/blob/main/Scripts/BUSCO.sh)


## SR genome: 


The current assembly is called: pomiankowski-tdalmanni.final.fasta


Analysis run here:
```
/SAN/ugi/StalkieGenomics/SRgenome
```

Summary of results: 
```
# BUSCO version is: 5.2.2 
# The lineage dataset is: diptera_odb10 (Creation date: 2020-08-05, number of genomes: 56, number of BUSCOs: 3285)
# Summarized benchmarking in BUSCO notation for file /SAN/ugi/StalkieGenomics/Genome1/pomiankowski-tdalmanni.final.fasta
# BUSCO was run in mode: genome
# Gene predictor used: metaeuk

	***** Results: *****

	C:89.6%[S:88.8%,D:0.8%],F:4.0%,M:6.4%,n:3285	   
	2944	Complete BUSCOs (C)			   
	2917	Complete and single-copy BUSCOs (S)	   
	27	Complete and duplicated BUSCOs (D)	   
	130	Fragmented BUSCOs (F)			   
	211	Missing BUSCOs (M)			   
	3285	Total BUSCO groups searched		   

Dependencies and versions:
	hmmsearch: 3.3
	metaeuk: 9dee7a78db0f2a8d6aafe7dbf18ac06bb6e23bf0
```

This is similar to results from the previous assembly (89%). But still less than the US genome: 96%
