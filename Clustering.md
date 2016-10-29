### 1. Hierarchial Clustering
# An agglomerative approach
  - Find closest two things
  - Put them together
  - Find next closest
· Requires
  - A defined distance metric
  - A merging approach
· Produces
  - A tree showing how close things are to each other


### 2. K-means Clustering
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


# Base: Distance or similarity
  - Continuous - euclidean distance
      = sqrt((x2 - x1)^2 + (y2 - y1)^2 + ...)
  - Binary - manhattan distance
      = abs(x2 - x1) + abs(y2 - y1) + ...
  - Continuous - correlation similarity


