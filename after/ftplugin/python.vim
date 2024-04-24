command! MakeTags execute 'silent !ctags -R --exclude=.git --exclude=venv .' | redraw! | e

" generates the relative path of the file being imported from the project root
function! ImportRelativeFile()
    let l:splitted_source = split(@f, "/")
    let l:splitted_path = l:splitted_source[0:-2]
    let l:path = join(l:splitted_path, ".")
    let l:filename = split(l:splitted_source[-1], "\\.")[0]
    let l:relative_path = l:path.".".l:filename

    execute "norm a".l:relative_path
endfunction

compiler pyright

" comment visually selected block
function! CommentBlock()
    execute "norm `<0w"
    let l:starting_line = line("'<")
    let l:starting_col = col(".")
    let l:end_line = line("'>")

    execute l:starting_line.",".l:end_line."norm ".l:starting_col."|i# "
endfunction

nnoremap <leader>pf <cmd>call ImportRelativeFile()<CR>
nnoremap <leader>mt <cmd>MakeTags<CR>
vnoremap gc :<C-u>call CommentBlock()<CR>
