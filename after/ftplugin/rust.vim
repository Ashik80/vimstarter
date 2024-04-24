compiler ruster

" comment visually selected block
function! CommentBlock()
    execute "norm `<0w"
    let l:starting_line = line("'<")
    let l:starting_col = col(".")
    let l:end_line = line("'>")

    execute l:starting_line.",".l:end_line."norm ".l:starting_col."|i// "
endfunction

vnoremap gc :<C-u>call CommentBlock()<CR>
