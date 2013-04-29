count <- function(cause = NULL) {
	validcauses <- c("asphyxiation", "blunt force", "other", "shooting", "stabbing", "unknown")

	## Check that "cause" is non-NULL; else throw error
	## Check that specific "cause" is allowed; else throw error
	if(is.null(cause) || !(cause %in% validcauses)) {
		stop("invalid cause")
	}

	# Read "homicides.txt" data file
	doc <- readLines("homicides.txt")

	## Extract causes of death
	search_term <- paste("cause:",cause)
	doc_cause <- grep(search_term,doc,ignore.case = TRUE, value=TRUE)

	## Return integer containing count of homicides for that cause
	length(doc_cause)
}