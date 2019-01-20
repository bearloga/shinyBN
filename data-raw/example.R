library(bnlearn)

edges <- matrix(
  c(
    "Rain", "Pavement",
    "Rain", "Sprinkler",
    "Sprinkler", "Pavement"
  ),
  ncol = 2, byrow = TRUE,
  dimnames = list(NULL, c("from", "to"))
)

dag <- empty.graph(c("Rain", "Sprinkler", "Pavement"))
arcs(dag) <- edges

cpt_r <- matrix(c(0.3, 0.7), ncol = 2, dimnames = list(NULL, c("Yes", "No")))
cpt_s <- matrix(c(0.001, 0.999, 0.8, 0.2), nrow = 2,
                dimnames = list("Sprinkler" = c("On", "Off"), "Rain" = c("Yes", "No")))
cpt_p <- array(
  c(
    1.0, 0.0, # Rain = Yes, Sprinkler = On
    0.8, 0.2, # Rain = Yes, Sprinkler = Off
    0.6, 0.4, # Rain = No, Sprinkler = On
    0.001, 0.999 # Rain = No, Sprinkler = Off
  ),
  dim = c(2, 2, 2),
  dimnames = list(
    "Pavement" = c("Wet", "Dry"),
    "Sprinkler" = c("On", "Off"),
    "Rain" = c("Yes", "No")
  ))

fit <- custom.fit(dag, dist = list(Rain = cpt_r, Sprinkler = cpt_s, Pavement = cpt_p))
pavement_model <- fit
usethis::use_data(pavement_model)

cpquery(fit, (Rain == "Yes"), (Pavement == "Wet" & Sprinkler == "Off"))

evidence <- data.frame(
  Pavement = factor("Wet", c("Wet", "Dry")),
  Sprinkler = factor("On", c("On", "Off")),
  stringsAsFactors = FALSE
)
predict(fit, "Rain", evidence, prob = TRUE, method = "bayes-lw")
