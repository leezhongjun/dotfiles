## Dotfiles for termux

Included in config:
 - nvim
 - fish
 - starship
 - ranger
 - tmux
 - termux settings
 - tokyonight theme

### Instructions

#### Installing termux

Install termux, termux:api, and termux:styling from f-droid

#### Commands for one-time setup
```
git config --global user.email "80515759+henrlly@users.noreply.github.com"
git config --global user.name "Henry Lee"
set -Ux EDITOR nvim
fish_vi_key_bindings
chsh -s fish
fish_add_path ~/.local/bin/
fish_add_path ~/go/bin/
fish_add_path ~/.cargo/bin/
fish_add_path "~/bin"
```

#### tmux plugins
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
set -Ux TMUX_MANAGER_PLUGIN_PATH ~/.tmux/plugins/tpm
./.tmux/plugins/tpm/tpm
tmux source ~/.tmux.conf
```
Then press `ctrl+b` then `I` to install plugins

#### Packages
```
pkg install jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip ranger timg starship mdbook binutils ninja llvmgold tur-repo pandoc termux-tools termux-api fzf

# languages
pkg install nodejs stylua luarocks lua-language-server golang gopls rust-analyzer rust python3.7 lua51

# glow (for markdown rendering)
go install github.com/charmbracelet/glow@latest

# markdown-toc
npm install -g markdown-toc

# pip packages
pip install pyright autopep8 pygments
```

#### adb patch (For Android 12+, to prevent killing phantom processes):
```
adb shell "settings put global settings_enable_monitor_phantom_procs false"
```

#### Remap caps lock to esc for physical keyboard:

https://github.com/ris58h/exkeymo-web

#### Other notes:

 - `ctrl+v` to paste, `ctrl+x` to copy from android clipboard in fish
 - `ctrl+e` to interrupt
 - `ctrl+c` to switch to normal mode in fish shell
 - `ctrl+e`` to remove suggestions in nvim
 - Must use physical keyboard to do `alt+hjkl` window resizing
 - rust-analyzer's autocomplete doesn't work in a single .rs file.

