# PRML

## 1. Introduction

- $\underbrace{Preprocess}_{\text{feature extraction}}$->$Learning\ Algorithm$->$Model$.
- $Supervised\left \{\begin{aligned}&classification\\&regression\end{aligned} \right.$
- $Unsupervised\left \{\begin{aligned}&clustering\\&density\ estimation&\\&visualization&\\&generation\end{aligned} \right.$
- $Reinforcement\left \{\begin{aligned}&credit\ assignment\\&exploration\\&exploitation\end{aligned} \right.$
  - Credit assignment: the reward must be properly assigned to every move that leads to it.
- Key ideas and tools: probability; decision; information theory.

### 1.1. Example: Polynomial Curve Fitting

- Causes of noise: *random noise* or *sources of unobserved variability*.
- Root-mean-square error: $R_{RMS}=\sqrt{\frac{2E(w^*)}{N}}$.
- Why high order polynomial tends to *over-fitting*?
  - Strange because: high order polynomials actually contains low order ones; The Taylor formula of target functions is actually infinite order polynomials.
  - One interpretation: 
    - As order increases, the **magnitude** of the coefficients gets larger.
    - The more flexible polynomials with larger order are becoming increasingly tuned to the random noise on the target values.
  - The over-fitting problem becomes less severe as the size of training set increasing.
  - *Regulations*: $\frac{\lambda}{2}||w||^2$.
    - $w_0$ should not be included or with its own $\lambda$.
  - Model selection: *validation set* or *hold-out set*.
- The number of parameters should not be determined by the size of data set, but the **complexity of the problem**. (Bayesian approach.)

### 1.2. Probability Theory

- *sum rule*: $\underbrace{P(X)}_{\text{marginal}}=\int \underbrace{P(X,Y)}_{\text{joint}}dy$.
- *product rule*: $P(X,Y)=p(Y|X)p(X)$.
- *Bayes rules*: $p(Y|X)=\frac{p(X|Y)p(Y)}{\sum\limits_Yp(X|Y)p(Y)}$.
  - Estimate probability distribution from data.
- 