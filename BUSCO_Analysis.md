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


