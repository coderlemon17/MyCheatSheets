# 第01集 [方程组的几何解释](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter01.ipynb)

- 列向量的线性组合：

- $$
  Ax=b\\
  [col_1 \cdots col_n]\times\begin{bmatrix}b_1\\\vdots\\b_n\\\end{bmatrix}=b_1\cdot col_1+\cdots+b_n\cdot col_n
  $$

  

# 第02集 [矩阵消元](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter02.ipynb)

- 高斯消元法

# 第03集 [乘法和逆矩阵](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter03.ipynb)

- 列相乘：

  - $$
    \begin{bmatrix}&&\\A_{col1}&A_{col2}&\cdots&A_{coln}\\&&\end{bmatrix}\begin{bmatrix}\cdots&b_{1j}&\cdots\\\cdots&b_{2j}&\cdots\\\cdots&\vdots&\cdots\\\cdots&b_{nj}&\cdots\\\end{bmatrix}=\begin{bmatrix}&&\\\cdots&\left(b_{1j}A_{col1}+b_{2j}A_{col2}+\cdots+b_{nj}A_{coln}\right)&\cdots\\&&\end{bmatrix}
    $$

- 行相乘：

  - $$
    \begin{bmatrix}\vdots&\vdots&\vdots&\vdots\\a_{i1}&a_{i2}&\cdots&a_{in}\\\vdots&\vdots&\vdots&\vdots\end{bmatrix}\begin{bmatrix}&B_{row1}&\\&B_{row2}&\\&\vdots&\\&B_{rown}&\end{bmatrix}=\begin{bmatrix}\vdots\\\left(a_{i1}B_{row1}+a_{i2}B_{row2}+\cdots+a_{in}B_{rown}\right)\\\vdots\end{bmatrix}
    $$

    

- 列乘以行

  - $$
    \begin{bmatrix}&&\\A_{col1}&A_{col2}&\cdots&A_{coln}\\&&\end{bmatrix}\begin{bmatrix}&B_{row1}&\\&B_{row2}&\\&\vdots&\\&B_{rown}&\end{bmatrix}=A_{col1}B_{row1}+A_{col2}B_{row2}+\cdots+A_{coln}B_{rown}
    $$

- <font color="red">注意：前面的矩阵一定要拆成列向量</font>

  - 左乘初等变换矩阵：行变换
  - 右乘初等变换矩阵：列变换

- 分块乘法：

  - $$
    \left[\begin{array}{c|c}A_1&A_2\\\hline A_3&A_4\end{array}\right]\left[\begin{array}{c|c}B_1&B_2\\\hline B_3&B_4\end{array}\right]=\left[\begin{array}{c|c}A_1B_1+A_2B_3&A_1B_2+A_2B_4\\\hline A_3B_1+A_4B_3&A_3B_2+A_4B_4\end{array}\right]
    $$

# 第04集 [A的LU分解](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter04.ipynb)

- LU分解：将一个矩阵表示成下三角矩阵$L$和上三角矩阵$U$的乘积：
  - 更一般的，如果我们希望下三角矩阵$L$的对角线元素**都为1**. (Doolittle分解) $\Leftrightarrow$ $U$为单位上三角(Crout分解)
  - ![img](.\pic\1203675-20180829172059738-678872282.png)
- 通过高斯消元进行LU分解:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210214100401427.png" alt="image-20210214100401427" style="zoom: 50%;" />
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210214100630857.png" alt="image-20210214100630857" style="zoom:50%;" />
  - 消去矩阵的逆矩阵只需要改变非对角元的符号: <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210214100710011.png" alt="image-20210214100710011" style="zoom:33%;" />
- 通过方程组求解直接进行LU分解:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210214100803634.png" alt="image-20210214100803634" style="zoom:50%;" />
- LU分解的**性质**:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210214101025362.png" alt="image-20210214101025362" style="zoom:50%;" />

- LU分解的**复杂度**:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210214101103911.png" alt="image-20210214101103911" style="zoom:80%;" />
  - <font color="grey">$n^2$是因为首先需要把第一行的每一个元素乘一个系数(n), 之后需要对剩下n-1行做一次加法(n-1)*n.</font>

# 第05集 [转置-置换-向量空间R](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter05.ipynb)

- n阶置换阵有$n!$个, $P\cdot P^T=I$.

- 向量空间: 

  > - 所有向量空间都必须包含**原点**（Origin）；
  >
  >   向量空间中任意向量的**数乘**、**求和**运算得到的向量也在该空间中。 即向量空间要满足**加法封闭和数乘封闭**。

# 第06集 [列空间和零空间](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter06.ipynb)

- A的零空间是$Ax=0$中$x$的解组成的集合。

# 第07集 [求解Ax=0：主变量、特解](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter07.ipynb)

- 举例, $A= \begin{bmatrix} 1 & 2 & 2 & 2\\ 2 & 4 & 6 & 8\\ 3 & 6 & 8 & 10\\ \end{bmatrix}$, 求解$Ax=0$的特解:

  - 主变量: (图中下划线元素)

    - $A= \begin{bmatrix} 1 & 2 & 2 & 2\\ 2 & 4 & 6 & 8\\ 3 & 6 & 8 & 10\\ \end{bmatrix} \underrightarrow{消元} \begin{bmatrix} \underline{1} & 2 & 2 & 2\\ 0 & 0 & \underline{2} & 4\\ 0 & 0 & 0 & 0\\ \end{bmatrix} =U$
    - 主变量: 2; 秩为2; 自由变量有**2**个. ($\text{列数}n - \text{主变量}=2$)
    - 主变量所在的列为主列 (pivot column), 其余列为自由列 (free column). 自由列对应的变量为自由变量 (free variable).

  - 求特解的方式:

    - 1. 给自由列变量赋值，去求主列变量的值, 如设$x_2=1, x_4=0$, 得$x=c_1\begin{bmatrix}-2\\1\\0\\0\\\end{bmatrix}$, 再设$x_2=0, x_4=1$, 得$x=c_1\begin{bmatrix}2\\0\\-2\\1\\\end{bmatrix}$.

    - <font color="red">零空间的维度仍为4, 但是其维数/秩为2, 即自由变量个数.</font> 原因是, 零空间相当于是自由变量可以任意取值, 之后主变量对应的$x$有唯一值; 故零空间的维数其实是由自由变量的个数决定的. 同时如果想要张成整个零空间, **选取的不同自由变量组成的向量要相互正交** (如上面$\begin{bmatrix}0\\1\end{bmatrix}$和$\begin{bmatrix}1\\0\end{bmatrix}$正交).

      - 因为自由列和主列线性相关, 所以自由列的任意组合都可以被主列的组合唯一表示.

    - 2. 利用简化行阶梯形式$R$ (Reduced row echelon form): 主元上下元素都为0, 且主元为1, 且主元放在一起
    
      - <img src=".\pic\image-20210217183550495.png" alt="image-20210217183550495" style="zoom: 80%;" />

# 第08集 [求解Ax=b：可解性和解的结构](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter08.ipynb)

- **可解性 ($Ax=b,b\neq 0, x\neq 0$)**: $\left[ \begin{array}{c c c c|c} 1 & 2 & 2 & 2 & b_1 \\ 2 & 4 & 6 & 8 & b_2 \\ 3 & 6 & 8 & 10 & b_3 \\ \end{array} \right] \underrightarrow{消元} \left[ \begin{array}{c c c c|c} 1 & 2 & 2 & 2 & b_1 \\ 0 & 0 & 2 & 4 & b_2-2b_1 \\ 0 & 0 & 0 & 0 & b_3-b_2-b_1 \\ \end{array} \right]$
  - 显然，有解的必要条件为$b_3-b_2-b_1=0$。
- 解=特解+通解 (<font color="red">注意通解应该选零空间的一组**基**</font>)
- 对于$m\times n$的矩阵$A$, 有矩阵$A$的秩$r\leq min(m,n)$: 
  - ![image-20210217190348260](D:\Workspace\MyCheatSheets\Math\pic\image-20210217190348260.png)
  - $\begin{array}{c|c|c|c}r=m=n&r=n\lt m&r=m\lt n&r\lt m,r\lt n\\R=I&R=\begin{bmatrix}I\\0\end{bmatrix}&R=\begin{bmatrix}I&F\end{bmatrix}&R=\begin{bmatrix}I&F\\0&0\end{bmatrix}\\1\ solution&0\ or\ 1\ solution&\infty\ solution&0\ or\ \infty\ solution\end{array}$
  - **注意**: <font color="red">向量的维数和向量空间的维数并不相等!!!</font>
    - 向量的维数: 向量的分量个数
    - 向量空间的维数: “能描述空间的最小向来个数”就是向量空间的维数，同时也是这个向量空间的秩数
      - 下图中左图是两个二维向量张成的二维空间; 右图则是两个二维向量张成的一维空间.
      - <img src="D:\Workspace\MyCheatSheets\Math\pic\QQMail_20210217.png" alt="QQMail_0" style="zoom: 25%;" />
      - 向量空间的维数$\leq$向量的维数.

# 第09集 [线性相关性、基、维数](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter09.ipynb)

- $A=[v_1, \cdots, v_n]$:
  - $A$可逆 = $v_i$是一组基 = $v_i$线性无关	 = $rank(A)=n$ = $A$的零空间只有$\bf0$向量 ($dim N(A)=n-rank(A)$)

# 第10集 [四个基本子空间](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter10.ipynb)

- 行空间: $C(A^T) \in \mathbb{R}^n, dim C(A^T)=r$.
  - 对矩阵进行初等行变换不改变列空间, 但改变行空间.
- 列空间: $C(A) \in \mathbb{R}^m, dim C(A)=r$.
  - 矩阵的行秩等于列秩.
- 零空间: $N(A) \in \mathbb{R}^n, dim N(A)=n-r$.
- 左零空间: $N(A^T) \in \mathbb{R}^m, dim N(A^T)=m-r$.
  - $A^Ty=0$.

# 第11集 [矩阵空间、秩1矩阵](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter11.ipynb)

- 矩阵空间:
  - $dim S + dim U=12=dim(S \cup U) + dim(S \cap U)$.
- 秩一矩阵:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210221142607521.png" alt="image-20210221142607521" style="zoom:67%;" />

# 第12集 [图和网络](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter12.ipynb)

- 

# 第13集 [复习一](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter13.ipynb)

# 第14集 [正交向量与子空间](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter14.ipynb)

# 第15集 [子空间投影](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter15.ipynb)

# 第16集 [投影矩阵和最小二乘](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter16.ipynb)

# 第17集 [正交矩阵和Gram-Schmidt正交化](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter17.ipynb)

# 第18集 [行列式及其性质](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter18.ipynb)

# 第19集 [行列式公式和代数余子式](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter19.ipynb)

# 第20集 [克拉默法则、逆矩阵、体积](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter20.ipynb)

# 第21集 [特征值和特征向量](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter21.ipynb)

# 第22集 [对角化和A的幂](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter22.ipynb)

# 第23集 [微分方程和exp(At)](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter23.ipynb)

# 第24集 [马尔可夫矩阵、傅立叶级数](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter24.ipynb)

# 第25集 [复习二](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter25.ipynb)

# 第26集 [对称矩阵及正定性](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter26.ipynb)

# 第27集 [复数矩阵和快速傅里叶变换](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter27.ipynb)

# 第28集 [正定矩阵和最小值](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter28.ipynb)

# 第29集 [相似矩阵和若尔当形](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter29.ipynb)

# 第30集 [奇异值分解](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter30.ipynb)

# 第31集 [线性变换及对应矩阵](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter31.ipynb)

# 第32集 [基变换和图像压缩](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter32.ipynb)

# 第33集 [单元检测3复习](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter33.ipynb)

# 第34集 [左右逆和伪逆](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter34.ipynb)

# 第35集 [期末复习](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter35.ipynb)