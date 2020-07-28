# 保存和加载模型

- [see](https://blog.csdn.net/weixin_41680653/article/details/93768559)

- ```
    #Only save parameters
    torch.save(net.state_dict(), 'net_params.pkl')
    #Save entire network
    torch.save(net, 'net.pkl')
    
    #Load only parameters
    model_object.load_state_dict(torch.load('net_params.pkl')) 
    #Load entire model, this will inherent CUDA running feature too
    model = torch.load('net.pkl') 
    ```

- 两种方法在载入模型时都需要有预设的网络结构!

- **1.只加载网络参数的速度比加载整个网络快得多**

    **2.pth、pkl格式效果相同，ckpt是tensorflow的格式**

- 使用`model.eval()`将model设置为evaluation模式(`drop_out, batch normalization`之类的会相应设置)

# 随机生成

- `rand`是均匀分布, `randn`是正态分布

# Multiply
- *elementwise*:
    - `x * y || torch.mul(x,y)`
- *matrixwise*:
    - `x @ y || torch.matmul(x, y)`

# 关于torch.nn和torch.nn.functional:
- [Ref](https://blog.csdn.net/GZHermit/article/details/78730856)
- **所以在定义网络的时候，如果层内有Variable,那么用nn定义，反之，则用nn.functional定义.**
