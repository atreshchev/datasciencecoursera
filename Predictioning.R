### Predictioning
### for SPAM/HAM recognition

library(kernlab) # library with e-mail spam samples
data(spam)

## Subsampling dataset (train + test)
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)

trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

# Summaries
names(trainSpam)
head(trainSpam)
table(trainSpam$type)

# Summary
plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)
plot(log10(trainSpam[, 1:4] + 1))

# Clustering
hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)

hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)

## Statistical prediction/modeling
trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55) {
  lmFormula = reformulate(names(trainSpam)[i], response = "numType")
  glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
  cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

names(trainSpam)[which.min(cvError)] # Which predictor has minimum cross-validated error?

## Get a measure of uncertainty
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam) # Use the best model from the group

predictionTest = predict(predictionModel, testSpam) # Get predictions on the test set
predictedSpam = rep("nonspam", dim(testSpam)[1])

predictedSpam[predictionModel$fitted > 0.5] = "spam" # Classify as `spam' for those with prob > 0.5

table(predictedSpam, testSpam$type) # Classification table
## predictedSpam: nonspam  spam
##       nonspam: 1346     458
##          spam: 61       449
##    Error rate: (61 + 458)/(1346 + 458 + 61 + 449)

