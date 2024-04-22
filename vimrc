let g:mapleader = " "

syntax on
filetype plugin indent on

set bg=dark
set number
set noswapfile
set incsearch
set hidden
set shiftwidth=4 tabstop=4 expandtab
set smartindent autoindent
set backspace=indent,eol,start
set ignorecase
set laststatus=2
set showcmd
set ttimeoutlen=0
set scrolloff=8
set cursorline

" commands
command! ListFiles execute '.!find . -type d \( -name .git -o -name node_modules -o -name .build -o -name dist -o -name __pycache__ -o -name .next \) -prune -o -type f -print | sed "s/^\.\///"'
command! Build execute 'silent make' | redraw! | cw

" colorscheme
" colorscheme desert
" hi Normal ctermbg=NONE
" hi NonText ctermbg=NONE
" hi MatchParen term=bold cterm=bold ctermfg=143 ctermbg=NONE guifg=#bdb76b guibg=NONE

" colorscheme tokyonight
" hi Normal ctermbg=NONE
" hi CursorLine ctermbg=black

colorscheme koehler
hi MatchParen term=bold cterm=bold ctermfg=226 ctermbg=NONE guifg=#ffff00 guibg=NONE

" status line plugin
let g:modes = {
            \ 'n': 'NORMAL',
            \ 'i': 'INSERT',
            \ 'v': 'VISUAL',
            \ 'V': 'VISUAL LINE',
            \ '': 'VISUAL BLOCK',
            \ 'c': 'COMMAND',
            \ 'R': 'REPLACE',
            \ 'r': 'REPLACE',
            \ 't': 'TERMINAL'
            \ }

function! GetFileType()
    if &filetype == ""
        return ""
    endif
    return "%#Folded# %y"
endfunction

function! GetLineAndColumn()
    return "%l:%c "
endfunction

let g:git_branch = ""

function! GetGitBranch()
    let l:branch = system("git branch | grep ^* | sed 's/\* //'")
    if l:branch != ""
        " for desert
        " let g:git_branch = \"%#Pmenu# \".split(l:branch, '\n')[0]." "

        " for koehler
        let g:git_branch = "%#Folded# ".split(l:branch, '\n')[0]." "

        " for tokyonight
        " let g:git_branch = \"%#Folded# \".split(l:branch, '\n')[0]." "
    endif
endfunction

call GetGitBranch()

" desert statusline
" set statusline=%#PmenuSel#\ %{g:modes[mode()]}\ %{%g:git_branch%}%#Folded#\ %f\ %m\ %r\ %h\ %w%=%{%GetFileType()%}\ %#PmenuSel#\ %{%GetLineAndColumn()%}

" koehler statusline
set statusline=%#PmenuSel#\ %{g:modes[mode()]}\ %{%g:git_branch%}%#Pmenu#\ %f\ %m\ %r\ %h\ %w%=%{%GetFileType()%}\ %#PmenuSel#\ %{%GetLineAndColumn()%}

" tokyonight statusline
" set statusline=%#TabLineSel#\ %{g:modes[mode()]}\ %{%g:git_branch%}%#Pmenu#\ %f\ %m\ %r\ %h\ %w%=%{%GetFileType()%}\ %#TabLineSel#\ %{%GetLineAndColumn()%}

" file to register
function! FileToRegister()
    let l:register = input("Enter register key: ")
    let l:current_file = expand("%:.")
    execute "let @".l:register." = ':e ".l:current_file."'"
endfunction

" show git blame for the next 10 lines
function! GitBlameFewLines()
    execute "!echo '------------------- GIT BLAME -------------------'"
    execute "!git blame -c -L ".line(".").",+10 %"
endfunction

" toggle terminal
function! ToggleTerm()
    let l:terms = term_list()
    if empty(l:terms)
        execute "bel terminal"
    else
        let l:term = l:terms[0]
        if bufwinnr(l:term) < 0
            execute "bel split"
            execute "buffer ".l:term
        else
            execute bufwinnr(l:term) "close"
        endif
    endif
endfunction

" grep/search functionality
" same functionality with grep and vimgrep. default: vimgrep
" change to grep in the keybinding if more speed is needed
function! GrepProject()
    let l:word = input("Search for pattern: ")
    execute "grep! -Ri --exclude={tags,tsconfig.tsbuildinfo} --exclude-dir={.git,node_modules,.next,.build,dist,target,__pycache__} ".l:word." ."
    cwindow
endfunction

function! VimGrepProject()
    let l:word = input("Search for pattern: ")
    execute 'vimgrep! /'.l:word.'/ `find . -type d \( -name .git -o -name node_modules -o -name .next -o -name .build -o -name dist -o -name target -o -name __pycache__ \) -prune -o -type f \( -name tags -o -name tsconfig.tsbuildinfo \) -prune -o -type f -print`'
    cwindow
endfunction

function! GrepProjectForExactWord()
    let l:word = input("Search for exact word: ")
    echo "\n".l:word
    execute "grep! -Riw --exclude={tags,tsconfig.tsbuildinfo} --exclude-dir={.git,node_modules,.next,.build,dist,target,__pycache__} ".l:word." ."
    cwindow
endfunction

function! VimGrepProjectForExactWord()
    let l:word = input("Search for exact word: ")
    execute 'vimgrep! /\<'.l:word.'\>/ `find . -type d \( -name .git -o -name node_modules -o -name .next -o -name .build -o -name dist -o -name target -o -name __pycache__ \) -prune -o -type f \( -name tags -o -name tsconfig.tsbuildinfo \) -prune -o -type f -print`'
    cwindow
endfunction

" mappings
vnoremap <leader>y :w !xclip -selection 'clipboard'<CR><CR>
nnoremap <leader>yf <cmd>let @f = expand("%:.")<CR>
nnoremap <leader>q <cmd>qa!<CR>
nnoremap <leader>fr <cmd>call FileToRegister()<CR>
nnoremap <leader>lf <cmd>ListFiles<CR>
nnoremap <leader>gb <cmd>call GitBlameFewLines()<CR>
vnoremap > >gv
vnoremap < <gv
nnoremap <leader>b <cmd>Build<CR>
nnoremap <C-h> <cmd>cn<CR>
nnoremap <C-k> <cmd>cp<CR>
nnoremap <leader>t <cmd>call ToggleTerm()<CR>
tnoremap <leader>t <cmd>call ToggleTerm()<CR>
nnoremap <leader>fg <cmd>call VimGrepProject()<CR>
nnoremap <leader>fw <cmd>call VimGrepProjectForExactWord()<CR>
