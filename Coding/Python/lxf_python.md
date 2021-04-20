# Python基础

## 数据类型和变量

**数据类型**:

> 此外,Python还提供了列表、字典等多种数据类型,还允许创建自定义数据类型

- 整数
- 浮点数
- 字符串
  - Python允许用`'''...'''`的格式表示多行内容.
  - 如果你不想字符串中的转义字符`\`起效, 可以使用`r"string\n"`.
- 布尔值: `and`; `or`; `not`
- 空值: `None`不能理解为`0`,因为`0`是有意义的,而`None`是一个特殊的空值.

***

**变量**:

> 这种变量本身类型不固定的语言称之为*动态语言*,与之对应的是*静态语言*

- Python中变量是以*引用* 的形式指向数据.
- Python中全大写的变量一般表示常量.

***

**区分变量和数据对象**:

- e.g. `a='abc'`: `a`是变量; `'abc'`是字符串对象.

## 字符串和编码

**字符编码**:

> 二进制数和字符的映射关系.

- Unicode是目前最全的字符集,但最常用的是UCS-16编码,用两个字节表示一个字符 (如果要用到非常偏僻的字符,就需要4个字节.) 本着节约的精神,又出现了把Unicode编码转化为“可变长编码”的`UTF-8`编码.

  - | 字符 | ASCII    | Unicode           |           UTF-8            |
    | :--- | :------- | :---------------- | :------------------------: |
    | A    | 01000001 | 00000000 01000001 |          01000001          |
    | 中   | x        | 01001110 00101101 | 11100100 10111000 10101101 |

- `Unicode`和`Utf-8`等的区别:

  - 简单来说：Unicode 是「**字符集**」, UTF-8 是「**编码规则**」.

  - 其中:

    - 字符集：为每一个「字符」分配一个唯一的 ID（学名为**码位** / 码点 / Code Point）
    - 编码规则：将「码位」转换为**字节序列**的规则（编码/解码 可以理解为 加密/解密 的过程）

  - 广义的 Unicode 是一个标准,定义了一个字符集以及一系列的编码规则,即 Unicode 字符集和 UTF-8、UTF-16、UTF-32 等等编码…… Unicode 字符集为**每一个字符分配一个码位**,例如「知」的码位是 30693,记作 U+77E5（30693 的十六进制为 0x77E5）.

  - 而UTF-8 顾名思义,是一套以 8 位为一个编码单位的可变长编码.**会将一个码位编码为 1 到 4 个字节**：

    - ```
      U+ 0000 ~ U+  007F: 0XXXXXXX
      U+ 0080 ~ U+  07FF: 110XXXXX 10XXXXXX
      U+ 0800 ~ U+  FFFF: 1110XXXX 10XXXXXX 10XXXXXX
      U+10000 ~ U+10FFFF: 11110XXX 10XXXXXX 10XXXXXX 10XXXXXX
      ```

  - 根据上表中的编码规则, 「知」字的码位 U+77E5 在UTF-8中的字符序列为:  E79FA5.

- 计算机系统通用的字符编码工作方式:

  - 在计算机内存中,统一使用[Unicode编码](这里指的是广义的Unicode, 可以认为也是一种编码方式, 直接将Unicode的码位映射等值映射到字符序列.),当需要保存到硬盘或者需要传输的时候,就转换为UTF-8编码.
  - 浏览网页的时候,服务器会把动态生成的Unicode内容转换为UTF-8再传输到浏览器. e.g. `<meta charset="UTF-8" />`

***

**字符串**:

- 内存:

  - Python程序中的字符串是存在内存中的, 故其以`Unicode`编码进行编码.

  - 对于单个字符的编码,Python提供了`ord()`函数获取字符的整数表示,`chr()`函数把编码转换为对应的字符：

    - ```python
      >>> ord('A')
      65
      >>> ord('中')
      20013
      >>> '\u4e2d\u6587' #字符的整数编码
      '中文'
      ```

- 网络流:

  - 如果要在网络上传输,或者保存到磁盘上,就需要把`str`变为以字节为单位的`bytes`.

  - 以Unicode表示的`str`通过`encode()`方法可以编码为指定的`bytes`; 反过来,如果我们从网络或磁盘上读取了字节流,那么读到的数据就是`bytes`.要把`bytes`变为`str`,就需要用`decode()`方法.

    - ```python
      # Encode
      >>> 'ABC'.encode('ascii') == b'ABC' == bytes('ABC')
      b'ABC'
      >>> '中文'.encode('utf-8')
      b'\xe4\xb8\xad\xe6\x96\x87' #在bytes中,无法显示为ASCII字符的字节,用\x##显示.
      
      # Decode
      >>> b'ABC'.decode('ascii')
      'ABC'
      >>> b'\xe4\xb8\xad\xe6\x96\x87'.decode('utf-8')
      '中文'
      ```

    - 如果`bytes`中只有一小部分无效的字节,可以传入`errors='ignore'`忽略错误的字节：

      - ```python
        >>> b'\xe4\xb8\xad\xff'.decode('utf-8', errors='ignore')
        '中'
        ```

- 磁盘:

  - 由于Python源代码也是一个文本文件,所以,当你的源代码中包含中文的时候,在保存源代码时,就需要务必指定保存为UTF-8编码.当Python解释器读取源代码时,为了让它按**UTF-8**编码读取,我们通常在文件开头写上这两行：

  - ```python
    #!/usr/bin/env python3
    # -*- coding: utf-8 -*-
    ```

  - 同时必须并且要确保文本编辑器正在使用`UTF-8 without BOM`编码.

- 字符串的格式化输出:

  - `%`:

    - ```python
      # %d 整数; %f	浮点数; %s	字符串; %x	十六进制整数
      # %% literal %
      >>> 'Hi, %s, you are %d %% taller.' % ('Michael', 10)
      'Hi, Michael, you are 10 % taller.'
      ```

  - `.format()`:

    - ```python
      #{1:.2f}: Index=1的位置上,保留2位小数(不会四舍五入)
      >>> 'Hello, {0}, 成绩提升了 {1:.2f}%'.format('小明', 17.125)
      'Hello, 小明, 成绩提升了 17.12%'
      ```

  - `f-string`:

    - 它和普通字符串不同之处在于,字符串如果包含`{xxx}`,就会以对应的变量替换.

    - ```python
      >>> r = 2.5
      >>> s = 3.14 * r ** 2
      >>> print(f'The area of a circle with radius {r} is {s:.2f}')
      The area of a circle with radius 2.5 is 19.62
      ```

## 使用list和tuple

**List**

- `append()`; `pop()`
- `insert(i, obj)`; `pop(i)`.

***

**Tuple**:

- tuple和list非常类似,但是tuple一旦初始化就不能修改.

- 但是,要定义一个只有1个元素的tuple的时候必须用`(1,)`而不能是`(1)`, 因为括号`()`既可以表示tuple,又可以表示数学公式中的小括号,这就产生了歧义,因此,Python规定,这种情况下,按小括号进行计算,计算结果自然是`1`.

  - ```python
    >>> t = (1,)
    >>> t
    (1,)
    ```

## X条件判断

## 循环

> <font color="red">*要特别注意*</font>，不要滥用`break`和`continue`语句.`break`和`continue`会造成代码执行逻辑分叉过多，容易出错.大多数循环并不需要用到`break`和`continue`语句，上面的两个例子，都可以通过改写循环条件或者修改循环逻辑，去掉`break`和`continue`语句.

## 使用dict和set

**Dict**

- Dict的默认实现方式: `Hash`$\rightarrow$ dict的key必须是**不可变对象** (e.g. 字符串, 整数, tuple)
  - 查找和插入的速度极快，不会随着key的增加而变慢；
  - 需要占用大量的内存，内存浪费多.
- Dict的key是否存在:
  - 通过`in`判断key是否存在.
  - 通过dict提供的`get()`方法，如果key不存在，可以返回`None`，或者自己指定的value. (`d.get('Thomas', -1)`)
- Dict删除key:
  - 使用`pop(key)`方法，对应的value也会从dict中删除.

***

**Set**:

> 一组**不重复**的**key**的集合, 但是不存储value.

- `set([1,2,3])`;`add(key)`; `remove(key)`.

- set可以看成数学意义上的无序和无重复元素的集合，因此，两个set可以做数学意义上的交集、并集等操作：

  - ```python
    >>> s1 = set([1, 2, 3])
    >>> s2 = set([2, 3, 4])
    >>> s1 & s2
    {2, 3}
    >>> s1 | s2
    {1, 2, 3, 4}
    ```

- set和dict的唯一区别仅在于没有存储对应的value, 因此set同样不可以放入可变对象.

# 函数

## 调用函数

函数名其实就是指向一个函数对象的引用，完全可以把函数名赋给一个变量，相当于给这个函数起了一个“别名”：

```shell
>>> a = abs # 变量a指向abs函数
>>> a(-1) # 所以也可以通过a调用abs函数
1
```

## X定义函数

## 函数的参数

- **位置参数**

- **默认参数**:

  - 必选参数在前，默认参数在后

  - 设置默认参数时, 把变化大(e.g. 姓名)的参数放前面, 变化小(e.g. 民族)的参数放后面, 可以作为默认参数.

  - :warning:```定义默认参数要牢记一点：默认参数必须指向不变对象！(str, None...)```
  
    - ```python
      def add_end(L=[]):
          L.append('END')
          return L
      >>> add_end() 
      ['END']
      >>> add_end() #Python函数在定义的时候，默认参数L的值就被计算出来了，即[]
      ['END', 'END']
      ```
  
- **可变参数** && **关键字参数**:

  - ```python
    def func(x, *args, **kw):
    	# args is a tuple!
    	# kw is a dict (a copy of the original one)
    	pass
    func(*[1,2,3])
    func(**{1:2,2:3})
    ```

- **命名关键字参数**:

  - > `*`后面的参数被视为命名关键字参数.

  - ```python
    def person(name, age, *, city='A', job): #只接收city和job作为关键字参数;可以有缺省值
        print(name, age, city, job)
    #命名关键字参数调用时必须传入参数名
    person('Jack', 24, job='Engineer')
    ```

  - 如果函数定义中已经有了一个可变参数，后面跟着的命名关键字参数就不再需要一个特殊分隔符`*`了：

    - ```python
      def person(name, age, *args, city, job):
          print(name, age, args, city, job)
      ```

***

- **参数组合**:

  > - 参数定义的顺序必须是：必选参数、默认参数、可变参数、**命名关键字参数**和关键字参数。

  - 


## 递归函数

# 高级特性
