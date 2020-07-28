# Modules

- [Ref](https://blog.csdn.net/Levy_96/article/details/86629444)

## Import Error

- 使用pip安装完成之后import仍然报错,一个很可能的原因就是该包暗转的位置并没有被加入到传统的Python module搜索目录中:

    - `工作目录; sys.path, PYTHONPATH`

- 解决方法

    ```
    1. 修改环境变量PYTHONPATH
    export PYTHONPATH="${PYTHONPATH}:/home/usr/projectdir"
    
    2. 在代码中
    import sys
    import os
    sys.path.append(os.path.dirname(os.path.abspath(__file__))
    
    2.1. 如果需要进到上级目录
    sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__), ".."))
    ```

## Relative Import && Absolute Import

```
package/
    __init__.py
    subpackage1/
        __init__.py
        moduleX.py
        moduleY.py
    subpackage2/
        __init__.py
        moduleZ.py
```

- 在modelX中进行导入

    - ```python
        import moduleY #隐式相对导入
        from . import modeuleY #显式相对导入
        from .moduleY import spam
        from ..subpackage2.modeuleZ import spam
        from package.subpackage1 import moduleY  #绝对导入
        ```

- > 需要注意的是使用相对导入后，当前模块就不能直接运行了，会抛出ValueError: Attempted relative import in non-package的错误。这是因为对于解释器来说，它无法理解导入语句中的相对关系，这时候就需要为它说明相对关系了，也就是用python -m A.B.C的方式代替python A/B/C.py来运行模块。

    