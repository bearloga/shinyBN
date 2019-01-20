#' @title Create a DiagrammeR graph from fitted Bayesian Network
#' @description Creates a `dgr_graph` object (cf. [DiagrammeR::create_graph])
#'   from a `bn.fit` object (cf. [bnlearn::bn.fit]).
#' @param x a `bn.fit` object
#' @return a graph object of class `dgr_graph`
#' @examples
#' data("pavement_model", package = "shinyBN")
#' pavement_graph <- bn_graph(pavement_model)
#' # DiagrammeR::render_graph(pavement_graph)
#' @export
bn_graph <- function(x) {
  if (!"bn.fit" %in% class(x)) stop("x must be a bn.fit object")
  # Extract DAG as a from->to matrix:
  d <- purrr::map_dfr(x, ~ dplyr::tibble(to = .x$children), .id = "from")
  # Nodes:
  n_nodes <- length(x)
  node_labels <- names(x)
  nodes_df <- DiagrammeR::create_node_df(n_nodes, label = node_labels, shape = "circle")
  # Edges:
  from_df <- dplyr::left_join(
    d[, "from", drop = FALSE],
    nodes_df[, c("label", "id")],
    by = c("from" = "label")
  )
  to_df <- dplyr::left_join(
    d[, "to", drop = FALSE],
    nodes_df[, c("label", "id")],
    by = c("to" = "label")
  )
  edges_df <- DiagrammeR::create_edge_df(from = from_df$id, to = to_df$id)
  # Output:
  graph <- DiagrammeR::create_graph(nodes_df, edges_df)
  return(graph)
}
