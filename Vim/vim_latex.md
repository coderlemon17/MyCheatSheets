# vimtex

- `\ll`: start compiling the document in continuous mode
- `\lv`: open pdf viewer and/or do forward search
- `\ll (or \lk)`: stop the running compilation
- `\le`: to parse log file and see errors (`esc` for exit)
- `\lc`: to clean auxiliary files (or `\lC` to remove pdf, too)

# vimautosave

- `:AutoSaveToogle`

# [UltiSnips](https://castel.dev/post/lecture-notes-1/#latex-snippets)

## Utils

- `sign / today / box`

## Environment

- `beg`: begin environment

    - ```latex
        snippet beg "begin{} / end{}" bA
        \begin{$1}
        	$0
        \end{$1}
        endsnippet
        ```

        - `b`: only be ex­pand­ed at the be­gin­ning of a line
        - `A`: automatically expanded (no need for `Tab`)

- 