# Install zplug
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
# Install fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ;~/.fzf/install

autoload -U compinit promptinit
compinit
promptinit

#ロケール設定
export LANG=ja_JP.UTF-8

#プロンプト設定
autoload -Uz colors
colors
case ${UID} in
0)
    PROMPT="%B%{$fg[green]%}[%n@%m]$%{$reset_color%}%b "
    RPROMPT="%B%{$fg[cyan]%}[%~]%{$reset_color%}%b"
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{$fg[green]%}[%n@%m]$%{$reset_color%} "
    RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"
    PROMPT2="%{$fg[green]%}%_%%%{$reset_color%} "
    SPROMPT="%{[32m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac 

#zplug設定
source ~/.zplug/init.zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

#C-rのようにC-sを使う(フロー制御を無効化)
setopt no_flow_control

# word-chars で指定した文字が単語の区切りとみなされる。
# M-f, M-b, ^w などの動作に影響する
WORDCHARS='.'
autoload -Uz select-word-style
select-word-style default 
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

#sudo時に環境変数を引き継ぎ
alias sudo='sudo -E '
#sudo補完
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"

#lsとパス補完を色付け
alias ls="ls -a --color=auto"
zstyle ':completion:*' list-colors "${LS_COLORS}"

#from:
#http://ama-ch.hatenablog.com/entry/20090109/1231526834
# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# 補完候補を詰めて表示する
setopt list_packed

# Emacsライクキーバインド設定
bindkey -e 


# ローカル設定の読み込み
if [ -e ~/.zshlocal ]; then
    source ~/.zshlocal
fi
