setlocal foldmethod=syntax

" let g:ledger_bin = 'ledger'
" let g:ledger_extra_options = '--explicit --pedantic'
let g:ledger_bin = 'hledger'
let g:ledger_extra_options = '--strict'

let g:ledger_default_commodity = '£'
let g:ledger_commodity_before = 1

" Number of columns used to display foldtext
let g:ledger_maxwidth = 80

" Allow folding of a single blank line between transactions
let g:ledger_fold_blanks = 1

" Open report buffers in a vertical split on the right
let g:ledger_winpos = 'r'

" Align commodities with <Tab> in normal and visual modes
nnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>
vnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>

" Use <Tab> in insert mode to complete account names and align
inoremap <silent> <buffer> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>

" Toggle transaction states with [s and ]s for cleared/pending
nnoremap <silent> <buffer> [s :call ledger#transaction_state_toggle(line('.'), ' *')<CR>
nnoremap <silent> <buffer> ]s :call ledger#transaction_state_toggle(line('.'), ' !')<CR>

" Create a new entry with <Leader>n
nnoremap <silent> <buffer> <Leader>n :call ledger#entry()<CR>
