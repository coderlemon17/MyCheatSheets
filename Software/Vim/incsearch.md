# Basic use

```
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
  
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)

```

- basically "/" for search, "?" for search backwards, "g/" for search while the cursor won't move
- and `Tab` for next hit, `<S-tab>` for previous one.
- `<C-j/k>` for display next page for search results.
