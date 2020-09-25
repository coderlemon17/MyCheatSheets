# Karush-Kuhn-Tucker (KKT)

## 等式约束优化

- $$
  \min f(x)\\
  s.t.\,g(x) = 0
  $$

- `Lagrange乘数法`将等式约束优化转为等价无约束优化问题
  $$
  \min\limits_{x,\lambda}L(x,\lambda)=f(x)+\lambda g(x)
  $$

- $$
  \nabla_xL=\frac{\partial L}{\partial x} = \nabla_x f+\lambda\nabla_x g = 0 \quad(1)\\
  \nabla_\lambda L = \frac{\partial L}{\partial \lambda} = g(x) = 0\quad (2)
  $$

  - (1)为**定常方程式** : 可以认为在$g(x)=0$这样一个超平面上由于g(x)始终为恒值, 所以g(x)的梯度始终垂直于这个超平面. 而f(x)取极小值时其梯度方向也会垂直于这个超平面. ($\lambda$的值可正可负)

## 不等式约束优化

- $$
  \min f(x)\\
  s.t.\,g(x) \leq 0 \text{ (可行域/feasible region)}
  $$

- 满足条件的$x$分为:

  - 内部解: $g(x)<0$, 约束条件无效, 等价于$\lambda=0, \nabla f=0$
  - 边界解: $g(x)=0$, 且我们希望最小化$f$, 其极小值点一定在可行域外部, 而可行域外部$g(x)>0$, 故$\nabla f$和$\nabla g$共线反向. 即$\nabla_x f + \lambda\nabla_x g = 0$, 且$\lambda\geq0$, 此性质称为**对偶可行性**.

- 不论是内部解还是边界解, $\lambda g(x) = 0$恒成立,这称为**互补松弛性**.

- 故最佳解的条件包括: 定常方程式, 原始可行性, 对偶可行性和互补松弛性:

  - $$
    \nabla_x L(x,\lambda) = \nabla f+\lambda\nabla g = 0\\
    g(x)\leq0\\
    \lambda\geq0\\
    \lambda g(x)=0
    	
    $$

- 此条件称为`KKT`条件

## 推广

- 若推广到多个约束等式与不等式的情况

  - $$
    \min f(x)\\
    s.t.\,g_j(x) = 0,\, j= 1,\cdots,m\\
    h_k(x)\leq0,\,k=1,\cdots,p
    $$

- 定义`Lagrangian`函数: 

  - $L(x,\{\lambda_j\}, \{\mu_k\}) = f(x)+\sum\limits_{j=1}^m\lambda_jg_j(x) + \sum\limits_{k=1}^p\mu_kh_k(x)$.

- 相应的`KKT`条件

  - $$
    \nabla_xL = 0\\
    g_j(x)=0,\,j=1,\cdots,m\\
    h_k(x)\leq0,\,k=1,\cdots,p\\
    \mu_k\geq0\\
    \mu_kh_k(x)=0,\,k=1,\cdots,p
    $$


# Lagrange Duality

## The **primary** optimization problem:

$$
\min_x f(x)\\
s.t.\,g_i(x)\leq 0,\,i=1,\cdots,k\\
h_j(x)=0,\,j=1,\cdots,l\\
$$

- We can define generalized Lagrangian $L(x,\alpha,\beta)=f(x)+\sum\limits_{i=1}^k\alpha_ig_i(x)+\sum\limits_{j=1}^l\beta_jh_j(x)$, and $\theta_{\mathcal{P}}(x) = \max\limits_{\alpha,\beta:\alpha_i\geq0} L(x,\alpha,\beta)$.
  - We can verify that $\theta_{\mathcal{P}}(x) = \left\{ \begin{aligned}&f(x)\text{ if }x\text{ satisfies primal constraints}\\&\infty\text{ otherwise}\end{aligned} \right.$
- So the **primal problem** can be transferred to $\min\limits_x\theta_{\mathcal{P}}(x)=\min\limits_x\max\limits_{\alpha,\beta:\alpha_i\geq0} L(x,\alpha,\beta)$. And $p^*=\min\limits_x\theta_{\mathcal{P}}(x)$, which is the *value* of the primal problem.

## The dual optimization problem

- We define $\theta_{\mathcal{D}}(\alpha,\beta) = \min\limits_x L(x,\alpha,\beta)$, and the **dual optimization problem** is $\max\limits_{\alpha, \beta: \alpha_i\geq0}\theta_{\mathcal{D}}(\alpha,\beta) = \max\limits_{\alpha, \beta: \alpha_i\geq0}\min\limits_x L(x,\alpha,\beta)$ . And we call $d^*=\max\limits_{\alpha, \beta: \alpha_i\geq0}\theta_{\mathcal{D}}(\alpha,\beta)$ the value of the dual problem.

## The primary problem and the dual problem

- (鸡头比不上凤尾): $d^*=\max\min \leq \min\max = p^*$.
- Under certain **conditions** we will have $d^*=p^*$, where we can transfer the primary problem to its dual problem.
  - <img src="D:\Learn\MyCheatSheets\Math\pic\image-20200921151123554.png" alt="image-20200921151123554" style="zoom:60%;" />
  - ![image-20200921151159627](D:\Learn\MyCheatSheets\Math\pic\image-20200921151159627.png)

# SVM

- When we choose $\hat\gamma = 1$, the optimization problem becomes:

  - $$
    \min\limits_{w,b} \frac{1}{2}||w||^2\\
    s.t.\, y^i(w^Tx^i+b) \geq 1,\,i=1,\cdots,m
    $$

  - Which is a problem with **convex quadratic objective** and **only linear constraints**.

- This can be also wrote as:

- $$
  \min\limits_{w,b} \frac{1}{2}||w||^2\\
  s.t.\, g_i(w) = 1 - y^i(w^Tx^i+b) \leq 0,\,i=1,\cdots,m
  $$

  - Note that from **KKT dual complementarity condition**, we will have $\alpha_i>0$ only for training examples that have functional margin exactly equal to one; others $\alpha_i=0$.
    - <img src="D:\Learn\MyCheatSheets\Math\pic\image-20200921154205176.png" alt="image-20200921154205176" style="zoom:50%;" />
    - Those three points are called the **support vectors** in this problem. (The number of support vectors are much smaller than the size of training set.)

-  To write the **dual form** of the problem, we first write $L(w,b,\alpha) = \frac{1}{2}||w||^2+\sum\limits_{i=1}^m\alpha_i[1-y^i(w^Tx^i+b)]$. Then to get $\theta_\mathcal{D}(w,b)=\min\limits_{w,b}L(w,b,\alpha)$:

  - $\nabla_wL(w,b,\alpha)=0\rightarrow w =\sum\limits_{i=1}^m\alpha_iy^ix^i$.
  - $\nabla_bL(w,b,\alpha)=0\rightarrow\sum\limits_{i=1}^m\alpha_iy^i=0$.

- After we plug these conditions back in, we get:

  - $L(w,b,\alpha)=\sum\limits_{i=1}^m\alpha_i-\frac{1}{2}\sum\limits_i\sum\limits_jy^iy^j\alpha_i\alpha_j<x^i,x^j>$

  - And the dual problem is (*we can prove it has the same solution as the primary problem*)

  - $$
    max_\alpha\, W(\alpha)=\sum\limits_{i=1}^m\alpha_i-\frac{1}{2}\sum\limits_i\sum\limits_jy^iy^j\alpha_i\alpha_j<x^i,x^j>\\
    s.t.\,\alpha_i\geq0,\,i=1,\cdots,m\\
    \sum\limits_{i=1}^m\alpha_iy^i=0
    $$

- If we solve the dual problem, we can **directly get corresponding** $w^*,b^*$ from $\alpha^*$:

  - $w^* =\sum\limits_{i=1}^m\alpha^*_iy^ix^i$, $b^*=-\frac{\max_{i:y^i=-1}w^{*T}x^i + \min_{i:y^i=1}w^{*T}x^i}{2}$ 
  - And when doing prediction: $w^{*T}x+b = \sum\limits_{i}\alpha^iy^i<x^i,x>+b$. Note that all $\alpha_i$ **are zero** except for support vector machines.

# Bias-Variance trade-off

![image-20200922104515679](D:\Learn\MyCheatSheets\Math\pic\image-20200922104515679.png)

![QQMail_0 (D:\Learn\MyCheatSheets\Math\pic\QQMail_0 (3).png)](C:\Users\lemon\Downloads\QQMail_0 (3).png)

- <img src="D:\Learn\MyCheatSheets\Math\pic\image-20200922104606622.png" alt="image-20200922104606622" style="zoom:50%;" />