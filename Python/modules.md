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

    

## Why my custom module dosenot work?

- 当你写了一个module,但是import时会报错:

- ```
    mygrid  <--- folder1
    ├── __init__.py
    ├── mygrid   <---folder2
    │   ├── __init__.py
    │   ├── MiniGrid
    ├── mygrid.egg-info
    └── setup.py
    ```

    

- 你在setup.py里假如写的是:

    - ```python
        from setuptools import setup
        
        setup(
            name='mygrid',
            version='0.0.1',
            packages=["mygrid"],
            install_requires=['gym']
        )
        ```

    - **这里的name不是随便写的**: 而应该是你setup.py**所在文件夹中的module的名字**:

        - 可以认为import的时候就是从这个文件夹(folder2)中去import mygrid, 所以你在这个文件夹中必须相应的要有这个文件夹(mygrid), 不然当然会报import error.