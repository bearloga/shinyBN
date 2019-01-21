# Interactive Bayesian Networks with ShinyBN

The primary function `launch_shinyBN` is used to launch a Shiny app to make it easy to work with a `bn.fit` object from the [bnlearn](http://www.bnlearn.com/) package.

Initially, all the variables (nodes) are unobserved. However, the user can set some (or all) of the nodes to specific values. When only a subset of the variables are observed, that is *evidence*. The plots for unobserved nodes are updated from the evidence propagating throughout the network.

## Licensing

The **shinyBN** R package and interface are open source licensed under the GNU Public License, version 3 (GPLv3).
