# Pytorch安装

- https://blog.csdn.net/minhuaQAQ/article/details/104420781/
    - 注意记得把`-c pytorch`去掉,不然还是从pytorch的源安装
    - 其实只要多第一个pytorch的清华源就行了
        - `conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/`
    - **注意别乱加源! 之前加了不是ubuntu的源把电脑搞崩了**

# 1. DEEP LEARNING WITH PYTORCH: A 60 MINUTE BLITZ

## 1.1. What is pytorch?

### 1.1.1 Tensors

- similar to numpy arrays, while it can be calculated on GPU.

- ```python
    torch.empty(2, 2)  # non-initialized, can be anything
    torch.rand(5, 3) # randomly intialized, between(0,1)
    torch.zeros(5, 3, dtype=torch.long)
    torch.new_ones(5, 3, dtype=torch.float)  # double = float64
    torch.tensor([5,5, 3]) #or torch.from_numpy(np_data)  #and tensor_data.numpy()
    print(tensor_data.size()) #get size
    ```

### 1.1.2. Operations

```python
x + y || torch.add(x, y) || torch.add(x, y, out=tensor_for_result) 
|| y.add_(x)   #note: this will change y
```

- Indexing `print(x[:, 1])`

#### Resizing:

- ```python
    x = torch.randn(4, 4)
    y = x.view(16)
    z = x.view(-1, 8)  # the size -1 is inferred from other dimensions
    print(x.size(), y.size(), z.size())
    ```

#### Get Python value

- ```python
    x = torch.randn(1)
    print(x)  # tensor([0.6884])
    print(x.item())  #0.6884220838546753
    ```

### 1.1.3. Numpy Bridge

- The Torch Tensor and NumPy array will **share their underlying memory locations** (if the Torch Tensor is on **CPU**), and changing one will change the other.

- :warning: **SHALLOW COPY**

- Torch to numpy

    - ```python
        a = torch.ones(5)
        b = a.numpy()
        a.add_(1)
        print(a) #tensor([2., 2., 2., 2., 2.])
        print(b) #[2. 2. 2. 2. 2.]   #WILL CHANGE
        ```

- Numpy to torch

    - :warning: Still **SHALLOW COPY**

    - ```python
        import numpy as np
        a = np.ones(5)
        b = torch.from_numpy(a)
        np.add(a, 1, out=a)
        print(a) #[2. 2. 2. 2. 2.]
        print(b) #tensor([2., 2., 2., 2., 2.], dtype=torch.float64)
        ```

### 1.1.4. CUDA Tensors

- Tensors can be moved onto any device using the `.to` method.

- ```python
    # let us run this cell only if CUDA is available
    # We will use ``torch.device`` objects to move tensors in and out of GPU
    if torch.cuda.is_available():
        device = torch.device("cuda")          # a CUDA device object
        y = torch.ones_like(x, device=device)  # directly create a tensor on GPU
        x = x.to(device)                       # or just use strings ``.to("cuda")``
        z = x + y
        print(z)
        print(z.to("cpu", torch.double))       # ``.to`` can also change dtype together!
    ```

## 1.2. Autograd: Automatic Differentiation

- The `autograd` package is a *define-by-run* framework.
- In a computational graph: 在张量间的计算过程中，如果在所有输入中，有一个输入需要求导，那么输出一定会需要求导；相反，只有当所有输入都不需要求导的时候，输出才会不需要.
- `.requires_grad`: attribute. (之后任意在计算图上依赖他的子节点都会默认需要求导. BP)
    - if `.requires_grad` is true, the tensor will have a `.grad_fn` attribute that references a `Function` for grad.
    - use `.requires_grad_()`  to change `.requires_grad` in place.
    - 似乎所有最后带`_`的function会改变`caller`自身.
- When you finish your computation you can call `.backward()` and have all the gradients computed automatically
    - `.grad`
- To stop a tensor from tracking history, you can call `.detach()` to detach it from the computation history, and to prevent future computation from being tracked.
- To prevent tracking history (and using memory), you can also wrap the code block in `with torch.no_grad():`.

### Vector-Jacobian product

- very nice [illustration](https://suzyahyah.github.io/calculus/pytorch/2018/07/01/Pytorch-Autograd-Backprop.html)
- Basically, give function $\mathop{y}\limits^{\rightarrow} = f(\mathop{x}\limits^{\rightarrow})$, the autograd computes **the product of a vector and the Jacobian**. $J^T\times v$

$$
\begin{split}J=\left(\begin{array}{ccc}
 \frac{\partial y_{1}}{\partial x_{1}} & \cdots & \frac{\partial y_{1}}{\partial x_{n}}\\
 \vdots & \ddots & \vdots\\
 \frac{\partial y_{m}}{\partial x_{1}} & \cdots & \frac{\partial y_{m}}{\partial x_{n}}
 \end{array}\right)\end{split}^T \times v
$$

- Why doing this?

    > - If $v$ happens to be the gradient of a scalar function $l=g\left(\vec{y}\right)$, that is, $v=\left(\begin{array}{ccc}\frac{\partial l}{\partial y_{1}} & \cdots & \frac{\partial l}{\partial y_{m}}\end{array}\right)^{T}$, then by the chain rule, the vector-Jacobian product would be the gradient of $l$ with respect to $\mathop{x}\limits^{\rightarrow}$:
    >
    > $$
    > \begin{split}J^{T}\cdot v=\left(\begin{array}{ccc}
    >  \frac{\partial y_{1}}{\partial x_{1}} & \cdots & \frac{\partial y_{m}}{\partial x_{1}}\\
    >  \vdots & \ddots & \vdots\\
    >  \frac{\partial y_{1}}{\partial x_{n}} & \cdots & \frac{\partial y_{m}}{\partial x_{n}}
    >  \end{array}\right)\left(\begin{array}{c}
    >  \frac{\partial l}{\partial y_{1}}\\
    >  \vdots\\
    >  \frac{\partial l}{\partial y_{m}}
    >  \end{array}\right)=\left(\begin{array}{c}
    >  \frac{\partial l}{\partial x_{1}}\\
    >  \vdots\\
    >  \frac{\partial l}{\partial x_{n}}
    >  \end{array}\right)\end{split}
    > $$
    >
    > - This is very convenient for BP calculation.

- By default, `v = Tensor([1])`, which is perfectly ok if `y` is **scalar**.

- But when `y` is not a scalar, you need to specify `v`:

    - If you want to get $\frac{\partial{y_1}}{\partial{x}}$, you can specify `v` as $[1, 0, \cdots, 0]^T$
        - And this is the recommended way.

- Note that, when programming `Pytorch`, usually we consider `vector = [1, 2, 3 ...]` (row vector) rather than column vector, for that `[[1,2,3]]` is much easier to type than `[[1], [2], [3]]`.

##  1.3. Neural Networks

- 

