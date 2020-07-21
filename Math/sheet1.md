## Active Learning

https://zhuanlan.zhihu.com/p/79764678

#### 定义：

- 主要是针对数据标签较少或打标签“代价”较高这一场景而设计的，又称为**最优实验设计**。
- 主要是模型抛出**hard sample** (unlabeled data)与专家进行交互，从而用最小的label获得最好的性能。

- 和passive learning的最主要区别在于使用少量标注样本和大量未标注样本进行训练。
  - 和semi-supervised learning的主要区别在于query时需要有专家参与。

#### scenarios

##### Membership Query Synthesis

- 其query samples可以为**任意样本或随机生成**（例如对图片样本进行旋转或添加“噪声”等，类似**样本增强**的策略），然后将其送个Oracle进行判断。
- 局限：随机生成的样本Oracle可能也无法判断。

##### Stream-Based Selective Sampling （Sequential active learning）

- 其key assumption为**样本的获得**是“免费的”或代价较小的，因此learner每次基于某种**query strategy**选择一个样本给专家进行标记。

##### Pool-Based Sampling

- 与Stream-Based Sampling最大的区别即为Pool-Based Sampling**每次确定一批**unlabeled data。
- 是当前应用最广的Active Learning框架。

#### Query Strategy Framework

- learner选择样本进行query的方法。

##### Uncertainty Sampling

- 其主要是将模型“**最易混淆**”或“**信息量**”最大、最有价值的样本返回给expert，以期获得较大的增益，主要有以下几种：

###### Least Confidence

- ![[公式]](https://www.zhihu.com/equation?tex=+x%5E%2A_%7BLC%7D%3Dargmax_x1-P_%7B%5Ctheta%7D%28%5Chat+y%7Cx%29%2C%5Cquad+%5Chat+y%3Dargmax_y+P_%7B%5Ctheta%7D%28y%7Cx%29%5Ctag%7B1%7D)
- 即考虑可信度最低的最大概率样本。

###### Margin Sampling 

![[公式]](https://www.zhihu.com/equation?tex=+x%5E%2A_M%3Dargmin_xP_%7Btheta%7D%28%5Chat+y_1%7Cx%29-P_%7B%5Ctheta%7D%28%5Chat+y_2%7Cx%29%2C%5C%5C+%5Ctext+%7Bwhere+%24%5Chat+y_1%24%2C%24%5Chat+y_2%24+are+the+first+and+secnod+most+probale+class+labels%7D%5Ctag%7B2%7D+)

- Least Confidence 没有考虑其他类别的概率。
- 相当于是最可能和第二可能的可信度的差值。

###### Entropy

![[公式]](https://www.zhihu.com/equation?tex=+x%5E%2A_H%3Dargmax_x-%5Csum_iP_%7B%5Ctheta%7D%28y_i%7Cx%29logP_%7B%5Ctheta%7D%28y_i%7Cx%29%5Ctag%7B3%7D+)

- 最大熵

###### 对比

![img](https://pic4.zhimg.com/80/v2-4e7625835bd1e776f44b8ce41f4774ef_720w.jpg)

##### Query-By-Committee

- 相当于模拟committee对不同类别进行投票，考虑`controversial sample`，利用`vote entropy`衡量：
- $x_{VE}^{*} = argmax_x - \sum_{i} \frac{V(y_i)}{C}log\frac{V(y_i)}{C}$
- 其中$C$是Committee Size， $V(y_i)$是投给类别$y_i$的票数

##### Expected Model Change

- **对模型“改变”最大**的标记样本为**“有价值”的样本**
- 这里对模型的改变可以通过**梯度**来体现：
- ![[公式]](https://www.zhihu.com/equation?tex=+x%5E%2A_%7BEGL%7D%3Dargmax_x%5Csum_iP%7B_%5Ctheta%7D%28y_i%7Cx%29%7C%7C%5Cnabla+l_%7B%5Ctheta%7D%28%7BL%7D+%5Ccup+%3Cx%2Cy_i%3E%29%7C%7C%5Ctag%7B5%7D+)
- 其中$L$是模型的loss function （注意是对$\theta$,即模型的**参数**求导，之后可以自由取负号）
  - $L \cup <x, y_i>$是加入了样本$<x, y_i>$之后的loss
  - 这样可以估计出**假如知道了x的类别之后的平均梯度**，进而估计**x**的**expected model change**

##### Expected Error Reduction

- ![[公式]](https://www.zhihu.com/equation?tex=+x%5E%2A_%7Blog%7D%3Dargmin_x%5Csum_iP%7B_%5Ctheta%7D%28y_i%7Cx%29%28-%5Csum_%7Bu%3D1%7D%5EU%5Csum_jP_%7B%5Ctheta%5E%7B%2B%7D%7D%28y_j%7Cx%5E%7B%28u%29%7D%29logP_%7B%5Ctheta%5E%7B%2B%7D%7D%28y_j%7Cx%5E%7B%28u%29%7D%29%29%5Ctag%7B6%7D+)
- 其中U是剩下的所有Unlabeled Data，$\theta^{+}$是假设加入了$<x, y_i>$之后的**新的model**。
- 相当于我们算了假设知道 $<x, y_i>$后新model的entropy，又因为不知道x的真实label 所以x 所有的预测类别都要考虑进去，最后加权平均。

##### Variance Reduction

- 上述Expected Error Reduction需要判断每个样本对模型的“贡献程度”，其“成本”较高，而Variance Reduction其主要思想是**使variance最小**的样本，其“价值”最大。

- 由于训练样本是随机的，因此模型拟合出来的$\hat{f}(X)$也是随机的，可以认为服从某分布。（与f独立）

- Err = Bias + Variance + $\epsilon$

  - 这里的泛化误差Err：就是MSE(均方误差)
  - 注意$Y = f + \epsilon$, Y是数据的标记（存在噪声），f是真实值。
    - $\epsilon$不是常数！也是随机变量

- ![QQMail_0](D:\大三春季学期\UGVR\Meeting2\pic\QQMail_0.png)
  
- 证明见：http://www.inf.ed.ac.uk/teaching/courses/mlsc/Notes/Lecture4/BiasVariance.pdf
  
- > 噪声表达了在当前任务上任何学习算法所能达到的期望泛化误差的下界，即刻画了学习问题本身的难度。
  >
  > 偏差度量了学习算法的期望预测与真实结果的偏离程度，即刻画了学习算法本身的拟合能力；
  >
  > 方差度量了同样大小的训练集的变动所导致的学习性能的变化，即刻画了数据扰动所造成的影响；


##### Density-Weighted Methods

- 上述Uncertain Strategy 关注的主要是**单个样本**对模型的提升程度，但实际上，很多“模糊”的样本可能是outliers 或 噪声，关注这些样本并不会对模型有很大帮助：
- ![img](D:\大三春季学期\UGVR\Meeting2\pic\v2-a9ec79e55673f8ee6bd5a29b06e17825_720w.jpg)

<center><font face="Times New Roman" size="3">Outliers</font></center>

- 因此，我们在考虑individual时同时还需关注**整体样本**的分布，故提出了Density-Weighted Methods

- $x_{ID}^* = argmax_x \Phi_A(x) * (\frac{1}{U} \overset{U}{\underset{u=1}{\sum}}sim(x, x^{u}))^\beta$
  - 期中$\Phi_A(x)$代表由Uncertain Sampling or QBC approach所确定的样本x的information, 后面是考虑的x与整体的相似度。

## Math

### Gaussian Process：

- https://www.zhihu.com/question/46631426?sort=created
- NOTE:
  - **一个样本$x_i$是一个随机变量**
- ![img](.\pic\8a8392925fee69d77ba8ab5e43af0888_1440w.jpg)
- ![preview](.\pic\f990560d014ade608c88ec796aaf2bab_r.jpg)
- ![img](.\pic\526b6427bb324daab5988346ff92e376_1440w.jpg)
- ![img](.\pic\a4077849c61b0c7a901a570f2c47aaf4_1440w.jpg)
- ![img](.\pic\c3e38f3dd0dca81bdea3b64481e7d41d_1440w.jpg)

#### Covariance Function

- http://evelinag.com/Ariadne/covarianceFunctions.html
- The key idea of Gaussian Process is simple: is input data is similar to some training data, the the predicted label should similar to the training label, too. (So given limited $(x_i, yi)$, we can predict any $y^*$ from $x^*$ based on its distance from training data.)
- The covariance function represents this kind of distance or similarity.
  - e.g. : **Squared exponential kernel**
  - $k(x_i,x_j)=\sigma^2 exp(\frac{−(x_i−x_j)^2}{2l^2})+\delta_{ij}\sigma^2_{noise}$


### Normal Distribution

- $f(x) = \frac{1}{\sqrt{2\pi\sigma^2}}exp(-\frac{(x-\mu)^2}{2\sigma^2})$

### Bayes' Update Formula

- $\omega$：模型参数；$D$: data set;  $N$: New data set
- $P(\omega | D, N) = \frac{P(N | \omega, D)*P(\omega | D)}{P(N|D)}$

- 注意$P(\omega|D)$其实就等于$P(\omega)$
- Bayes回归：
  - $\int P(y|\omega,D,x)*P(\omega|D)d\omega$

### Laplace Approximation

- Preliminary: works for functions in the class of $\mathcal{L}^2$, which is:
  - $\int f^2(x)dx < \infty$
- **The general idea is to take a well-behaved uni-modal function (单峰函数) and approximate it with a Normal density function**
- ![img](.\pic\unnamed-chunk-3-1.png)
  - Rough Approximation：$\int_{x_0-\epsilon/2}^{x_0+\epsilon/2}f(x)dx \approx f(x_0)\epsilon$

#### Laplace Approximation

- Suppose $f(x)\in \mathcal{L}^2$, which achieves maximum at $x_0$, we want to compute $\int_a^bf(x)dx$.
- Let $h(x) = log f(x)$, so we have:
  - $\int_a^bf(x)dx = \int_a^bexp(h(x))$
  - Use Taylor series approximation of $h(x)$ around point $x_0$ (maximum where $h'(x_0) = 0$, since $h(x)$ is a monotonic(单调的) transformation of $f(x)$).
  -  $\int_a^bexp(h(x))dx \approx \int_a^bexp(h(x_0) + h'(x_0)(x - x_0) + \frac{1}{2}h''(x_0)(x-x_0)^2)dx$
  - $ = \int_a^bexp(h(x_0) + \frac{1}{2}h''(x_0)(x-x_0)^2)dx$
  - $= exp(h(x_0))\int_a^bexp(-\frac{1}{2} \frac{(x-x_0)^2}{-h''(x_0)^{-1}})$
  - $= \exp \left(h\left(x_{0}\right)\right) \sqrt{\frac{2 \pi}{-h^{\prime \prime}\left(x_{0}\right)}} \int_{a}^{b} \varphi\left(x | x_{0},-h^{\prime \prime}\left(x_{0}\right)^{-1}\right) d x$
  - $= \exp \left(h\left(x_{0}\right)\right) \sqrt{\frac{2 \pi}{-h^{\prime \prime}\left(x_{0}\right)}}\left[\Phi\left(b | x_{0},-h^{\prime \prime}\left(x_{0}\right)^{-1}\right)-\Phi\left(a | x_{0},-h^{\prime \prime}\left(x_{0}\right)^{-1}\right)\right]$
    - Where $\Phi(x|\mu,\sigma^2)$ denotes the cumulative distribution function of Normal distribution, and $\phi$ denotes the density function.
  - If $a=-\infty$ and $b = \infty$, we get:
    - $\int_a^bf(x)dx = exp(h(x_0))\sqrt{\frac{2\pi}{-h''(x_0)}}$

#### Computing the Posterior Mean

- Assume the parameter $\theta$ has a prior distribution $p(\theta)$, and we get new data $D$, we want to calculate the posterior mean:
  - $\mathbb{E}_p(\theta) = \int \theta p(\theta|D)d\theta = \int\theta\frac{p(D|\theta)p(\theta)}{p(D)}d\theta = \frac{\int\theta p(D|\theta)p(\theta)d\theta}{p(D)} = \frac{\int\theta p(D|\theta)p(\theta)d\theta}{\int p(D|\theta)p(\theta)d\theta}$ 
  - Let $h(\theta) = logf(y|\theta)\pi(\theta)$, because $h(\theta)$ is simply a monotonic transformation of a function proportional to the posterior density, we know that $h(\theta)$ achieves its maximum at the *posterior mode* ( 后验分布的众数，也就是概率密度最高的那个点）.
  - Let $\hat{\theta}$ denotes the mode of posterior $p(\theta|D)$, then use the Laplace Approximation we can get:
  - $\begin{aligned}
    \int \theta p(\theta | D) d x \approx & \frac{\int \theta \exp \left(h(\hat{\theta})+\frac{1}{2} h^{\prime \prime}(\hat{\theta})(\theta-\hat{\theta})^{2}\right) d \theta}{\int \exp \left(h(\hat{\theta})+\frac{1}{2} h^{\prime \prime}(\hat{\theta})(\theta-\hat{\theta})^{2}\right) d \theta} \\
    =& \frac{\int \theta \exp \left(\frac{1}{2} h^{\prime \prime}(\hat{\theta})(\theta-\hat{\theta})^{2}\right) d \theta}{\int \exp \left(\frac{1}{2} h^{\prime \prime}(\hat{\theta})(\theta-\hat{\theta})^{2}\right) d \theta} \\
    =& \int \frac{\int \theta \sqrt{\frac{2 \pi}{-h^{\prime \prime}(\hat{\theta})}} \varphi\left(\theta | \hat{\theta},-h^{\prime \prime}(\hat{\theta})^{-1}\right) d \theta}{\int \sqrt{\frac{2 \pi}{-h^{\prime \prime}(\hat{\theta})}} \varphi\left(\theta | \hat{\theta},-h^{\prime \prime}(\hat{\theta})^{-1}\right) d \theta} \\
    =& \hat{\theta}
    \end{aligned}$
    - Note: do not be silly, if $\theta \sim f(\theta)$, where $f(\theta)$ is the probability density  function, then $\int\theta f(\theta)d\theta = \mu_{\theta}$

### Entropy

#### Shannon Entropy (Information Entropy)

- $H(X) = -\sum\limits_{i=1}^{N}p_ilogp_i$, and the information we gain when $X=x_i$ is $-logp_i$.

#### KL-divergence (Relative Entropy)

- $D_{KL}(P||Q) = \mathbb{E}_{X \sim P}[log\frac{P(X)}{Q(X)}] = \mathbb{E}_{X\sim P}[logP(X)-logQ(X)]$

- Intuition:

  - Design an encoding such that information from $Q(X)$ has the **minimal encoding length**,  then send information from $P(X)$, the **additional encoding length** used than using optimal encoding for $P(X)$ is $D_{KL}(P||Q)$.

  - The **optimal** encoding is: for information with probability $p_i$, the optimal encoding length is $-logp_i$, 

  - So when send information from $P(X)$ using optimal encoding for $Q(X)$, additional encoding length (or additional information) expectation is $\int P(x) [-logQ(x) - (-logP(x))]dx$

  - > Gibbs' inequality:
    >
    > Given $\sum\limits_{i=1}^{N}p_i = 1$ , $\sum\limits_{i=1}^{N}q_i = 1$ and $p_i,q_i \in (0,1]$:
    >
    > $-\sum_{i=1}^{n} p_{i} \log p_{i} \leq-\sum_{i=1}^{n} p_{i} \log q_{i}$, if and only if $p_i = q_i, \forall i$

#### 