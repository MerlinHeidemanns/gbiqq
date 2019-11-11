
#' Make monotonicity statement (positive)
#'
#' Generate a statement for Y monotonic (increasing) in X
#'
#' @param X input node
#' @param Y outcome node
#' @family statements
#' @export
#'
#' @return A character statement of class statement
#' @examples
#' increasing("A", "B")
#'
increasing <- function(X, Y){

	if(!is.character(X) | !is.character(Y)) stop("Provide node names as strings in function: increasing")

	statement = paste0("(", Y, "[", X, "=1] > ", Y, "[", X, "=0])")

	class(statement) <- "statement"

	statement
	}

#' Make monotonicity statement (negative)
#'
#' Generate a statement for Y monotonic (decreasing) in X
#'
#' @param X input node
#' @param Y outcome node
#' @family statements
#' @export
#' @return A character statement of class statement
#' @examples
#' decreasing("A", "B")
#'
decreasing <- function(X, Y){

	if(!is.character(X) | !is.character(Y)) stop("Provide node names as strings in function: decreasing")

	statement = paste0("(", Y, "[", X, "=1] < ", Y, "[", X, "=0])")

	class(statement) <- "statement"

	statement
}


#' Make statement for any interaction
#'
#' Generate a statement for X1, X1 interact in the production of Y
#'
#' @param X1 input node 1
#' @param X2 input node 2
#' @param Y outcome node
#' @family statements
#' @export
#' @return A character statement of class statement
#' @examples
#' interacts("A", "B", "W")
#' get_query_types(model = make_model("X-> Y <- W"),
#'          query = interacts("X", "W", "Y"))
#'

interacts <- function(X1, X2, Y){

	if(!is.character(X1) | !is.character(X2) |!is.character(Y)) stop("Provide node names as strings in function: interacts")

	statement = paste0("((", Y, "[", X1, " =1, ", X2, " = 1]) - (", Y, "[",X1, " = 0, ", X2, " = 1])) != ",
										 "((", Y, "[", X1, " =1, ", X2, " = 0]) - (", Y, "[",X1, " = 0, ", X2, " = 0]))" )

	class(statement) <- "statement"

	statement
}



#' Make statement for complements
#'
#' Generate a statement for X1, X1 complement each other in the production of Y
#'
#' @param X1 input node 1
#' @param X2 input node 2
#' @param Y outcome node
#' @family statements
#' @export
#' @return A character statement of class statement
#' @examples
#'complements("A", "B", "W")
#'
complements <- function(X1, X2, Y){

	if(!is.character(X1) | !is.character(X2) |!is.character(Y)) stop("Provide node names as strings in function: complements")

	statement = paste0("((", Y, "[", X1, " =1, ", X2, " = 1]) - (", Y, "[",X1, " = 0, ", X2, " = 1])) > ",
										 "((", Y, "[", X1, " =1, ", X2, " = 0]) - (", Y, "[",X1, " = 0, ", X2, " = 0]))" )

	class(statement) <- "statement"

	statement
}



#' Make statement for substitutes
#'
#' Generate a statement for X1, X1 substitue for each other in the production of Y
#'
#' @param X1 input node 1
#' @param X2 input node 2
#' @param Y outcome node
#' @export
#' @family statements
#' @return A character statement of class statement
#' @examples
#'
#'get_query_types(model = make_model("A -> B <- C"),
#'          query = substitutes("A", "C", "B"))
#'
#'query_model(model = make_model("A -> B <- C"),
#'          queries = substitutes("A", "C", "B"),
#'          using = "parameters")
#
substitutes <- function(X1, X2, Y){

	if(!is.character(X1) | !is.character(X2) |!is.character(Y)) stop("Provide node names as strings in function: substitutes")

	statement = paste0("((", Y, "[", X1, " = 1, ", X2, " = 1]) - (", Y, "[",X1, " = 0, ", X2, " = 1])) < ",
										 "((", Y, "[", X1, " = 1, ", X2, " = 0]) - (", Y, "[",X1, " = 0, ", X2, " = 0]))" )

	class(statement) <- "statement"

	statement
}

#' Make treatment effect statement (positive)
#'
#' Generate a statement for (Y(1) - Y(0)). This statement when applied to a model returns an element in (1,0,-1) and not a set of cases. This is useful for some purposes such as querying a model, but not for uses that require a list of types, such as \code{set_restrictions}.
#'
#' @param X input node
#' @param Y outcome node
#' @family statements
#' @export
#'
#' @return A character statement of class statement
#' @examples
#' te("A", "B")
#'
#' model <- make_model("X->Y") %>% set_restrictions(increasing("X", "Y"))
#' query_model(model, list(ate = te("X", "Y")),  using = "parameters")
#'
#' # set_restrictions  breaks with te because it requires a listing
#' of causal types, not numeric output.
#'\dontrun{
#' model <- make_model("X->Y") %>% set_restrictions(te("X", "Y"))
#' }
#'
te <- function(X, Y){

	if(!is.character(X) | !is.character(Y)) stop("Provide node names as strings in function: increasing")

	statement = paste0("(",Y, "[", X, "=1] - ", Y, "[", X, "=0])")

	class(statement) <- "statement"

	statement
}