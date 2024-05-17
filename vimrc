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
set autoread

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" commands
command! ListFiles execute '.!find . -type d \( -name pack -o -name .git -o -name node_modules -o -name .build -o -name dist -o -name __pycache__ -o -name .next -o -name target \) -prune -o -type f -print | sed "s/^\.\///"'
command! Build execute 'silent make' | redraw! | cw
command! MkdirAndSave execute 'silent !mkdir -p %:h' | redraw! | w

" colorscheme
hi LineNr ctermfg=248
hi MatchParen term=bold cterm=bold ctermfg=11 ctermbg=NONE guifg=#ffff00 guibg=NONE
hi Pmenu ctermbg=239 ctermfg=14
hi PmenuSel ctermbg=14 ctermfg=0
hi CursorLine term=NONE cterm=NONE ctermbg=237
hi CursorLineNr term=NONE cterm=NONE
hi SpellBad term=underline cterm=underline ctermfg=9 ctermbg=NONE
hi SpellCap term=underline cterm=underline ctermfg=12 ctermbg=NONE
hi SignColumn ctermbg=NONE

" statusline setting
hi CommandDisp ctermfg=0 ctermbg=11
hi GitDisp ctermfg=11 ctermbg=239
hi FileDisp ctermfg=white ctermbg=237

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
    return "%#GitDisp# %y"
endfunction

function! GetLineAndColumn()
    return "%l:%c "
endfunction

let g:git_branch = ""

function! GetGitBranch()
    let l:branch = system("git branch | grep ^* | sed 's/\* //'")
    if l:branch != ""
        " for rosepine
        let g:git_branch = "%#GitDisp# ".split(l:branch, '\n')[0]." "
    endif
endfunction

call GetGitBranch()

" rosepine statusline
set statusline=%#CommandDisp#\ %{g:modes[mode()]}\ %{%g:git_branch%}%#FileDisp#\ %f\ %m\ %r\ %h\ %w%=%{%GetFileType()%}\ %#CommandDisp#\ %{%GetLineAndColumn()%}

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
    execute "grep! -Ri --exclude={tags,tsconfig.tsbuildinfo} --exclude-dir={pack,.git,node_modules,.next,.build,dist,target,__pycache__} ".l:word." ."
    cwindow
endfunction

function! VimGrepProject()
    let l:word = input("Search for pattern: ")
    execute 'vimgrep! /'.l:word.'/ `find . -type d \( -name pack -o -name .git -o -name node_modules -o -name .next -o -name .build -o -name dist -o -name target -o -name __pycache__ \) -prune -o -type f \( -name tags -o -name tsconfig.tsbuildinfo \) -prune -o -type f -print`'
    cwindow
endfunction

function! GrepProjectForExactWord()
    let l:word = input("Search for exact word: ")
    echo "\n".l:word
    execute "grep! -Riw --exclude={tags,tsconfig.tsbuildinfo} --exclude-dir={pack,.git,node_modules,.next,.build,dist,target,__pycache__} ".l:word." ."
    cwindow
endfunction

function! VimGrepProjectForExactWord()
    let l:word = input("Search for exact word: ")
    execute 'vimgrep! /\<'.l:word.'\>/ `find . -type d \( -name pack -o -name .git -o -name node_modules -o -name .next -o -name .build -o -name dist -o -name target -o -name __pycache__ \) -prune -o -type f \( -name tags -o -name tsconfig.tsbuildinfo \) -prune -o -type f -print`'
    cwindow
endfunction

" remove line numbers for the terminal buffer
augroup TermNoNumber
    au! TerminalOpen * setlocal nonumber
augroup END


" Comment syntax highlighting
hi TodoComment term=bold cterm=bold ctermfg=0 ctermbg=14
call matchadd("TodoComment", " TODO:")

hi WarnComment term=bold cterm=bold ctermfg=0 ctermbg=11
call matchadd("WarnComment", " WARN:")

hi InfoComment term=bold cterm=bold ctermfg=0 ctermbg=13
call matchadd("InfoComment", " INFO:")

hi BugComment term=bold cterm=bold ctermfg=0 ctermbg=9
call matchadd("BugComment", " BUG:")
call matchadd("BugComment", " ERROR:")

hi NoteComment term=bold cterm=bold ctermfg=0 ctermbg=121
call matchadd("NoteComment", " NOTE:")

" mappings

" clipboard mapping
if has("clipboard")
    vnoremap <leader>y "+y
    nnoremap <leader>y "+y
    vnoremap <leader>Y "+Y
    nnoremap <leader>Y "+Y

    vnoremap <leader>cp "+p
    nnoremap <leader>cp "+p
    vnoremap <leader>cP "+P
    nnoremap <leader>cP "+P
else
    vnoremap <leader>y :w !xclip -selection 'clipboard'<CR><CR>
endif

nnoremap <leader>yf <cmd>let @f = expand("%:.")<CR>
nnoremap <leader>q <cmd>qa!<CR>
nnoremap <leader>fr <cmd>call FileToRegister()<CR>
nnoremap <leader>lf <cmd>ListFiles<CR>
nnoremap <leader>gb <cmd>call GitBlameFewLines()<CR>
vnoremap > >gv
vnoremap < <gv
nnoremap <leader>b <cmd>Build<CR>
nnoremap <C-n> <cmd>cn<CR>
nnoremap <C-p> <cmd>cp<CR>
nnoremap <Esc>t <cmd>call ToggleTerm()<CR>
tnoremap <Esc>t <cmd>call ToggleTerm()<CR>
nnoremap <leader>fg <cmd>call VimGrepProject()<CR>
nnoremap <leader>fw <cmd>call VimGrepProjectForExactWord()<CR>
nnoremap <leader>ff <cmd>b 1<CR>
nnoremap <leader>w <cmd>MkdirAndSave<CR>
" replace all occurences of word in line
vnoremap <leader>s y:s/<c-r>"//g<left><left>
" edit vimrc from anywhere
nnoremap <leader>ve <cmd>vsplit $MYVIMRC<CR>
" surround word with quotes/brackets
vnoremap <leader>" c"<c-r>""<esc>
vnoremap <leader>' c'<c-r>"'<esc>
vnoremap <leader>) c(<c-r>")<esc>
vnoremap <leader>} c{<c-r>"}<esc>
vnoremap <leader>] c[<c-r>"]<esc>


" ale settings
set omnifunc=ale#completion#OmniFunc
set signcolumn=yes
nnoremap K <cmd>ALEHover<CR>
nnoremap <leader>gd <cmd>ALEGoToDefinition<CR>
nnoremap <leader>gr <cmd>ALEFindReferences<CR>
nnoremap <leader>ca <cmd>ALECodeAction<CR>
let g:ale_completion_enabled = 1
set completeopt=menuone,noselect
