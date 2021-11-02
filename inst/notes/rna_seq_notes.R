library(SummarizedExperiment)
data(airway, package="airway")
se <- airway
se


library(iSEE)
app <- iSEE(se)
shiny::runApp(app)

# some common functions from SummarizedExperiment
dim(assay(se)) # 64102 x 8
dim(colData(se)) # 8 x 9
rowData(se) # 64102 x 0

rowRanges(se)[[1]][1]
metadata(se)
abstract(se)

# assays
# This object can have mutliple assay datasets
assays(se)$counts
# is equivalent to
assay(se)

# rowData and rowRanges
# rowData is for SummarizedExperiment objects
# rowRanges is for RangedSummarizedExperiment objects. This is used to access GRangesList objects that contain
# exon information

# colData
colData(se)
se[ , se$dex == "trt"] # if you put this in assay(), you will just get count data for the treated cells

# metaData
# ote that metadata() is just a simple list, so it is appropriate
# for any experiment wide metadata the user wishes to save, such as storing model formulas.
metadata(se)$formula <- counts ~ dex + albut

metadata(se)

# Common operations on SummarizedExperiment
# subset the first five transcripts and first three samples
se_subset <- se[1:5, 1:3]
colData(se_subset) # see how the different SummarizedExperiment elements are synced??
# beautiful!
# $ operates on colData() columns, for easy sample extraction
se[, se$cell == "N61311"]

# assay() versus assays() There are two accessor functions for extracting the assay data from a
# SummarizedExperiment object. assays() operates on the entire list of assay data as a whole, while assay()
# operates on only one assay at a time. assay(x, i) is simply a convenience function which is equivalent to
# assays(x)[[i]]

# assay defaults to the first assay if no i is given

# pretty straightforward!

# DESeq2 vignette
# https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

# The DESeq2 model internally corrects for library size, so transformed or
# normalized values such as counts scaled by library size should not be used as input

# The object class used by the DESeq2 package to store the read counts and the intermediate estimated
# quantities during statistical analysis is the DESeqDataSet, which will usually be represented in the
# code here as an object dds.

# A technical detail is that the DESeqDataSet class extends the RangedSummarizedExperiment class of the
# SummarizedExperiment package. The “Ranged” part refers to the fact that the rows of the assay data
# (here, the counts) can be associated with genomic ranges (the exons of genes). This association
# facilitates downstream exploration of results, making use of other Bioconductor packages’ range-based
# functionality (e.g. find the closest ChIP-seq peaks to the differentially expressed genes)

# Note: In order to benefit from the default settings of the package, you should put the variable of
# interest at the end of the formula and make sure the control level is the first level.

library(DESeq2)
# constructing  a dds object from a SummarizedExperiment object
ddsSE <- DESeqDataSet(se, design = ~ cell + dex)
ddsSE

metadata(ddsSE) # notice that we now have a `formula` object!

# pre-filtering
keep <- rowSums(counts(ddsSE)) >= 10
dds <- ddsSE[keep, ]

# Note on factor levels
# By default, R will choose a reference level for factors based on alphabetical order. Then, if you never
# tell the DESeq2 functions which level you want to compare against (e.g. which level represents the control
# group), the comparisons will be based on the alphabetical order of the levels

dds$dex <- factor(dds$dex, levels = c("untr","trt"))

# working with the pasilla dataset
# the code below shows how to create a dds object from count matrix data
# I think you should still begin with a SummarizedExperiment object
library("pasilla")
pasCts <- system.file("extdata",
                      "pasilla_gene_counts.tsv",
                      package="pasilla", mustWork=TRUE)
pasAnno <- system.file("extdata",
                       "pasilla_sample_annotation.csv",
                       package="pasilla", mustWork=TRUE)
cts <- as.matrix(read.csv(pasCts,sep="\t",row.names="gene_id"))
coldata <- read.csv(pasAnno, row.names=1)
coldata <- coldata[,c("condition","type")]
coldata$condition <- factor(coldata$condition)
coldata$type <- factor(coldata$type)

rownames(coldata) <- sub("fb", "", rownames(coldata))
all(rownames(coldata) %in% colnames(cts))

cts <- cts[, rownames(coldata)]
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ condition)
dds

# Differential expression analysis
# The standard differential expression analysis steps are wrapped into a single function, DESeq
dds <- DESeq(dds)
res <- results(dds)
res # so simple!!

# Log fold change shrinkage for visualization and ranking
# Shrinkage of effect size (LFC estimates) is useful for visualization and ranking of genes.
# To shrink the LFC, we pass the dds object to the function lfcShrink. Below we specify to use the apeglm
# method for effect size shrinkage (Zhu, Ibrahim, and Love 2018), which improves on the previous estimator

# WHY DO THIS??

# We provide the dds object and the name or number of the coefficient we want to shrink, where the number
# refers to the order of the coefficient as it appears in resultsNames(dds)

resultsNames(dds)
resLFC <- lfcShrink(dds, coef="condition_untreated_vs_treated", type="apeglm")
resLFC

# p-values and adjusted p-values
resOrdered <- res[order(res$pvalue), ]
summary(res)

# The results function contains a number of arguments to customize the results table which is generated.
# You can read about these arguments by looking up ?results. Note that the results function automatically
# performs independent filtering based on the mean of normalized counts for each gene, optimizing the number
# of genes which will have an adjusted p value below a given FDR cutoff, alpha. Independent filtering is
# further discussed below. By default the argument alpha is set to 0.1. If the adjusted p value cutoff will
# be a value other than 0.1, alpha should be set to that value

res05 <- results(dds, alpha=0.05)
summary(res05)

# Exploring and exporting results
#MA-plot

# In DESeq2, the function plotMA shows the log2 fold changes attributable to a given variable over the
# mean of normalized counts for all the samples in the DESeqDataSet. Points will be colored red if the
# adjusted p value is less than 0.1. Points which fall out of the window are plotted as open triangles
# pointing either up or down.

plotMA(res, ylim=c(-2,2))

# It is more useful visualize the MA-plot for the shrunken log2 fold changes, which remove the noise
# associated with log2 fold changes from low count genes without requiring arbitrary filtering thresholds.
plotMA(resLFC, ylim=c(-2,2))

# WHAT DOES THIS PLOT SHOW US??

# Rich visualization and reporting of results
# Check these out at some point
