# ST genome

PacBio HiFi reads x 2 SMRT cells


Software: Using [HiFiasm](https://github.com/chhylp123/hifiasm#hifionly) to assemble the genome. 

[HiFiasm tutorial](https://hifiasm.readthedocs.io/en/latest/pa-assembly.html)

Using the [STgenome4.sh]() script specifying 4 threads, 20 hours, and 8 Gb RAM. The final time and computing resources needed was: 
```
[M::main] Version: 0.16.1-r375
[M::main] CMD: /SAN/ugi/StalkieGenomics/software/hifiasm/hifiasm -o /SAN/ugi/StalkieGenomics/STgenome/STgenome_220510.asm -t 4 --primary /SAN/ugi/StalkieGenomics/STgenome_rawdata/HiFi/m64157e_211024_013127.hifi_reads.fastq.gz /SAN/ugi/StalkieGenomics/STgenome_rawdata/HiFi/m64157e_210730_141553.hifi_reads.fastq.gz
[M::main] Real time: 70485.004 sec; CPU: 111946.371 sec; Peak RSS: 24.832 GB

real	1174m55.122s
user	1799m8.122s
sys	66m40.244s

```
