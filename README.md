# R_scripts
R_scripts includes some scripts created by Haifeng Sun to process some daily bio data.

## Usage:
### stringtie_tab_merge.R
```
git clone https://github.com/sunhaifeng123/R_scripts.git
chmod 755 stringtie_tab_merge.R
```


If you supplied all the sample.txb files, run: 
```  
Rscript stringtie_tab_merge.R sample1/sample1.tab sample2/sample2.tab sample3/sample2.tab ...
````
or just:

```
Rscript stringtie_tab_merge.R
```
which will find all the files in the dir matched "\*.tab".

#### Output:
* Merge_Coverage.txt

* Merge_FPKM.txt

* Merge_TPM.txt

### stringtie_tab_merge.R
```
git clone https://github.com/sunhaifeng123/R_scripts.git
chmod 755 Gtf_Genelength.R
```

```
Rscript Gtf_Genelength.R xxx.gtf GRcm38 gene_id/gene_name/both
```

#### Output:
* GRcm38.gene_id.len
* GRcm38.gene_name.len
* GRcm38.gene_id_name.len




