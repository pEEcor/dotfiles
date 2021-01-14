" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" theme nord
Plug 'arcticicestudio/nord-vim'
" wal vim theme
Plug 'dylanaraps/wal.vim'
" nord
Plug 'arcticicestudio/nord-vim'
" airline
Plug 'vim-airline/vim-airline'
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


call plug#end()


"set cmdheight=2

" enable truecolor support
"if (has("nvim"))
"  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif
"if (has("termguicolors"))
"  set termguicolors
"endif


set nobackup
set nowritebackup
set noshowmode
filetype plugin indent on

"Spaces and Tabs
set tabstop=4                   " width of tab
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4                " number of spaces for tabs when expandtab is set, also affects automatic indentaion
set expandtab                   " tabs are spaces with amount of shiftwidth
set autoindent                  " auto indent curser in next line to current column
"set colorcolumn=80

"UI Config
set number
"set cursorline
set wildmenu
"set textwidth=120               " automatically wrap after 120 characters
"set colorcolumn=+1              " show 120 character indicator
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
nnoremap <C-p> :bp<CR>      " previous buffer

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"####################### PLUGIN SPECIFIC CONFIGURATIONS #######################

" vim airline
let g:airline_powerline_fonts=1
let g:airline_theme='wal'
let g:airline#extensions#tabline#enabled = 1

" nord
"let g:nord_italic = 1
"let g:nord_italic_comment = 1
"let g:nord_cursor_line_number_background = 1
"let g:nord_bold_vertical_split_line = 1

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

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

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
"Colors
syntax on
colorscheme wal
