# [Gaussian Process](https://www.youtube.com/watch?v=4vGiHC35j9s&feature=emb_logo)

## Gaussian Basics

- $x \sim N(\mu, \Sigma)$ 
    
    - ![Image for post](/home/lemon/Workspace/myCheatSheet/Math/pic/1_qUy5tdKD3JF8SBpGfN9TpQ.png)
    
    - $\Sigma$: covariance <-> $\rho$ : correlation 
        - $\rho_{x_1x_2} = \frac{Cov(x_1,x_2)}{\sigma_{x_1}\sigma_{x_2}} $
        - $Cov(x_1,x_2) = \mathbb{E}[(X_1-E(X_1))(X_2-E(X_2))]$
    
- Joint distribution && Conditional distribution  <--> Marginal distribution
    - <img src="/home/lemon/Workspace/myCheatSheet/Math/pic/image-20200716110856952.png" alt="image-20200716110856952" style="zoom:50%;" />]
    - For Gaussian, $\Sigma$ is **symmetric** and **positive definite**. 
    
- <img src="/home/lemon/Workspace/myCheatSheet/Math/pic/123123.png" alt="image-20200716111425199" style="zoom:50%;" />
    
- From joint distribution to conditional distribution :arrow_up_small:
    
- How to sample Gaussian data from uniform distribution:

    - `Inverse Cumulative Sampling`:
        - <img src="/home/lemon/Workspace/myCheatSheet/Math/pic/image-20200716122325494.png" alt="image-20200716122325494" style="zoom:25%;" />
        - 绿色的是高斯分布的Cumulative Distribution Function (累积分布函数) $\Phi(x)$, 所以从红色的uniform分布中sample出$x\sim[0,1]$, 然后逆映射$y = \Phi^{-1}(x)$, $y$符合高斯分布.

    > Inverse Transfer Learning ([see](https://www2.isye.gatech.edu/~sman/courses/6644/Module07-RandomVariateGenerationSlides_171116.pdf))
    >
    > Theorem: Let $X$ be a continuous random variable with c.d.f. $F(x)$, then $F(X) \sim \mathcal{U}(0,1)$
    >
    > Proof: Let $Y = F(X)$ and has a c.d.f. $\mathcal{G}(y)$, then:
    >
    > $\mathcal{G}(y) = P(Y \leq y) = P(F(X) \leq y) = P(x \leq F^{-1}(y)) = F(F^{-1}(y)) = y$
    >
    > Then: Let $U \sim \mathcal{U}(0,1)$, given an arbitrary distribution $F(x)$, then assign $X = F^{-1}(U)$, $X$ will have the distribution $F(x)$.
    >
    > ![image-20200716133309820](/home/lemon/Workspace/myCheatSheet/Math/pic/image-20200716133309820.png)
    
- $X_i \sim N(0,1)$ <===> $X_i \sim N(\mu,\sigma^2) \sim \mu+\sigma N(0,1)$

- How to get samples from $X\in\mathbb{R}^n, X\sim N(\mu^n, \Sigma_{n\times n})$?
    - If each dimension is **independent**, it's easy.
    - If not, we can still apply the trick in one-dimension case.
        - $X\sim \mu+L\cdot N(0, I)$. $L$ is the "square root" of $\Sigma$. (Cholesky decomposition, $\Sigma=LL^T$)
        - For $N(0,I)$, every dimension is independent. 

## Gaussian Process

- An intuitive assumption: 
    - If $x_i$ and $x_j$ are close to each other, then $y_i$ and $y_j$ should be close too.
    - We use kernel function to measure the **similarity of $x$ **.
- If we have two known data $(x_1,y_1), (x_2,y_2)$, let's say it comes from 
    - $\begin{bmatrix}y_1 \\ y_2 \\\end{bmatrix} \sim N(0, \begin{bmatrix}K_{11} & K_{12} \\ K_{21} & K_{22}\\ \end{bmatrix}) = N(0, \mathbf{K})$ 
    - :warning: $\mathbf{K}$ is all calculated with **kernel function**.
    -  Then we want to predict $y_*$ given $x_*$, let's **assume it comes from** $y_*\sim N(0,K(x_*,x_*)) = N(0, K_{**})$, where $K(\cdot, \cdot)$ is a kernel function, e.g. $K(x_i, x_j) = \sigma^2 * exp(-\lambda||x_i - x_j||)$
    - And we think $y_1,y_2$ and $y_*$ are correlated, so we get $\begin{bmatrix}y_1\\y_2\\y\\\end{bmatrix} \sim N(0, \begin{bmatrix}\mathbf{K} & & K_{1*} \\ & & K_{2*} \\ K_{*1} & K_{*2} & K_{**}\end{bmatrix})$, let's call $\begin{bmatrix}K_{1*} \\ K_{2*}\\\end{bmatrix} = K_*$ and $y = \begin{bmatrix}y_1 \\ y_2\\\end{bmatrix}$

- Then we can *apply Multivariate Gaussian Theorem* to get **$P(y_* | (x_1,y_1), (x_2,y_2))$**
    - $\mu_* = K_*^TK^{-1}y$
    - $\sigma_* = -K_*^TK^{-1}K_* + K_{**}$ 
- So Gaussian Process is a Gaussian distribution over functions. 

## Gaussian Posterior

- $p(y|D) = \frac{p(D|f)p(f)}{P(D)}$
- Prior Knowledge: $y_i \text{ and } y_j$ are close when $x_i$ and $x_j$ are close.

## Noiseless GP regression

<img src="/home/lemon/Workspace/myCheatSheet/Math/pic/image-20200716155438926.png" alt="image-20200716155438926" style="zoom:67%;" />

