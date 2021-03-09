" Vim Options {{{

let mapleader=" "

set foldmethod=marker
set timeoutlen=200 ttimeoutlen=0

set termguicolors
set noshowmode
set showcmd
set shiftwidth=4
set expandtab
set completeopt-=preview
set clipboard+=unnamedplus
set lazyredraw
set icm=nosplit
syntax enable

set nu rnu
set hidden
set cmdheight=2
set updatetime=50
set shortmess+=c
filetype plugin on

nnoremap dm :execute 'delmarks '.nr2char(getchar())<cr>

"}}}

" configuration {{{

" VSCode {{{

if exists('g:vscode')

lua require('code.plugins')

" cutlass
nnoremap <leader>d d
xnoremap <leader>d d
nnoremap <leader>dd dd
nnoremap <leader>D D


" subversive
nmap <leader>s <plug>(SubversiveSubstitute)
nmap <leader>ss <plug>(SubversiveSubstituteLine)
nmap <leader>S <plug>(SubversiveSubstituteToEndOfLine)

nmap <leader><leader>s <plug>(SubversiveSubstituteRange)
xmap <leader><leader>s <plug>(SubversiveSubstituteRange)
nmap <leader><leader>ss <plug>(SubversiveSubstituteWordRange)


"}}}

" vanilla {{{
else

lua require('faith.plugins')

set signcolumn=yes

" fzf
nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>p :RG<CR>

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" -- old config
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }
"
" function! FloatingFZF()
"   let buf = nvim_create_buf(v:false, v:true)
"   call setbufvar(buf, '&signcolumn', 'no')
"
"   let height = float2nr(10)
"   let width = float2nr(80)
"   let horizontal = float2nr((&columns - width) / 2)
"   let vertical = 1
"
"   let opts = {
"         \ 'relative': 'editor',
"         \ 'row': vertical,
"         \ 'col': horizontal,
"         \ 'width': width,
"         \ 'height': height,
"         \ 'style': 'minimal'
"         \ }
"
"   call nvim_open_win(buf, v:true, opts)
" endfunction
"

" ale

" let g:ale_list_window_size = 5
" let g:ale_open_list = 1
" let g:ale_linters = {
" \ 'python': ['prospector'],
" \ 'cs': ['OmniSharp']
" \}
" let g:ale_fixers = ['black']
" let g:ale_sign_error = ''
" let g:ale_sign_warning = ''

" lf
" let g:lf_replace_netrw = 1
" map <leader>ff :LfNewTab<CR>

" ranger
" let g:ranger_replace_netrw = 1
" map <leader>ff :RangerNewTab<CR>

" coc
" let g:coc_global_extensions = [
" \ 'coc-snippets',
" \ 'coc-tsserver',
" \ 'coc-html',
" \ 'coc-css',
" \ 'coc-prettier',
" \ 'coc-json',
" \ 'coc-emmet',
" \ 'coc-pyright',
" \ 'coc-omnisharp'
" \ ]
"
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_leader() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_leader() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" autocmd CursorHold * silent call CocActionAsync('highlight')
" nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
" nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
" nnoremap <silent> gd <Plug>(coc-definition)
" nnoremap <silent> gy <Plug>(coc-type-definition)
" nnoremap <silent> gi <Plug>(coc-implementation)
" nnoremap <silent> gr <Plug>(coc-references)
"
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
"
" nnoremap <leader>rn <Plug>(coc-rename)
" xnoremap <leader>ff  <Plug>(coc-format-selected)
" xnoremap <leader>aa  <Plug>(coc-codeaction-selected)
" nnoremap <leader>aa  <Plug>(coc-codeaction-selected)
" nnoremap <leader>ac  <Plug>(coc-codeaction)
" nnoremap <leader>qf  <Plug>(coc-fix-current)
" xnoremap if <Plug>(coc-funcobj-i)
" xnoremap af <Plug>(coc-funcobj-a)
" onoremap if <Plug>(coc-funcobj-i)
" onoremap af <Plug>(coc-funcobj-a)
"
" command! -nargs=0 Format :call CocAction('format')
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" "nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>

" nnoremap <silent> <leader>e :CocCommand explorer<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  deoplete#close_popup()
inoremap <expr><C-e>  deoplete#cancel_popup()

" autocmd
augroup filetypes
    autocmd FileType ruby,json,haml,eruby,yaml,html,javascript,coffee,sass,cucumber,stylus,css,xml,htmldjango set ai ts=2 sw=2 sts=2 et
    autocmd FileType python,doctest set ai ts=4 sw=4 sts=4 et
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

autocmd InsertEnter * norm zz
autocmd BufWritePre * %s/\s\+$//e


" closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '>>'

" highlight hi DiffAdd ctermbg=0
hi DiffChange ctermbg=0
hi DiffDelete ctermbg=0

" spacegray.vim
let g:spacegray_low_contrast = 1
let g:spacegray_use_italics = 1

" gruvbox
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" tcomment
let g:tcomment#options = {'col': 1}

let ayucolor="light"  " for light version of theme
let &background="light"
colorscheme serenade

let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_setColors = 0
let g:indentLine_showFirstIndentLevel = 0

" Open lazygit
nnoremap <silent> <Leader>' :call openterm#horizontal('lazygit', 0.8)<CR>

" yoink
" let g:yoinkIncludeDeleteOperations = 1
" let g:yoinkAutoFormatPaste='1'
" nmap <C-n> <plug>(YoinkPostPasteSwapBack)
" nmap <C-m> <plug>(YoinkPostPasteSwapForward)
"
" nmap p <plug>(YoinkPaste_p)
" nmap P <plug>(YoinkPaste_P)

" cutlass
nnoremap <leader>d d
xnoremap <leader>d d
nnoremap <leader>dd dd
nnoremap <leader>D D

" subversive
nmap <leader>s <plug>(SubversiveSubstitute)
nmap <leader>ss <plug>(SubversiveSubstituteLine)
nmap <leader>S <plug>(SubversiveSubstituteToEndOfLine)

nnoremap <leader><leader>s <plug>(SubversiveSubstituteRange)
xnoremap <leader><leader>s <plug>(SubversiveSubstituteRange)
nnoremap <leader><leader>ss <plug>(SubversiveSubstituteWordRange)

" undotree
nnoremap <F5> :UndotreeToggle<cr>

" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"nvim-tree
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 0
let g:nvim_tree_auto_ignore_ft = ['startify', 'dashboard']
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_tab_open = 1
let g:nvim_tree_width_allow_resize  = 1
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'symlink': "",
    \   }
    \ }

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" lspsaga
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" bufferline
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>]b :BufferLineCyclePrev<CR>

endif
"}}}

"}}}
