# screen
export SCREENDIR=$HOME/.screen

# パスの設定
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
# composerをパスに追加
PATH="$HOME/.config/composer/vendor/bin:$PATH"
# denoをパスに追加
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# alias
alias cd="pushd$1 > /dev/null"
alias dirs='dirs -v'

alias hgrep='history | grep'
alias hrg='history | rg'
