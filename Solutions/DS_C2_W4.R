## Assignment DS_C2_W4:
## US Hospitals' measures

## 1. Plot the 30-day mortality rates for heart attack
outcome <- read.csv("data/ProgAssignment3/outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
nrow(outcome)
ncol(outcome)
names(outcome)

class(outcome[, 11]) # numbers as characters by first
outcome[, 11] <- as.numeric(outcome[, 11]) # convert characters to numeric (incl. NA values)
hist(outcome[, 11]) # simple histogram of the 30-day death rates from heart attack


## 2. Finding the best hospital in a state (with lowest 30-day mortality in the state)
best <- function(state, outcome) {
  # Read outcome data
  data <- read.csv("data/ProgAssignment3/outcome-of-care-measures.csv", colClasses = "character")
  
  # Check that state and outcome are valid
  filtered <- data[data$State == state, ]
  if(nrow(filtered) == 0) {
    stop("invalid state")
  }
  else if(outcome == "heart attack") {
    orderedcol = 11
  }
  else if(outcome == "heart failure") {
    orderedcol = 17
  }
  else if(outcome == "pneumonia") {
    orderedcol = 23
  }
  else {
    stop("invalid outcome")
  }

  filtered[, orderedcol] <- as.numeric(filtered[, orderedcol]) # convert values to num
  filtered <- filtered[!is.na(filtered[, orderedcol]), ] # drop NA
  filtered <- filtered[, c(hnamecol = 2, orderedcol)] # get 2 columns only: hospital names & orderedcol
  
  # Search hospital name in that state with lowest 30-day death rate
  hnamecol = 1 # new hospital name column in cutted data frame
  orderedcol = 2 # new ordered column in cutted data frame
  
  #sorted <- filtered[order(filtered[, orderedcol]), ] # order by 2nd column
  #somebestval <- sorted[1, orderedcol] # some of the best hospital measured value
  #sorted <- sorted[order(sorted[sorted[, orderedcol] == somebestval, hnamecol]), ]  # get all best hospitals by alphabetic order of names
  sorted <- filtered[do.call("order", filtered[c(orderedcol, hnamecol)]), ] # 1st order by orderedcol & 2nd order by name
  
  sorted[1, hnamecol] # get the name of best of the best hospital
}

# Test
best("CA", "heart attack")
best("CA", "heart failure")
best("CA", "pneumonia")


## 3. Ranking hospitals by outcome in a state (search the hospital by specified rank)
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("data/ProgAssignment3/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  filtered <- data[data$State == state, ]
  if(nrow(filtered) == 0) {
    stop("invalid state")
  }
  else if(outcome == "heart attack") {
    orderedcol = 11
  }
  else if(outcome == "heart failure") {
    orderedcol = 17
  }
  else if(outcome == "pneumonia") {
    orderedcol = 23
  }
  else {
    stop("invalid outcome")
  }
  
  filtered[, orderedcol] <- as.numeric(filtered[, orderedcol]) # convert values to num
  filtered <- filtered[!is.na(filtered[, orderedcol]), ] # drop NA
  filtered <- filtered[, c(hnamecol = 2, orderedcol)] # get 2 columns only: hospital names & orderedcol
  
  ## Search hospital name in that state with the given rank 30-day death rate
  hnamecol = 1 # new hospital name column in cutted data frame
  orderedcol = 2 # new ordered column in cutted data frame
  sorted <- filtered[do.call("order", filtered[c(orderedcol, hnamecol)]), ] # 1st order by orderedcol & 2nd order by name
  
  if(class(num) == "character") {
    if(num == "best") {
      num <- 1
    }
    else if(num == "worst") {
      num <- nrow(sorted)
    }
    else {
      stop("invalid character rank")
    }
  }
  sorted[num, hnamecol]
}

# Test
rankhospital("CA", "heart attack", 1)
rankhospital("CA", "heart attack", "best")
rankhospital("CA", "heart attack", "worst")
rankhospital("CA", "heart attack", 5000)


## 4. Ranking hospitals in all states
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("data/ProgAssignment3/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that outcome are valid
  if(outcome == "heart attack") {
    orderedcol = 11
  }
  else if(outcome == "heart failure") {
    orderedcol = 17
  }
  else if(outcome == "pneumonia") {
    orderedcol = 23
  }
  else {
    stop("invalid outcome")
  }
  
  data[, orderedcol] <- as.numeric(data[, orderedcol]) # convert values to num
  filtered <- data[!is.na(data[, orderedcol]), ] # drop NA
  filtered <- filtered[, c(hnamecol = 2, statecol = 7, orderedcol)] # get 3 columns only: hospital name & state & orderedcol
  
  ## For each state, find the hospital of the given rank
  hnamecol = 1 # new hospital name column in cutted data frame
  statecol = 2
  orderedcol = 3
  
  states <- sort(unique(data$State))
  # searched <- mapply(rankhospital, states, outcome, num) # multiple task for different states with fixed outcome & num

  if(class(num) == "character") {
    if(num == "best") {
      num <- 1
    }
    else if(num == "worst") {
      worst <- TRUE
    }
    else {
      stop("invalid character rank")
    }
  }
  else {
    worst <- FALSE
  }
  
  searched <- data.frame()
  for(i in 1:length(states)) {
    statefiltered <- filtered[filtered[, statecol] == states[i], ]
    sorted <- statefiltered[do.call("order", statefiltered[c(orderedcol, hnamecol)]), ] # 1st order by orderedcol & 2nd order by name
    rownames(sorted) <- NULL
    if(worst == TRUE) {
      num <- nrow(sorted)
    }
    searched <- rbind(searched, data.frame(hospital = sorted[num, hnamecol], state = states[i]))
  }
  
  # Return a data frame with the hospital names and the (abbreviated) state name
  searched
}

# Test
r <- rankall("heart attack", 4)
r
as.character(subset(r, state == "HI")$hospital)

