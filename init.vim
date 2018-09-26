" ------------
" dein Scripts
" ------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Ensure we read vim config.
set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath
source $HOME/.vimrc

" Required:
set runtimepath+=$XDG_CONFIG_HOME/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$XDG_CONFIG_HOME/dein')
  call dein#begin('$XDG_CONFIG_HOME/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$XDG_CONFIG_HOME/dein/repos/github.com/Shougo/dein.vim')

  " Startup screen and sessions.
  " Use case 1: Show startup screen when running nvim with no files.
  " Use case 2: Save sessions applicable at a certain directory.
  " Use case 3: Load saved sessions from startup screen.
  call dein#add('mhinz/vim-startify')

  " Auto-completion.
  " Use case 1: Auto-complete with words already used in file for
  "             configuration, text files and the like.
  " Use case 2: Auto-complete file paths in local file system while
  "             editing.
  " For programming use cases, we use eclim.
  call dein#add('Shougo/deoplete.nvim')
  
  " Context-aware tab completion.
  " Use case 1: Auto-complete with tab in a context-sensitive manner using the
  "             current auto-completion engine.
  call dein#add('ervandew/supertab')

  " Formatting code.
  " Use case 1: Auto-format on file save or leaving insert mode while
  "             programming.
  " Use case 2: Support different formatters for different programming
  "             languages.
  call dein#add('sbdchd/neoformat')

  " Fuzzy searching files and directories by name.
  " Use case 1: Search for files and directories matching a set of regexes.
  call dein#add('junegunn/fzf')

  " Searching for files based on keyword match.
  " Use case 1: Search and get a list of files.
  " Use case 2: Drill down search results with more keyword matching.
  " Use case 3: Open one of the found files.
  " Use case 4: Return back to the search results.
  call dein#add('rking/ag.vim')
  
  " Required:
  call dein#end()
  call dein#save_state()
endif

" Enable deocomplete where applicable.
let g:deoplete#enable_at_startup = 1
autocmd FileType java call deoplete#custom#buffer_option('auto_complete', v:false)

" Enable context-sensitive tab completion.
let g:SuperTabDefaultCompletionType = 'context'

" Setup Neoformat for Java.
let g:neoformat_java_google = {
            \ 'exe': 'sh',
            \ 'args': ['$XDG_CONFIG_HOME/google_formatter/google-java-format-1.6-all-deps.sh'],
            \ 'stdin': 1, 
            \ }
let g:neoformat_enabled_java = ['google']
autocmd BufWritePre,InsertLeave Filetype java Neoformat google

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" --------------------------
" Generic vim configuration.
" --------------------------

" We want to control indentation behavior based on file type.
" by default, the indent is 4 spaces. 
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

autocmd BufNewFile,BufRead build.xml setf ant
autocmd Filetype ant,sh,vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Making it easier to get out of a native terminal emulator in nvim.
tnoremap <Esc> <C-\><C-n>

" Changing directories within editor.
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" -------------------------
" Setup Eclim key bindings.
" -------------------------
nnoremap <silent> <LocalLeader>i :JavaImport<cr>
nnoremap <silent> <LocalLeader>jd :JavaDocSearch -x declarations<cr>
nnoremap <silent> <LocalLeader><cr> :JavaSearchContext<cr>
nnoremap <silent> <LocalLeader>jv :Validate<cr>
nnoremap <silent> <LocalLeader>jc :JavaCorrect<cr>

" -------------------------
" Editing crontabs safely.
" -------------------------
autocmd Filetype crontab setlocal nobackup nowritebackup
