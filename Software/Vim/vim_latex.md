# vimtex

- `\ll`: start compiling the document in continuous mode
- `\lv`: open pdf viewer and/or do forward search
- `\ll (or \lk)`: stop the running compilation
- `\le`: to parse log file and see errors (`esc` for exit)
- `\lc`: to clean auxiliary files (or `\lC` to remove pdf, too)

# vimautosave

- `:AutoSaveToogle`

# [UltiSnips](https://castel.dev/post/lecture-notes-1/#latex-snippets)

## NOTE

- Unfortunately, it's **impossible** to jump back after you reach `$0` placeholder because of performance reasons. UltiSnips finishes snippet as soon as you reach last placeholder to keep things fast.

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


## Inline and display math

- `mk`: inline math, `$$`

- ```latex
    snippet mk "Math" wA
    $${1}$`!p
    if t[2] and t[2][0] not in [',', '.', '?', '-', ' ']:
        snip.rv = ' '
    else:
        snip.rv = ''
    `$2
    endsnippet
    ```

    - `w`: only expand at *word boundaries*

- `dm`: display math, `\[ .\]`

## Sub- and superscripts

- An­oth­er use­ful snip­pet is one for sub­scripts. It changes changes `a1` to `a_1` and `a_12` to `a_{12}`.

- use `td` for `^{}`, and after insert, a tab will bring you to `$0`

    - ```
        snippet td "superscript" iA
        ^{$1}$0
        endsnippet
        ```

## Fractions

- ```
    //	→	\frac{}{}
    3/	→	\frac{3}{}
    ```

- The last snip­pet con­cern­ing frac­tions I’d like to share is one that uses your se­lec­tion to make a fraction. You can use it by first se­lect­ing some text, then press­ing Tab, typ­ing `/` and press­ing Tab again.

    ![visualfrac](https://castel.dev/0da01b9566dc437fabf0c563ed14941f/visualfrac.gif)


## Sympy and Mathematica

- An­oth­er cool — but less used — snip­pet is one that uses [sympy](https://www.sympy.org/) to evaluate math­e­mat­i­cal expressions. For ex­am­ple: `sympy` Tab ex­pands to `sympy | sympy`, and `sympy 1 + 1 sympy` Tab ex­pands to `2`.

    ![sympy](https://castel.dev/8c8f143fdcdc2f3e6de9853cf7ea3def/sympy.gif)