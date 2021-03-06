% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/example.R
\docType{data}
\name{pavement_model}
\alias{pavement_model}
\title{Pavement example model}
\format{An object of class \code{bn.fit} (inherits from \code{bn.fit.dnet}) of length 3.}
\usage{
pavement_model
}
\description{
Example of a Bayesian network with 3 nodes: Rain (Yes/No),
Sprinkler (On/Off), Pavement (Wet/Dry). In the DAG, Rain has an effect on
Sprinkler and Pavement, Sprinkler has an effect on Pavement. Explore the
model with \code{launch_shinyBN_demo("pavement")}
}
\keyword{datasets}
