# Lecture 14 Eigenvectors and eigenvalues

- Eigenvectors are vectors that won't be knocked off their span by the linear transformation $Ax$.

- Imaging a 3D rotation, finding the eigenvector with eigenvalue 1 is actually finding the axis for the rotation. 
- $(A-\lambda I)v=\bf0$ will have a non-zero solution only when $A$ squeezes the space into a lower dimension:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210223201648255.png" alt="image-20210223201648255" style="zoom: 25%;" /> $\rightarrow$ <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210223201731538.png" alt="image-20210223201731538" style="zoom:25%;" />$\rightarrow$ <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210223201800415.png" alt="image-20210223201800415" style="zoom:25%;" />

- Diagonal matrix: $\begin{bmatrix}1\ 0\ 0\\0\ 2\ 0\\ 0\ 0\ 3 \end{bmatrix}$
  - One interpretation is that all the basis vectors are eigenvectors with the diagonal entries of this matrix being their eigenvalues.
- **When there are enough eigenvectors to span the full space:**
  - How to rewrite the transformation in another coordinate (with different basis):
    - $B=[b_1, \cdots, b_n]$, where $b_1, \cdots, b_n$ are new basis.
    - Then $B^{-1}AB$ is the transformation $A$ under new basis.
  - So when $A$ has **enough eigenvectors** to span the whole space, choose them as the new basis, the new transformation $B^{-1}AB$ will be **a diagonal matrix**. (Because the new transformation will only scale the eigenvectors / **eigenbasis**.)
  - The power of diagonal matrix is easy to compute, so if you want to calculate $C^{100}$, it's easier if you change it into an eigenbasis coordinate, compute the power, and convert back.
- Question:
  - <img src="D:\Workspace\MyCheatSheets\Math\pic\image-20210223204931545.png" alt="image-20210223204931545" style="zoom:67%;" />