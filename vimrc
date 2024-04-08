let g:mapleader = " "

syntax on
filetype plugin indent on

set bg=dark
set number
set noswapfile
set incsearch
set hidden
set shiftwidth=4 tabstop=4 expandtab
set backspace=indent,eol,start
set ignorecase
set laststatus=2
set showcmd
set ttimeoutlen=0

" commands
command! ListFiles execute '.!find . -type d \( -name .git -o -name node_modules -o -name .build -o -name dist -o -name __pycache__ -o -name .next \) -prune -o -type f -print | sed "s/^.\//:e /"'

" colorscheme
colorscheme desert
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE
hi MatchParen term=bold cterm=bold ctermfg=143 ctermbg=NONE guifg=#bdb76b guibg=NONE

" status line plugin
let g:modes = {
            \ 'n': 'NORMAL',
            \ 'i': 'INSERT',
            \ 'v': 'VISUAL',
            \ 'V': 'VISUAL LINE',
            \ '': 'VISUAL BLOCK',
            \ 'c': 'COMMAND',
            \ 'R': 'REPLACE',
            \ 't': 'TERMINAL'
            \ }

function! GetFileType()
    if &filetype == ""
        return ""
    endif
    return "%#Search# %y"
endfunction

function! GetLineAndColumn()
    return "%l:%c "
endfunction

let g:git_branch = ""

function! GetGitBranch()
    let l:branch = system("git branch | grep ^* | sed 's/\* //'")
    if l:branch != ""
        let g:git_branch = "%#Pmenu# ".split(l:branch, '\n')[0]." "
    endif
endfunction

call GetGitBranch()

set statusline=%#PmenuSel#\ %{g:modes[mode()]}\ %{%g:git_branch%}%#Folded#\ %f\ %m\ %r\ %h\ %w%=%{%GetFileType()%}\ %#PmenuSel#\ %{%GetLineAndColumn()%}

" file to register
function! FileToRegister()
    let l:register = input("Enter register key: ")
    let l:current_file = expand("%:.")
    execute "let @".l:register." = ':e ".l:current_file."'"
endfunction

" show git blame
function! GitBlameFewLines()
    execute "!echo '------------------- GIT BLAME -------------------'"
    execute "!git blame -c -L ".line(".").",+10 %"
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
