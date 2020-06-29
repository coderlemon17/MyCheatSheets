# Useful pluggings

- `:Goyo`
    - `<C-g>`
- `LimeLight`
    - `\l`
    - `\ql`

# Vimtutor

## cheat sheet

- `e`: end of the word
- `w`: word
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
- `