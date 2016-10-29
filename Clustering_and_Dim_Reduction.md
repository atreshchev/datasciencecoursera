### Clustering
## 1. Hierarchial Clustering
# An agglomerative approach ('bottom-up')
  - Find closest two things
  - Put them together
  - Find next closest
· Requires
  - A defined distance metric
  - A merging approach
· Produces
  - A tree showing how close things are to each other

## 2. K-means Clustering
# A partioning approach
  - Fix a number of clusters
    * Pick by eye/intuition
    * Pick by cross validation/information theory, etc.
    * Determining the number of clusters
  - Get "centroids" of each cluster
  - Assign things to closest centroid - Recalculate centroids
· Requires
  - A defined distance metric
  - A number of clusters
  - An initial guess as to cluster centroids
· Produces
  - Final estimate of cluster centroids
  - An assignment of each point to clusters

# Base: Distance (or similarity) between points 
  - Continuous - euclidean distance
      = sqrt((x2 - x1)^2 + (y2 - y1)^2 + ...)
  - Binary - manhattan distance
      = abs(x2 - x1) + abs(y2 - y1) + ...
  - Continuous - correlation similarity
  
# Base: Distance between clusters
  - Complete linkage
      = the greatest (max) distance between the pairs! of points in those two clusters
  - Average linkage
      = distance between "average" points of clusters (think of it as the cluster's center of gravity)
        doing it by computing the mean (average) x and y coordinates of the points in clusters

### Dimension reduction
· Alternatives to SDV/PCA approach
  - Factor analysis
      https://en.wikipedia.org/wiki/Factor_analysis
  - Independent components analysis
      https://en.wikipedia.org/wiki/Independent_component_analysis
  - Latent semantic analysis
      https://en.wikipedia.org/wiki/Latent_semantic_analysis

# The Elements of Statistical Learning: Data Mining, Inference, and Prediction (T. Hastie, R. Tibshirani, J. Friedman)
  http://www.stat.cmu.edu/%7Ecshalizi/ADAfaEPoV/ADAfaEPoV.pdf

# Elements of statistical learning
  http://statweb.stanford.edu/~tibs/ElemStatLearn/



