# Git 工作规则

## git rebase

- 创建自己的工作分支`work`, 记得每次要先从`dev`上拉取最新信息, 当自己完成工作commit之后

- `git rebase -i --autosquash dev`: 

    - 当前是在`work`分支, 这句话的意思是把当前分支rebase到dev上, 主要目的是为了防止git分叉
    - `git rebase -i` 表示合并提交
        - `git rebase -i HEAD~2`: 表示合并最近的两次提交
        - `--autosquash`: 会把所有提交压缩到一个提交
    - NOTE: `glog`下`git历史记录`看起来更好看

- 如果有冲突,需要解决冲突, 之后在:

    - ```
        git add <file1> <file2> ...
        git rebase --continue
        ```

- 由于你的操作修改了历史,所以需要强制提交: `git push -f`

    - 当与他人合作时**建议使用更温和的git push --force-with-lease**
    - 当本地仓库落后于远程仓库时,`-f`提交会覆盖那些仅仅存在远程仓库的别人的提交, 但是`--force-with-lease`会被拒绝
        - 即使你`pull`之后再`-f`也不安全,因为从`pull`到`-f`还是存在时间差
        - 注意你如果先`fetch`,再`--force-with-lease`,那么一定能成功,不管你fetch下来的存不存在修改:
            - 故如果你`fetch`下来的存在修改,记得再rebase一次.
            - `pull=fetch+merge`: 故`merge`相对安全
            - 一旦提交到公共分支,就**绝对不要再rebase了**

## commit message

- 