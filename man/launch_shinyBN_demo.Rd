% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/example.R
\name{launch_shinyBN_demo}
\alias{launch_shinyBN_demo}
\title{Launch example}
\usage{
launch_shinyBN_demo(model = c("pavement", "tasting"), ...)
}
\arguments{
\item{model}{"pavement" or "tasting"}

\item{...}{parameters to pass to \link[shiny:shinyApp]{shiny::shinyApp}}
}
\description{
Launches the app for interacting with either \link{pavement_model}
or \link{tasting_model}.
}
