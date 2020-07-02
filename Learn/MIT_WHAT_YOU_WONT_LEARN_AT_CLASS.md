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
- 