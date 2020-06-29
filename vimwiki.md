## 基本标记

```
= 一级标题 =
== 二级标题 ==
=== 三级标题 ===


*bold* -- 粗体文本
_italic_ -- 斜体文本
（应用于句中的汉字文本时，必须在标记前后加空格，例如：一段 *中文* 文本）

[[wiki link]] -- wiki 链接
[[wiki link|description]] -- 带有描述文本的 wiki 链接
```

列表：

```
* bullet list item 1（无编号列表）
    - bullet list item 2
    - bullet list item 3
        * bullet list item 4
        * bullet list item 5
* bullet list item 6
* bullet list item 7
    - bullet list item 8
    - bullet list item 9

1. numbered list item 1（有编号列表）
2. numbered list item 2
    a) numbered list item 3
    b) numbered list item 4
```

更多格式说明，请阅 `:h vimwiki-syntax`

## 键位绑定

normal 模式:\<Leader>

- `<Leader>ww` -- 打开默认的 wiki 目录文件
- `<Leader>wt` -- 在新标签（Tab）中打开 wiki 目录文件
- `<Leader>ws` -- 在多个 wiki 中选择并打开该 wiki 的目录文件
- `<Leader>wd` -- 删除当前 wiki 文件
- `<Leader>wr` -- 重命名当前 wiki 文件
- `<Enter>` -- 创建或打开 wiki 链接
- `<Shift-Enter>` -- 先上下分屏再打开 wiki 链接（若非链接则先创建）
- `<Ctrl-Enter>` -- 先左右分屏再打开 wiki 链接（若非链接则先创建）
- `<Backspace>` -- 返回之前浏览的 wiki 文件
- `<Tab>` -- 跳到本文件中下一个 wiki 链接
- `<Shift-Tab>` -- 跳到本文件中上一个 wiki 链接

更多快捷键说明，请阅 `:h vimwiki-mappings`

## 命令

- `:Vimwiki2HTML` -- 将当前 wiki 文件转换成 HTML 网页
- `:VimwikiAll2HTML` -- 把所有 wiki 文件转换成 HTML 网页
- `:help vimwiki-commands` -- 显示全部命令