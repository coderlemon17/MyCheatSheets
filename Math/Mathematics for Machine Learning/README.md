# Mathematics for Machine Learning

# Mathematic Foundations

## 1. Introduction and Motivation

> Data, model and learning.
>
> The goal of ML is to design general-purpose methodologies to **extract valuable patterns** from **data**.

### 1.1. Finding Words for Intuitions

<img src=".\pic\image-20210226133003505.png" alt="image-20210226133003505" style="zoom: 50%;" />

`Foundations and four pillars of ML: regression; dimension reductin; density estimation; classification`

## 2. Linear Algebra

- When formalize intuitive concepts, a common approach is to construct a set of *object* and a set of *rules*.

> In general, vectors are special objects that can be added together and multiplied by scalars to produce another object of the same kind. 
>
> E.g. Geometric vectors; **Polynomials**; Audio signals; Elements of $\mathbb{R}^n$.

<img src=".\pic\image-20210227154052103.png" alt="image-20210227154052103" style="zoom: 67%;" />

~~X 2.1. Systems of Linear Equation~~

### 2.2. Matrices

<font color="red">Matrices是matrix的复数; matric是尺度/标尺</font>

#### 2.2.1. Matrix Addition and Multiplication

- Matrix multiplication (*dot product*) $\Leftrightarrow$ Element-wise production i.e. $c_{ij}=a_{ij}b_{ij}$ (*Hadamard product*)
- Matrix satisfies: association (结合律: $A(BC)=(AB)C$), distributivity (分配律: $A(B+C)=AB+AC$).

### 2.2.2. Inverse and Transpose

- 矩阵可逆: `regular/invertible/nonsingular` $\Leftrightarrow$ `singular/noninvertible`
  - 虽然矩阵乘法并不满足交换律, 但是$AA^{-1}=A^{-1}A=I$.
- Properties: <img src=".\pic\image-20210227155816135.png" alt="image-20210227155816135" style="zoom: 50%;" />

- If $A$ is invertible, then $(A^{-1})^T=(A^T)^{-1}:=A^{-T}$.

~~X 2.2.3. Multiplication by a Scalar~~

~~X 2.2.4 Compact Representations of Systems of Linear Equations~~

### 2.3 Solving Systems of Linear Equations

#### 2.3.1 Particular and General Solution

- General solution to $Ax=b$ => special solution to $Ax=b$ + general solution to $Ax=0$.

#### 2.3.2 Elementary Transformations

- Elementary transformations: <img src=".\pic\image-20210227160737113.png" alt="image-20210227160737113" style="zoom:50%;" />\
- `Remark`:
  - Pivot: first nonzero coefficient from the left of each row.
  - Row-Echelon Form: 1) 零行在非零行下面; 2) 非零行的pivot严格在上一行pivot的右边.
  - Reduced Row Echelon Form: 1) 是Row-Echelon Form; 2) Pivot都是1; 3)Pivot是该列唯一的非零元素.
  - Basic and free variables: The variables corresponding to the **pivots** in the *row-echelon form* are called **basic variables** and the other variables are **free variables**.
    - 利用Pivot所在列线性组合成$b$是一种找$Ax=b$特解的方便解法.
  - When transform $A$ into reduced row echelon form, the key to find $Ax=0$ is to **express the non-pivot columns** with **pivot columns**.
    - And the **dimension** of $Ax=0$'s solution equals to the number of non-pivot columns. So express **every non-pivot columns** to get the entire solution space.

#### 2.3.3 The Minus-1 Trick

- For a reduced row-echelon matrix $A\in\mathbb R^{k\times n}$, extend it to an $n\times n$ matrix $\tilde A$ by adding $n − k$ rows of the form:$[0,\cdots, 0, -1, 0, \cdots, 0]$
  - s.t. the diagonal of the augmented matrix $\tilde A$ contains either $1$ or $-1$.
  - <font color="red">Then the columns of $\tilde A$ that contain the −1 as pivots are solutions of the homogeneous equation system $Ax = 0$.</font>

- E.g.

<img src=".\pic\image-20210227163515644.png" alt="image-20210227163515644" style="zoom:50%;" />

#### 2.3.4 Algorithms for Solving a System of Linear Equations

- *Moore-Penrose pseudo-inverse*:
  - When $A$ is invertible: <img src=".\pic\image-20210228101241337.png" alt="image-20210228101241337" style="zoom: 33%;" />
  - `Remark`: 
    - $x=(A^TA)^{-1}A^Tb$ is also the solution to the minimum norm least-square solution $||Ax-b||$.
    - `Proof`: It's easy to know that for minimum solution, $Ax$ should be $b$'s orthogonal projection to $Col(A)$ ($A$的列空间). And $A^TAx=A^Tb\Rightarrow A^T(Ax-b)=0\Rightarrow (Ax-b)和Col(A)正交\Rightarrow Ax为b在Col(A)上的正交投影$.

- 线性方程的直接解法: 高斯消元法
- 线性方程的迭代解法: $x^{k+1}=Cx^k+d$. e.g. Jacobi; G-S, SOR.

### 2.4. Vector Spaces

#### 2.4.1. Groups

> Generally, group is a set of elements and operations that keep some structure of the set intact.

- Formal definition of *group*:
  - <img src=".\pic\image-20210228102823162.png" alt="image-20210228102823162" style="zoom: 50%;" />
  - `Remark`: the inverse and neutral elements are just defined w.r.t. operation $\otimes$.
  - Additionally: if $\forall x,y\in\mathcal G, x\otimes y = y\otimes x$, then $G =(\mathcal G,\otimes)$ is an *Abelian group* (commutative).
    - E.g. the general linear group (regular matrix + matrix multiplication) is a group but not Abelian group.

#### 2.4.2. Vector Spaces

<img src=".\pic\image-20210304101911015.png" alt="image-20210304101911015" style="zoom:50%;" />

- We consider addition $+$ as inner operation and scaling $\cdot$ as outer operation.
- $a^Tb\in \mathbb R$: inner/scalar/dot product; $ab^T\in\mathbb R$: outer product.

#### 2.4.3. Vector Subspace

- $U=(\mathcal U, +, \cdot) \subseteq V=(\mathcal V, +, \cdot)$, if:
  - $U\subseteq V$
  - $\mathcal U \neq \varnothing$, and particularly: $\bf{0}\in\mathcal U$.
  - Closure of $U$:
    - <img src=".\pic\image-20210228105648127.png" alt="image-20210228105648127" style="zoom:50%;" />

- `Remark`:
  - The intersection of arbitrarily many subspaces is a subspace itself.
  - The solution set of a homogeneous system of linear equations $Ax=0$ is a subspace of $\mathbb R^n$.

~~2.5. Linear Independence~~

### 2.6. Basis and Rank

#### 2.6.1. Generating Set and Basis

- *Generating sets:*
  - For a vector space $V$, if all its vectors can be expressed as a linear combination of $\mathcal A$, then $\mathcal A$ is the generating set of $V$. And the set of all linear combination of vectors in $\mathcal A$ is the *span* of $\mathcal A$: $span(A)$.
- *Basis*:
  - A basis is a **minimal** generating set and a maximal **linearly independent** set of vectors.
  - $dim(V)$: the number of basis vectors. There's no unique basis, but the number is fixed for given vector space.
- Finding the maximal L.I. vector group in the generating set is to find the basis.

#### 2.6.2. Rank

$A\in\mathbb R^{m\times n}$

- 列空间: $U\subseteq\mathbb{R}^m$: image / range $\Leftrightarrow$ 行空间: $W\subseteq\mathbb R^n$.
- $Ax=b$ can be solved if and only if $rk(A)=rk(A|b)$, where $A|b$ is the augmented system.
- 零空间: $dim(N(A))= n - rk(A)$: kernel or null space.
- full rank: $rk(A)=\min(m,n)$ $\Leftrightarrow$ rank deficient: $rk(A)< \min(m,n)$.

### 2.7. Linear Mappings

- Linear mappings:
  - <img src=".\pic\image-20210228133945377.png" alt="image-20210228133945377" style="zoom: 50%;" />

- Injective; Surjective; Bijective:
  - <img src=".\pic\image-20210228134611067.png" alt="image-20210228134611067" style="zoom: 50%;" />
- <span id='automorphism'>Special linear mappings:</span>
  - <img src=".\pic\image-20210228135024270.png" alt="image-20210228135024270" style="zoom:33%;" />
    - <img src=".\pic\image-20210228135107131.png" alt="image-20210228135107131" style="zoom: 33%;" />
- `Remark`:
  - For linear mapping $\Phi, \Psi$, $\Phi\text{o}\Psi$ is also linear mapping.

#### 2.7.1. Matrix Representation of Linear Mappings

- **Coordinate:**
  
  - Any basis defines a valid coordinate system. But to acquire coordinate, we need to define **ordered basis**, which accordingly defines the coordinates.
    - For **ordered basis $\mathcal B=(\bf{b}_1, \cdots, \bf b_n)$**, $\bf x	= \alpha_1\bf b_1+\cdots+\alpha_n\bf b_n$ so $\bf\alpha=\begin{bmatrix}\alpha_1\\\vdots\\\alpha_n\end{bmatrix}$ is the *coordinates / coordinate vector / coordinate representation* of $\bf x$ w.r.t. $\mathcal B$.
  - `Remark`:
    - $(\bf{b}_1, \cdots, \bf b_n)$: ordered basis.
    - $\{\bf{b}_1, \cdots, \bf b_n\}$: unordered basis.
    - $[\bf{b}_1, \cdots, \bf b_n]$: matrix.
  
- **The connection between matrices and <font color="red">linear mappings</font>**: (Transformation Matrix):
  - <img src=".\pic\QQMail_0 (4).png" alt="QQMail_0 (4)" style="zoom:30%;" />
  - For linear mapping between vector spaces / basis:
    - $(\bf \Phi(b_1), \cdots, \Phi(b_n)) = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi$
      
      - 记法: 你试图去表示$b$, 所以是把向量从$b$的空间里mapping到$c$的空间里.
  - And the relationship between coordinates is:
    
      - $
        \begin{aligned}
        &(\bf \Phi(b_1), \cdots, \Phi(b_n)) = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi \\&\Rightarrow \Phi[(\bf b_1, \cdots, \bf b_n)\bf x] = (\bf \Phi(b_1), \cdots, \Phi(b_n))x  = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi \bf x \end{aligned}$ $\Rightarrow$ 在像空间$c$下的coordinate是$\tilde x=A_\Phi x$
  - `Note:`the transformation matrix of linear mapping $\Phi$ is $A$ under canonical basis equals to <font color="red">*$\Phi$ maps any coordinate $x$ to $Ax$*</font>.
  
- **Linear mapping matrices w.r.t. basis change**: 
  - 在canonical basis下某transformation matrix $A=\begin{bmatrix}2, 1\\1, 2\end{bmatrix}$. 请问在新的基$\begin{bmatrix}1\\1\end{bmatrix}$, $\begin{bmatrix}1\\-1\end{bmatrix}$下的矩阵为?
    - **注意这里的transformation matrix是某线性变换在canonical基下对应的矩阵**, we consider how basis change effects the matrices of linear mappings.
    - Denote canonical 和 新的基之间的变换矩阵 as $B_\Phi$: i.e. $I = \begin{bmatrix}&1, &1\\&1, &-1\end{bmatrix}\cdot B_\Phi$.
      - <font color="red">Basis change can also be perceived as linear mapping.</font>
      - $\hat x=Ax\Rightarrow \Phi(\hat x) = \Phi(Ax) \Rightarrow B_\Phi\hat x = B_\Phi AB_\Phi^{-1}\ B_\Phi x \Rightarrow \hat y = B_\Phi AB_\Phi^{-1} y$:
      - 所以$A$在新的基下的线性变换矩阵为$\tilde A = B_\Phi AB_\Phi^{-1}$, 结果为$\begin{bmatrix}3, 0\\0, 1\end{bmatrix}$, 为对角阵.
        - I.e. $A=B_\Phi^{-1}\tilde AB_\Phi$.
      - **故如果要计算某向量对于A的线性变换(的若干次幂), 最好的方法是先转换到新的基下进行运算, 之后再转换回去.**

#### 2.7.2. Basis Change

> Don't confuse **basis** with **coordinates/vectors**.

- `Remark`:
  - Basis change: the vector space stays the same, we just use different basis, and the coordinates change.
    - Can be perceived as a special linear mapping. (automorphism)
    - $(\bf b_1, \cdots, b_n) = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi$
  - Linear mapping: the vector space doesn't necessarily stay the same, we map the basis to new basis, and the coordinate change. 
    - $(\bf \Phi(b_1), \cdots, \Phi(b_n)) = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi$.
    - In common cases, if we only say linear transformation $\Phi$ over ordered basis $(\bf b_1, \cdots, b_n)$, we refer to mapping $\Phi: (\bf b_1, \cdots, b_n)\mapsto(\bf b_1, \cdots, b_n)$
- ,定理:
  - <img src=".\pic\image-20210228162427422.png" alt="image-20210228162427422" style="zoom:50%;" />
  - Intuitive interpretation:
    - <img src=".\pic\image-20210228162533422.png" alt="image-20210228162533422" style="zoom:50%;" />
- *Equivalent* and *Similar*:
  - <img src=".\pic\image-20210228162648463.png" alt="image-20210228162648463" style="zoom:40%;" />

#### 2.7.3. Image and Kernel

- <img src=".\pic\image-20210304102620030.png" alt="image-20210304102620030" style="zoom: 50%;" />
- `Remark`:
  - Null space is **NERVER** empty, for that $\Phi(\bf 0_V)=\bf 0_W$ always holds.
  - $\text{Im}(\Phi)\subseteq W$ is a subspace of $W$; $\text{ker}(\Phi)\subseteq V$ is a subspace of $V$;
  - Consider $\Phi:\mathbb R^n\rightarrow \mathbb R^m, x\mapsto Ax, A\in\mathbb R^{m\times n}$.
    - $\text{Im}(\Phi)=\text{span}[a_1,\cdots,a_n]\subseteq \mathbb R^m$. Image/column space is subspace of $\mathbb R^m$, and $\text{rk}(A)=\text{dim}(\text{Im}(\Phi))$
    - Kernel space is a subspace of $\mathbb R^n$. 
- **Rank-Nullity Theorem**:
  - <img src=".\pic\image-20210304103536186.png" alt="image-20210304103536186" style="zoom:50%;" /> $\Leftarrow$ 即非主列的个数+主列的个数=列数.
  - `Remark`:
    - If $\dim (\text{Im}(\Phi)) < \dim(V)$, then $\text{ker}(\Phi)$ is non-trivial, i.e. it contains more than $\bf 0_V$ / $\dim(\text{ker}(\Phi))\geq1$ / $A_\Phi(x)=\bf 0$ has infinitely solutions.
    - If  $\dim(V)=\dim(W)$, then $\Phi$ is **injective**, **surjective**, **bijective**.

### 2.8. Affine Spaces

> Affine space: spaces that are offset from the origin, which means they are no longer vector subspace. (vector space + offset.)

#### 2.8.1. Affine Subspaces

<img src=".\pic\image-20210304142917434.png" alt="image-20210304142917434" style="zoom: 50%;" />

- `Remark`:
  - If $x_0\notin U$, then the affine subspace $L$ excludes $\bf 0$, and thus is not a (linear) subspace (vector subspace). of $V$.
  - *Parametric equation:*
    - Consider a $k$-dimensional affine space $L=x_0+U$ of $V$. If $(b_1,\cdots,b_k)$ is an ordered basis of $U$, then every $x\in L$ can be uniquely described as:
      - $\bf x= \bf x_0 + \lambda_1\bf b_1 + \cdots + \lambda_k\bf b_k$, where $\lambda_1,\cdots,\lambda_k\in\mathbb R$. It's called the *parametric equation* of $L$ with directional vectors $\bf b_1,\cdots,\bf b_k$ and parameters $\lambda_1,\cdots,\lambda_k$.
  - Examples of affine space:
    - 1-dimensional: line; 2-dimensional: plane
      - In $\mathbb R^n$, the $n-1$-dimensional affine subspace are called ***hyperplanes***.
  - The solution of $Ax=b$ is either the empty set or an affine subspace of $\mathbb R^n$ of dimension $n-\text{rk}(A)$.

#### 2.8.2. Affine Mappings

- Affine Mappings:
  - Given two vector space $V,W$, a linear mapping $\Phi: V\mapsto W$, and $\bf a\in W$, then mapping $\phi$:
    - $\phi:V\mapsto W$; $\bf x\mapsto \bf a + \Phi(x)$ is an *affine mapping* from $V$ to $W$. Vector $\bf a$ is called *translation vector* of $\phi$,
- `Remark`:
  - <img src=".\pic\image-20210304144211094.png" alt="image-20210304144211094" style="zoom:67%;" />



## 3. Analytic Geometry

<img src=".\pic\image-20210305110331427.png" alt="image-20210305110331427" style="zoom:50%;" />

<center><font color="black" face="Times New Roman">Mindmap of this chapter.</font></center>

### 3.1. Norms

> The length of the vector.

- <img src=".\pic\image-20210305110623430.png" alt="image-20210305110623430" style="zoom:50%;" /> 

### 3.2. Inner Products

> Allow some intuitive geometrical concepts, such the length or the angle or the distance between vectors.

#### 3.2.1. Dot Products

*Scalar product / dot product*: $\bf{x}^T \bf{y}$$=\sum\limits_{i=1}^n x_i y_i$.

#### 3.2.2. General Inner Products

- Prerequisite:
  - *Bilinear mapping $\Omega$*: a linear mapping with two arguments, and it's linear in each argument.
    - For $\bf x,y,z\in$ vector space $V$ and $\lambda,\psi\in\mathbb R$ that: <img src=".\pic\image-20210305135948468.png" alt="image-20210305135948468" style="zoom:50%;" />
  - *Symmetric* and *positive definite*:
    -  <img src=".\pic\image-20210305140030165.png" alt="image-20210305140030165" style="zoom: 50%;" /> 
- *Inner product*:
  - <img src=".\pic\image-20210305140110184.png" alt="image-20210305140110184" style="zoom:50%;" /> 

#### 3.2.3. Symmetric, Positive Definite Matrices

> The symmetric positive definite matrices is actually defined via the inner product.

- For vector space $V$ with inner product and an ordered basis $\mathcal B=\bf(b_1,\cdots,b_n)$ of $V$: (Note: inner product is bilinear mapping)
  - <img src=".\pic\image-20210305141240766.png" alt="image-20210305141240766" style="zoom: 50%;" />, where $A_{ij}:=<\mathbf b_i,\mathbf b_j>$ and $\hat x$, $\hat y$ are the coordinates of $\mathbf x$ and $\bf y$ w.r.t. basis $\mathcal B$.
  - Which implies that **that the inner product $<.,\ .>$is uniquely determined through $A$**.
    - Therefore, according to the positive definiteness of the inner product: $\forall \mathbf x\in V\backslash \{\mathbf 0\}:\mathbf x^TA\mathbf x>0$.
    - Accordingly we can define symmetric, positive/semipositive definite matrices.
- `Remark`:
  - <img src=".\pic\image-20210305141922364.png" alt="image-20210305141922364" style="zoom:50%;" /> 
  - If $A$ is symmetric and positive definite, then:
    - The null space (kernel) of $A$ consist only of $\mathbf 0$ $\mathbf x^tA\mathbf x > 0$ if $\mathbf \neq 0$; the diagonal elements $a_{ii}$ of $A$ are always positive ($e_i^TAe_i>0$).

### 3.3. Lengths and Distances

- Any **inner product** introduces a **norm**: $||x||:=\sqrt{<x,x>}$; but **NOT** every norm is induced by an inner product, e.g. Manhattan norm.
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305143909361.png" alt="image-20210305143909361" style="zoom:50%;" /> 
- *Distance and Metric*:
  - $d(x,y):=||x-y||=\sqrt {<x-y,x-y>}$ is called *distance*, and mapping <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305144028326.png" alt="image-20210305144028326" style="zoom:50%;" /> is called *metric*.
    - **Metric $\neq$ Metrices**.
  - Note that metric doesn't always require inner product, a **norm** is sufficient.
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305144219825.png" alt="image-20210305144219825" style="zoom:50%;" /> 

### 3.4. Angles and Orthonormal

> Using inner product, by Cauchy-Schwarz inequality we can define the **angle $\omega$** in inner product spaces between vectors.
>
> <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305151733963.png" alt="image-20210305151733963" style="zoom:33%;" /> <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305151741869.png" alt="image-20210305151741869" style="zoom:33%;" />

-  *Orthogonal* and *orthonormal*:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305151843869.png" alt="image-20210305151843869" style="zoom:50%;" /> 
- *Orthogonal Matrix*:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305151940838.png" alt="image-20210305151940838" style="zoom:50%;" /> 
  - Which means: $A^T=A^{-1}$.
  - Transformations (linear mapping) with orthogonal matrices **preserve distances and angle.**
    - Actually they define **rotations** (with the possibility of [flips](翻转)).

### 3.5. Orthonormal Basis

- *Orthonormal basis* (ONB):
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210305152457811.png" alt="image-20210305152457811" style="zoom:50%;" />.
  - If only (3.33) satisfies, it's called orthogonal basis.
- For any basis, we can conduct ***Gram-Schmidt process***:
  - It's general idea is:
    - $b_1$: $b_1'=b_1$
    - Eliminate $b_2$'s projection on $b_1$: $b_2' = b_2-\frac{<b_1',b_2>}{||b_1'||^2}$.
    - Keep going...
  - If you want to get ONB, add normalization after every step.

### 3.6. Orthogonal Complement

> Now we look at vector spaces that are orthogonal to each other.

- Consider a $D$-dimensional vector space $V$ and an $M$-dimensional subspace $U\subseteq V$. Then its *orthogonal complement* $U^{\perp}$ is a $D-M$-dimensional subspace of $V$, which contains all vectors in $V$ that are orthogonal to **every** vector in $U$.
  - Also, for that $U\cap U^{\perp}=\mathbf{0}$, so that $\forall \mathbf{x}\in V$, it can be uniquely decomposed into:
    - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210306153831026.png" alt="image-20210306153831026" style="zoom:50%;" /> 
- In a three dimensional space, for vector $\omega$ with $||\omega||=1$, there is a plane $U$ which $\omega$ is orthogonal to. Then $\omega$ is called the **normal** vector of $U$.

### 3.7. Inner Product of Functions

> We can think a vector $\mathbb{x}\in\mathbb{R}^n$ **as a function with $n$ function values.**

- As the dot product sums over individual components of vectors, an inner product of two functions $u$ and $v$ can be defined as:
  - $<u,b>:=\int\limits_a^bu(x)v(x)dx$.
- `Remark`:
  - For a more mathematically precise definition, one might need the definition integrals, Hilbert space and ...
  - $\{1,\cos(x),\cos(2x),\cos(3x),\cdots\}$ is a very special collection of functions, where *any pair of functions* are orthogonal to each other (if integrate from $-\pi$ to $\pi$). 

### 3.8. Orthogonal Projections

> Projections are an important class of **linear** transformation (besides rotations and reflections). One common use of this in ML is data compression, which is very useful in high-dimensional data processing, because usually only a few dimensions contain most information. Therefore, we want to extract the most valuable dimensions while minimizing information loss.

- **Projection**:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307151518899.png" alt="image-20210307151518899" style="zoom:50%;" /> 
    - Since linear transformation can be expressed as matrices, the projection matrices $\mathbf{P}_\pi$ satisfies $\mathbf{P}_\pi^2=\mathbb{P}_\pi$.

In the following sections we will talk about projection of vectors in $<\mathbb{R}^n,<.,.>$ onto subspaces.

#### 3.8.1. Projection onto One-Dimensional Subspaces (Lines) 

Consider a line (one-dimensional subspace) $\underbrace{\textbf{through the origin}}_{\text{because it's subspace!}}$ with basis vector $\mathbb{b}\in\R^n$, which we denote as $U$. For any $\mathbb{x}\in\R^n$, we use $\pi_U(\mathbb{x})\in U$ as its projection.

- `Remark`:
  - The projection is closest vector to $\mathbb{x}$ in $U$, where closest means the distance $||\mathbb{x}-\pi_U(\mathbb{x})||$. And it also means $\pi_U(x)-x$ is orthogonal to $U$.
  - Since $\pi_U(\mathbb{x})\in U$, there exists $\pi_U(\mathbb{x})=\lambda\mathbb{b}$, for some $\lambda\in\R$.
    - Using $<\pi_U(\mathbb{x})-\mathbb{x},\mathbb{b}>=0$ and $\pi_U(\mathbb{x})=\lambda\mathbb{b}$, we can derive that $\lambda=\frac{<\mathbb{x},\mathbb{b}>}{<\mathbb{b},\mathbb{b}>}=\frac{<\mathbb{b},\mathbb{x}>}{||\mathbb{b}||^2}$.
  - The length of $\pi_U(\mathbb{x})$ is <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307154455177.png" alt="image-20210307154455177" style="zoom:50%;" />
  - The projection matrix $\mathbf{P}_\pi$ in dot product:
    - Since $\pi_U(\mathbf{x}) = \lambda\mathbf{b}=\frac{\mathbf{b}\mathbf{b}^T}{||b||^2}\mathbf{x}$, $\mathbf{P}_\pi=\frac{\mathbf{b}\mathbf{b}^T}{||b||^2}$, which means it's symmetric matrix of rank $1$.
    - Also because $\mathbf{P}_\pi^2\mathbf{x}=\mathbf{P}_\pi\mathbf{x}$, we can show that $\pi_U(\mathbf{x})=\mathbf{P}_\pi\mathbf{x}$ is an eigenvector of $\mathbf{P}_\pi$ with eigenvalue $1$.

#### 3.8.2 Projection onto General Subspaces

Consider a subspace $U\subseteq\R^n$ with $\dim(U)=m\geq1$, and $(\mathbf{b}_1,\cdots,\mathbf{b}_m)$ is an ordered basis, we can thus assume $\pi_U(\mathbf{x})=\sum\limits_{i=1}^m\lambda_i\mathbf{b}_i$

- <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307164305747.png" alt="image-20210307164305747" style="zoom:50%;" />
- Since projection is the closest vector in $U$, which implies that $x-\pi_U(\mathbf{x})$ must be orthogonal to all basis vectors of $U$:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307164440230.png" alt="image-20210307164440230" style="zoom:50%;" />$\Rightarrow$ <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307164450736.png" alt="image-20210307164450736" style="zoom:50%;" />$\Rightarrow$ <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307164528057.png" alt="image-20210307164528057" style="zoom:50%;" />
  - Since $(\mathbf{b}_1,\cdots,\mathbf{b}_m)$ are basis, $B^TB$ is regular, and thus $\mathbf{\lambda}=(B^TB)^{-1}B^T\mathbf{x}$.
    - $(B^TB)^{-1}B^T$ is also called the *pseudo-inverse* of $B$ (doesn't require $B$ to be square). It only requires $B$ to be full rank, and thus $B^TB$ will be positive definite.
  - We can derive that: 
    - $\pi_U(\mathbf{x})=B\lambda=B(B^TB)^{-1}B^T\mathbf{x}$.
    - $\mathbf{P}_\pi=B(B^TB)^{-1}B^T$.
- `Remark`:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307165143499.png" alt="image-20210307165143499" style="zoom:50%;" /> 
  - Projection can also be helpful when we look at linear system $A\mathbf{x}=\mathbf{b}$ without a solution. We can find a *approximate solution* by projecting $\mathbf{b}$ onto the subspace spanned by $A$'s column vectors.
  - Specially, if $(\mathbf{b}_1,\cdots,\mathbf{b}_m)$ is ONB, which means $B^TB=I$, then $\pi_U(\mathbf{x})=BB^T\mathbf{x}$, and $\lambda=B^T\mathbf{x}$.

#### 3.8.3. Gram-Schmidt Orthogonalization

- If we want to transform any **basis** into orthogonal/orthonormal basis, we can use Gram-Schmidt orthogonalization. The general principle is:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307165842623.png" alt="image-20210307165842623" style="zoom:50%;" />
    - If we want ONB, we need to add normalization ($u_k=\frac{u_k}{||u_k||}$) after each step.

#### 3.8.4. Projection onto Affine Subspaces

Consider an affine subspace $L=x_0+U$, the general principle for considering projection onto $L$ is:

<img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307170401527.png" alt="image-20210307170401527" style="zoom:50%;" />

- So the problem becomes: $\pi_L(\mathbf{x})=\mathbf{x_0}+\pi_U(\mathbf{x}-\mathbf{x_0})$, and the distance between $\mathbf{x}$ and $L$ is identical to the distance between $\mathbf{x-x_0}$ and $U$. (<img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307170648376.png" alt="image-20210307170648376" style="zoom:33%;" />).

### 3.9. Rotations

> Linear mapping with orthogonal transformation matrices will preserve length and angle, which is actually rotation.

- A rotation is a linear mapping (more specifically, an [automorphism](#automorphism) of rotation a Euclidean vector space) that rotates a plane by an angle $θ$ about the origin.

#### 3.9.1 Rotations in $\R^2$

- Consider the standard basis $\mathbf{e_1}=\begin{bmatrix}1\\0\end{bmatrix}; \mathbf{e_2}=\begin{bmatrix}0\\1\end{bmatrix}$, we can define a rotation matrix $R(\theta)$ ($\theta$ is positive considering *counterclockwise*):
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307172710131.png" alt="image-20210307172710131" style="zoom:50%;" />
  - It can be perceived as a *basis change*, which means it changes the standard basis to the rotated basis, **but the coordinates (e.g. $\begin{bmatrix}cos\theta\\sin\theta\end{bmatrix}$) are still based on the standard basis!!!**.
    - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210307173125445.png" alt="image-20210307173125445" style="zoom:50%;" />
    - $[\Phi(\mathbf{e_1}),\Phi(\mathbf{e_2})]=[\mathbf{e_1},\mathbf{e_2}]\mathbf{R}(\theta)$

#### 3.9.2. Rotations in $\R^3$

- In $\R^3$ we can rotate any **two-dimensional plane** about a **one-dimensional axis**.
  - And we need to specify what's *counterclockwise* rotation:
    - It refers to a rotation about an axis when we look the axis "head on, from the end toward the origin" $\rightarrow$ [detail](这个axis指向你的眼睛时, 从这个axis的end向origin看的时候, 是counterclockwise的旋转.); 
      - e.g. <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210308125341916.png" alt="image-20210308125341916" style="zoom:33%;" />
- Rotation matrix in $\R^3$ ($\theta$ degree, counterclockwise:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210308125436423.png" alt="image-20210308125436423" style="zoom:50%;" /> 
  -  <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210308125445639.png" alt="image-20210308125445639" style="zoom:50%;" /> 
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210308125453111.png" alt="image-20210308125453111" style="zoom:50%;" /> 

#### 3.9.3. Rotations in n Dimensions

- The generalization of rotations in $n$-dimensional Euclidean vector space can be expressed as **fixing $n-2$ dimensions and restrict the rotation to a two-dimensional plane.**

-  Definition (*Givens Rotation*):
  - For an $n$-dimensional Euclidean vector space $V$ and $\Phi:V\mapsto V$ as an automorphism with transformation matrix:
    - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210308165310364.png" alt="image-20210308165310364" style="zoom:50%;" /> 

#### 3.9.4. Properties of Rotations

- It preserves distance and angles.
- Rotations in three (or more) dimensions are generally **NOT** [commutative][可交换次序的].

## 4. Matrix Decompositions

> We consider three aspects of matrices: how to **summarize** matrices, how matrices can be **decomposed**, and how these
> decompositions can be used for **matrix approximations**.

<img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210309110019623.png" alt="image-20210309110019623" style="zoom:50%;" />

### 4.2. Determinant and Trace

**Determinant:**

- The determinant $\det(A)$ is the **signed volume** of an n-dimensional parallelepiped formed **by columns of the matrix A**.
  - Or: determinant is the scaling factor of linear mappings.
  - The sign of the determinant indicates the orientation of the spanning vectors (of A's column space) w.r.t. the standard basis.
- Laplace Expansion:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210313161835848.png" alt="image-20210313161835848" style="zoom:50%;" />
- Properties of determinants:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210313161915466.png" alt="image-20210313161915466" style="zoom:50%;" />
  - From the last three properties, we can deduct that $\det(A)=0\Leftrightarrow rk(A)=n$.

**Trace:**

- The trace of linear mapping $\Phi$ is the trace of corresponding matrix $A_{\Phi}$ (under given ordered basis).

- Properties of trace:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210313162139367.png" alt="image-20210313162139367" style="zoom:50%;" /> 
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210313162208835.png" alt="image-20210313162208835" style="zoom:50%;" /> 
    - $\Leftrightarrow$ $tr(B)=tr(S^{-1}AS)=tr(ASS^{-1})=tr(A)$: although matrix representation of linear mappings are basis dependent, the trace of a linear mapping $Φ$ is **independent** of the basis.

- Characteristic Polynomial:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210313162546568.png" alt="image-20210313162546568" style="zoom:50%;" /> $\Leftrightarrow$ $\left\{\begin{aligned}c_0&=\det(A)\\c_{n-1}&=(-1)^{n-1}tr(A)\end{aligned}\right.$
  - <font color="grey">$c_{n-1}$可以理解为，对于$\det(A-\lambda I)$做展开的时候, 排列组合, 含有n-1个lambda项一定会乘以一个$a_{ii}$的项.</font>













# Central Machine Learning Problems

