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

#### 2.6.2. Rank $A\in\mathbb R^{m\times n}$

- 列空间: $U\subseteq\mathbb{R}^m$: image / range $\Leftrightarrow$ 行空间: $W\subseteq\mathbb R^n$.
- $Ax=b$ can be solved if and only if $rk(A)=rk(A|b)$, where $A|b$ is the augmented system.
- 零空间: $dim(N(A))= n - rk(A)$: kernel or null space.
- full rank: $rk(A)=\min(m,n)$ $\Leftrightarrow$ rank deficient: $rk(A)< \min(m,n)$.

### 2.7. Linear Mappings

- Linear mappings:
  - <img src=".\pic\image-20210228133945377.png" alt="image-20210228133945377" style="zoom: 50%;" />

- Injective; Surjective; Bijective:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210228134611067.png" alt="image-20210228134611067" style="zoom: 50%;" />
- Special linear mappings:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210228135024270.png" alt="image-20210228135024270" style="zoom:33%;" />
    - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210228135107131.png" alt="image-20210228135107131" style="zoom: 33%;" />
- `Remark`:
  - For linear mapping $\Phi, \Psi$, $\Phi\text{o}\Psi$ is also linear mapping.

#### 2.7.1. Matrix Representation of Linear Mappings

- Any basis defines a valid coordinate system. But to acquire coordinate, we need to define **ordered basis**, which accordingly defines the coordinates.
  - For **ordered basis $\mathcal B=(\bf{b}_1, \cdots, \bf b_n)$**, $\bf x	= \alpha_1\bf b_1+\cdots+\alpha_n\bf b_n$ so $\bf\alpha=\begin{bmatrix}\alpha_1\\\vdots\\\alpha_n\end{bmatrix}$ is the *coordinates / coordinate vector / coordinate representation* of $\bf x$ w.r.t. $\mathcal B$.
- `Remark`:
  - $(\bf{b}_1, \cdots, \bf b_n)$: ordered basis.
  - $\{\bf{b}_1, \cdots, \bf b_n\}$: unordered basis.
  - $[\bf{b}_1, \cdots, \bf b_n]$: matrix.
- Transformation Matrix:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\QQMail_0 (4).png" alt="QQMail_0 (4)" style="zoom:30%;" />
  - For linear mapping between vector spaces / basis:
    - $(\bf b_1, \cdots, \bf b_n) = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi$
      - 记法: 你试图去表示$b$, 所以是把coordinate从$b$转到$c$.
    - And the relationship between coordinates is:
      - $(\bf b_1, \cdots, \bf b_n) = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi \Rightarrow (\bf b_1, \cdots, \bf b_n)\bf x = (\bf c_1,\cdots,\bf c_n)\cdot A_\Phi \bf x \Rightarrow$ 在新的$c$下的coordinate是$\tilde x=A_\Phi x$.

- One example: 
  - 在canonical basis下某transformation matrix $A=\begin{bmatrix}2, 1\\1, 2\end{bmatrix}$. 请问在新的基$\begin{bmatrix}1\\1\end{bmatrix}$, $\begin{bmatrix}1\\-1\end{bmatrix}$下的矩阵为?
    - **注意这里的transformation matrix并不是上面的两组基之间的transform矩阵**, 而是应该被理解为是某线性变换在canonical基下对应的矩阵.
    - canonical 和 新的基之间的变换矩阵: $I = \begin{bmatrix}&1, &1\\&1, &-1\end{bmatrix}\cdot\Phi$.
    - $\hat x=Ax\Rightarrow \Phi \hat y = A\Phi y\Rightarrow \hat y = \Phi^{-1}A\Phi y$:
      - 所以$A$在新的基下的线性变换矩阵为$\Phi^{-1}A\Phi$, 结果为$\begin{bmatrix}3, 0\\0, 1\end{bmatrix}$, 为对角阵.
      - **故如果要计算某向量对于A的线性变换(的若干次幂), 最好的方法是先转换到新的基下进行运算, 之后再转换回去.**

#### 2.7.2. Basis Change

- 注意, 在思考线性映射的时候, 如果不是自同态/自映射; 则就是两个不同的向量空间映射, 那就不仅仅是单纯换基而使得向量不变了, 因为不同的向量空间中的向量本身就不是一个东西.
- 定理:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210228162427422.png" alt="image-20210228162427422" style="zoom:50%;" />
  - Intuitive interpretation:
    - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210228162533422.png" alt="image-20210228162533422" style="zoom:50%;" />
- *Equivalent* and *Similar*:
  - <img src="D:\Workspace\MyCheatSheets\Math\Mathematics for Machine Learning\pic\image-20210228162648463.png" alt="image-20210228162648463" style="zoom:40%;" />

TODO 只看完了Similarity.



# Central Machine Learning Problems

