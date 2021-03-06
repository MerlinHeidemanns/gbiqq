% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_params.R
\name{clean_param_vector}
\alias{clean_param_vector}
\title{Clean parameter vector}
\usage{
clean_param_vector(model, parameters)
}
\arguments{
\item{model}{A \code{causal_model}. A model object generated by \code{\link{make_model}}.}

\item{parameters}{A vector of real numbers in [0,1]. Values of parameters to specify (optional). By default, parameters is drawn from \code{model$parameters_df}.}
}
\description{
Clean parameter vector
}
