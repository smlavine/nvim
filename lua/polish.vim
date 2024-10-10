" Some Vimscript copied from my original vim configuration that I have not
" translated to Lua for use in AstroNvim.

" I try to keep my max columns to 80 lines. This lets me know when I go over.
highlight ColorColumn ctermbg=black
let &colorcolumn=join(range(80,80),",")

" When writing Markdown, I prefer to use a 72 column max length. This allows
" me to toggle it quickly.
fun! ToggleColumnWidth()
	if (&colorcolumn == 80)
		let &colorcolumn=join(range(73, 80),",")
		set textwidth=72
	else
		let &colorcolumn=join(range(80,80),",")
		set textwidth=0
	endif
endfun
au BufNewFile,BufRead *.md call ToggleColumnWidth()
nnoremap <C-B> :call ToggleColumnWidth()<CR>

" Run Modal (https://git.sr.ht/~smlavine/zm) code on selections.
" zm is in development; if I am in the development folder and there is the
" executable present, run that; otherwise assume locally installed.
fun! ModalOnSelection()
	if filereadable("./zm-debug")
		'<,'>!xp ./zm-debug -F
	elseif filereadable("./zm")
		'<,'>!xp ./zm -F
	elseif filereadable(expand("~/.local/bin/zm"))
		'<,'>!xp ~/.local/bin/zm -F
	endif
endfun
vnoremap <F4> :call ModalOnSelection()<CR>
nnoremap <F4> :call ModalOnSelection()<CR>

" TODO actually fix
" workaround for big error messages when opening git's COMMIT_EDITMSG.
autocmd BufRead,BufNewFile COMMIT_EDITMSG TSDisable highlight
