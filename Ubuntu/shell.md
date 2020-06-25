https://www.cnblogs.com/ultranms/p/9353157.html

https://www.jianshu.com/p/9c0c2b57cb73

https://blog.csdn.net/denghaibo/article/details/6524293

# 重定向

## 重定向符号

#### >  输出重定向到文件，覆盖

#### >! 输出重定向到文件，强制覆盖

#### >> 输出重定向到文件，追加

#### <  输入重定向到文件

## 文件描述符

| 类型             | 文件描述符 | 默认情况       | 对应文件句柄位置 |
| ---------------- | ---------- | -------------- | ---------------- |
| 标准输入 std in  | 0          | 从键盘获得输入 | /proc/self/fd/0  |
| 标准输出 std out | 1          | 输出到屏幕     | /proc/self/fd/1  |
| 错误输出 err out | 2          | 输出到屏幕     | /proc/self/fd/2  |

- Note，如果不加说明`>`等于`1>`,即将标准输出重定向，`<`等于`0<`.
- `nohup test.py >/dev/null 2>&1 &`
    - 先将标准输出重定向到`null`里，再将错误输出也重定向到`1`即`null`中
    - Warning：如果`2>&1 >/dev/null`是不行的，这样错误输出仍然会输出到屏幕

# 管道

管道命令`|`传递的只是前一个任务的标准输出。`$?`存储上一次命令返回的结果

### xsel

- 一款软件

```
# 将剪切板中的内容输出到文件
echo $(xsel --clipboard) >> a.txt

# 将文件的内容复制到剪切板
cat a.txt | xsel --clipboard
```

### 选取命名

#### cut

```
cut -d '分隔字符' -f field // 用于分隔字符
cut -c 字符范围
[参数说明]
-d : 后面接分隔字符,通常与 -f 一起使用
-f : 根据-d 将信息分隔成数段，-f 后接数字 表示取出第几段，从1开始编号
-c : 以字符为单位取出固定字符区间的信息

//e.g.1:
打印/etc/passwd文件中以:为分隔符的第1个字段和第6个字段分别表示用户名和家目录
[root@izuf6i29flb2df231kt91hz /]# cat etc/passwd | cut -d ':' -f 1,6
root:/root             //相当于1是："root", 6是":/root"
bin:/bin
daemon:/sbin
adm:/var/adm
lp:/var/spool/lpd
...


//e.g.2:
打印/etc/passwd文件中每一行的前10个字符：
[root@izuf6i29flb2df231kt91hz /]# cat /etc/passwd | cut -c 1-10
root:x:0:0        // cut -c 1-  //表示从1到最后
bin:x:1:1:
daemon:x:2
adm:x:3:4:
lp:x:4:7:l
...
```

#### **grep**

```
grep [-acinv] [--color=auto] '查找字符串' filename
[参数]
-a : 将binary文件以text文件的方式查找数据
-c : 计算找到 '查找字符串'的次数
-i : 忽略大小写的不同
-n : 输出行号
-v : 反向选择，显示没有查找内容的行
--color=auto : 将找到的关键字部分加上颜色显示
```

#### **uniq**

```
uniq [-ic]
[参数]
-i ：忽略大小写的不同
-c ：进行计数

//e.g.1:
使用 last 取出历史登录信息的账号，排序，去重
[root@izuf6i29flb2df231kt91hz /]# last | cut -d ' ' -f 1 | sort | uniq -c
      1 
      7 reboot
     19 root
      1 wtmp
```

#### tr

```
tr [OPTION]... SET1 [SET2]
-s : 替换重复的字符
-d ：删除字符
-t ：字符替换，将SET1中字符用SET2对应位置的字符进行替换，一般缺省为-t
-c ：字符补集替换，用SET2替换SET1中没有包含的字符
```

- `-s`: 

    - ```
        e.g.: 
        [root@localhost ~]# echo "aaabbbaacccfddd" | tr -s [abcdf]
        abacfd        //只有出现在set1中的重复字符才会被压缩
        
        cat test.txt | tr -s "\n"
        \\可以删除空行，因为空行就是连续的两个\n
        ```

- `-d`：

    - 后面可以跟范围，例如`tr -d "[a-z][A-Z]"`

- `-t`：translate

    - 例如可以进行大小写转化`tr -t [afd] [AFO]`

- `-c`:

    - `tr -c "[a-z][A-Z]" "#"`
    - 将所有不是字母的都替换为`#`

#### **wc**

- ```
    wc [-lwm]
    [参数]
    -l ：仅列出行
    -w ：仅列出多少字(英文单字)
    -m ：多少字符
    ```

    

# TODO

- https://www.jianshu.com/p/9c0c2b57cb73看完

# 有用的命令：

- `cat ~/.zsh_history | cut -c 16- | tr -s "\n" | uniq | fzf | xsel --clipboard`
    - 将查到的命令复制到剪贴板了
    - alias是`mcom`
- `ctrl+z`后台；`fg %任务序号`调回前台（不是PID，是jobs中的序号，注意有%）
- `ctrl+s`锁定shell，`ctrl+q`退出锁定
- `ctrl+.`可以在中文模式下使用英文标点.

# `wget`

- `wget -P [dir] -O [filename] [url]`
    - `-P`指定保存路径
    - `-O`重命名下载文件名
    - `-P`在有`-O`时会失效:
        - 如果想同时指定保存路径和文件名 `-O [dir/filename]`