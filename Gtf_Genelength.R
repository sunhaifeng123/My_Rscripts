# Gtf_Genelength.R
# By Sun Haifeng,haifeng4432@gmail.com,2020-02-16

# Usage:
# Rscript Gtf_Genelength.R xxx.gtf GRcm38 gene_id/gene_name/both

args <- commandArgs(T)

# 如果需要安装R包的话：
# install.packages("BiocManager")
# BiocManager::install("GenomicFeatures")
# BiocManager::install("rtracklayer")

library(GenomicFeatures)

txdb <- makeTxDbFromGFF(args[1],
                        format="gtf") # 制作Txdb

exons_gene <- exonsBy(txdb, by = "gene") # 提取exon

exons_gene_lens <- lapply(exons_gene,function(x){sum(width(reduce(x)))}) # 得到：去除重复部分的长度

output <- t(as.data.frame(exons_gene_lens)) # 转为df

colnames(output) <- "gene_length"
output_df <- as.data.frame(output)
output_df$gene_id <- row.names(output) # 赋予name

if (args[3]=="gene_id"){
        print ("Your result is gene_id and gene_length!")
        write.table(output,
                    paste(args[2],".gene_id.len",sep=""),
                    sep="\t",
                    quote=F,
                    col.names = F,
                    row.names = T) # 输出为：xxx.gene_id.len
        print ("OK!")
} else if ((args[3]=="gene_name")|(args[3]=="both")){
        library("rtracklayer")
        gtf_df <- as.data.frame(rtracklayer::import(args[1])) # 导入gtf
        geneid_df <- dplyr::select(gtf_df[which(gtf_df$type=="gene"),],
                                   c(gene_id,gene_name)) # 选择注释genename
        rownames(geneid_df) <- geneid_df[,"gene_id"]
        result <- merge(geneid_df,
                        output_df,
                        by="gene_id",
                        all=TRUE) # 注释好
        if (args[3]=="gene_name"){
                print ("Your result is gene_name and gene_length!")
                write.table(result[,c("gene_name","gene_length")],
                            paste(args[2],".gene_name.len",sep=""),
                            sep="\t",
                            quote=F,
                            col.names = F,
                            row.names = F)
                print ("OK!")
        } else if (args[3]=="both"){
                print ("Your result is gene_id and gene_name and gene_length!")
                write.table(result,
                            paste(args[2],".gene_id_name.len",sep=""),
                            sep="\t",
                            quote=F,
                            col.names = T,
                            row.names = F)
                print ("OK!")
        }
}
