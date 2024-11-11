".vimrc

" Set relative line number
set relativenumber

" Highlight horizontal cursor line
set cursorline

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Highlight search matches and press esc to remove highlight
set hlsearch
nnoremap <Esc> :noh<Esc>

" Current clipboard is cmd+v to paste from system clipboard, p and y is independent from system clipboard

" Auto close brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

