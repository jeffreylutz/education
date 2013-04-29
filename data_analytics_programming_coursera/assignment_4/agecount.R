agecount <- function(age = NULL) {
	## Check that "age" is non-NULL; else throw error
	if(is.null(age)) {
		stop("invalid age")
	}
	age <- as.numeric(age);
	if(age < 0 || age > 100) {
		stop("invalid age")
	}

	## Read "homicides.txt" data file
	doc <- readLines("homicides.txt")

	## Extract ages of victims; ignore records where no age is given
	search_term <- paste("",age,"years old")
	doc_cause <- grep(search_term,doc,ignore.case = TRUE, value=TRUE)

	## Return integer containing count of homicides for that age
	length(doc_cause)
}