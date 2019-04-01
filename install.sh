#!/usr/bin/env bash

set -e
set -u
set -o pipefail

is_app_installed() {
  type "$1" &>/dev/null
}

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";

if ! is_app_installed tmux; then
  printf "WARNING: \"tmux\" command is not found. \
Install it first\n"
  exit 1
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  printf "WARNING: Cannot found TPM (Tmux Plugin Manager) \
 at default location: \$HOME/.tmux/plugins/tpm.\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ -e "$HOME/.tmux.conf" ]; then
  printf "Found existing .tmux.conf in your \$HOME directory. Will create a backup at $HOME/.tmux.conf.bak\n"
fi

if [ -e "$HOME/.vimrc" ]; then
  printf "Found existing .vimrc in your \$HOME directory. Will create a backup at $HOME/.vimrc.bak\n"
fi

if [ -e "$HOME/.bashrc" ]; then
  printf "Found existing .bashrc in your \$HOME directory. Will create a backup at $HOME/.bashrc.bak\n"
fi

if [ -e "$HOME/.bash_aliases" ]; then
  printf "Found existing .bash_aliases in your \$HOME directory. Will create a backup at $HOME/.bash_aliases.bak\n"
fi

if [ ! -a "$HOME/.inputrc" ]; then
  echo "set completion-ignore-case On" > "$HOME/.inputrc"
fi

cp -f "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak" 2>/dev/null || true
cp -f "$HOME/.vimrc" "$HOME/.vimrc.bak" 2>/dev/null || true
cp -f "$HOME/.bashrc" "$HOME/.bashrc.bak" 2>/dev/null || true
cp -f "$HOME/.bash_aliases" "$HOME/.bash_aliases.bak" 2>/dev/null || true
cp -a ./tmux/. "$HOME"/.tmux/
cp -f ./vimrc "$HOME"/.vimrc
cp -f ./bashrc "$HOME"/.bashrc
cp -f ./bash_aliases "$HOME"/.bash_aliases
ln -sf .tmux/tmux.conf "$HOME"/.tmux.conf;

source "$HOME"/.bashrc

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
printf "Install TPM plugins\n"
tmux new -d -s __noop >/dev/null 2>&1 || true 
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

printf "OK: Completed\n"
