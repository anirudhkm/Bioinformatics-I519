
#Change this to the folder where the csv data files are.
setwd("C:/Users/Samuel/Desktop/Bioinformatics/Project/WGCNA/data normalized with edgeR")

rm(list = ls());

library(WGCNA);

#Read gene data from csv that has 1 row/gene, and each column represents a sample.
otauData = read.csv("data_transformed.csv");

#Rename rows based on the "gene" column and this remove this column from expression data.
datExpr0 = as.data.frame(t(otauData[, -c(1)]));
names(datExpr0) = otauData$gene;
rownames(datExpr0) = names(otauData)[-c(1)];

#Read in trait data and remove uncessary columns
traitData = read.csv("numeric_traits.csv");
allTraits = traitData[, -c(1)];

#Reorganize data so that it is in a format similar to expression data (samples held in columns)
allSamples = rownames(datExpr0);
traitRows = match(allSamples, allTraits$new_name);
datTraits = allTraits[traitRows, -1];
rownames(datTraits) = allTraits[traitRows, 1];

collectGarbage();

#---------------------------------------------

#This will show whether the samples that are similar (i.e. close to one another in dendogram, based on gene expression data),
#also have similar traits (in our case, this will be group identifiers).

# # Re-cluster samples
sampleTree2 = hclust(dist(datExpr0), method = "average");
# Convert traits to a color representation: white means low, red means high, grey means missing entry
traitColors = numbers2colors(datTraits, signed = FALSE);

# Plot the sample dendrogram and the colors underneath.
plotDendroAndColors(sampleTree2, traitColors,
                    groupLabels = names(datTraits),
                    main = "Sample dendrogram and trait heatmap");



