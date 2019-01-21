#' @title shinyBN: Interactive Visualization for Bayesian Networks
#' @description Shiny-powered tool for visualizing probabilities in
#'   Bayesian Networks.
#' @aliases shinyBN
#' @docType package
#' @name shinyBN-package
NULL

#' @title Launch the 'shinyBN' app
#' @description Launch the Shiny-powered app to visualize and interact with a
#'   `bn.fit` object (cf. [bnlearn::bn.fit]).
#' @param object a discrete Bayesian network
#' @param app_title name to use for the instance of the app
#' @param node_labels optional named vector of labels to use for the nodes
#' @param value_labels optional named list of labels to use for the possible
#'   values of the nodes
#' @param help_texts optional named character vector of helpful text to
#'   include in the node interfaces
#' @param documentation_md optional path to a Markdown document to include in
#'   the app; if provided, it is wrapped in `withMathJax`, so the documentation
#'   can include math
#' @param ... parameters to pass to [shiny::shinyApp]
#' @examples \dontrun{
#' launch_shinyBN(pavement_model)
#' }
#' @import shiny
#' @export
launch_shinyBN <- function(object, app_title = NULL,
                           node_labels = NULL, value_labels = NULL,
                           help_texts = NULL, documentation_md = NULL,
                           ...) {
  graph <- bn_graph(object)
  node_names <- stats::setNames(names(object), names(object))
  # Fill out labels, where needed:
  node_labels <- purrr::map_chr(node_names, function(name) {
    if (name %in% names(node_labels)) return(node_labels[name])
    else return(name)
  })
  value_labels <- purrr::map(node_names, function(name) {
    if (name %in% names(value_labels)) return(value_labels[[name]])
    if (length(dim(object[[name]]$prob)) > 1) {
      return(dimnames(object[[name]]$prob)[[name]])
    } else {
      return(names(object[[name]]$prob))
    }
  })
  help_texts <- purrr::map_chr(node_names, function(name) {
    if (name %in% names(help_texts)) return(help_texts[name])
    else return("")
  })

  generate_nodeUI <- function(name) {
    if (help_texts[name] != "") {
      wp <- wellPanel(
        nodeUI(
          id = name,
          label = node_labels[[name]],
          choices = value_labels[[name]]
        ),
        helpText(help_texts[name])
      )
    } else {
      wp <- wellPanel(nodeUI(
        id = name,
        label = node_labels[[name]],
        choices = value_labels[[name]]
      ))
    }
    return(div(style = "display:inline-block;", wp))
  }

  node_uis <- purrr::map(node_names, generate_nodeUI)

  if (!is.null(app_title))
    optional_title <- titlePanel(app_title)
  else optional_title <- NULL
  if (!is.null(documentation_md))
    optional_documentation <- withMathJax(includeMarkdown(documentation_md))
  else optional_documentation <- tagList(NULL)

  ui <- fluidPage(
    optional_title,
    fluidRow(
      column(DiagrammeR::grVizOutput("bn", width = "90%"), width = 4),
      column(tagList(node_uis), width = 8)
    ),
    optional_documentation
  )

  initial_probabilities <- bnlearn::cpdist(object, node_names, evidence = TRUE) %>%
    dplyr::mutate_all(as.character) %>%
    tidyr::gather("node", "value") %>%
    dplyr::count(node, value) %>%
    dplyr::group_by(node) %>%
    dplyr::transmute(value = value, prop = n / sum(n)) %>%
    dplyr::ungroup() %>%
    split(.$node) %>%
    purrr::map(~ stats::setNames(.x$prop, .x$value))

  server <- function(input, output, session) {
    modules <- reactiveValues()
    probabilities <- reactiveValues()
    for (node_name in names(node_names)) {
      probabilities[[node_name]] <- reactive({ initial_probabilities[[node_name]] })
    }
    for (node_name in names(node_names)) {
      force(node_name)
      possibilities <- value_labels[[node_name]]
      modules[[node_name]] <- callModule(
        module = nodeServer, id = node_name,
        possibilities = possibilities,
        probabilities = probabilities[[node_name]]
      )
    }
    output$bn <- DiagrammeR::renderGrViz({
      graph$nodes_df$style <- "filled"
      for (node_name in names(node_names)) {
        if (modules[[node_name]]() == "(Unobserved)") {
          graph$nodes_df$style[graph$nodes_df$label == node_name] <- "empty"
        }
      }
      DiagrammeR::render_graph(graph, layout = "tree")
    })
  }

  return(shinyApp(ui, server, ...))
}
