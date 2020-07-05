# Useful pluggings

- `:Goyo`
    - `<C-g>`
- `LimeLight`
    - `\l`
    - `\ql`

# Vimtutor

## cheat sheet

- `e`: end of the word
- `w`: word  (`b`: back a word)
- `$`: end of the line

## 第一讲

- 删除字符: 在Normal模式下，`x`可删除**光标所在处**的字符
- 插入字符: 在光标处插入 (在原本处于光标处的字符**前**插入) `i`
- 添加字符: 在该行行尾插入后的字符处 (在normal模式下`A`)

## 第二讲

- <[number] + operator + [number] + object>
    - 注意,只有单独不能用的operator才能组合operator + object
    - 比如 `hjkl`就不能这么干(因为你单独一个`hjkl`就已经被识别为操作并执行了)
    - 但`d3j`是可以的,表示剪贴下面三行
- 删除命令
    - 删除单词: 在Normal模式下输入`dw` (光标需要位于单词**开头处**)
        - `dw`从光标开头删除至下一个单词开头 (两个单词之间的空格也会被删除)
        - `de`: 从光标开头删除至当前单词结尾 (两个单词之间的空格不会被删除)
    - 删除至行尾: Normal, `d$` (**含**光标处字符)
    - `dd`: 剪贴整行
- **使用计数器指定动作** (数字位于开头）：
    - `2dw`: 向后删除两个单词
    - `2w`: 向后移动两个单词
    - `3e`: 向后移动到第三个单词的末尾  (`$`也可以用)
    - `0`：移动到行首
- `^`: first non empty character.
    
- 撤销：
    - `u`: 撤销最后一次命令
    - `U`: 撤销对整行的操作
    - `Ctrl+r`: 恢复上一次撤销

## 第三讲

- `p`: 粘贴光标所在行的**下一行**
- 替换:
    - `r`: 在Normal模式下替换光标所在处的字符
    - `ce`: change to the end of the word: 改变文本直到单词的末尾
        - 同`cw`
    - `c$`: change to the end of the line.

## 第四讲

- 跳转

    - `ctrl+g`: 显示当前状态信息行
    - `G`: 文尾, `gg` : 文首
    - `NUMBER+G`: 跳转至指定行

- 搜索:

    - 正向: `/`; 逆向: `?`
    - `n/N`: 下一个/上一个匹配处
    - `ctrl + o/i`: 回到上一个/下一个进行搜索的位置
        - 注意你使用`n/N`也算进行了一次搜索

- 匹配括号跳转:

    - 在左/右括号处使用`%`可以跳转至对应的括号处.

- 替换

    - | 命令             | 效果                        |
        | ---------------- | --------------------------- |
        | `:s/old/new`     | 本行, 第一个匹配            |
        | `:s/old/new/g`   | 本行, 所有匹配              |
        | `:#,#old/new/g`  | #,#代表起止行号, 全部匹配   |
        | `:%s/old/new/g`  | 全文, 全部匹配              |
        | `:%s/old/new/gc` | 全文,全部匹配, 提示是否替换 |

        - g: 是否全部替换
        - c: 是否提示  (`y/n/q`)

## 第五讲

- 执行shell命令:
    - `:! cmd`
- `:w filename`
    - 相当于另存为
- 部分保存:
    - 使用Visual mode选中部分文本后, `:w filename`
- 提取和合并文件
    - `:r FILENAME`: 从光标所在位置开始插入
    - `:r !cmd`: 可以读取外部命令的输出

## 第六讲

- `o / O`: 在光标所在行的下一行/上一行插入空行并进入插入模式
- `a`: 可在光标后插入文本  <--> `i`: 可以在光标前插入文本
    - <--> `A`: 在行尾插入
- `e`: 可跳至单词末尾
- `R`: 可进行连续替换
- 复制粘贴文本
    - `y/p`: 复制粘贴
    - 粘贴是在光标后粘贴
- 设置类命令:
    - `:set ic`: set ignore case
    - `:set noic `: not ignore case

## 第七讲

- `:help info` 可以打开关于任意东西的帮助文档
    - `e.g. :help e`
- `ctrl+w+hjkl`: 可以在窗口间进行跳转

# Vim分屏

## 从shell打开

```
vim [option] [FILES]
```

- `-o/O`: 水平/垂直分割

## 从vim打开

- `:new` open a blank window
- 打开当前文件
    - `<C-w>s`水平; `<C-w>v` 垂直
    - 水平打开当前文件的时候会触发锁定`<C-s>`, 若解锁需要`<C-q>`
- 打开任意文件
    - `:sp FILENAME` ; `:vs FILENAME`  (split / vsplit)

- 关闭分屏
    - `:q` 可退出当前选中分屏
    - `:only` 只保留当前分屏
- `<C-w>+/-`可以调整分屏大小

# Vim tab

- `:tabc`: close current tab (mapping with `<tc>`) (or just `:q`)
- `:tas`: list all tabs' status
- `:tabo`: close all but current
- `:tabn`: next tab  (mapping with `<tn>`)
- `:tabp`: previous tab (mapping with `<tp>`)

- `:tabm INDEX` : move current tab to INDEX (start from 0)
- `:ts` split current tab (like make a copy) (mapping with `<ts>`)`
- `:tabnew` new tab (mapping with `<tt>`)

# Vim 复制粘贴

- `vim --version | grep clipboard`查看你的vim支不支持粘贴到系统粘贴板

- 支持的话:

    - Vim 中的复制、删除的内容都会被存放到默认（未命名）寄存器中，之后可以通过粘贴操作读取默认寄存器中的内容。寄存器是完成这一过程的中转站，Vim 支持的寄存器非常多，其中常用的有 a-zA-Z0-9+“。其中：

        - 0-9：表示数字寄存器，是 Vim 用来保存最近复制、删除等操作的内容，其中 0 号寄存器保存的是最近一次的操作内容。

        a-zA-Z：表示用户寄存器，Vim 不会读写这部分寄存器

        - "（单个双引号）：未命名的寄存器，是 Vim 的默认寄存器，例如删除、复制等操作的内容都会被保存到这里。
        - +：剪切板寄存器，关联系统剪切板，保存在这个寄存器中的内容可以被系统其他程序访问，也可以通过这个寄存器访问其他程序保存到剪切板中的内容。

- 通过下面命令可以查看所有寄存器中的内容，也可以只查看指定寄存器的内容（将寄存器名称作为参数）

    ```text
    :reg [register_name] 
    ```

- Vim 有12个粘贴板依次编号为：0、1、2、...、9、a、"、+，其中 + 号为系统粘贴板，” 为临时粘贴板。系统剪切板中的内容可在其他程序中使用。上面的复制指令都可以配合剪切板进行操作。

- ```text 注意"
    "+yy  // 复制当前行到剪切板
    "+p   // 将剪切板内容粘贴到光标后面
    "ayy  // 复制当前行到寄存器 a
    "ap   // 将寄存器 a 中的内容粘贴到光标后面
    ```

# 缩放

- 其实是terminal的缩放 (`<C+shift+>` && `<C+->`)

# 边框

- 首先需要分清: `console`, `terminal`, 和`shell`

> To Summarize my answer :
>
> **Shell** is a program which `processes` commands and `returns` output , like **bash** in Linux .
>
> **Terminal** is a program that `run` a **shell** , in the past it was a **physical device** (Before terminals were monitors with keyboards, they were **teletypes**) and then its concept was transferred into **software** , like **Gnome-Terminal** .
>
> So I open **Gnome-Terminal** , a black windows appear that run **Shell** so i can run my commands.
>
> Console is a **special sort of terminal** , it was also a Physical device . example in Linux we have `virtual console` which i can access them by combination of Ctrl + Alt + F1 to F7 .
>
> **Console** sometimes means the keyboard and monitor **physically** attached to this computer.

- 而`zsh`, `bash`都是`shell`, 使用的terminal则是`gnome-ternimal`, 因此使用vim是产生的边框其实是terminal和vim之间产生的 (具体原因没有深挖,好像是二者对于pixel的处理方式)
- 解决方法: 取消terminal自带的transparent, 仅使用`compton`
    - 之后在preference中修改背景色, 使之与vim中的背景色相近

# 缩进
- `<<`和`>>`可以控制缩进

# Buffers
- Note:
    - Open **Vertical**: means the new window is vertically as high as original.
    - Open **Horizontal**: means the new window is horizontally as long as the original.
- Basic control:
    - Open new window/buffers:
        - `new / vnew`: open new window horizontally/vertically.
        - `e /path/file` open new buffer in current window
            - you have to save current buffer first to do so.
            - won't close other buffers.
    - Delete buffer:
        - `bd`: delete current buffer (won't affect files in the disk)
        - `bd2`: delete buffer2
    - Buffer navigation:
        - `ls / buffers`: list all buffer
            - 在展示的列表中有一些 buffer 的状态：
            ```
            非活动的缓冲区
            a 光标所在缓冲区
            h 隐藏缓冲区
            % 当前的缓冲区
            # 交换缓冲区， 可以使用 Ctrl + ^
            = 只读缓冲区
            + 已经更改的缓冲区
            ```
        - `<C-^>` change between current and previous buffer.
        - `bn[ext] bp[revious]`
