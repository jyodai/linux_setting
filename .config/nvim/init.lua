-- """"""""""""""""""""""""""""""""""""""""""""""""
-- """"""""""""" プラグイン関係の設定 """""""""""""
-- """"""""""""""""""""""""""""""""""""""""""""""""


-- プラグイン管理のためのプラグイン
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグインのインストール
require("lazy").setup({

  -- fzf のインストール
  {
    "junegunn/fzf",
    build = function() vim.fn["fzf#install"]() end,
    config = function()
      -- FZF のデフォルトオプション
      vim.env.FZF_DEFAULT_OPTS = "--layout=reverse"
      vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**'"

      -- FZF のレイアウト設定
      vim.g.fzf_layout = {
        up = "~90%",
        window = {
          width = 0.8,
          height = 0.8,
          yoffset = 0.5,
          xoffset = 0.5,
          border = "sharp",
        },
      }

      -- FZF のキーマッピング
      vim.g.mapleader = " "

      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      keymap("n", "<leader>f", ":Files<CR>", opts)
      keymap("n", "<leader>g", ":GFiles<CR>", opts)
      keymap("n", "<leader>G", ":GFiles?<CR>", opts)
      keymap("n", "<leader>b", ":Buffers<CR>", opts)
      keymap("n", "<leader>h", ":History<CR>", opts)
      keymap("n", "<leader>j", ":Jumps<CR>", opts)
      keymap("n", "<leader>w", ":Windows<CR>", opts)
      keymap("n", "<leader>l", ":Lines<CR>", opts)
      keymap("n", "<leader>r", ":Rg<CR>", opts)
      keymap("n", "<leader>c", ":BCommits<CR>", opts)
      keymap("n", "<leader>C", ":Commits<CR>", opts)
    end
  },
  { "junegunn/fzf.vim" },

  -- nvim-lspconfigのインストール
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",          -- LSPサーバー管理
      "williamboman/mason-lspconfig.nvim",-- masonとlspconfigの統合
      "hrsh7th/nvim-cmp",                 -- 補完
      "hrsh7th/cmp-nvim-lsp",             -- LSP補完
      "L3MON4D3/LuaSnip",                 -- スニペット
    },
    config = function()
      -- mason設定
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "intelephense", "ts_ls" }
      }

      -- LSP設定
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.intelephense.setup {
        capabilities = capabilities,
      }

      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }

      -- 診断結果の表示設定
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●', -- 虚像テキストのプレフィックスを変更
          spacing = 4,  -- コードからのスペース
        },
        float = {                 -- 浮動ウィンドウとして表示
            border = "rounded",
            severity_sort = true,
        },
        signs = true,             -- サインを表示
        update_in_insert = false, -- 挿入モード中に更新しない
      })

      -- 行の直下に診断結果を表示するための設定
      vim.cmd [[
        autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
      ]]

      -- LSPのコマンド設定
      vim.api.nvim_create_user_command("Lpd", function() vim.lsp.buf.definition() end, {})
      vim.api.nvim_create_user_command("Ld", function() vim.lsp.buf.definition() end, {})
      vim.api.nvim_create_user_command("Lh", function() vim.lsp.buf.hover() end, {})
      vim.api.nvim_create_user_command("Lr", function() vim.lsp.buf.references() end, {})
      vim.api.nvim_create_user_command("Ls", function() vim.lsp.buf.status() end, {})
      vim.api.nvim_create_user_command("Lms", function() vim.lsp.buf.manage_servers() end, {})
      vim.api.nvim_create_user_command("Lis", function() vim.lsp.buf.install_server() end, {})
      vim.api.nvim_create_user_command("Ldd", function() vim.lsp.buf.document_diagnostics() end, {})


      -- エラー内容をクリップボードにコピーする関数
      function CopyDiagnosticToClipboard()
        local line = vim.fn.line('.') - 1  -- 現在のカーソル行を取得（0-indexed）
        local diagnostics = vim.diagnostic.get(0, {lnum = line}) -- カーソル位置のエラーのみ取得
        if #diagnostics > 0 then
          local diagnostic_message = ""
          for _, diag in ipairs(diagnostics) do
            diagnostic_message = diagnostic_message .. diag.message .. "\n"
          end
          -- クリップボードにコピー
          vim.fn.setreg("+", diagnostic_message)
          print("診断結果をクリップボードにコピーしました")
        else
          print("カーソル位置に診断結果はありません")
        end
      end

      -- 診断結果をクリップボードにコピー
      vim.api.nvim_create_user_command('Lc', CopyDiagnosticToClipboard, {})

    end,
  },

    -- nvim-cmpのインストール
    -- lspの補完機能を使用するために必要
  {
    "hrsh7th/nvim-cmp",  -- 補完プラグイン
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP補完ソース
      "L3MON4D3/LuaSnip",      -- スニペット
      "saadparwaiz1/cmp_luasnip", -- LuaSnip用の補完ソース
      "hrsh7th/cmp-buffer",    -- バッファ補完
      "hrsh7th/cmp-path",      -- パス補完
    },
    config = function()
      local cmp = require('cmp')

      -- cmpの設定
      cmp.setup({
        completion = {
          completeopt = 'menu,menuone',
          max_item_count = 10,  -- 候補数制限
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)  -- LuaSnipのスニペット展開
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),  -- 上方向
          ['<C-n>'] = cmp.mapping.select_next_item(),  -- 下方向
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),     -- ドキュメントスクロール
          ['<C-f>'] = cmp.mapping.scroll_docs(4),      -- ドキュメントスクロール
          ['<C-Space>'] = cmp.mapping.complete(),      -- 補完開始
          ['<C-e>'] = cmp.mapping.close(),             -- 補完を閉じる
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 選択して確定
          ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Ctrl + yで確定
          ['<Esc>'] = cmp.mapping.abort(),             -- Escで選択を取りやめ
        },
        sources = {
          { name = "copilot" },    -- Copilotから補完候補を取得
          { name = 'nvim_lsp' },   -- LSPから補完候補を取得
          { name = 'luasnip' },    -- スニペットから補完
          { name = 'buffer' },     -- バッファ内の補完
          { name = 'path' },       -- ファイルパス補完
        },
      })
    end,
  },

  {
    "tomasiser/vim-code-dark",  -- VSCode-likeテーマ
    config = function()
      vim.cmd("colorscheme codedark")  -- テーマの適用
    end
  },

  {
    "airblade/vim-gitgutter",
    config = function()
      -- gitgutter設定
      vim.o.signcolumn = "yes"
      vim.o.updatetime = 250
      
      -- GitGutter関連のハイライト設定
      vim.cmd("highlight clear SignColumn")
      vim.cmd("highlight GitGutterAdd ctermfg=green")
      vim.cmd("highlight GitGutterChange ctermfg=blue")
      vim.cmd("highlight GitGutterDelete ctermfg=red")

      -- GitGutterのキーバインド
      vim.api.nvim_set_keymap("n", "gp", ":GitGutterPrevHunk<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gn", ":GitGutterNextHunk<CR>", { noremap = true, silent = true })

      -- コマンド設定
      vim.api.nvim_create_user_command("Gu", "GitGutterUndoHunk", {})
      vim.api.nvim_create_user_command("Gp", "GitGutterPreviewHunk", {})
      vim.api.nvim_create_user_command("Gd", "GitGutterDiffOrig", {})
      vim.api.nvim_create_user_command("Gf", "GitGutterFold", {})
    end
  },

  {
    "tpope/vim-fugitive",
    config = function()
      -- Git blame コマンドを設定
      vim.api.nvim_create_user_command("Gb", "Git blame", {})
    end
  },

  {
    "junegunn/vim-easy-align",
    config = function()
      -- vim-easy-alignの設定
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false })
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false })
    end
  },

  -- ステータスラインの設定
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g["airline#extensions#default#layout"] = {{ "", "b", "c" }, { "x", "y", "z" }}
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline_theme"] = "wombat"
      vim.g["airline#extensions#branch#enabled"] = 0
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },  -- 競合を防ぐために無効化（後で cmp と連携）
        panel = { enabled = false },
      })
    end,
  },

  -- nvim-cmpと連携するために必要
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "dense-analysis/ale",
    config = function()
      -- 保存時にフォーマット
      vim.g.ale_fix_on_save = 1
    end,
  },

  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'x' } },
      { 'gb', mode = { 'n', 'x' } },
      { 'gcc', mode = 'n' },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    build = ':TSUpdate',  -- パーサーをインストール
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = {
          enable = true,  -- シンタックスハイライト
        },
        indent = {
          enable = true,  -- インデント
        },
      }
    end,
  },

  -- 内部のパース処理で nvim-treesitter/nvim-treesitter を使用
  {
    'Wansmer/treesj',
    keys = {
      { ',s', '<Cmd>TSJSplit<CR>', desc = 'Split lines' },
      { ',j', '<Cmd>TSJJoin<CR>',  desc = 'Join lines' },
      { ',m', '<Cmd>TSJToggle<CR>', desc = 'Toggle Split/Join' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({})
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- GitHub Copilot本体
      { "nvim-lua/plenary.nvim", branch = "master" }, -- 必要なユーティリティ
    },
    build = "make tiktoken", -- MacOS/Linuxの場合のみ
    config = function ()
      require("CopilotChat").setup {
        show_help = "yes",
        prompts = {
            Explain = {
                prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
                mapping = '<leader>ce',
                description = "コードの説明をお願いする",
            },
            Review = {
                prompt = '/COPILOT_REVIEW コードを日本語でレビューしてください。',
                mapping = '<leader>cr',
                description = "コードのレビューをお願いする",
            },
            Fix = {
                prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
                mapping = '<leader>cf',
                description = "コードの修正をお願いする",
            },
            Optimize = {
                prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
                mapping = '<leader>co',
                description = "コードの最適化をお願いする",
            },
            Docs = {
                prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
                mapping = '<leader>cd',
                description = "コードのドキュメント作成をお願いする",
            },
            Tests = {
                prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
                mapping = '<leader>ct',
                description = "テストコード作成をお願いする",
            },
            FixDiagnostic = {
                prompt = 'コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。',
                mapping = '<leader>cd',
                description = "コードの修正をお願いする",
                selection = require('CopilotChat.select').diagnostics,
            },
            Commit = {
                prompt =
                '実装差分に対するコミットメッセージを日本語で記述してください。',
                mapping = '<leader>cco',
                description = "コミットメッセージの作成をお願いする",
                selection = require('CopilotChat.select').gitdiff,
            },
            CommitStaged = {
                prompt =
                'ステージ済みの変更に対するコミットメッセージを日本語で記述してください。',
                mapping = '<leader>cs',
                description = "ステージ済みのコミットメッセージの作成をお願いする",
                selection = function(source)
                    return require('CopilotChat.select').gitdiff(source, true)
                end,
            },
        },
      }
    end,
  },

})


-- """"""""""""""""""""""""""""""""""""""
-- """"""""""""" 基本の設定 """""""""""""
-- """"""""""""""""""""""""""""""""""""""


-- viエディタの互換性をなくします
vim.opt.compatible = false

-- 行の先頭に行数を表示します
vim.opt.number = true

-- 改行した際に前の行のインデントを継承します
vim.opt.autoindent = true

-- 検索した文字列をハイライトします
vim.opt.hlsearch = true

-- 検索時にEnterを押さなくてもハイライト
vim.opt.incsearch = true

-- ESCでIMEを確実にOFF
vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>:set iminsert=0<CR>', { noremap = true, silent = true })
vim.opt.iminsert = 0
vim.opt.imsearch = 0

-- insert mode にキーバインド
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- insert mode でカーソル移動
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- ペーストモードの切り替え
vim.api.nvim_create_user_command('Sp', 'set paste', {})
vim.api.nvim_create_user_command('Snp', 'set nopaste', {})

-- backSpaceの調整
vim.opt.backspace = 'indent,eol,start'

-- 不可視文字を表示させる
vim.opt.list = true
vim.opt.listchars = { tab = '»-', trail = '-', eol = '↲', extends = '»', precedes = '«', nbsp = '%', space = '·' }

-- eol, extends, precedes のカラーを指定
vim.cmd('highlight NonText ctermfg=59')

-- nbsp, tab, trail のカラーを指定
vim.cmd('highlight SpecialKey ctermfg=59')

-- スペルチェック
vim.opt.spell = false

-- vimdiffの色設定
vim.cmd('highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17')
vim.cmd('highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52')
vim.cmd('highlight DiffChange cterm=bold ctermfg=10 ctermbg=22')
vim.cmd('highlight DiffText   cterm=bold ctermfg=10 ctermbg=21')

-- ファイル名の候補を出力
vim.opt.wildmenu = true

-- バッファの切り替え
vim.api.nvim_set_keymap('n', '<C-j>', ':bprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':bnext<CR>', { noremap = true, silent = true })

-- バッファを閉じた時にウィンドウは開いたままにする
vim.api.nvim_set_keymap('c', 'bd', 'b#|bd#<CR>', { noremap = true, silent = true })

-- 現在アクティブなバッファ以外を閉じる
vim.api.nvim_set_keymap('c', 'bc', 'let curr=bufnr("%")<Bar>bufdo if bufnr("%") ~= curr | bwipeout | endif<Bar>execute "buffer" curr<CR>', { noremap = true, silent = true })

-- 文字コード
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Beep音をオフ
vim.opt.visualbell = true

-- 補完
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "'", "''<Left>", { noremap = true, silent = true })

-- インデント
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

-- 旧式の正規表現を使用
vim.opt.re = 0


-- """"""""""""""""""""""""""""""""""""""""""
-- """"""""""""" ファイルの設定 """""""""""""
-- """"""""""""""""""""""""""""""""""""""""""
--

vim.cmd([[
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
  autocmd BufNewFile,BufRead *.sh set filetype=sh
  autocmd FileType sh setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

  " cだったらインデント幅が4
  autocmd BufNewFile,BufRead *.c set filetype=c
  autocmd FileType c setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

  " Makefileだったらタブ
  autocmd BufNewFile,BufRead Makefile set filetype=make
  autocmd FileType make setlocal tabstop=4 softtabstop=4 shiftwidth=4

  " nginxだったらインデント幅が2
  autocmd BufNewFile,BufRead *nginx*conf set filetype=nginx
  autocmd FileType nginx setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

  " luaだったらインデント幅が2
  autocmd BufNewFile,BufRead *.lua set filetype=lua
  autocmd FileType lua setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

augroup END
]])

-- .env.*ファイルをシェルスクリプトとして認識させる
vim.cmd('autocmd BufRead,BufNewFile .env.* set filetype=sh')


-- """"""""""""""""""""""""""""""""""""""""""
-- """"""""""""" スクリプト """""""""""""""""
-- """"""""""""""""""""""""""""""""""""""""""


-- ヤンクでクリップボードにコピー
vim.api.nvim_create_augroup('myYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'myYank',
  pattern = '*',
  callback = function()
    if vim.fn.system('uname -a | grep microsoft') ~= '' then
      vim.fn.system('clip.exe', vim.fn.getreg('"'))
    elseif vim.fn.system('uname') == "Darwin\n" then
      vim.fn.system('pbcopy', vim.fn.getreg('"'))
    end
  end,
})


-- 相対パスをコピーする関数
function _G.copy_relative_file_path()
  -- '%:.' は作業ディレクトリからの相対パスを取得する
  local file_path = vim.fn.expand('%:.')
  vim.fn.setreg('+', file_path)
  vim.fn.setreg('"', file_path)
  print(file_path)
end
-- :Path コマンドで相対パスをコピー
vim.api.nvim_create_user_command('Path', _G.copy_relative_file_path, {})


-- 絶対パスをコピーする関数
function _G.copy_absolute_file_path()
  -- '%:p' は絶対パスを取得する
  local file_path = vim.fn.expand('%:p')
  vim.fn.setreg('+', file_path)
  vim.fn.setreg('"', file_path)
  print(file_path)
end
-- :Patha コマンドで絶対パスをコピー
vim.api.nvim_create_user_command('Patha', _G.copy_absolute_file_path, {})


-- インサートモードを抜けた時に英数モードに切り替える
function _G.switch_to_english_layout()
  if vim.fn.executable('im-select') == 1 then
    vim.fn.system('im-select com.apple.keylayout.ABC')
  end
end

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    switch_to_english_layout()
  end,
})

-- """""""""""""""""""""""""""""""""""""""""""""
-- """"""""""""" ファイルの読み込み"""""""""""""
-- """""""""""""""""""""""""""""""""""""""""""""

-- プロジェクト内の*.vimファイルを読み込む
local filelist = vim.fn.glob('~/.config/nvim/project/*.lua', false, true)
for _, file in ipairs(filelist) do
  vim.cmd('source ' .. vim.fn.fnameescape(file))
end


