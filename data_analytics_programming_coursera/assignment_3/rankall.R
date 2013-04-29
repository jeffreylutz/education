rankall <- function(outcome, num = "best") {
	source("rankhospital.R")
	validnums <- c("best", "worst")
    validoutcomes <- c("heart attack","heart failure","pneumonia")

	## Read outcome data
    hospitals <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	validstates <- sort(unique(hospitals[,7],na.rm = TRUE))


	## Check that state and outcome are valid
	if(!outcome %in% validoutcomes) {
		stop("invalid outcome")
	}

	## For each state, find the hospital of the given rank
	resultDF <- data.frame(hospital = character(), state = character())
	for(i in 1:length(validstates)) {
		state <- validstates[i]
		hospital_name <- rankhospital(state, outcome, num)
		newrow <- data.frame(hospital = hospital_name, state = state)
		resultDF <- rbind(resultDF, newrow)
#		print(paste("|",outcome,"|",num,"|",state,"|",hospital_name,"|"))
		colnames(resultDF) <- c("hospital", "state")			
	}

	## Return a data frame with the hospital names and the
	## (abbreviated) state name
	resultDF
}