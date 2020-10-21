# 必死的操作

- 在`old`分支上, `git branch -f new`: 注意这里并不是**把old拉到new, 而是把new拉到old**, 所以你如果不记得之前的`new`的commit id,你就完了
    - 应该在`new`的时候`git branch -f old HEAD`
    - 多用`git merge`



# Git 

## Git 沙盒

- https://learngitbranching.js.org

## HEAD

- HEAD通常是指向当前分支的**分支指针**的, HEAD分离意思是HEAD不再指向某个分支指针而是commit
    - `git checkout [COMMIT ID]`

## git branch

- `git branch -f master HEAD~3`: 会将分支指针`master`强制指向当前HEAD的第三级父提交.
- `git branch -f master [COMMIT ID]`: 也可以

## git checkout

- `git checkout HEAD~n`: 可以将当前`HEAD`指针向前移动n次
- NOTE:
    - `git branch`修改的是分支指针(但一般情况下HEAD指向的就是分支指针)
    - `git checkout`修改的是HEAD

## git commit

- 新的空行将标题和主体两者隔开。

    *为什么：*

    > Git 非常聪明，它可将您提交消息的第一行识别为摘要。实际上，如果您尝试使用 `git shortlog` ，而不是 `git log` ，您会看到一个很长的提交消息列表，只会包含提交的 id 以及摘要（，而不会包含主体部分）。
    - 使用git commit / gc 可以在新打开的编辑器里完成这一工作
    - ctrl+x退出nano

- 在标题中使用 [祈使句](https://en.wikipedia.org/wiki/Imperative_mood) (表达命令、请求、劝告、警告、禁止等的句子)

    *为什么：*

    > 与其在写下的信息中描述提交者做了什么，不如将这些描述信息作为在这些提交被应用于该仓库后将要完成的操作的一个说明。[更多请阅读...](https://news.ycombinator.com/item?id=2079612)

- 使用主体部分去解释 **是什么** 和 **为什么** 而不是 **怎么做**。

## git cherry-pick

- `git cherry-pick [COMMIT ID]`, 会把对应commit id的版本**做出的修改**和当前版本进行合并(支持cherry-pick**多个**commit id)并形成一个/多个新的commit (取决于你cherry-pick了几个)
    - 相当可以把别的分支上的修改拿过来用
- 和merge的不同:
    - merge会把那一整个分支上的修改都merge过来
    - cherry-pick只会pick目标commit中做出的改动
- 一个trick:
    - 加入调试信息之后commit一下(commitA)
    - 然后bug修改完毕之后再commit一下(commitB)
    - 最后只需要在master分支cherry-pick commitB即可
- cherry-pick 可以将提交树上任何地方的提交记录取过来追加到 HEAD 上（只要不是 HEAD **上游**的提交就没问题）

## [git rebase](https://dev.to/lydiahallie/cs-visualized-useful-git-commands-37p1)

- 找到当前分支和`rebase`的目标分支的最近公共祖先, 然后把分支rebase过去.

- 创建自己的工作分支`work`, 记得每次`rebase`之前要先从`dev`上拉取最新信息, 当自己完成工作commit之后把`work`rebase到`dev`上去:

- `git rebase -i --autosquash dev`: 

    - 当前是在`work`分支, 这句话的意思是把当前分支rebase到dev上, 主要目的是为了防止git分叉
    - `git rebase -i` 表示`interative`地合并提交
        - `git rebase -i HEAD~2`: 表示对最近的两次提交进行交互式合并(包括HEAD指向的那个提交)
            - 如果想从当前分支的第一个提交开始rebase: `git rebase -i --root`
        - `--autosquash`: 会把所有提交压缩到一个提交

- 交互式合并:

    - `reword`: Change the commit message (你只需要把前面改成reword,之后会再有地方让你修改的)
    - `edit`: Amend this commit
    - `squash`: Meld commit into the previous commit
    - `fixup`: Meld commit into the previous commit, without keeping the commit's log message
    - `exec`: Run a command on each commit we want to rebase
    - `drop`: Remove the commit

- 如果有冲突,需要解决冲突, 之后在:

    - ```
        git add <file1> <file2> ...
        git rebase --continue
        ```

- 由于你的操作修改了历史,所以**有可能**需要强制提交: `git push -f`

    - 当与他人合作时**建议使用更温和的git push --force-with-lease**
    - 当本地仓库落后于远程仓库时,`-f`提交会覆盖那些存在于远程仓库而本地没有的别人的提交, 但是`--force-with-lease`会被拒绝
        - 即使你`pull`之后再`-f`也不安全,因为从`pull`到`-f`还是存在时间差
        - 注意你如果先`fetch`,再`--force-with-lease`,那么一定能成功,不管你fetch下来的存不存在修改或者你有没有commit这些修改:
            - 故如果你`fetch`下来的存在修改,记得再rebase一次.
            - `pull=fetch+merge`: 故`fetch`相对安全
            - 一旦提交到远程公共分支,就**绝对不要再rebase了**

- 注意: rebase其实是把你要reabse的提交节点复制了一遍, 然后rebase到了目标节点去

- ```
    ick 2bdfd62 Add report for Meeting1.
    
    # Rebase 07b137e..2bdfd62 onto 07b137e (1 command)
    #
    # Commands:
    # p, pick = use commit
    # r, reword = use commit, but edit the commit message
    # e, edit = use commit, but stop for amending
    # s, squash = use commit, but meld into previous commit
    # f, fixup = like "squash", but discard this commit's log message
    # x, exec = run command (the rest of the line) using shell
    # d, drop = remove commit
    #
    //注意,最上面的commit是最老的,squash是squash到前一个commit
    # These lines can be re-ordered; they are executed from top to bottom.
    #
    # If you remove a line here THAT COMMIT WILL BE LOST.
    #
    # However, if you remove everything, the rebase will be aborted.
    #
    # Note that empty commits are commented out
    ```


## git reset

- `git reset`修改的只是当前所在分支的分支指针指向版本树的位置.

## git revert

- 会生成一个新的提交, 对于有多人合作的远程分支尽量用revert.
- `git revert [COMMIT ID]`: 相当于会生成一个和目标提交状态一模一样的新的提交

## TODO: git submodule

- https://www.cnblogs.com/lsgxeva/p/8540758.html
- https://blog.justwe.site/post/git-submodule/

# gitignore

## 模型文件:

- `.gitignore`可以存在多个,每个只负责自己存在的那个目录.

- 例如在`/project/model`,可在model文件夹下建立一个`.gitignore`

    - ```
        *
        !.gitignore
        ```

        