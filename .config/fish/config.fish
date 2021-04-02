# vi mode
fish_vi_key_bindings

# find completion dir
for d in (echo $XDG_DATA_DIRS | tr ':' '\n')
  if test -d {$d}/fish/completions
    set -Ux FPATH {$d}/fish/completions $FPATH
  end
end

# pyenv settings
set -Ux PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH

# user-local binaries
set -gx PATH $HOME/.bin $HOME/.local/bin $PATH

# for git commits
set -Ux EDITOR nvim

# aliases
alias d='docker'
alias dc='/usr/bin/docker-compose'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gr='git remote'
alias grb='git rebase'
alias k='kubectl'
if type -q bat
  alias cat='bat'
end
if type -q prettyping
  alias ping='prettyping'
end
if type -q hub
  alias git='hub'
end
if test -x $HOME/.cargo/bin/exa
  alias ls='exa'
end
if test -x $HOME/.cargo/bin/btm
  alias top='btm'
end
if test -x $HOME/.cargo/bin/procs
  alias ps='procs'
end

# virtualenv settings
set -Ux WORKON_HOME $HOME/.virtualenvs
set -Ux PROJECT_HOME $HOME/Projects
if test -d $HOME/.poetry
  set -gx PATH $HOME/.poetry/bin $PATH
end

# ghostscript (for gimp)
if test -f /usr/bin/gs
  set -Ux GS_PROG /usr/bin/gs
end

# insert last arg from previous command
bind -M insert \e. history-token-search-backward

# cargo binaries (rust)
set -gx PATH $HOME/.cargo/bin $PATH

# set go paths
set -Ux GOROOT
for dir in /usr/lib/go /usr/local/lib/go
  test -e $dir && set GOROOT $dir
  set -gx PATH $HOME/go/bin $GOROOT/bin $PATH
  break
end

# snap
set -gx PATH /snap/bin $PATH

# xpath
if test -d /usr/local/opt/libxml2/bin
  set -gx PATH $PATH /usr/local/opt/libxml2/bin
end

# android sdk
if test -d $HOME/Android/Sdk
  set -Ux ANDROID_SDK_ROOT $HOME/Android/Sdk
  set -Ux ANDROID_HOME $ANDROID_SDK_ROOT
end

# pyenv
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

# direnv
if type -q direnv
  eval (direnv hook fish)
end

# starship
starship init fish | source
set -Ux PYENV_ROOT "$HOME/.pyenv"
contains $PYENV_ROOT/bin $fish_user_paths; or set -a fish_user_paths $PYENV_ROOT/bin
# nodenv
set -Ux NODENV_ROOT "$HOME/.nodenv"
contains $NODENV_ROOT/shims $fish_user_paths; or set -a fish_user_paths $NODENV_ROOT/shims
# asdf
set -Ux ASDF_ROOT "$HOME/.asdf"
contains $ASDF_ROOT/bin $fish_user_paths; or set -a fish_user_paths $ASDF_ROOT/bin
contains $ASDF_ROOT/shims $fish_user_paths; or set -a fish_user_paths $ASDF_ROOT/shims

