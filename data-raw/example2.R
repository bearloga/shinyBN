library(bnlearn)

edges <- matrix(
  c(
    "Quality", "Test1",
    "Quality", "Test2",
    "Quality", "Test3",
    "Taster1", "Test1",
    "Taster2", "Test2",
    "Taster3", "Test3"
  ),
  ncol = 2, byrow = TRUE,
  dimnames = list(NULL, c("from", "to"))
)

dag <- empty.graph(c("Quality", "Taster1", "Test1", "Taster2", "Test2", "Taster3", "Test3"))
arcs(dag) <- edges

cpt_q <- matrix(c(0.5, 0.5), ncol = 2, dimnames = list(NULL, c("Good", "Bad")))
cpt_a <- matrix(c(0.5, 0.5), ncol = 2, dimnames = list(NULL, c("Inaccurate", "Accurate")))
cpt_t2 <- cpt_t3 <- cpt_t1 <- array(
  c(
    0.6, 0.4,
    0.9, 0.1,
    0.4, 0.6,
    0.1, 0.9
  ),
  dim = c(2, 2, 2),
  dimnames = list(
    "Test1" = c("Good", "Bad"),
    "Taster1" = c("Inaccurate", "Accurate"),
    "Quality" = c("Good", "Bad")
  ))
dimnames(cpt_t2) <- list(
  "Test2" = c("Good", "Bad"),
  "Taster2" = c("Inaccurate", "Accurate"),
  "Quality" = c("Good", "Bad")
)
dimnames(cpt_t3) <- list(
  "Test3" = c("Good", "Bad"),
  "Taster3" = c("Inaccurate", "Accurate"),
  "Quality" = c("Good", "Bad")
)

fit <- custom.fit(dag, dist = list(
  Quality = cpt_q,
  Taster1 = cpt_a, Test1 = cpt_t1,
  Taster2 = cpt_a, Test2 = cpt_t2,
  Taster3 = cpt_a, Test3 = cpt_t3
))
tasting_model <- fit
usethis::use_data(tasting_model)

library(DiagrammeR)

nodes_df <- create_node_df(
  7, shape = "circle", style = "filled",
  label = c(
    "Product\nQuality",
    "Taster 1\nAccuracy", "Taste\nTest 1",
    "Taster 2\nAccuracy", "Taste\nTest 2",
    "Taster 3\nAccuracy", "Taste\nTest 3"
  )
)
edges_df <- create_edge_df(
  from = c(1, 1, 1, 2, 4, 6),
  to = c(3, 5, 7, 3, 5, 7),
  color = "black"
)
graph <- create_graph(nodes_df, edges_df)
render_graph(graph, layout = "tree")
