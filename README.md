# My_Rscripts
My_Rscripts

## Usage:
### stringtie_tab_merge.R
```
git clone https://github.com/sunhaifeng123/My_Rscripts.git
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

