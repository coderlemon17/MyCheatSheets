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

    - `cat <(ls)`: will simply display what's ls returns

- ![image-20200703124436328](/home/lemon/Workspace/myCheatSheet/Learn/pic/image-20200703124436328.png)

- `ls project?`:
    - `?` will expand to one (not zero, not more) character.
- `convert image.png image.jpg` == `convert image.{png, jpg}`
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
    - run the script is different from source/load the script
-  **USEFUL** `tldr` and `man`:
    - `tldr`: some useful **examples** regarding the program (all store in `~/.tldr`)
    - `man`:  the full capacity regarding the program
- TODO: [ls](https://unix.stackexchange.com/questions/62660/the-result-of-ls-ls-and-ls)

- `find DIR -name scr -type d`:
    - `find . -path '**/test/*/py' -type f`: `**` stands for any level of directory
    - `find . -name 'a' -exec rm {} \;`: exec need a command line end with`;`, or `\;` in cmd.
- `locate STRING`
-  `grep`: (more useful concerning std/file)
    - `grep hh hh.txt`
    - `grep -R hh tmpt`

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