function! NormNewLine()
    execute "norm o"
endfunction

function! NormText(text)
    execute "norm i".a:text
endfunction

function! NormIndentLeft()
  execute "norm <<"
endfunction

function! NormGoToTop()
  execute "norm gg"
endfunction

function! SearchWord(word)
  execute "silent vimgrep ".a:word." %"
endfunction

function! SelectWord()
  execute "norm viw"
endfunction

" html/jsx snippets
inoremap ;div <div></div><Esc>F>a
inoremap ;h1 <h1></h1><Esc>F>a
inoremap ;h2 <h2></h2><Esc>F>a
inoremap ;h3 <h3></h3><Esc>F>a
inoremap ;h4 <h4></h4><Esc>F>a
inoremap ;h5 <h5></h5><Esc>F>a
inoremap ;h6 <h6></h6><Esc>F>a
inoremap ;p <p></p><Esc>F>a
inoremap ;button <button type=""></button><Esc>F>a
inoremap ;title <title></title><Esc>F>a
