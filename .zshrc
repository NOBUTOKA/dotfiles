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

# moshでsshの補完
compdef mosh=ssh

# ローカル設定の読み込み
if [ -e ~/.zshlocal ]; then
    source ~/.zshlocal
fi

# fzfのインストール
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
elif [ -f ~/.zplug/repos/junegunn/fzf/install ]; then
    ~/.zplug/repos/junegunn/fzf/install --no-update-rc
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --no-update-rc
fi

    

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

# Tramp対策
if [[ "$TERM" == "dumb" ]]; then
	unsetopt zle
	unsetopt prompt_cr
	unsetopt prompt_subst
	unfunction precmd
	unfunction preexec
	PS1='$ '
fi

# tmux起動(原則、zshrcの最後に置いておく)
PERCOL=fzf
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
