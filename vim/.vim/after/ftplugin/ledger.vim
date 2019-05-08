setlocal foldmethod=syntax

let g:ledger_extra_options = '--pedantic'

" Number of columns used to display foldtext
let g:ledger_maxwidth = 80

" Allow folding of a single blank line between transactions
let g:ledger_fold_blanks = 1

" Open report buffers in a vertical split on the right
let g:ledger_winpos = 'r'

" Align commodities with <Tab>
nnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>
vnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>

" Toggle transaction states with [s and ]s for cleared/pending
nnoremap <silent> <buffer> [s :call ledger#transaction_state_toggle(line('.'), ' *')<CR>
nnoremap <silent> <buffer> ]s :call ledger#transaction_state_toggle(line('.'), ' !')<CR>

" Create a new entry with <Leader>n
nnoremap <silent> <buffer> <Leader>n :call ledger#entry()<CR>
