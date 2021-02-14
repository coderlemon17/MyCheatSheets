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

# 第06集 [列空间和零空间](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter06.ipynb)

# 第07集 [求解Ax=0：主变量、特解](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter07.ipynb)

# 第08集 [求解Ax=b：可解性和解的结构](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter08.ipynb)

# 第09集 [线性相关性、基、维数](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter09.ipynb)

# 第10集 [四个基本子空间](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter10.ipynb)

# 第11集 [矩阵空间、秩1矩阵和小世界图](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter11.ipynb)

# 第12集 [图和网络](https://github.com/zlotus/notes-linear-algebra/blob/master/chapter12.ipynb)

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