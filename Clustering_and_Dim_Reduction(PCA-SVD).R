### Here are the Clustering code
### & Dimension Reduction code (PCA/SVD)
###
### Different R functions: http://gallery.r-enthusiasts.com/RGraphGallery.php

# Get sample observations
set.seed(1234)
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2) 
par(mar = rep(0.2, 4))
  plot(x, y, col = "blue", pch = 19, cex = 2)
    text(x + 0.05, y + 0.05, labels = as.character(1:12))


### 1. Hierarchial Clustering
DF <- data.frame(x = x, y = y)
dist_matrix <- dist(DF) # evaluate pairwise distances between x & y (as triangle matrix) 
                        # method = "euclidean" (default), "maximum", "manhattan", "canberra", "binary" or "minkowski"
hClustering <- hclust(dist_matrix) # get clusters of observations (rows)
plot(hClustering) # produce the dendrogram of clustering tree
plot(as.dendrogram(hClustering)) # draw the dendrogram without any labels (only Y-axis - indication of distance)

# R.Peng modifiction of plclust for plotting hclust objects *in colour*! 
colorplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)),
                      hang = 0.1, ...) {
  # Copyright Eva KF Chan 2009 Arguments: 
  # hclust - hclust object, lab - a character vector of labels of the leaves of the tree,
  # lab.col - colour for the labels (NA = default device foreground colour)
  # hang - as in hclust & plclust.
  # Side effect: A display of hierarchical cluster with coloured leaf labels.
  y <- rep(hclust$height, 2)
  x <- as.numeric(hclust$merge)
  y <- y[which(x < 0)]
  x <- x[which(x < 0)]
  x <- abs(x)
  y <- y[order(x)]
  x <- x[order(x)]
  plot(hclust, labels = FALSE, hang = hang, ...)
  text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order],
       col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}

colorplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))

# Heatmap 
set.seed(1234)
heatmap(as.matrix(DF)[sample(1:12), ]) # organize! & draw heatmap using hieararchial clustering by rows & columns values close together


### 2. K-means Clustering (based on random! (by default) first init of centroids -- get different results all the time)
DF <- data.frame(x, y)
set.seed(1234)
kmeansObj <- kmeans(DF, centers = 3) # set up to 3 random centroids
kmeansObj <- kmeans(DF, centers = 3, nstart = 100) # set up to 3 random centroids trying 100 random starting points' values (be default = 1)

names(kmeansObj)
kmeansObj$cluster # vector of clust IDs for each observation of DF (row (x, y))

par(mar = rep(0.2, 4))
  plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
    points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

# Heatmap
set.seed(1234)
kmeansObj <- kmeans(DF, centers = 3) # set up to 3 random centroids
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
  image(t(as.matrix(DF))[, nrow(DF):1], yaxt = "n") # draw the heatmap for the original observations' order
  image(t(as.matrix(DF))[, order(kmeansObj$cluster)], yaxt = "n") # draw the heatmap of reordered by clusters observations 



### Dimension Reduction (patterns matching):
### Principal Component Analysis (анализ главных компонентов)
### & Singular Value Decomposition (сингулярное разложение)

# 1
set.seed(12345)
DM <- matrix(rnorm(400), nrow = 40) # get 40 x 10 matrix
par(mar = rep(0.2, 4))
  image(t(DM)[, nrow(DM):1]) # get real! data heatmap

par(mar = rep(0.2, 4)) 
  heatmap(DM) # draw organized (clustered)! data heatmap


# 2 Adding the random pattern to the data: 0000033333
set.seed(678910)
for (i in 1:40) {
  coinFlip <- rbinom(1, size = 1, prob = 0.5) # flip a coin
  if (coinFlip) {
    DM[i, ] <- DM[i, ] + rep(c(0, 3), each = 5)  # if coin is heads add a common pattern to that row
  }
}
par(mar = rep(0.2, 4)) 
  image(t(DM)[, nrow(DM):1]) # get new real! data heatmap

par(mar = rep(0.2, 4)) 
  heatmap(DM) # get new organized (clustered)! data heatmap


# 3 Analyse patterns in rows and columns
hc <- hclust(dist(DM)) # clust 40 observations (rows) of DM
DMordered <- DM[hc$order, ] # reorder DM rows
par(mfrow = c(1, 4), mar = c(4, 4, 1, 1))
  image(t(DM)[, nrow(DM):1], xlab = "Not ordered rows\n[relative coord]") # draw not ordered heatmap
  image(t(DMordered)[, nrow(DMordered):1], xlab = "Clust-ordered rows\n[relative coord]") # draw clust-ordered heatmap
  plot(rowMeans(DMordered), 40:1, xlab = "Row Mean value", ylab = "Row [abs coord]", pch = 19) # draw mean values by rows
  plot(colMeans(DMordered), xlab = "Column\n[abs coord]", ylab = "Column Mean value", pch = 19) # draw mean values by columns



### Singular Value Decomposition (сингулярное разложение - для матрицы, где столбцы - переменные, строки - наблюдения)
# We can think of each singular value as representing the percent of the total variation(???)
# in the data set that's explained by that particular component. 
#
# SVD: M = U * D * V^T (where U - orthogonal (left singular vectors), V - orthogonal (right singular vectors),  D - diagonal matrix (singular values))
#      RxC = RxC * RxR * RxR (sizes)
# PCA: matrix that equals to the right singular values (V) if M was scaled (subtract the mean, divide by the standard deviation for each value - by variable/coulumn) 
# U: explain column patterns' components - columns are 'Left singular vectors'
# V: explain row patterns' - columns are 'Principal components' ('Right singular vectors')
# D: explain rows & cols single pattern's (principal components) variance explanation - diagonal elements are 'Singular values'

DMscaled <- scale(DMordered) # normalize - subtract the mean & divide by the standard deviation for each value (by column)
DMsvd <- svd(DMscaled) # get SVD objects list (u, v, d components) - d is just a vector! here (not diag matrix)

DMoriginal <- DMsvd$u %*% diag(DMsvd$d) %*% t(DMsvd$v)


# SVD: u & v - data pattern explained from '1st left singular vector' & '1st right singular vector'
par(mfrow = c(1, 5))
  image(t(DMordered)[, nrow(DMordered):1], xlab = "Clust-ordered rows\n[relative coord]", main = "Ordered data") # draw clust-ordered heatmap
  image(t(DMsvd$u)[, nrow(DMsvd$u):1], main = "U")
  image(t(DMsvd$v)[, nrow(DMsvd$v):1], main = "V")
  plot(DMsvd$u[, 1], 40:1, xlab = "Obs. normalized values (for 1st U col.)", ylab = "Singular vector values' indexes (ROWS)", main = "U[ ,1]\n1st left singular vector", pch = 19)
  # get a kind of row data pattern! (as mirrored version) - roughly explains 0000033333 pattern adding (as a deviation from the mean values)
  plot(DMsvd$v[, 1], ylab = "Obs. normalized values (for 1st V col)", xlab = "Singular vector values' indexes\n(COLS)", main = "V[ ,1]\n1st right singular vector", pch = 19)


# Relationship between SVD & PCA = V
DMsvd <- svd(scale(DMordered))
DMpca <- prcomp(DMordered, scale = TRUE) # equals! to DMsvd$v
  plot(DMpca$rotation[, 1], DMsvd$v[, 1], pch = 19, 
       xlab = "Principal Component 1", ylab = "Right Singular Vector 1") # demonstrate 1st component for example
    abline(c(0, 1)) # demonstrate that PCA values equal to V values of SVD (points' values coincide)


# SVD: Variance explained (объясненная дисперсия) - 1
par(mfrow = c(1, 2))
  plot(DMsvd$d, xlab = "Column", ylab = "Singular value", pch = 19) # draw raw singular values
  # If we divide by the total sum of all the singular values, then we can interpret it
  # as the proportion of the variance explained, and for example we can see that the first singular value 
  # (as kind of the shift in the mean between the rows and the columns) 
  # captures about 40% of the variation in all data. 
  plot(DMsvd$d^2/sum(DMsvd$d^2), xlab = "Column", ylab = "Proporton of variance explained", pch = 19)


# SVD: Variance explained (объясненная дисперсия) - 2
# Using 0000011111 pattern rows only in the data
DMconstant <- DMordered * 0
for(i in 1:dim(DMordered)[1]) {
  DMconstant[i, ] <- rep(c(0, 1), each = 5) # get sample data pattern
}
DMconstantSvd <- svd(DMconstant)
par(mfrow = c(1, 4))
  image(t(DMconstant)[, nrow(DMconstant):1])
  plot(DMconstantSvd$d, xlab = "Column", ylab = "Singular value", pch = 19)
  # Even though we have lots of so-called observations, there's really only kind of a small fraction
  # of information that's actually useful in this matrix - and so that's captured by the SVD.
  # By the fact we can explain 100% of the variation with a single! component (see 1st component value)
  plot(DMconstantSvd$d^2/sum(DMconstantSvd$d^2), xlab="Column", ylab="Proportion of variance explained", pch=19)
  # get a real row data pattern (100% 1st component in this example) - explains 0000055555 pattern using (as a deviation from the mean values)
  plot(DMconstantSvd$v[, 1], pch = 19, xlab = "Column", ylab = "First right singular vector")


# Adding 2 random patterns to the data: 0000055555 & 0505050505
set.seed(678910)
for (i in 1:40) {
  coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
  coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
  if (coinFlip1) {  # if coin is heads add a common pattern to that row
    DM[i, ] <- DM[i, ] + rep(c(0, 5), each = 5) # get 0000055555 vector
  }
  if (coinFlip2) {
    DM[i, ] <- DM[i, ] + rep(c(0, 5), 5) # get 0505050505 vector
  }
}
hc <- hclust(dist(DM))
DMordered <- DM[hc$order, ]

par(mfrow = c(1, 2))
  image(t(DM)[, nrow(DM):1], main = "Original data")
  image(t(DMordered)[, nrow(DMordered):1], main = "Ordered data")

DMsvd2 <- svd(scale(DMordered))
par(mfrow = c(1, 4))
  plot(rep(c(0, 1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
  plot(rep(c(0, 1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")
  # get a kind of row data patterns! - roughly explains 0000055555 & 0505050505 patterns adding (as a deviation from the mean values)
  plot(DMsvd2$v[, 1], pch = 19, xlab = "Column", ylab = "First right singular vector")
  plot(DMsvd2$v[, 2], pch = 19, xlab = "Column", ylab = "Second right singular vector")

par(mfrow = c(1, 2))
  # ~50% variation's explanation of rows (and cols) pattern by 1st component, ~20% variation's explanation of rows (and cols) pattern by 2nd component
  plot(DMsvd2$d, xlab = "Column", ylab = "Singular value", pch = 19)
  plot(DMsvd2$d^2/sum(DMsvd2$d^2), xlab = "Column", ylab = "Percent of variance explained", pch = 19)


# Image data reduction & aproximation using SVD
load("data/face.rda") # load saved workspace
image(t(faceData)[, nrow(faceData):1]) # draw picture saved as numeric matrix

IMGsvd <- svd(scale(faceData))
  # get principle components' variance explanation
  plot(IMGsvd$d^2/sum(IMGsvd$d^2), pch = 19, xlab = "Singular vector", ylab = "Variance explained") 

approx1comp <- IMGsvd$u[, 1] %*% ( t(IMGsvd$v[, 1]) * IMGsvd$d[1] ) # create the IMG approximation - here svd1$d[1] is a constant
approx5comp <- IMGsvd$u[, 1:5] %*% diag(IMGsvd$d[1:5]) %*% t(IMGsvd$v[, 1:5]) # here we make the diagonal matrix out of d
approx10comp <- IMGsvd$u[, 1:10] %*% diag(IMGsvd$d[1:10]) %*% t(IMGsvd$v[, 1:10])

par(mfrow = c(1, 4))
  image(t(approx1)[, nrow(approx1):1], main = "1 component")
  image(t(approx5)[, nrow(approx5):1], main = "5 components")
  image(t(approx10)[, nrow(approx10):1], main = "10 components")
  image(t(faceData)[, nrow(faceData):1], main = "Original img data")



