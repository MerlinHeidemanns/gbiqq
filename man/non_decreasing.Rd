% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/query_helpers.R
\name{non_decreasing}
\alias{non_decreasing}
\title{Make monotonicity statement (non negative)}
\usage{
non_decreasing(X, Y)
}
\arguments{
\item{X}{A character. The quoted name of the input node}

\item{Y}{A character. The quoted name of the outcome node}
}
\value{
A character statement of class statement
}
\description{
Generate a statement for Y weakly monotonic (increasing) in X
}
\examples{
non_decreasing('A', 'B')

}
\seealso{
Other statements: 
\code{\link{complements}()},
\code{\link{decreasing}()},
\code{\link{increasing}()},
\code{\link{interacts}()},
\code{\link{non_increasing}()},
\code{\link{substitutes}()},
\code{\link{te}()}
}
\concept{statements}
