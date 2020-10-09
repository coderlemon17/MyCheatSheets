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
- Why high order polynomial tends to **over-fitting**?
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

#### 1.2.1. Probability Densities

- Terminologies: probability densities function; probability mass function (discrete); cumulative density function.

- Variable change:

  - Assume $x=g(y)$, $p_x(x)dx\approx p_y(y)dy\rightarrow p_y(y)=p_x(x)|\frac{dx}{dy}|=p_x(g(y))|g'(y)|$.

  - > The concept of the **maximum** of a probability density is dependent on the choice of the variable.

#### 1.2.2. Expectations and covariances

- $\mathbb{E}_x[f(x,y)]$ is a function of $y$.
- *Conditional expectation:* $\mathbb{E}_x[f|y]=\sum\limits_xf(x)p(x|y)$.
- (Co)variances:
  - $var[x]=\mathbb{E}[(x-\mathbb{E}[x])^2]=\mathbb{E}[x^2]-\mathbb{E}[x]^2$
  - $cov[x,y]=\mathbb{E}_{x,y}[(x-\mathbb{E}[x])(y-\mathbb{E}[y])] = \mathbb{E}_{x,y}[xy]-\mathbb{E}[x]\mathbb{E}[y]$.

#### 1.2.3. Bayesian Probabilities

- Classical or frequentist interpretation of probabilities:
  - Frequencies of random, repeatable events.
  - The parameter $w$ is fixed, whose value is determined by "estimator", and error/likelihood of the "estimator" are obtained by considering the distribution of data set $\mathcal{D}$.
    - MLE; Bootstrap (with replacement).

- Bayesian probabilities:
  - **Quantified expression of uncertainty**.
  - $posterior\propto likelihood \times prior$
  - There's only a single data set $\mathcal{D}$ and *the uncertainty in the parameters* is expressed through a probability distribution over $w$.
  - **Prior**: debatable; usually chose for mathematical conveniences; significant related to model's performances; noninformative priors (try to alleviate the importance of the prior).
  - Need integrate / sum over the whole parameter space (sampling method: e.g. MC)
    - $p(y|x,Data)=\int_\theta p(y|x,\theta)p(\theta|Data)d\theta$
  - Deterministic approximation schemes: variational Bayes; expectation propagation.

#### 1.2.4. The Gaussian Distribution

- $\mathcal{N}(x|\mu,\Sigma)=\frac{1}{(2\pi)^{\frac{D}{2}}}\frac{1}{|\Sigma|^{\frac{1}{2}}}exp\{-\frac{1}{2}(x-\mu)^T\Sigma^{-1}(x-\mu)\}$.
  - And we might use $\beta=\frac{1}{\sigma^2}$ to denote the *precision*.
- For a data set with $N$ observation, MLE is actually maximizing the probability of data given the parameter (not the other way round, but these two criteria are actually related).
  - The log likelihood: <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009153643613.png" alt="image-20201009153643613" style="zoom:50%;" />
  - $\mu_{ML}=\frac{1}{N}\sum\limits_{n=1}^Nx_n$, $\sigma^2_{ML}=\frac{1}{N}\sum\limits_{n=1}^N(x_n-\mu_{ML})^2$.
  - But we can see: <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009153951878.png" alt="image-20201009153951878" style="zoom: 50%;" />, which means MLE is actually **BIASED** on variance estimation (for that it's measured relative to the sample mean rather than the true mean.), and this lies at the **root of the over-fitting problem in earlier polynomial curve fitting**.

#### 1.2.5. Curve Fitting Re-visited

- Bayesian interpretation: **we can express our uncertainty over the value of the target variable using a probability distribution.**
  - $p(t|x,w,\beta)= \mathcal{N}(t|y(x,w), \beta^{-1})$, which is the *predictive distribution*, we use its **expectation** for prediction.
  - <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009154620389.png" alt="image-20201009154620389" style="zoom:33%;" />
- The (log) likelihoods are:
  - <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009154643558.png" alt="image-20201009154643558" style="zoom: 60%;" /> <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009154726310.png" alt="image-20201009154726310" style="zoom:60%;" />
- **Maximize the log likelihood** (the probability of data given parameter)
  - Maximize likelihood w.r.t. $w$ is actually **minimize the sum-of-squares error function**. (L2 norm)
  - Maximize likelihood w.r.t. $\beta$: <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009155717224.png" alt="image-20201009155717224" style="zoom:67%;" />
    - But we don't actually need it, because we don't use $\beta$ when doing prediction.
- **Maximize the posterior** (the probability of parameter given data) 
  - Prior: we choose a prior for the coefficients $w$, where $\alpha$ is the precision of the distribution:
    - <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009155957824.png" alt="image-20201009155957824" style="zoom:67%;" />
  - $p(w|x,t,\alpha,\beta)\propto p(t|x,w,\beta)p(w|\alpha)$: maximize the posterior (**MAP**)
    - It's equivalent to minimize: <img src="/home/lemon/Workspace/myCheatSheet/Learn/PRML/pic/image-20201009160313155.png" alt="image-20201009160313155" style="zoom: 67%;" />. (ridge regression with $\lambda=\frac{\alpha}{\beta}$)

####  1.2.6. Bayesian Curve Fitting

- In previous discussion we are actually making **point estimation** (we assume it has a value) of $w$, what if we consider it as a random variable (with distribution).
- For simplicity, we assume $\beta, \alpha$ are fixed and known:
  - $p(t|x,\mathbf{x},\mathbf{t})=\int p(t|x,w)\underbrace{p(w|\mathbf{x},\mathbf{t})}_{\text{posterior}}dw$. (Note that the posterior needs to be normalized.)
- In the polynomial curve fitting example, the uncertainty (variance) now is not only $\beta^{-1}$, but also has term that comes from the uncertainty in the parameter $w$.

### 1.3. Model Selection

- validation set; test set (if the model will be trained and test on validation set iteratively, then test set is for **final** evaluation).
- *(k-folder) cross-validation*: train $k$ models.
  - Drawback: $k$ time slower; multiple complexity parameters might need to testing for exponentially large combinations.
- Information criteria: Adding a penalty term to compensate for the over-fitting (caused by the bias in MLE).
  - $\left\{\begin{aligned}&\text{Akaike information criterion (AIC)}\\&\text{Bayesian information criterion (BIC).}\end{aligned}\right.$
  - However in practice these methods usually favor overly simple models.

### 1.4. The Curse of Dimensionality

- Something different w.r.t to high dimensions:
  - Exponential data / parameters.
  - Most volume of a sphere is concentrated in a thin shell near the surface in high dimension.
  - The probability mass of the Gaussian is concentrated in a thin shell in high dimension.
- Two good properties of real data to conquer the "curse":
  - Only partial dimensions are effective.
  - (At least locally) smoothness properties, we might exploit local interpolation-like (局部插值) techniques.