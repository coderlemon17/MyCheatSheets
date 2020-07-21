# Stupid bugs

## `Expected object of scalar type Long but got scalar type Float for argument #3 'mat1' in call to _th_addmm_`

- occurred when training CNN
- solution : ([see](https://blog.csdn.net/qq_33866063/article/details/106946405))
    - `data_input -> data_input.float()`
- 即把CNN的输入变为float32, 但实际上和报错信息有冲突,不知道为什么
- CNN的图片输入维度为`[N,C,W,H]`
    - N: number, C: channel
- numpy增加维度 ([see](https://blog.csdn.net/xtingjie/article/details/72510834))
    - `x = x[:, np.newaxis]`
- pytorch增加维度
    - `x = x.unsqueeze(0)`