# "Visualization of proteomics data using R and Bioconductor"
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4510819/pdf/pmic0015-1375.pdf
BiocManager::install("RforProteomics")
library(RforProteomics)
vignette(package='RforProteomics')
RProtVis() # contains code for the above manuscript

# Introduction to DEP (for differential expression analysis)
BiocManager::install("DEP")
library(DEP)
# Error: package or namespace load failed for ‘DEP’ in dyn.load(file, DLLpath = DLLpath, ...):
#   unable to load shared object '/Library/Frameworks/R.framework/Versions/4.0/Resources/library/gmm/libs/gmm.so':
#   dlopen(/Library/Frameworks/R.framework/Versions/4.0/Resources/library/gmm/libs/gmm.so, 6): Library not loaded: /usr/local/gfortran/lib/libgomp.1.dylib
# Referenced from: /Library/Frameworks/R.framework/Versions/4.0/Resources/library/gmm/libs/gmm.so
# Reason: image not found

# DEqMS: A Method for Accurate Variance Estimation in Differential Protein Expression Analysis
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7261819/pdf/zjw1047.pdf
BiocManager::install("DEqMS")
library(DEqMS)
# DEqMS analysis using MaxQuant outputs (label-free data)
url2 <- "https://ftp.ebi.ac.uk/pride-archive/2014/09/PXD000279/proteomebenchmark.zip" # note the change
download.file(url2, destfile = "./PXD000279.zip",method = "auto")
unzip("PXD000279.zip")

# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2016/06/PXD004163/Yan_miR_Protein_table.flatprottable.txt doesn't work
# try this -
#  https://ftp.ebi.ac.uk/pride-archive/2016/06/PXD004163/Yan_miR_Protein_table.flatprottable.txt
# works!
# ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2014/09/PXD000279/proteomebenchmark.zip doesn't work
# try this -
# https://ftp.ebi.ac.uk/pride-archive/2014/09/PXD000279/proteomebenchmark.zip
# works!

df.prot = read.table("proteinGroups.txt",header=T,sep="\t",stringsAsFactors = F,
                     comment.char = "",quote ="")
# remove decoy matches and matches to contaminant
df.prot = df.prot[!df.prot$Reverse=="+",]
df.prot = df.prot[!df.prot$Contaminant=="+",]

# Extract columns of LFQ intensites
df.LFQ = df.prot[,89:94]
df.LFQ[df.LFQ==0] <- NA

rownames(df.LFQ) = df.prot$Majority.protein.IDs
df.LFQ$na_count_H = apply(df.LFQ,1,function(x) sum(is.na(x[1:3])))
df.LFQ$na_count_L = apply(df.LFQ,1,function(x) sum(is.na(x[4:6])))
# Filter protein table. DEqMS require minimum two values for each group.
df.LFQ.filter = df.LFQ[df.LFQ$na_count_H<2 & df.LFQ$na_count_L<2,1:6]

# Relevant links -
# https://reader.elsevier.com/reader/sd/pii/S1570963913001866?token=5ECE083CB66D3088B2E954C685C192812ACF4524C2A6FC4A1825A8EFC3E75FABB3CB5CD978726A8C58F332BFEBC76A8A&originRegion=us-east-1&originCreation=20211202130226
# https://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/s12859-019-3059-z.pdf
# https://devonkohler.files.wordpress.com/2021/10/ushupo2021_msstatsptm_poster.png
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8015007/pdf/main.pdf
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7261819/pdf/zjw1047.pdf
# https://www.nature.com/articles/nmeth.3252.pdf

