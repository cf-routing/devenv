" Called after everything just before setting a default colorscheme
" Configure you own bindings or other preferences. e.g.:

" set nonumber " No line numbers
" let g:gitgutter_signs = 0 " No git gutter signs
" let g:SignatureEnabledAtStartup = 0 " Do not show marks
" nmap s :MultipleCursorsFind
" colorscheme hybrid
" let g:lightline['colorscheme'] = 'wombat'
" ...
set notermguicolors

" TODO: fix EnableYtt on Ytt files
" augroup config#yml
"   autocmd FileType yaml EnableYtt
"   autocmd BufLeave FileType yaml DisableYtt
" augroup END
