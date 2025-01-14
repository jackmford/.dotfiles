syntax on
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set autoindent
set cursorline
set tabstop=2
set shiftwidth=2
set smarttab
set wrap
set relativenumber
set number
set visualbell
set incsearch
set hlsearch
set clipboard=unnamedplus

" H to move to first char in line
noremap H ^
" L to move to last char in line
noremap L g_

" Use ctrl k and j to scroll up an down
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" jj to esc
imap jj <Esc>


" Ctrl e to exit terminal mode
tnoremap <C-e> <C-\><C-n>
