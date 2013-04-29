corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  # 1- call complete with directory to get DF with complete count
  completedata<-complete(directory)
  
  # 2- filter DF where df$nobs >= threshold
  filtereddata<-subset(completedata,completedata$nobs>=threshold)
  
  corVals <- numeric(0);

  # 3- Iterate over filtered DF$id calling getmonitor for each id
  for(id in filtereddata$id) {
    newdata <- na.omit(getmonitor(id,directory))
    # 4- Keep adding cor(getmonitor()) value into vector corVals
    corVal <- cor(newdata$sulfate,newdata$nitrate)
#    print(paste("ID: ",id,"COR: ",corVal))
    corVals <- append(corVals, corVal)
  }

  # 5- Return vector of cor values
  corVals
}