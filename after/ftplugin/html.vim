runtime! snippet_helpers.vim

" snippets
" boilerplate html
inoremap ;html <cmd>call NormText("<!DOCTYPE html>") <bar> call NormNewLine() <bar> call NormText("<html>") <bar> call NormNewLine() <bar> call NormText("\<tab><head>") <bar> call NormNewLine() <bar> call NormText("\<tab>\<tab><meta charset=\"UTF-8\">") <bar> call NormNewLine() <bar> call NormText("\<tab>\<tab><meta name=\"description\" content=\"Description Of the Application\">") <bar> call NormNewLine() <bar> call NormText("\<tab>\<tab><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">") <bar> call NormNewLine() <bar> call NormText("\<tab></head>") <bar> call NormNewLine() <bar> call NormText("\<tab><body>") <bar> call NormNewLine() <bar> call NormText("\<tab>\<tab><div>change</div>") <bar> call NormNewLine() <bar> call NormText("\<tab></body>") <bar> call NormNewLine() <bar> call NormText("</html>") <bar> call NormGoToTop() <bar> call SearchWord("change") <bar> call SelectWord()<CR><Esc>l

inoremap ;img <img src="" alt=""><Esc>F<f"a
