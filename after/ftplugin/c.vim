runtime! commenter.vim

let g:ale_c_cc_options = '`pkg-config --cflags --libs gtk4`'
let g:ale_linters_ignore = {'c': ['clangd']}

vnoremap gc :<C-u>call CommentBlock("//")<CR>
nnoremap gcc :call CommentLine("//")<CR>
