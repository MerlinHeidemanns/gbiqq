
#' Get ambiguities matrix
#'
#' Return ambiguities matrix if it exists; otherwise calculate it assuming no confounding. The ambiguities matrix  maps from causal types into data types.
#'
#' @inheritParams gbiqq_internal_inherit_params
#'
#' @return A \code{data.frame}. Types (rows) corresponding to possible data realizations (columns).
#' @return A matrix representing ambiguities.
#' @export
#' @examples
#' model <- make_model('X -> Y')
#' get_ambiguities_matrix(model = model)
#'
#' @export
#'
get_ambiguities_matrix <- function(model) {

    if (!is.null(model$A))
        return(model$A)

    make_ambiguities_matrix(model)

}

#' Make ambiguities matrix
#'
#' Make ambiguities matrix. The ambiguities matrix  maps from causal types into data types.
#'
#' @inheritParams gbiqq_internal_inherit_params
#' @return A \code{data.frame}. Types (rows) corresponding to possible data realizations (columns).
#' @return A matrix representing ambiguities.
#' @export
#' @examples
#' model <- make_model('X -> Y')
#' make_ambiguities_matrix(model = model)
#'
make_ambiguities_matrix <- function(model) {

    # 1. Get types as the combination of possible data. e.g. for X->Y: X0Y00, X1Y00, X0Y10, X1Y10...
    types <- get_causal_types(model)
    var_names <- colnames(types)
    type_labels <- sapply(1:nrow(types), function(i) paste0(var_names, types[i, ], collapse = ""))
    # cbind(types, type_labels) # A check

    # 2. Map types to data realizations. This is done in reveal_outcomes
    data_realizations <- reveal_outcomes(model)
    types$revealed_data <- apply(data_realizations, 1, paste0, collapse = "")

    # 3.  Create and return matrix A max_possible_data <- get_max_possible_data(model)
    full_possible_data <- all_data_types(model, possible_data = TRUE)
    data_names <- full_possible_data$event
    # data_names <- sapply(1:ncol(full_possible_data), function(i)
    # paste0(colnames(full_possible_data)[i],full_possible_data[,i] )) data_names <- matrix(data_names,
    # ncol = ncol(full_possible_data)) data_names <- apply(data_names, 1, paste0, collapse = '')
    fundamental_data <- apply(dplyr::select(full_possible_data, -event), 1, paste0, collapse = "")

    # 4. Generate A
    A <- sapply(1:nrow(types), function(i) (types$revealed_data[i] == fundamental_data) * 1)
    A <- matrix(A, ncol = length(type_labels))
    colnames(A) <- type_labels
    rownames(A) <- data_names

    t(A)

}


#' Set ambiguity matrix
#'
#' Add an ambiguities matrix to a model
#'
#' @inheritParams gbiqq_internal_inherit_params
#'
#' @export
#'
set_ambiguities_matrix <- function(model, A = NULL) {

    if (is.null(A))
        A <- make_ambiguities_matrix(model)
    model$A <- A
    class(model$A) <- c("ambiguities_matrix")
    model

}



