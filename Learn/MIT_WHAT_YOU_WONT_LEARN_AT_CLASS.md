# The Missing Semester of Your CS Education

## TODO

- 课程官网里的references material 和 homework其实比课程本身还要重要，推荐阅读

## Lecture 1: Course Overview + The Shell

- `Terminal`: application for display `shell`.
- `Environment Variable`:
    - `$PATH`: `where python`; `which python`
    - `/`: slash; `\`: backslash
- `cd ~` && `cd -`
- `ls -l` $=$ `l`
    - `drwxr-xr-x`:
        - `d`: directory (`-` means file)
        - `rwx`: permission for the owner of the file/directory
        - `r-x`: permission for the owner group of the file/directory
        - `r-x`: permission for everyone else of the file/directory
    - `rwx`: read write execute
        - for directory:
            - `r`: whether you can see files
            - `w`: whether you can create/ rename/ move/ delete files 
                - If you have permission on a file, but not the directory. You can empty it, but not delete it, because deleting requires direct action to the directory.
            - `x`: whether you can `cd` into the directory (and child directory)
- `mv`, `cp`
- `mkdir home\ world`: 
    - one directory called `home world`
- `>` && `<`:
    - `>` redirect standard output to
    - `<` redirect standard input with
    - `>`: override; `>>`: append
- `Pipe |`
    - `l | tail -n2`: `-n2`: last 2 lines of the input
    - `sudo echo 500 > brightness`: Permission denied
        - It means run `sudo` with argument `echo 500`, and then redirect the output to file `brightness`
        - The redirection won't be allowed as current user does not have the right permission.
        - `# sudo echo 500 > brightness`: `#` means run as root
    - `echo 500 | sudo tee brightness`
        - `tee`: take input as argument, redirects it to `the file` and `the standard output`
            - `-a ` as append
- `\sys`:
    - Interesting kernel module. (e.g. manipulate your Caps Lock Led light)

## Lecture 2: Shell Tools and Scripts

- `foo=bar`: assign

    - `foo = bar`: wrong, this command actually executes *call program foo with argument $=$ and $bar$*
        - be careful with \<space>

- `" and '`:

    - `"Value is $foo"`, foo will be replaced with its **real value**
    - `'Value is $foo'`, will just  give `$foo` as string

- Define function:

    - ```shell
        mcd () {
        	mkdir -p "$1"
        	cd "$1"
        }
        
        -p, --parents
        no error if existing, make parent directories as needed
        
        $0: the name of the script
        $1-$9: 1st to 9th arguments
        $#: the number of arguments given the the command
        $$: the pid
        $@: will expand to all arguments
        $?: the error code from the previous command (mcd is a function, mkdir is a command)
        $_: the last argument from the previous command
        !!: last command (e.g. mkdir /mnt/data -> permission denied -> sudo !!)
        
        
        &&, ||, ;
        ; : will always excute regardless of whether the previous command is successful
        ```

- `foo=$(pwd)`: get the **output** of the `pwd` command, and assign it to `foo` 

- `process substitution`:

    - `<(ls)`: put `ls`'s result to a temporary file and then treated as **a file handler**

    - ```
        $ cat <(ls)       #把<(ls)当一个临时文件，文件内容是ls的结果，cat这个临时文件
         
        $ ls > >(cat)      #把>(cat)当成临时文件，ls的结果重定向到这个文件，最后这个文件被cat
        ```

    - `cat $(ls)`: will cat every file is this folder

    - `cat <(ls)`: will simply display what's ls returns (think of `<(ls)` as a file)

    - keep in mind that `STDIN` is completely different from command line arguments:

        - [stackoverflow](https://unix.stackexchange.com/questions/46372/whats-the-difference-between-stdin-and-arguments-passed-to-command)
        - there are just two different things, you can image `STDIN` as a special file, and command line arguments as something you type in cmd. And the process will read from `STDIN` or command lists and react (if it's programed to do so). So `$(ls)` is actually like a string (`h j.txt b.txt`), and will expand before execution.
        - so `cat $(ls)` actually is like `cat h j.txt b.txt` 
        - `<(ls)` will only treat the `STDOUT` as file, not `STRERR` (but you can use `2>&1`)
            - `2` is a `[FILE_DESCRIPTOR]`, and `&2 means the value of the file discriptor`
            - In redirecting, the correct format should be `FILE_DESCRIPTOR > FILE(FILE_DESCRIPTOR Value)` 
        
    - one useful command: preview the output in vim (e.g. the `--help`)

    - ```
        # for preview help information in vim
        mvp() {
            vim <($@ 2>&1);
        }
        alias vp=mvp
        ```

- ![image-20200703124436328](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200703124436328.png)

- `ls project?`:
  
    - `?` will expand to one (not zero, not more) character.
    
- `convert image.png image.jpg` == `convert image.{png,jpg}`(no sapce!, {png, jpg} X)
    - `touch foo{,1}` == `touch foo foo1`
    - `touch project{1,2}\code{1,2}` (will create four files)
    - `cp vim.{md, wiki}`
    - `touch {a..d}`: will create `a` to `d`
    - `diff <(ls foo) <(ls bar)`
    
- `the magic line`: the first line in the script, specified what program to run this script (when using `./script.py` instead of `python script.py`)
    - `#!/usr/local/bin/python`
    - `#!/usr/bin/env python`: run process `env` with argument `python`, which will call the `python` in current environment
    
- `shellcheck mcd.sh`:
  
    - a tool for checking your script
    
- `source myscript.sh`: will add the content of this file to your shell
  
    - run the script is different [from](from) source/load the script
    
-  **USEFUL** `tldr` and `man`:
    - `tldr`: some useful **examples** regarding the program (all store in `~/.tldr`)
    - `man`:  the full capacity regarding the program
    
- TODO: [ls](https://unix.stackexchange.com/questions/62660/the-result-of-ls-ls-and-ls)

- **Finders**:
    - `find/locate/fzf` for find filename, `rg/grep` for find file content.
    - `find DIR -name scr -type d`:
        - `find . -path '**/test/*/py' -type f`: `**` stands for any level of directory
        - `find . -name 'a' -exec rm {} \;`: exec need a command line end with`;`, or `\;` in cmd.
    - `locate STRING`
    -  `grep`: (more useful concerning std/file)
        - `grep hh hh.txt`
        - `grep -R hh tmpt` (recursively match)
        
        - `grep -v hh tmpt` do not match
        
    - `rg`: a more useful tool (*can not use pip/conda to install, not support on ubuntu18.04, use pre compiled binary*)
        - called `ripgrep` in Github
    
        - `rg "function" -t py -C 5 ./project`
            - `-t` file type; `-C 5`: length of context provided
            - **search for where the function is used in your project**
        - `rg -u --files-without-match "^#\!" --stats -t sh`:
            - `-u`: include hidden files
            - `--files-without-match`: show files not match
            - `--stats` show counted match results
    
- **What if search for a string with `-`**

    - [read](https://unix.stackexchange.com/questions/11376/what-does-double-dash-mean/11382#11382)
    - `grep -- -f file`: `--` in bash denotes the end of the `option`

- `fzf`
  
- `hifstory 1`: print all your cmd history.

- `tree` and `broot`:
    - `broot`: https://dystroy.org/broot/install/  (vim like browser)
        - can just download pre-compiled bin
        - type as fuzzy finder
        - `enter` for enter / go back
        - `alt enter` for cd
        - `:view` for view in current tab
            - `:e` for edit using `$EDITOR`
        - `:q \ <C-q>` for quit
        - `<tab>` for jump between match
        - `/` for using regex
        - `c/STRING`: **search for file content**
        - `: move / cp` or `:cp_to_panel / move_to_panel`
            - `<C-LEFT> / <C-RIGHT>` for create / focus on different pane

## Lecture 3: vim

- `mode editor`: 
    - *normal*, *insert*, *replace*, *visual (`<S-v>,<C-v>`) -- line/block mode*, *command*
    - `^v = Ctrl-v = <C-v>`

-  `buffers | windows | tabs`:
    - ![image-20200704131634780](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200704131634780.png)
    - one buffer can be related to multiple windows (e.g. working on different sections of a file)
    - `:q` is not actually quit, it's just quit window. (no window then vim will quit)
        - `:qa`
- The interface (`vim`) is actually a programming language.
    - `^U / ^D`: up / down
    - `w / b`
    - `H M L`: move to the **highest, middle, lowest** line **on the screen**.
    - `fc`: find(move to) the first `c` in this line (after your cursor)
        - `Fc`: reverse find `c`. (before your cursor)
        - `t / T`: move cursor to the character, but not on the cursor
- `ce / de`: change will not only delete to the end, but also put you into insert mode.
- `ci[`: **change inside [**:
    - `[hello]`: will delete hello, and switches to insert mode.
- `ca[`: **change around/including [**
    - `[hello]`: will delete hello and `[]`, and switches to insert mode.
    - `ci' / da"` ....
- `.`: in normal mode, repeat **previous editing command**

## Lecture 4: Data wrangling

- convert data from one form to another.

- `journalctl`: show real time Linux log.

- `less` : open a file for interactive reading, kinda like low-end vim (do not forget my `vp` command in zsh)

- `tail` <--> `head`

- `sed`:
    - a stream editor: make change to the stream.
    - ![image-20200705154126693](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200705154126693.png)
    - Better use `sed -e "{{regex}}"` for it to support modern regex (otherwise it will only match **literal parenthesis**)
        - `"(ab)*"` means `(ab` and `)*`
        - if you want it to act like modern regex: use `\(ab\)*` or `-e "(ab)*"`
        - (PS： `？` for non-greedy match)
        - also try to use `''` instead of `""`, because `*` will be expand in `""` in cmd.
    -  the catch group:
        - `"users (.*)"`: `()` stands for a catch group (start from 1)
        - use `\NUMBER` to refer to any catch group
    - `*` won't stand for anything in regex (different from `shell`)
        - `.*` will do the job.
    - [regex debugger](https://regex101.com/):
    
- `sort`:
    - `sort -nk1,1`: 
        - `n`: numeric sort
        - `k`: each line of the input stream will be automatically separate with \<space> (different columns, start from 1) (can be a list, e.g. -k1,2)
    
- `uniq`:
  
    - `uniq -c`： count as well
    
- `awk`:
    - ![image-20200705161758626](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200705161758626.png)
    - e.g. `awk '$1 == 1 && $2 ~ /^hh.*e$/' '{print $1}'`
        - `~` means match regex expression 
        - `!=` for unmatch
    - `awk 'BEGIN {hit=0} '$1 == 1 {hit+=1} END {print hit}' `
        - `BEGIN`: hit=0 will execute only at line 0.
        - can also use `wc -l` (count lines)
    
- `paste`:
  
    - `paste -sd,` : paste input (lines) into a single file(`-s`) with delimiter(`-d`) comma.
    
- `bc`: (calculator)
    - ![image-20200705162809583](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200705162809583.png)
    - better use `bc -l`
    
- command line arguments wrangling:
    - `xargs`: take input (lines) and change them into arguments.
    -  `echo "h.txt" | xargs rm`
        - like `rm $(ls)`, but you can do more wrangling with stream
    - `{{argument_source}} | xargs -I _ {{commnad}} _`: here `_` is a placeholder (if not specified, default placeholder is `R`), it will be replaced with one line from the argument_source, and the command will be executed multiple times (same as lines number of argument_source)
    - `echo "Summary.md" | xargs -I _ bash -c "touch _ && ty _"`  (不能直接xargs -I _ touch _ && ty _, 因为会被拆成两个单独的命令)
    
- `-`: tell the program to use standard input rather than a file. (can be used as the last argument)

- `feh`: can be used to display image / image stream
  
    - `feh -`
    
- Random pick lines:

    - ```
        sort -R input | head -n 100 >output
        
        shuf -n N input > output
        
        # random pick 10% lines
        awk 'BEGIN {srand()} !/^$/ { if (rand() <= .01) print $0}'
        ```

## Lecture 5: Command-line Environment

### **Job Control**

- `<C-c>`: `SIGINT`
- `<C-\>` `SIGQUIT`
- `<C-z>`: `SIGSTOP`
    - `bg %NUMBER`: restart in the background  (`NUMBER` is job number, not pid)
    - `fg %NUMBER`: recover to the foreground.
    - `kill -STOP %NUMBER` : send `SIGSTOP` (pause)
- ![image-20200706150919672](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200706150919672.png)
- ![image-20200706151035581](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200706151035581.png)
    - if the program does not have a method for dealing with signals, default function will be executed.
    - `SIGKILL`: cannot be captured by captured. (force quit, might have uncontrollable result)
- `nohup` and` &`:
    - `&`: in background (ignore `<C-c>`)
    - `nohup`
        - when you log out, process will received a `SIGHUP`, usually it will terminate (unless use `nohup`

### **Terminal Multiplexers**

- `tmux`: session / window / panel
- Session:
    - `tmux a -t NUMBER`, `tmunx kill-server`

### **Dot-files**

- it's better to use version control

### **Remote Machine**

- `ssh-copy-id lemon@111.111.111.111`:

    - can do the following things automatically (so you won't need to enter password anymore)

    - generate a pub and secret key: 
        - pub key to remote machine (`.ssh/authorized_keys`)
        - key the secret key in your `~/.ssh`

- use `rsync` rather than `scp`:

    - `rsync` can restart at where it stops, and can transfer multiple files without entering password each time
    - ![image-20200706165907471](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200706165907471.png)

- `use ~/.ssh/config`, so you can just `ssh lemon` instead of `ssh lemon@111.111.111.111` (at 51 min)
- `htop` more readable than `top`

## Lecture 6: Version Control

### Some basic idea about git

-  `tree : folder`; `file ：　blob`

- O <- O <- O  (`<-` point to the parent)

- ```
    # basic elements
    type blob = array<byte>
    type tree = map<String, tree | blob>
    type commit = struct {
    	parents: array<commit>,
    	author: String,
    	message: String,
    	snapshot: tree
    } # actually they are reference
    
    type object = blob | tree | commit 
    objects = map<String, object>
    
    # store object : in git all objects are addressed by their hash
    def store(o):
    	id = hash(o) # sha1 for example
    	objects[id] = o
    	
    	
    type references = map<String, String> # map human readable name to hash id
    ```

- [git工作区和版本库(暂存区 +历史)](https://www.liaoxuefeng.com/wiki/896043488029600/897271968352576)

- 这堂课的其他 [info](https://missing.csail.mit.edu/2020/version-control/)

### **Oh-shit-git**

- `reset` && `revert`:

    - Annotations: `working-dir:工作区`,`index/stage: 暂存区`, `history: 历史`
    - 想要完成一个提交分三步:
        - `change` make some changes in `working-dir`
        - `add`: changes from `working-dir` to `index`
        - `commit`: changes from `index` to history
    - e.g. A <- B <- C(HEAD)
    - `git reset --soft B`:
        - just clean the `commit` step for C
        - `HEAD` will be reseted to `B`(actually branch master will be reseted)
        - which means your index will be like exactly the time before you type `git commit -m "C"`
        - which means all the changes in C will be staged in index, and your `working-dir` won't be affected.
    - `git reset (--mixed) B`:
        - clean `add ` && `commit`
        - `HEAD` will be reseted to `B`
        - you index will be changed so that it matches `B` in history.
        - your `working-dir` won't be affected.
    - `git reset --hard B`:
        - your `working-dir`, `index`, `history` will **all** reseted.

- `git --amend`

    - `git add newfile && git commit --amend --no-edit` : forget a file for last commit
    - `git commit --amend`: change commit message

- `git reflog`:

    - show everything you have done for this repo.

- `git stash`:

    - 将当前工作区/暂存区保存在工作栈, **reset**当前的working-tree到`HEAD`, 在需要的时候恢复

    - stash is actually a stash bag hanged to commit.

    - ```
        # push current working-dir and index into stash (stash@{num})
        git stash (--keep-index)
        //--keep-index: the index will be left intact
        
        # DONOT USE
        # recover the latest stash and drop it!!! (recommend `git statsh apply`)
        git stash pop
        
        git stash list
        git stash show 
        
        git stash apply stash(@{N}) (--index)
        //N: 倒数第几次stash, start from 1
        //--index: will try to recover the exact working-dir && index states brfore stash (which files have been added, and which are not)
        
        git stash drop stash(@{N})
        ```

- undo changes to a file:

    - ```python
        # find a hash for a commit before the file was changed
        git log
        # use the arrow keys to scroll up and down in history
        # once you've found your commit, save the hash
        git checkout [saved hash] -- path/to/file
        # the old version of the file will be in your index
        git commit -m "Wow, you don't have to copy-paste to undo"
        ```

## Lecture 7: Debugging and Profiling

### Debugging

- use `Log`
    - different lever, and format output
    - using colors
- logs usually: `/var/log`
    - one useful tool `lnav`: `cat /var/log/system.log | lnav -q` 
        - `-q`: do not print the logs
- `ipdb`: (a syntax highlight for `pdb`) ([see](https://www.cnblogs.com/wanghui-garcia/p/10644935.html))
    - a python debugger, please just ignore the warning now.
    - `l`: list code
    - `s`: take a step // `n`: next, 如果下一步有函数调用,不会进入(step会)
    - `c`: auto continue
    - `p/pp something`: print the value of something (pp用的是pprint)
        - `p locals()`
    - `a`: print current function's argument
    - `until NUMBER`: continue until a line number greater or equal is reached.
    - `q`: quit
    - ``: 直接回车会执行上一步的命令
    - `u/d`: 跳回上一层的调用, 调回之前的调用位置
    - `!变量名称/ 变量名称`:查看名称(因为变量名可能和指令冲突, 加一个!说明是变量)
    - `r(eturn)`执行至函数结束
    - `x=100`:修改变量值
    - `b NUMBER`: 在某一行加入断点(无数字则打印所有断点信息)
    - `c(ontinue)`
    - `l(ist) / ll`: l可以制定查看源码行数, 默认是往后11行, ll看所有
    - `run/restart args`: 给脚本提供参数运行

- `gdb`
- track `syscalls`:
    - `sudo strace ls`: trace all syscalls used in `ls`
- use `pylint / pyflakes` to check your code
    - `:CocCommand`: python.selectLinter

### Profiling

- `real time, user time, `
    - real time: real time
    - user time: the real time spent on your program on user level (时间片)
    - sys time: the real time spent on your program on kernel level
    - `time ls`: to check the time spent on `ls`
- `tracing profiles` && `sampling profiles`
- `perf`
    - ![image-20200707161407913](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200707161407913.png)

- `htop`: a more readable version of `top`
- `du -h .`: disk usage
    - `ncdu` a interactive version to check disk usage
    - ![image-20200707161827048](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200707161827048.png)

- `lsof`: check which program is using the port / file
    - ![image-20200707162012711](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200707162012711.png)
- `hyperfine`: compare two program's preformance

## Lecture 8: Metaprogrammning

### Build system:

- dependencies -> rules -> target output
- one useful tool: `make` (not necessary C++)
    - [Makefile Syntax](https://makefiletutorial.com/)

### Dependency management

- `repository`: apt, npm...
    - open, controlled
- `semantic versioning`:
    - `1.2.3`: 
        - 1 : the major version
            - a backwards **incompatible** update.
        - 2 : minor version
            - `add` something to the library. (and set the patch version to zero)
        - 3 : patch version
            - the change is entirely backwards **compatiable**. 

- `lock file`:
    - the version of the denpendency you use. (in case accidentally use dependency with wrong version)

### Continuous intergration systems

- `event trigger actions`
    - e.g. Github CI
    - hooks and event
- `dependable bot on Github`
- Github pages

### Testing

- Test suite: a **collective term** for all the tests
- Unit test: a “micro-test” that tests a **specific feature** in isolation
- Integration test: a “macro-test” that runs a larger part of the system to check that different feature or components work **together**.
- Regression test: a test that implements a particular pattern that *previously* caused a bug to ensure that the **bug does not resurface**.
- Mocking: to replace a function, module, or type with a fake implementation to **avoid testing unrelated functionality**. For example, you might “mock the network” or “mock the disk”

## Lecture 9: Security and Cryptography

### Entropy

- $log_2(possibility)$ = $-log_2(probability)$
- the strongness of your password.
    - assumption: the attacker knows the model of your password, but not the randomness.
- 40 bits of entropy is pretty good, but 80 bits or more is stronger.

### Hash function

- `SHA1`: arbitrary-sized inputs -> 160-bit output. (has been broken)

    - ```
        echo "hh" | sha1sum
        ```

- properties for hash functions:

    - `deterministic`: same input, same output.
    - `non-invertible`: given output, cannot find input.
    - `target collision resistant`: given one input, cannot find another input, with the same output.
    - `collision resistant`: cannot find two inputs, with same outputs.

- [hash methods lifetime](https://valerieaurora.org/hash.html)

- applications:

    - git; software signature; commitment schemes (say a commitment, but only reveal the sha results in advance).

### Key derivation functions (KDFs)

- will work slow: in case violent break.
- check whether the password is right by comparing the hash results.
    - `KDP(passowrd + salt)`

### Symmetric cryptography

### Asymmetric cryptography

- RSA

- public key; private key
- key distribution (how to get the public key safely)
- usually symmetric cryptography is fast and asymmeric cryptography is slow:
    - so usually we use asymmetric cryptography to transfer symmetric key, and use symmetric key for encryption. 
    - we can send those two together to others.

### Case studies

- password managers; two-factor authentication; full disk encryption; private messaging; ssh (the server uses the client's public key to encrypt a random number)

## Lecture 10: Potpourri

### Keyboard remapping

- xmodmap or autohotkey

### Daemons

- process working in the background.

- `systemd`: the system daemon

- `systemctl status`: list all daemons (which daemons are required by others)

    - `systemctl enable/ disable/ start/ stop/ restart/ status`

- ```shell
    # /etc/systemd/system/myapp.service
    [Unit]
    Description=My Custom App
    After=network.target   # dependencies
    
    [Service]
    User=foo
    Group=foo
    WorkingDirectory=/home/foo/projects/mydaemon
    ExecStart=/usr/bin/local/python3.7 app.py
    Restart=on-failure
    
    [Install]
    WantedBy=multi-user.target
    ```

### FUSE

- `touch hh.txt` <- userlevel

- `interaction with VFS` <- vitrual file system (kernel level)

- `dinteraction with your hard drive`

- so what if we want modify behavior concerning file system? But we should not modify the kernal code --> `FUSE (Filesystem in User Space)`

- FUSE: allows filesystems to be implemented by a user program. (usercode -> FUSE -> VFS -> hard drive)

    - so you can mount virtual filesystem throught ssh (e.g. to a remote machine)

- `sshfs`: Open locally remote files/folder through an SSH connection.

    - mount remote filesystem: `sshfs [user@]hostname:[directory] mountpoint `
    - to unmount them: `fusermount -u mountpoint`

    
