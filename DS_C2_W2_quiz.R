## DS_C2_W2_quiz
## Functions 

# 1: pollutantmean.R
# Write a function named 'pollutantmean' that calculates 
# the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
# The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' 
# particulate matter data from the directory specified in the 'directory' 
# argument and returns the mean of the pollutant across all of the monitors, 
# ignoring any missing values coded as NA.
pollutantmean <- function(directory, polutant, ID = 1:332) {
  means <- vector ("numeric", length(ID))
  pol.DF <- vector ("numeric", 0)
  for(i in ID) {
    file.DF <- read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep = "")) # adding zeros up to 3 symbols number
    pol.DF <- c(pol.DF, file.DF[, polutant])
  }
  meanval <- mean(pol.DF, na.rm = TRUE)
  meanval
}

# pollutantmean("./data/specdata", "sulfate", 1:10) # 2nd arg may be "nitrate"


# 2: complete.R
# Write a function that reads a directory full of files and reports 
# the number of completely observed cases in each data file. 
# The function should return a data frame where the first column 
# is the name of the file and the second column is the number of complete cases. 
complete <- function(directory, ID = 1:332) {
  compl.obs.DF <- data.frame(id = integer(0), nods = integer(0))
  for(i in ID) {
    file.DF <- read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep = "")) # adding zeros up to 3 symbols number
    nods <- nrow(file.DF[!is.na(file.DF$sulfate) & !is.na(file.DF$nitrate),])
    compl.obs.DF <- rbind(compl.obs.DF, list(id = i, nods = nods))
  }
  compl.obs.DF
}

# complete(directory, 40:10)


# 3: corr.R
# Write a function that takes a directory of data files and a threshold 
# for complete cases and calculates the correlation between sulfate and nitrate 
# for monitor locations where the number of completely observed cases (on all variables) 
# is greater than the threshold. The function should return a vector of correlations 
# for the monitors that meet the threshold requirement. If no monitors meet 
# the threshold requirement, then the function should return a numeric vector of length 0. 
corr <- function(directory, treshold = 0) {
  compl.obs.DF <- complete(directory) # ID = 1:332 by default
  filt.compl.obs.DF <- compl.obs.DF[compl.obs.DF$nods > treshold,]
  
  corvect <- vector("numeric", 0) # init length = 0
  if(nrow(filt.compl.obs.DF) > 0) {
    for(i in 1:nrow(filt.compl.obs.DF)) {
      file.DF <- read.csv(paste(directory, "/", sprintf("%03d", filt.compl.obs.DF[i,]$id), ".csv", sep = ""))
      sulfvect <- file.DF[!is.na(file.DF$sulfate) & !is.na(file.DF$nitrate),"sulfate"]
      nitrvect <- file.DF[!is.na(file.DF$sulfate) & !is.na(file.DF$nitrate),"nitrate"]
      corvect <- c(corvect, cor(sulfvect, nitrvect))
    }
  }
  corvect
}

# corr(directory, 1000)

