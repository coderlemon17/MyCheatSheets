# Summary

## Lecture 1: introduction

### What's ML: $y=f(x)$

- What kind of model do you want to find? (**what's the y?**) 
    - Regression / classification / generation
- How to interact with the model? (**what's the x?**) 
    - Supervised learning.
    - RL.
    - Unsupervised learning. (clustering, generation...)
- How to acquire good model? (**what's the f?**)
    - Network architecture (limit model space)
    - Gradient descent (parameter optimization)

### Modern Research

- Explainable, Adversarial, Network Compression, Anomaly Detection, Transfer Learning, Meta Learning

## Lecture 2.1: Regression

- output: scalar

### Three Steps

- Find model
- Define goodness (e.g. Loss function)
- Find best function (optimization)

### Gradient Descent

- GD: loss function need to be **differentiable**
- Failure point: 
- <img src="/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200710133353374.png" alt="image-20200710133353374" style="zoom: 67%;" />
    - `plateau`; `saddle point`, `local minima`
- Linear model is convex. (Linear: `y` is linear w.r.t parameters $\omega$, not data `x`)

### Model Selection

- Over-fitting and under-fitting
    - Under-fitting: hidden-factors not considered.
    - Over-fitting: model too complex.  <---> `Regularization`
- Regularization:
    - when $\omega_i$ is smaller, the function is less sensitive to (noisy) input, and thus smoother.

## Lecture 2.2: Bias and Variance

### Where dose the error come from?

- Bias + Variance
- There are **two** types of bias and variance !
    - model `f` bias / variance. (bias / variance of one specific function)
    - model family bias `{f1, f2...}`.
    - e.g. 
        - A model family $f(x) = \omega_1 x_1 + \omega_2 x_2$  (1)                     
        - A model is $f(x) = 2 x_1 + 3 x_2$               (2)
        - These two has bias / variance respectively.
        - for (1): ---> image multiple data set, and we can acquire optimal function $f^*_i(x)
            $ for each one of them, then calculate average bias / variance

### Model family Variance

- Complex model tends to have **larger variance**. (for the same input, different model tends to give very different output)
    - Simple model is less influential by the sampled data.

### Model family Bias

- Simple model tends to have **larger bias**.

### Bias and Variance

- Cannot fit the training data: large bias
    - resign model (missing hidden factors); complex model 
- Can fit the training data, large error on testing: large variance
    - add more data; simplify model

### Model Selection

- **Training set** (= training set + validation set) <---> **Testing Set** (= public set + private set)

1. find the best model w.r.t score on `validation set`
2. test error on `public set`. 

Note: error on `public set` should be larger, because this way it can really indicates your model's performance on private set.

Note: if you go back and do something to improve performance on the `public set`:

- This could be `harmful`, because this way you actually consider patterns from the `public set`, which might be misleading on `private set`.

- **N-fold Cross Validation**

## Lecture 3.1: Gradient Descent

### Tuning Learning Rates

- Visualization:
    - <img src="/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200710140006638.png" alt="image-20200710140006638" style="zoom:67%;" />
- Adaptive Learning Rate
    - Simple methods:
        - Reduce learning rate every few epochs:
            - $\eta^t = \frac{\eta}{\sqrt{t+1}}$
        - **Give different parameters different learning rate**
    - `Adagrad`
        - $w^{t+1} \leftarrow\omega^t - \frac{\eta^t}{\sigma^t}g^t$
        - $\sigma^t$ is the root mean square (rms) of the model's previous derivatives.
        - e.g. <img src="/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200710140422678.png" alt="image-20200710140422678" style="zoom:50%;" />
    - combined with time decay $\eta^t = \frac{\eta}{\sqrt{t+1}}$:
        - $w^{t+1} \leftarrow\omega^t - \frac{\eta^t}{\sigma^t}g^t = w^t - \frac{\eta}{\sqrt{\sum_{i=0}^t{(g^i)^2}}}$
    - **Intuition about `Adagrad`**:
        - emphasize the *surprise*.
        - $1^{st}$ order derivative dose not indicate the best step, the best step should be $\frac{1^{st} \text{derivative}}{2^{nd} \text{derivative}}$
            - so the rms kind of represent $2^{nd} \text{derivative}$.

### Stochastic Gradient Descent

- Loss function only for some data.

### Feature Scaling

- Make different features (dimensions of `x`) have **same scaling**.
    - Otherwise:
        - Best learning rate for different features is more different.
        - GD might not be able to aim for the minimal. (GD is not go directly to the minimal, instead it follows the normal direction(法线方向) of the loss contour (等高线))
- $x_i^r \leftarrow\frac{x_i^r-m_i}{\sigma_i}$ (the $r$th dimension of the $i$th sample)

### Theory

- Actually **GD** can be thought as approximation with *Taylor Series*, so the learning rate (step size) has to be small to make approximation valid.

## Lecture 3.2 TODO

## Lecture 4.1