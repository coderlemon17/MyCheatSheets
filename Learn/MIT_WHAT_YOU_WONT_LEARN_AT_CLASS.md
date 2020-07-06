# The Missing Semester of Your CS Education

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
        
    - `rg`: a more useful tool (*use pip/conda to install*)
        - `rg "function" -t py -C 5 ./project`
            - `-t` file type; `-C 5`: length of context provided
            - **search for where the function is used in your project**
        - `rg -u --files-without-match "^#\!" --stats -t sh`:
            - `-u`: include hidden files
            - `--files-without-match`: show files not match
            - `--stats` show counted match results
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

- **Job Control**
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
        - `&`: in background (ignore `<C-c`)
        - `nohup`
            - when you log out, process will received a `SIGHUP`, usually it will terminate (unless use `nohup`

- **Terminal Multiplexers**
    - `tmux`: session / window / panel
    - 
- **Dot-files**
- 
- **Remote Machine**