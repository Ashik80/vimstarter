runtime! ftplugin/javascript.vim

function! NormNewLine()
    execute 'norm o'
endfunction

function! NormText(text)
    execute 'norm i'.a:text
endfunction

function! NormIndentLeft()
  execute 'norm <<'
endfunction

function! NormGoToTop()
  execute 'norm gg'
endfunction

function! SearchWord(word)
  execute 'silent vimgrep '.a:word.' %'
endfunction

function! SelectWord()
  execute 'norm viw'
endfunction

" snippets mappings
" function component (rfc)
inoremap rfc<Tab> <cmd>call NormText('import React from "react";') \| call NormNewLine() \| call NormNewLine() \| call NormText('export default function ComponentName() {') \| call NormNewLine() \| call NormText('<tab>return (') \| call NormNewLine() \| call NormText('<tab><tab><div>hello</div>') \| call NormNewLine() \| call NormText('<tab>);') \| call NormNewLine() \| call NormText('}') \| call NormIndentLeft() \| call NormGoToTop() \| call SearchWord('ComponentName') \| call SelectWord()<CR>

" arrow component (rafc)
inoremap rafc<Tab> <cmd>call NormText('import React from "react";') \| call NormNewLine() \| call NormNewLine() \| call NormText('const ComponentName = () => {') \| call NormNewLine() \| call NormText('<tab>return (') \| call NormNewLine() \| call NormText('<tab><tab><div>hello</div>') \| call NormNewLine() \| call NormText('<tab>);') \| call NormNewLine() \| call NormText('};') \| call NormIndentLeft() \| call NormNewLine() \| call NormNewLine() \| call NormText('export default ComponentName;') \| call NormGoToTop() \| call SearchWord('ComponentName') \| call SelectWord()<CR>
