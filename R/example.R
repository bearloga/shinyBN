#' @title Pavement example model
#' @description Example of a Bayesian network with 3 nodes: Rain (Yes/No),
#'   Sprinkler (On/Off), Pavement (Wet/Dry). In the DAG, Rain has an effect on
#'   Sprinkler and Pavement, Sprinkler has an effect on Pavement. Explore the
#'   model with `launch_shinyBN_demo("pavement")`
"pavement_model"

#' @title Taste tests example model
#' @description Example of a Bayesian network with 7 nodes: 1 for underlying
#'   product quality, 3 for taste testers' accuracy, and 3 for taste testers'
#'   judgements. Explore the model with `launch_shinyBN_demo("tasting")`
"tasting_model"

#' @title Launch example
#' @description Launches the app for interacting with either [pavement_model]
#'   or [tasting_model].
#' @param model "pavement" (default) or "tasting"
#' @param ... parameters to pass to [shiny::shinyApp]
#' @export
launch_shinyBN_demo <- function(model = c("pavement", "tasting"), ...) {
  model <- model[1]
  if (!model %in% c("pavement", "tasting"))
    stop("must use either pavement or tasting model")
  title <- paste0(
    "Interactive '", ifelse(model == "pavement", "Pavement", "Taste tests"),
    "' Bayesian network with ShinyBN"
  )
  doc <- system.file("extdata", ifelse(
    model == "pavement", "pavement_example.md", "tasting_example.md"
  ), package = "shinyBN")
  fit <- switch(model, pavement = pavement_model, tasting = tasting_model)
  launch_shinyBN(fit, app_title = title, documentation_md = doc, ...)
}
