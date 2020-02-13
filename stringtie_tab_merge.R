# stringtie_tab_merge.R
# By Sun Haifeng,haifeng4432@gmail.com,2020-02-12

args <- commandArgs(T)

if (length(args)>1){
        print ("")
        print ("Use input Mode!")
}else{
        print ("Use grep *.tab Mode!")
        args <- list.files(path = ".", pattern = "\\.tab$",recursive = T,include.dirs=T)
}


# 定义一个match文件名的函数：
getfilename <- function(file){
        basename <- basename(file)
        parts <- strsplit(basename,".",fixed = TRUE)
        nparts <- parts[[1]][1]
        return(nparts)
}

# getfilename(args[1]) # 测试函数

# 读取第一个文件：
print ("")
print (paste(args[1],"reading...",sep=" "))
merge <- read.table(args[1],sep="\t",header=T,stringsAsFactors = F,check.names = F)
filename_1 <- getfilename(args[1])
print (paste(args[1],"have",nrow(merge),"rows!",sep=" ")) # 打印行数
colnames(merge)[c(7,8,9)] <- c(paste("Coverage",filename_1,sep = "_"), # 重命名
                               paste("FPKM",filename_1,sep = "_"),
                               paste("TPM",filename_1,sep = "_"))

# for循环读取合并：
for (i in (2:length(args))){
        # print (i)
        # print (args[i])
        print("")
        print (paste(args[i],"reading...",sep=" "))
        data <- read.table(args[i],sep="\t",header=T,stringsAsFactors = F,check.names = F)
        colnames(data)[c(7,8,9)] <- c(paste("Coverage",getfilename(args[i]),sep = "_"),
                                       paste("FPKM",getfilename(args[i]),sep = "_"),
                                       paste("TPM",getfilename(args[i]),sep = "_"))
        print (paste(args[i],"have",nrow(data),"rows!",sep=" "))
        merge <- merge(merge,data,by=c("Gene ID","Gene Name","Reference","Strand","Start","End"),all=TRUE)
}

print("")
print (paste("Merge have",nrow(merge),"rows!",sep=" "))
# head(merge)


# 合并：
Coverage <- merge[,c("Gene ID","Gene Name","Reference","Strand","Start","End",colnames(merge)[grepl("^Coverage", colnames(merge))])]
# head(Coverage)
FPKM <- merge[,c("Gene ID","Gene Name","Reference","Strand","Start","End",colnames(merge)[grepl("^FPKM", colnames(merge))])]
TPM <- merge[,c("Gene ID","Gene Name","Reference","Strand","Start","End",colnames(merge)[grepl("^TPM", colnames(merge))])]

# NA值赋值为0：
Coverage[is.na(Coverage)] <- 0
FPKM[is.na(FPKM)] <- 0
TPM[is.na(TPM)] <- 0

# 输出到本地：
write.table(Coverage,"Merge_Coverage.txt",sep="\t",quote=F,row.names = F)
write.table(FPKM,"Merge_FPKM.txt",sep="\t",quote=F,row.names = F)
write.table(TPM,"Merge_TPM.txt",sep="\t",quote=F,row.names = F)

print("")
print ("Running Over!")
