# [A Tutorial on Bayesian Optimization of Expensive Cost Functions, with Application to Active User Modeling and Hierarchical Reinforcement Learning](https://arxiv.org/pdf/1012.2599.pdf)

# Bayes' Theorem

- M: the *posterior* probability of a model (or theory, or hypothesis)
- E: evidence (or data, or observations)

$$
P(M|E) \propto P(E|M)P(M)
$$

# Where's the Bayesian part in GP?

- https://stats.stackexchange.com/questions/84167/is-gaussian-process-regression-a-bayesian-method
- The very thing which makes GP a Bayesian approach is that, *it specifies a Prior, and the Gaussian conditional acts as the Posterior*.
    - Think about Gaussian a distribution over functions, we add observed data, then the distribution changed (using Gaussian conditional):
        - <img src="/home/lemon/Workspace/myCheatSheet/Math/pic/index.md" alt="image-20200730161738297" style="zoom:50%;" />
    - Actually in GP, the $P(M|E) = P(M|(x_i,y_i)_N) =  P(x_1,y_1, \cdots, x_N,y_N)$ (Gaussian joint probability) is **not** what we care, what we care is $P(f|M)$.
        - Because GP is non-parametrized, so we don't care how to apply the Bayes' chain rule for updating $M$ (you can think that $M$ is updated using new data automatically), but how to use the posterior for prediction. :

