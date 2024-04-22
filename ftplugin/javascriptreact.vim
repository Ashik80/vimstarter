runtime! ftplugin/javascript.vim

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

" snippets mappings
" function component (rfc)
inoremap ;rfc <cmd>call NormText('import React from "react";') <bar> call NormNewLine() <bar> call NormNewLine() <bar> call NormText('export default function ComponentName() {') <bar> call NormNewLine() <bar> call NormText('<tab>return (') <bar> call NormNewLine() <bar> call NormText('<tab><tab><div>hello</div>') <bar> call NormNewLine() <bar> call NormText('<tab>);') <bar> call NormNewLine() <bar> call NormText('}') <bar> call NormIndentLeft() <bar> call NormGoToTop() <bar> call SearchWord('ComponentName') <bar> call SelectWord()<CR><Esc>l

" arrow component (rafc)
inoremap ;rafc <cmd>call NormText('import React from "react";') <bar> call NormNewLine() <bar> call NormNewLine() <bar> call NormText('const ComponentName = () => {') <bar> call NormNewLine() <bar> call NormText('<tab>return (') <bar> call NormNewLine() <bar> call NormText('<tab><tab><div>hello</div>') <bar> call NormNewLine() <bar> call NormText('<tab>);') <bar> call NormNewLine() <bar> call NormText('};') <bar> call NormIndentLeft() <bar> call NormNewLine() <bar> call NormNewLine() <bar> call NormText('export default ComponentName;') <bar> call NormGoToTop() <bar> call SearchWord('ComponentName') <bar> call SelectWord()<CR><Esc>l
