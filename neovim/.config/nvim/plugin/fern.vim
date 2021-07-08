" Disable netrw
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let g:loaded_netrwSettings=1
let g:loaded_netrwFileHandlers=1

let g:fern#default_hidden=1             " display hidden files and folders by default

let g:fern#renderer = "nerdfont"

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" Open fern in drawer mode
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=


nnoremap <silent> <Leader>ee :<C-u>Fern <C-r>=<SID>smart_path()<CR><CR>

" Return a parent directory of the current buffer when the buffer is a file.
" Otherwise it returns a current working directory.

function! s:smart_path() abort
    if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
        return fnamemodify('.', ':p')
    endif
    return fnamemodify(expand('%'), ':p:h')
endfunction
