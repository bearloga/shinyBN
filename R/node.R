nodeUI <- function(id, label, choices) {
  ns <- shiny::NS(id)
  width <- paste0(max(250, 75 * length(choices)), "px")
  shiny::tagList(
    shiny::plotOutput(ns("probs"), height = "200px", width = width),
    shiny::selectInput(
      ns("choices"), label,
      choices = c("(Unobserved)", choices), selected = "(Unobserved)",
      width = "250px"
    )
  )
}

nodeServer <- function(input, output, session,
                       possibilities,
                       probabilities) {
  # force(possibilities)
  output$probs <- shiny::renderPlot({
    n <- length(possibilities)
    if (input$choices == "(Unobserved)") {
      # Return estimated probabilities
      x <- probabilities()
    } else {
      x <- stats::setNames(rep(0, n), possibilities)
      x[input$choices] <- 1.0
    }
    graphics::par(las = 1, mar = c(3, 3, 1, 0), bg = "transparent")
    graphics::barplot(x, ylim = c(0, 1), border = NA, col = "gray30")
  }, bg = "transparent")
  return(shiny::reactive({ input$choices }))
}
