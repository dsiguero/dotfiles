lua require('telescope')

" Prompts user for string to grep by
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>

" Shows git files
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>

" Shows git stashes
nnoremap <leader>gs :lua require('telescope.builtin').git_stash()<CR>

" File finder
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>

" Greps by current word
nnoremap <leader>pw :lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>")})<CR>

" Buffers
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>

" Open help for Vim's tags 
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
