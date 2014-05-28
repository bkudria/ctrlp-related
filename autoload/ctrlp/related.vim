" =============================================================================
" File:          autoload/ctrlp/related.vim
" Description:   Example extension for ctrlp.vim
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['related']
"
" Where 'related' is the name of the file 'related.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ ]

" Load guard
if ( exists('g:loaded_ctrlp_related') && g:loaded_ctrlp_related )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_related = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
let s:ext_vars = {
	\ 'init': 'ctrlp#related#init(s:crbufnr)',
	\ 'accept': 'ctrlp#related#accept',
	\ 'lname': 'related files',
	\ 'sname': 'related',
	\ 'type': 'line',
	\ 'enter': 'ctrlp#related#enter()',
	\ 'exit': 'ctrlp#related#exit()',
	\ 'opts': 'ctrlp#related#opts()',
	\ 'sort': 0,
	\ 'specinput': 0,
	\ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
	call add(g:ctrlp_ext_vars, s:ext_vars)
else
	let g:ctrlp_ext_vars = [s:ext_vars]
endif

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#related#init(bufnr)
	let fname = s:getName(bufname(a:bufnr))

	" If there's no file, just return empty list
	if fname == ""
		return []
	endif

	let flist = split(glob("**/" . fname . ".*"), "\n")
	let foundInd = 0

	" Remove the current file from the list
	for i in flist
		if i == bufname(a:bufnr)
			call remove(flist, foundInd)
			break
		endif
		let foundInd = foundInd + 1
	endfor

	" @todo: if there's one only file, should just accept the file right away
	if len(flist) == 1
	endif

	return flist
endfunction

" Returns file name only, no file path and extension
function! s:getName(filename)
	return fnamemodify(a:filename, ':t:r')
endfunction

" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#related#accept(mode, str)
	" For this example, just exit ctrlp and run help
	call ctrlp#exit()
	echo a:str
	exec "edit " . a:str
	" help ctrlp-extensions
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#related#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#related#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#related#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#related#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/related.vim
" command! CtrlPRelated call ctrlp#init(ctrlp#related#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2

