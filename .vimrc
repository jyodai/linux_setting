""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""" プラグイン関係の設定 """""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""


call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'kamykn/spelunker.vim'

Plug 'tomasiser/vim-code-dark'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'dense-analysis/ale'

Plug 'pangloss/vim-javascript'

Plug 'posva/vim-vue'

Plug 'tpope/vim-fugitive' 

Plug 'tomtom/tcomment_vim'

Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'

" Install your UIs
Plug 'Shougo/ddc-ui-native'

" Install your sources
Plug 'Shougo/ddc-source-around'

" Install your filters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'

Plug 'shun/ddc-vim-lsp'

Plug 'alvan/vim-closetag'

Plug 'github/copilot.vim'

Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

:let filelist =  expand("~/.vim/plugin/*.vim")
:let splitted = split(filelist, "\n")
:for file in splitted
    execute 'source' file
:endfor

" 次の提案に移動
nmap <silent> <C-]> <Plug>(copilot-next)

" 前の提案に移動
nmap <silent> <F7> <Plug>(copilot-previous)


" fzf settings
let $FZF_DEFAULT_OPTS="--layout=reverse"
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }

" fzf のキーバインド
let mapleader = "\<Space>"
nnoremap <silent> <leader>f :Files<CR>
"nnoremap <silent> <C-p>     :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>G :GFiles?<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>j :Jumps<CR>
nnoremap <silent> <leader>w :Windows<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>r :Rg<CR>
nnoremap <silent> <leader>c :BCommits<CR>
nnoremap <silent> <leader>C :Commits<CR>

" vim-gitgutter settings
set signcolumn=yes
set updatetime=250
highlight clear SignColumn 
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

"" vim-gitgutter のキーバインド
" gpで前の変更箇所へ移動する
nnoremap gp :GitGutterPrevHunk<CR>
" gnで次の変更箇所へ移動する
nnoremap gn :GitGutterNextHunk<CR>

:command Gu GitGutterUndoHunk
:command Gp GitGutterPreviewHunk
:command Gd GitGutterDiffOrig 
:command Gf GitGutterFold

" tpope/vim-fugitive
:command Gb Git blame

"vim-lsp setting
" カーソルを当てた時に、下側にエラー内容を出力する
let g:lsp_diagnostics_echo_cursor = 1
" コードの近くにエラーメッセージを表示しない
let g:lsp_diagnostics_virtual_text_enabled = 0
" エラー箇所の行の横にマークを出力
let g:lsp_diagnostics_signs_enabled=1
let g:lsp_diagnostics_signs_delay=200
" エラー箇所のコードを強調しない
let g:lsp_diagnostics_highlights_enabled=0
" 対象箇所の詳細表示
:command Lpd LspPeekDefinition
" 対象箇所にジャンプ
:command Ld LspDefinition
" 定義箇所の情報を表示
:command Lh LspHover
" 使用箇所の一覧表示
:command Lr LspReferences

:command Lms LspManageServer
:command Lis LspInstallServer

:command Ldd LspDocumentDiagnostics

" 言語サーバーのステータスを表示する
:command Ls LspStatus

" spelunker.vim setting
" 有効化
let g:enable_spelunker_vim = 1
let g:spelunker_check_type = 2
" 存在しない単語は下線で表現
highlight SpelunkerSpellBad cterm=underline ctermfg=NONE gui=underline guifg=NONE

" vim-code-dark settig
set t_Co=256
set t_ut=
colorscheme codedark

" vim-airline setting
" 表示する値の設定
let g:airline#extensions#default#layout = [['', 'b', 'c'], ['x', 'y', 'z']]
" タブラインを表示
let g:airline#extensions#tabline#enabled = 1
" テーマを設定
let g:airline_theme = 'wombat'
" ブランチを表示
let g:airline#extensions#branch#enabled = 0

" ale setting
"ファイル保存時に整形実行
let g:ale_fix_on_save = 0
" lspの機能は重複するため無効化
let g:ale_disable_lsp = 1
" コードチェックの感覚が早すぎると重くなる
let g:ale_lint_delay=3000
" ファイルを開いた時に実行
let g:ale_lint_on_enter = 0
" ファイルを変更したタイミングで実行
let g:ale_lint_on_text_changed = 0
" インサートモード終了時に実行
let g:ale_lint_on_insert_leave = 0
" ファイルを保存時に実行
let g:ale_lint_on_save = 1
" コードの近くにエラーメッセージを表示しない
let g:ale_virtualtext_cursor = 0

" ale のキーバインド
:command Af ALEFix
:command Ai ALEInfo

" ale PHPの設定
let g:ale_php_phpcbf_use_global = 1
let g:ale_php_phpcs_use_global = 1

let g:ale_fixers = {
\   'sql': [
\       {
\           buffer -> {
\               'command': 'sql-formatter -l mysql'
\           }
\       },
\   ]
\}


" vim-vue setting
let g:vue_pre_processors = ['vue']

" vim-closetag setting"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.tsx,*.vue,*.jsx,*.blade.php'

" AndrewRadev/splitjoin.vim setting
" ,s で現在の構造を分割
nnoremap ,s :SplitjoinSplit<CR>
" ,j で現在の構造を結合
nnoremap ,j :SplitjoinJoin<CR>

""""""""""""""""""""""""""""""""""""""
""""""""""""" 基本の設定 """""""""""""
""""""""""""""""""""""""""""""""""""""


" viエディタの互換性をなくします
set nocompatible

" 行の先頭に行数を表示します    
set number

" 改行した際に前の行のインデントを継承します
set autoindent

" 検索した文字列をハイライトします
set hlsearch

" 検索時にEnterを押さなくてもハイライト
set incsearch

" ESCでIMEを確実にOFF
inoremap <ESC> <ESC>:set iminsert=0<CR>
set iminsert=0
set imsearch=0

" insert mode にキーバインド
inoremap <silent> jj <ESC>

" insert mode でカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" ペーストモードの切り替え
command! Sp set paste
command! Snp set nopaste

" backSpaceの調整
set backspace=2

" 不可視文字を表示させる
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%,space:·
" eol, extends, precedes のカラーを指定
hi NonText ctermfg=59
" nbsp, tab, trail のカラーを指定
hi SpecialKey ctermfg=59

" スペルチェック
set nospell

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=22
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" ファイル名の候補を出力
set wildmenu

" バッファの切り替え
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <c-k> :bnext<CR>

" バッファを閉じた時にウィンドウは開いたままにする
cnoremap bd b#\|bd#<CR>
" 現在アクティブなバッファ以外を閉じる
cnoremap bc :let curr=bufnr('%')<Bar>bufdo if bufnr('%') != curr \| bwipeout \| endif<Bar>execute 'buffer' curr<CR>

"文字コード
set enc=utf-8
set fenc=utf-8

" Beep音をオフ
set visualbell t_vb=

"補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" インデント
set tabstop=4
set expandtab
set shiftwidth=4

" 旧式の正規表現を使用
set re=0

""""""""""""""""""""""""""""""""""""""""""
""""""""""""" ファイルの設定 """""""""""""
""""""""""""""""""""""""""""""""""""""""""


augroup vimrc-filetype
	autocmd!
	" PHPだったらインデント幅が4
	autocmd BufNewFile,BufRead *.php set filetype=php
	autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

	" JSだったらインデント幅が2
	autocmd BufNewFile,BufRead *.js set filetype=javascript
	autocmd FileType javascript setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" TSだったらインデント幅が2
	autocmd BufNewFile,BufRead *.ts set filetype=typescriptreact
	autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
	autocmd FileType typescriptreact setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" vueだったらインデント幅が2
	autocmd BufNewFile,BufRead *.vue set filetype=vue
	autocmd FileType vue setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" cssだったらインデント幅が2
	autocmd BufNewFile,BufRead *.css set filetype=css
	autocmd FileType css setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" scssだったらインデント幅が2
	autocmd BufNewFile,BufRead *.scss set filetype=scss
	autocmd FileType scss setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" jsonだったらインデント幅が2
	autocmd BufNewFile,BufRead *.json set filetype=json
	autocmd FileType json setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" htmlだったらインデント幅が4
	autocmd BufNewFile,BufRead *.html set filetype=html
	autocmd FileType html setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

	" vimだったらインデント幅が4
	autocmd BufNewFile,BufRead *.vimrc set filetype=vim
	autocmd FileType vim setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

	autocmd BufNewFile,BufRead *.vim set filetype=vim
	autocmd FileType vim setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

	" shだったらインデント幅が4
	autocmd BufNewFile,BufRead *.sh set filetype=vim
	autocmd FileType sh setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

	" cだったらインデント幅が4
	autocmd BufNewFile,BufRead *.c set filetype=vim
	autocmd FileType c setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

	" Makefileだったらタブ
	autocmd BufNewFile,BufRead Makefile set filetype=make
	autocmd FileType make setlocal tabstop=4 softtabstop=4 shiftwidth=4

	" nginxだったらインデント幅が2
	autocmd BufNewFile,BufRead *nginx*conf set filetype=nginx
	autocmd FileType nginx setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END


""""""""""""""""""""""""""""""""""""""""""
""""""""""""" スクリプト """""""""""""""""
""""""""""""""""""""""""""""""""""""""""""

" ヤンクでクリップボードにコピー
augroup myYank
    autocmd!
    " Windows Subsystem for Linux (WSL)
    if system('uname -a | grep microsoft') != ''
        autocmd TextYankPost * :call system('clip.exe', @")
    " MacOS
    elseif system('uname') == "Darwin\n"
        autocmd TextYankPost * :call system('pbcopy', @")
    endif
augroup END


" カレントファイルのパスをコピー
command! Path :call s:Path()
function! s:Path()
	let @+ = expand('%:h') . "/" . expand('%:t')
	let @" = expand('%:h') . "/" . expand('%:t')
	call system('clip.exe', @")
    echo @"
endfunction


" インサートモードを抜けた時に英数モードに切り替えるための関数
function! SwitchToEnglishLayout()
    " im-selectの存在を確認
    if executable('im-select')
        call system('im-select com.apple.keylayout.ABC')
    endif
endfunction

" インサートモードから抜ける際に関数を呼び出す
autocmd InsertLeave * call SwitchToEnglishLayout()

"""""""""""""""""""""""""""""""""""""""""""""
""""""""""""" ファイルの読み込み"""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""


:let filelist =  expand("~/.vim/project/*.vim")
:let splitted = split(filelist, "\n")
:for file in splitted
    execute 'source' file
:endfor

