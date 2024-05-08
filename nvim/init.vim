set nocompatible
filetype on

call plug#begin()

" Typescript support
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Javascript syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'othree/jsdoc-syntax.vim'

" robotframework
Plug 'mfukar/robotframework-vim'
Plug 'evedovelli/rst-robotframework-syntax-vim'

" Hashicorp Terraform syntax support
Plug 'hashivim/vim-terraform'

" Best status bar ever
Plug 'vim-airline/vim-airline'

" Git Integration
Plug 'tpope/vim-fugitive'

" Surrounding plugin (to add quotes/parens/brackets around stuff)
Plug 'tpope/vim-surround'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'

" Nerdcommenter best comment tool ever
Plug 'scrooloose/nerdcommenter'


" Ack support
" Beware ! git.fsck might not like this plugin. Use manual install if needed:
" git clone --config transfer.fsckobjects=false https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
Plug 'mileszs/ack.vim'

" Syntax checker
Plug 'scrooloose/syntastic'

" Easy motion
Plug 'easymotion/vim-easymotion'

" fzf for vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Better swap file handling
Plug 'gioele/vim-autoswap'

" Code formatting
Plug 'sbdchd/neoformat'

" Better substitute
Plug 'tpope/vim-abolish'

" PEP8 checker
Plug 'nvie/vim-flake8'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim'

" Dirdiff
Plug 'will133/vim-dirdiff'

" Conquer of Code (Completion and LSP support)
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }

call plug#end()

" LEADER SHORTCUTS
let mapleader = " "

" CoC config
nmap <silent> gi <Plug>(coc-codeaction-cursor)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <silent> gn <Plug>(coc-rename)
nmap <silent> gf <Plug>(coc-refactor)

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Markdown support
"let g:markdown_fenced_languages = ['html', 'javascript', 'bash=sh']

" Treat *.dockerfile files as dockerfile syntax
au BufNewFile,BufFilePre,BufRead *.dockerfile set filetype=dockerfile

au BufNewFile,BufFilePre,BufRead *.bashrc set filetype=sh
au BufNewFile,BufFilePre,BufRead *.env.local set filetype=sh

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=0 |
    \ set expandtab |
    \ set fileformat=unix

autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
autocmd BufNewFile,BufRead *.resource setlocal filetype=robot

" Security concerns and useless anyway
set modelines=0

" Quit
nnoremap <LEADER>q :q<CR>
" Save current buffer
nnoremap <LEADER>w :w<CR>
" Save and Exit
nnoremap <LEADER>x :x<CR>
" Select everything
nnoremap <LEADER>v V`]
" Clear search highlight
nnoremap <LEADER>, :noh<CR>
" Toggle NERDTree panel
nnoremap <LEADER>z <C-z>
" Refresh vim config from ~/.vimrc
nnoremap <LEADER>sv :source ~/.config/nvim/init.vim<CR>
" Edit vimrc in a vertical split
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<CR>

" NERDTree configuration
nnoremap <LEADER>n :NERDTreeToggle<CR>
nnoremap <LEADER>f :NERDTreeFind<CR>
" enable line numbers
let NERDTreeShowLineNumbers=1
" enable hidden files display
let NERDTreeShowHidden=1
let g:NERDTreeFileLines = 1

" If no file required at CLI invoke, open with NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | wincmd w | q | endif

" Set to Background
" Tab movement
nnoremap <F2> :tabp<CR>
nnoremap <F3> :tabn<CR>

" Activate robotframework sytax highlighting
noremap <F12> :setf robot<CR>

" Move around windows
nnoremap <LEADER>h <C-w>h
nnoremap <LEADER><Left> <C-w>h
nnoremap <LEADER>j <C-w>j
nnoremap <LEADER><Down> <C-w>j
nnoremap <LEADER>k <C-w>k
nnoremap <LEADER><Up> <C-w>k
nnoremap <LEADER>l <C-w>l
nnoremap <LEADER><Right> <C-w>l

" Use Markdown plugin
nnoremap <LEADER>m :MarkdownPreview<CR>
nnoremap <LEADER>ms :MarkdownPreviewStop<CR>

" Write if you forgot sudo
cmap w!! w !sudo tee % >/dev/null


" Activate vim paste option
set pastetoggle=<F4>


" Display trailing spaces and other stuff
set listchars=tab:\ \ ,trail:~,extends:>,precedes:<,nbsp:⎵
set list

" Automatically refresh buffer on external changes
" For the CursorHold see
" [here](https://superuser.com/a/1090762)
au CursorHold * checktime

" Call flake8 before writing
autocmd BufWritePost *.py call flake8#Flake8()

" Easymotion configuration
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Open files of location/quickfix lists in new tabs instead of in the current
" buffer
set switchbuf+=newtab

" Vim markdown preview parameters
let vim_markdown_preview_browser='Mozilla Firefox'
let vim_markdown_preview_github=1

" Indent setup
set expandtab
set shiftwidth=2
set softtabstop=2

" File search
set wildmenu
set wildmode=list:longest
set wildignore+=node_modules/*,bower_components/*,*.swp,*.bak,*.pyc,*.class
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

" Misc
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set showmatch
set hidden
set visualbell
set cursorline
set ttyfast
set ruler
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

" Always display status line
set laststatus=2

" Change to uppercase, lowercase and titlecase
function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
      let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
      let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
      let result = toupper(a:str)
    endif
    return result
endfunction
vnoremap <LEADER>u y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

function! CustomBranchName(name)
  return fnamemodify(a:name, ':t')[0:10]
endfunction
let g:airline#extensions#branch#format = 'CustomBranchName'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_y=''

" Centralize all vim temp files in home folder
set backup
set backupdir=~/.nvim/backup
set directory=~/.nvim/swap
set undodir=~/.nvim/undo
set writebackup
set backupcopy=yes

" Ensure title and titlestring variables are set to default for autoswap
set title titlestring=

" Automatically refresh buffer on external changes
" For the CursorHold see
" [here](https://superuser.com/a/1090762)
au CursorHold * checktime

" Wait x milliseconds of inactivity to write the current buffer into a swap
" file, and to trigger CursorHold a event.
set updatetime=2000

" Syntastic options
" Customize status line with syntastic errors
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { "mode": "passive" }

" Undo info available across vim instances
set undofile
" Enable spell checking with default english dictionnary
autocmd FileType markdown setlocal spell spelllang=en
