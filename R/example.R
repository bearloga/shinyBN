#' @title Pavement example model
#' @description Example of a Bayesian network with 3 nodes: Rain (Yes/No),
#'   Sprinkler (On/Off), Pavement (Wet/Dry). In the DAG, Rain has an effect on
#'   Sprinkler and Pavement, Sprinkler has an effect on Pavement.
"pavement_model"

#' @title Launch example
#' @description Launches the app using the [pavement_model] data.
#' @param ... parameters to pass to [shiny::shinyApp]
#' @export
launch_shinyBN_demo <- function(...) {
  title <- "Interactive 'Pavement' Bayesian network with ShinyBN"
  doc <- system.file("extdata", "pavement_example.md", package = "shinyBN")
  launch_shinyBN(
    pavement_model,
    app_title = title,
    documentation_md = doc,
    ...
  )
}
