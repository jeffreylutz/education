rankhospital <- function(state, outcome, num = "best") {
	validnums <- c("best", "worst")
    validoutcomes <- c("heart attack","heart failure","pneumonia")
    ## Read hospital data

	## Read outcome data
	outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

	## Check that state and outcome are valid
    hospitals <- read.csv("hospital-data.csv", colClasses = "character")
	validstates <- unique(hospitals[,7],na.rm = TRUE)

	if(!state %in% validstates) {
		stop("invalid state")
	}

	if(!outcome %in% validoutcomes) {
		stop("invalid outcome")
	}

	if(!num %in% validnums && !as.numeric(num) > 0) {
		stop("invalid num")
	}

	## Return hospital name in that state with lowest 30-day death
	## rate
	if(outcome == "heart attack") {
		col <- 11
	}
	if(outcome == "heart failure") {
		col <- 17
	}
	if(outcome == "pneumonia") {
		col <- 23
	}
	outcomes[,col] <- as.numeric(outcomes[,col])
	outcomes_state <- subset(outcomes,State == state)
	outcomes_sorted <- outcomes_state[ order(outcomes_state[,col], outcomes_state[,3]) , ]
	outcomes_sorted <- outcomes_sorted[complete.cases(outcomes_sorted[,col]),]
	if(num == "best") {
		outcomes_sorted[1, ]$Hospital.Name
	} else if(num == "worst") {
		outcomes_sorted[nrow(outcomes_sorted), ]$Hospital.Name
	} else if(as.numeric(num) <= nrow(outcomes_sorted)){
		outcomes_sorted[as.numeric(num), ]$Hospital.Name
	} else {
		NA
	}
}
