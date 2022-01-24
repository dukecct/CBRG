# https://bioconductor.org/packages/release/bioc/vignettes/DEqMS/inst/doc/DEqMS-package-vignette.html#deqms-analysis-using-maxquant-outputs-label-free-data
# Section 2.2

library(DEqMS)
# DEqMS analysis using MaxQuant outputs (label-free data)
url2 <- "https://ftp.ebi.ac.uk/pride-archive/2014/09/PXD000279/proteomebenchmark.zip" # note the change
download.file(url2, destfile = "./PXD000279.zip",method = "auto")
unzip("PXD000279.zip")

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

library(matrixStats)
# we use minimum peptide count among six samples
# count unique+razor peptides used for quantification
pep.count.table = data.frame(count = rowMins(as.matrix(df.prot[,19:24])),
                             row.names = df.prot$Majority.protein.IDs)
# Minimum peptide count of some proteins can be 0
# add pseudocount 1 to all proteins
pep.count.table$count = pep.count.table$count+1

# DEqMS analysis on LFQ data
protein.matrix = log2(as.matrix(df.LFQ.filter))

class = as.factor(c("H","H","H","L","L","L"))
design = model.matrix(~0+class) # fitting without intercept

fit1 = lmFit(protein.matrix,design = design)
cont <- makeContrasts(classH-classL, levels = design)
fit2 = contrasts.fit(fit1, contrasts = cont)
fit3 <- eBayes(fit2)

fit3$count = pep.count.table[rownames(fit3$coefficients), "count"]

#check the values in the vector fit3$count
#if min(fit3$count) return NA or 0, you should troubleshoot the error first
min(fit3$count)

fit4 = spectraCounteBayes(fit3) # this doesn't look like it does anything!!!

# visualize the fit curve
VarianceBoxplot(fit4, n=20, main = "Label-free dataset PXD000279",
                xlab="peptide count + 1")

# extract output from DEqMS
DEqMS.results = outputResult(fit4, coef_col = 1) # compare with TopTable(fit3) - you get the same output!!
fit3_results <- top

# Add Gene names to the data frame
rownames(df.prot) = df.prot$Majority.protein.IDs
DEqMS.results$Gene.name = df.prot[DEqMS.results$gene,]$Gene.names
head(DEqMS.results)

# 2.3 DEqMS analysis using a PSM table (isobaric labelled data)
library(ExperimentHub)
eh = ExperimentHub()
query(eh, "DEqMS")
dat.psm = eh[["EH1663"]]

dat.psm.log = dat.psm
dat.psm.log[,3:12] =  log2(dat.psm[,3:12])
head(dat.psm.log)

# summarization and normalization
dat.gene.nm = medianSweeping(dat.psm.log, group_col = 2)
boxplot(dat.gene.nm, las=2,ylab="log2 ratio",main="TMT10plex dataset PXD004163")

# perform DEqMS analysis as usual








