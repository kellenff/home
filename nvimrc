" Neovim virtualenvs
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

execute pathogen#infect('~/.config/nvim/bundle/{}')

filetype plugin indent on
syntax enable

" Basic config
set encoding=utf-8
set history=200
set number
set scrolloff=3
set wrap
set formatoptions=qrn1
set mouse=a
set diffopt=vertical  " Diffs are shown side-by-side and not above/below
:set completeopt=menu,preview

" Leader
let mapleader=","

" Movement
inoremap jk <esc>
nnoremap B ^
nnoremap E $
inoremap <c-c> <esc>

" Spacing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Splits
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
set splitbelow
set splitright

" Search
set ignorecase
set smartcase
set showmatch
set hlsearch
set gdefault
set so=4
" very magic mode by default: https://stackoverflow.com/a/9273242/3882704
nnoremap / /\v
vnoremap / /\v

" Languages
" ===========
" 
    "let g:deoplete#enable_at_startup = 1
    "if !exists('g:deoplete#omni#input_patterns')
        "let g:deoplete#oni#input_patterns = {}
    "endif
    "autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " completions configuration
    "call deoplete#custom#option('smart_case', v:true)

    " matchers
    "call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])

    " converters
    "call deoplete#custom#source('_', 'converters', ['converter_auto_paren', 'remove_overlap', 'converter_auto_delimiter'])

    " deoplete tab-complete
    "inoremap <expr><tab> pumvisible() ? "\<c-p>" : "\<tab>"
    "inoremap <expr><s-tab> pumvisible() ? "\<c-n>" : "\<s-tab>"
    "inoremap <expr><cr> pumvisible() ? deoplete#complete() : "\n"<cr>

    " <c-h>, <bs>: close popup and delete backward char
    "inoremap <expr><c-h> deoplete#smart_close_popup()."\<c-h>"
    "inoremap <expr><bs> deoplete#smart_close_popup()."\<c-h>"

    " <cr>: close popup and save indent
    "imap <CR> <C-R>=pumvisible() ? deoplete#mappings#close_popup() : "\n"<CR>
    "inoremap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>
    "function! s:my_cr_function() abort
        "return deoplete#close_popup() . "\<cr>"
    "endfunction

    " Supertab cycles from top to bottom
    let g:SuperTabDefaultCompletionType = "<c-n>"
    let g:test#strategy = 'neovim'
    let g:test#python#runner = 'pytest'
    let g:test#python#pytest#options = {
                \ 'nearest': '--color=no --quiet --tb=short',
                \ }

    let g:autofmt_save = 1

    "nmap <cr> :w\|:TestFile --test %<cr>

    "let g:deoplete#sources#rust#racer_binary='$HOME/.cargo/bin/racer'
    "let g:deoplete#sources#rust#rust_source_path='$HOME/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/'
    "let g:deoplete#sources#rust#show_duplicates=0

    let g:endwise_no_mappings = 1

    " Golang
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'

    " CoC
    " extensions
    let g:coc_global_extensions = [
                \ 'coc-tsserver'
                \ ]
    " use <tab> to trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~ '\s'
    endfunction

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gr <Plug>(coc-references)

    nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

    " use <cr> to confirm selection
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    " if you want to also reformat code on <cr>
    "inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR><c-r>=coc#on_enter()\<CR>"
    

    " Ale

" Multipurpose tab key
"function InsertTabWrapper()
    "let col = col('.') - 1
    "if !col
        "return "\<tab>"
    "endif

    "let char = getline('.')[col - 1]
    "if char =~ '\k'
        " There's an identifier before the cursor, so complete the identifier
        "return "\<c-p>"
    "else
        "return "\<tab>"
    "endif
"endfunction
"inoremap <expr> <tab> InsertTabWrapper()
"inoremap <s-tab> <c-n>

" testing
let test#strategy = "dispatch"

function! MapCR()
    nnoremap <cr> :TestNearest<cr>
endfunction
call MapCR()
nnoremap <leader>T :call RunNearestTest()<cr>
nnoremap <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Are we in a test file?
    let in_test_file = match(expand("%"), '\(_spec.rb\|_test.rb\|test_.*\.py\|_test.py\|.test.ts\|.test.ts\)$') != -1

    " Run the tests for the previously-marked file (or the current file if
    " it's a test).
    if in_test_file
        call SetTestFile(command_suffix)
    elseif !exists("t:kellen_test_file")
        return
    end
    call RunTests(t:kellen_test_file)
endfunction

function! RunNearestTest()
    let spec_line_nubmer = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile(command_suffix)
    " Set the spec file that tests will be run for.
    let t:kellen_test_file=@% . a:command_suffix
endfunction

function! RunTests(filename)
    " Set the spec file and run tests for the given filename
    if expand("%") != ""
        :w
    end
    " The file is executable; assume we should run
    if executable(a:filename)
        exec ":!./" . a:filename
        " Project-specific test script
    elseif filereadable("bin/test")
        exec ":!bin/test " . a:filename
    elseif filereadable("bin/rspec")
        exec ":!bin/rspec " . a:filename
        " Fall back to the .test-commands pipe if available assuming someone is reading the other side and running the commands
    elseif filewritable(".test-commands")
        let cmd = 'rspec --color --format progress --require "~/lib/vim_rspec_formatter" --format VimFormatter --out tmp/quickfix'
        exec ":!echo " . cmd . " " . a:filename . " > .test-commands"

        " Write an empty string to block until the command completes
        sleep 100m  " milliseconds
        :!echo > .test-commands
        redraw!
        " Fall back to a blocking test run with bundler
    elseif filereadable("Gemfile") && strlen(glob("spec/**/*.rb"))
        exec ":!bundle exec rspec --color " . a:filename
    elseif filereadable("Gemfile") && strlen(glob("test/**/*.rb"))
        exec ":!bin/rails test " . a:filename
    elseif strlen(glob("test/**/*.py") . glob("**/tests/**/*.py"))
        exec "!pytest " . a:filename
    elseif strlen(glob("**/*_test.go"))
        exec "!go test"
    end
endfunction

" Quickfix management
function! GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction

function! BufferIsOpen(bufname)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bunfwinnr(bufnum) != -1
            return 1
        endif
    endfor
    return 0
endfunction

function! ToggleQuickfix()
    if BufferIsOpen("Quickfix List")
        cclose
    else
        call OpenQuickfix()
    endif
endfunction

function! OpenQuickfix()
    cgetfile tmp/quickfix
    topleft cwindow
    if &ft == "qf"
        cc
    endif
endfunction

nnoremap <leader>q :call ToggleQuickfix()<cr>
nnoremap <leader>Q :cc<cr>

" Appearance
" ==========

" Command line
set showcmd
set cmdheight=2
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

" Misc.
" =====

" From the coc.nvim docs
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Ctrl-P
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
    let g:ctrlp_working_path_mode = 'ra'

    " Python projects might not be under version control, but will still have
    " a venv directory
    let g:ctrlp_root_markers = ['venv', 'init.vim']

    " Find dotfiles
    let g:ctrlp_show_hidden = 1

    " Use ripgrep, if available: https://github.com/BurntSushi/ripgrep
    if executable('rg')
        set grepprg=rg\ --vimgrep
        let g:ctrlp_user_command = 'rg --files --glob "!.git/*" --glob "!.hg/*" --glob "!.svn" --glob "!*.exe" --glob "!*.so" --glob "!*.dll" --glob "!dein/repos/*" %s'

        " ripgrep is generally fast enough for fresh results to outweigh the
        " speed gain
        let g:ctrlp_use_caching = 0
    endif

" Return to the last position when reopening file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" Quickfix window height fit to input
au FileType qf call AdjustWindowHeight(3, 30)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

au FileType qf nmap q :ccl<cr>

" Use tsx plugin on jsx files
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Ensure that syntax highlighting is synced for javascript and typescript
" files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

colorscheme minimal

