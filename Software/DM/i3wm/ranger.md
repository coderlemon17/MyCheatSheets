# 基础操作(rc.conf)

`^ = ctrl`

- `hjkl`: move
    - `J / K`: large range move
    - `[ / ]`: move up / down in the parent directory
- `^r`: reload everything
    - `^l`: redraw the screen
- `q`:  quit
    - `Q`: quit all
- `gg`: top; `G`: bottom
- `i`: inspect current file in a bigger window
- `S`: open a shell in the current directory
- `cw`: change word, i.e. **rename** (completely rename) 
    - `A` : 在原文件尾巴添加/append
    - `I`:在原文件名头添加/insert

# Tasks

- `W`: task info
    - Opens the log window where you can review messages thatpop up at the bottom.
- `w`: open task window
    - Opens the task window where you can view and modify background processes that currently run in ranger.  In there, you can type `dd` to abort a process and `J` or `K` to change the priority of a process.  Only one process is run at a time.
- `^C`: stop background task
    - Stop the currently running background process that ranger has started, like copying files, loading directories or file previews.

# Copy/Cut and paste and delete

- `yy / dd`: copy / cut
- `pp / po`: paste /paste and override (if there is a file with the same name)
- `ya / da`: copy / cut the file into buffer
    - `yr / dr`: copy / cut the file, mode = remove
- `uy / yd`: clean the copy / cut buffer
- `DD`: delete through shell
- `dD`: mv to `~/.local/share/Trash/files/`
- `uD`: mv back the latest delete file (*only the latest*)
- `dDh`: show delete history, in `~/.config/ranger/trash_history`
    - so you can manually restore
- `yd / yn / yp`: copy only the directory, filename, or file path

# Settings

- `zh`: `!show_hidden`
- 

# Selection

- `space`
- `V`: into visual mode, move arond and select / unselect multiple files  （`esc`)
- `v`: change select mode of all files
- `uv`: unselect all files

# Navigation

- `f`： quick file filter (`tab` for moving around)

- `/`: regex search  (`n/N`)

- ```
    map gh cd ~
    map ge cd /etc
    map gu cd /usr
    map gd cd /dev
    map gl cd -r .
    map gL cd -r %f
    map go cd /opt
    map gv cd /var
    map gm cd /media
    map gM cd /mnt
    map gs cd /srv
    map gr cd /
    map gR eval fm.cd(ranger.RANGERDIR)
    map g/ cd /
    map g? cd /usr/share/doc/ranger
    ```

    

# Tabs

- 使用`<alt+NUMBER>`:切换tab  (or `shift + tab`)
- `q`退出

# 文件打开方式(scope.sh)

- 编辑`rifle.conf`
- 自己选择打开方式使用`r`

# 自定义utils

- `Z`: tar.gz
- `X`: untar / unzip

## TODO

- https://www.youtube.com/watch?v=L6Vu7WPkoJo
- 