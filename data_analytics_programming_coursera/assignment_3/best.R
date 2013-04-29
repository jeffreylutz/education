best <- function(state, outcome) {
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

	## Return hospital name in that state with lowest 30-day death
	## rate

	if(outcome == "heart attack") {
		outcomes[,11] <- as.numeric(outcomes[,11])
		outcomes_state <- subset(outcomes,State == state)
		min <- min(outcomes_state[,11],na.rm = TRUE)
		outcomes_min <- subset(outcomes_state, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == min,na.rm = TRUE)
	}
	if(outcome == "heart failure") {
		outcomes[,17] <- as.numeric(outcomes[,17])
		outcomes_state <- subset(outcomes,State == state)
		min <- min(outcomes_state[,17],na.rm = TRUE)
		outcomes_min <- subset(outcomes_state, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == min,na.rm = TRUE)
	}
	if(outcome == "pneumonia") {
		outcomes[,23] <- as.numeric(outcomes[,23])
		outcomes_state <- subset(outcomes,State == state)
		min <- min(outcomes_state[,23],na.rm = TRUE)
		outcomes_min <- subset(outcomes_state, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == min,na.rm = TRUE)
	}
#	outcomes_min
	sort(outcomes_min["Hospital.Name"])$Hospital.Name
}