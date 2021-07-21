
" Automatically install pluginmanager if not present
" -----------------------------------------------------------------------------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins 
" -----------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

"fugitive
Plug 'tpope/vim-fugitive'
" wal vim theme
Plug 'dylanaraps/wal.vim'
" gitgutter
Plug 'airblade/vim-gitgutter'
" conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" css color
Plug 'ap/vim-css-color'
" tmuxline
Plug 'edkolev/tmuxline.vim'
" float term
Plug 'voldikss/vim-floaterm'
" tagbar
Plug 'majutsushi/tagbar'
" nerdtree
Plug 'preservim/nerdtree'
" vimtex
Plug 'lervag/vimtex'
" c/c++ syntax highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'
" json filetype with comments
Plug 'kevinoid/vim-jsonc'
" toml support
Plug 'cespare/vim-toml'
" rust doc search
Plug 'rhysd/rust-doc.vim'
" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
" vim tmux navigator
Plug 'christoomey/vim-tmux-navigator'
" Lightline
Plug 'itchyny/lightline.vim'

call plug#end()




" Basics 
" ----------------------------------------------------------------------------

set nobackup
set nowritebackup
" disable display of mode, as it is shown in status line
set noshowmode
" enable file type specific indentation
filetype plugin indent on

" width of tab
set tabstop=4
" number of spaces in tab when editing
set softtabstop=4
" number of spaces for tabs when expandtab is set, affects automatic indent
set shiftwidth=4
" tabs are spaces with amount of shiftwidth
set expandtab
" auto indent curser in next line to current column
set autoindent
" column at 80 characters
"set colorcolumn=80

"UI Config
set number
"set cursorline
set wildmenu
" exchange split behaviour to match splitting with tmux and sway
set splitbelow splitright

set hidden

"Searching
set incsearch
set hlsearch
set ignorecase
nnoremap <silent> <F2> :nohlsearch<CR>

" filetype specific indentations
autocmd FileType c setlocal smartindent 
autocmd FileType cpp setlocal noexpandtab shiftwidth=2
autocmd FileType make setlocal noexpandtab
"autocmd FileType python setlocal expandtab
autocmd FileType tex setlocal textwidth=80

"Moving
inoremap jj <Esc>
nnoremap <C-n> :bn<CR>      " next buffer
"nnoremap <C-p> :bp<CR>      " previous buffer

"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

"Colors
syntax on
colorscheme wal




" Plugin Config
" ----------------------------------------------------------------------------

" vim airline
"let g:airline_powerline_fonts=1
"let g:airline_theme='wal'
"let g:airline#extensions#tabline#enabled = 1


" coc
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use KK to show documentation in preview window.
nnoremap <silent> KK :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)


" git gutter
" faster gitgutter (200 ms)
set updatetime=200


" floaterm
let g:floaterm_autoclose = v:true
nnoremap <silent> <F7> :FloatermNew<CR>


" lf
command! LF FloatermNew lf
nnoremap <silent> <leader>lf :LF<CR>


" tagbar
nmap <silent> <F4> :TagbarToggle<CR>


" nerdtree
map <silent> <F3> :NERDTreeToggle<CR>


" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" lightline
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ }

" rust-doc
let g:rust_doc#downloaded_rust_doc_dir = '~/file:///home/pb/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/doc'

