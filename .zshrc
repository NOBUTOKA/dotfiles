autoload -U compinit promptinit
compinit
promptinit; prompt gentoo

#ロケール設定
export LANG=ja_JP.UTF-8

#プロンプト設定
autoload -Uz colors
colors
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{$fg[green]%}[%n@%m]$%{$reset_color%} "
    RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"
    PROMPT2="%{[32m%}%_%%%{[m%} "
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
