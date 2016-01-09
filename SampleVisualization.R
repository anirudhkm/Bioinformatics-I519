# Name: Anirudh K M
# R program to create heatmap plots to visualize the correlation between samples

library(WGCNA)
options(stringsAsFactors = FALSE)

read_file <- function(file)
{
  r = read.csv(file, header = T)
  rownames(r) <- r[[1]]
  r <- r[, -1]
  for(i in ncol(r))
  {
    r[[i]] = as.numeric(r[[i]])
  }
  a = list(wt = r, wit = t(r))
  a
}


heat.map <- function(dat, title)
{
  net = blockwiseModules(dat, power=10,TOMType = "unsigned",minModuleSize = 10,
                         reassignThreshold = 0,mergeCutHeight = 0.25,numericLabels = T
                         ,pamRespectsDendro = F,verbose=3, nThreads = 5)
  
  geneTree <- net$dendrograms[[1]]
  modulecolors <- labels2colors(net$colors)
  
  dissTOM <- 1- TOMsimilarityFromExpr(dat, power=10)
  plotTOM <- dissTOM^1
  diag(plotTOM) <- NA
  TOMplot(plotTOM, geneTree, modulecolors, main = title, xlab = "Samples", ylab = "Samples")
  
}

r = read_file("North_carolina.csv")
heat.map(r$wit, "Complementary matrix for North Carolina")


r = read_file("Western_Australia.csv")
heat.map(r$wit, "Complementary matrix for Western Australia")


r = read_file("italy.csv")
heat.map(r$wit, "Complementary matrix for Italy")


r = read_file("data.csv")
heat.map(r$wit, "Complementary matrix for all the samples")
heat.map(r$wt, "Complementary matrix for all the genes")