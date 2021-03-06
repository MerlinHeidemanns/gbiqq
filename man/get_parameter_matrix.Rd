% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_parameter_matrix.R
\name{get_parameter_matrix}
\alias{get_parameter_matrix}
\title{Get parameter matrix}
\usage{
get_parameter_matrix(model)
}
\arguments{
\item{model}{A model created by make_model()}
}
\description{
Return parameter matrix if it exists; otherwise calculate it assuming no confounding. The parameter matrix  maps from parameters into causal types. In models without confounding parameters correspond to nodal types.
}
