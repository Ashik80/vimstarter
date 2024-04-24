runtime! ftplugin/javascript.vim
runtime! snippet_helpers.vim

" snippets mappings
" function component (rfc)
inoremap ;rfc <cmd>call NormText('import React from "react";') <bar> call NormNewLine() <bar> call NormNewLine() <bar> call NormText('export default function ComponentName() {') <bar> call NormNewLine() <bar> call NormText('<tab>return (') <bar> call NormNewLine() <bar> call NormText('<tab><tab><div>hello</div>') <bar> call NormNewLine() <bar> call NormText('<tab>);') <bar> call NormNewLine() <bar> call NormText('}') <bar> call NormIndentLeft() <bar> call NormGoToTop() <bar> call SearchWord('ComponentName') <bar> call SelectWord()<CR><Esc>l

" arrow component (rafc)
inoremap ;rafc <cmd>call NormText('import React from "react";') <bar> call NormNewLine() <bar> call NormNewLine() <bar> call NormText('const ComponentName = () => {') <bar> call NormNewLine() <bar> call NormText('<tab>return (') <bar> call NormNewLine() <bar> call NormText('<tab><tab><div>hello</div>') <bar> call NormNewLine() <bar> call NormText('<tab>);') <bar> call NormNewLine() <bar> call NormText('};') <bar> call NormIndentLeft() <bar> call NormNewLine() <bar> call NormNewLine() <bar> call NormText('export default ComponentName;') <bar> call NormGoToTop() <bar> call SearchWord('ComponentName') <bar> call SelectWord()<CR><Esc>l

inoremap ;img <img src="" alt="" /><Esc>F<f"a
