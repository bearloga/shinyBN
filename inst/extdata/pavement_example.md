# Pavement Model

The included example model `pavement_model` is a [Bayesian network](https://en.wikipedia.org/wiki/Bayesian_network) created with the [bnlearn](http://www.bnlearn.com/) package. It's a [directed acyclic graph (DAG)](https://en.wikipedia.org/wiki/Directed_acyclic_graph) which describes the probabilistic relationships between **R**ain (Yes/No), **S**prinkler (On/Off), and **P**avement (Wet/Dry).

The joint probability function is:

$$
\text{Pr}(\mathbf{P}, \mathbf{S}, \mathbf{R}) = \text{Pr}(\mathbf{P}|\mathbf{S},\mathbf{R}) \text{Pr}(\mathbf{S}|\mathbf{R}) \text{Pr}(\mathbf{R})
$$

This Bayesian network can be used to answer probabilistic queries about the variables even when only a subset of variables are known. The observed nodes are *evidence* and approximate inference algorithms -- together with [Bayes' rule](https://en.wikipedia.org/wiki/Bayes%27_theorem) -- propagate this evidence throughout the network to update the probabilities in the unobserved nodes.

## Further Reading

- Fenton, N., & Neil, M. (2018). Risk Assessment and Decision Analysis with Bayesian Networks, Second Edition. CRC Press.
- Scutari, M., & Denis, J. (2014). Bayesian Networks: With Examples in R. CRC Press.
- Nagarajan, R., Scutari, M., & Lè̀bre, S. (2013). Bayesian Networks in R. Springer Science & Business Media. http://doi.org/10.1007/978-1-4614-6446-4
- Kjærulff, U. B., & Madsen, A. L. (2007). Bayesian Networks and Influence Diagrams: A Guide to Construction and Analysis. Springer Science & Business Media. http://doi.org/10.1007/978-0-387-74101-7
- Bishop, C. M. (2006). [Pattern Recognition and Machine Learning](https://www.microsoft.com/en-us/research/people/cmbishop/#!prml-book). Springer. ([PDF](https://www.microsoft.com/en-us/research/uploads/prod/2006/01/Bishop-Pattern-Recognition-and-Machine-Learning-2006.pdf))
