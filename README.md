commands for one-time setup:
```
git config --global user.email "80515759+h@users.noreply.github.com"
git config --global user.name "Henry"
set -Ux EDITOR nvim
fish_vi_key_bindings
chsh -s fish
fish_add_path ~/.local/bin/
fish_add_path ~/go/bin/
fish_add_path ~/.cargo/bin/
fish_add_path "~/bin"
```


tmux plugins:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
set -Ux TMUX_MANAGER_PLUGIN_PATH ~/.tmux/plugins/tpm
./.tmux/plugins/tpm/tpm
tmux source ~/.tmux.conf
```
then press ctrl+b I to install plugins

packages:
```
pkg install jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip ranger timg starship mdbook binutils ninja llvmgold tur-repo pandoc termux-tools termux-api fzf

# languages
pkg install nodejs stylua luarocks lua-language-server golang gopls rust-analyzer rust python3.7 lua51

# glow (for markdown rendering)
go install github.com/charmbracelet/glow@latest

# markdown-toc
npm install -g markdown-toc
```

pip:
```
pip install pyright autopep8 pygments
```

termux-specific (install from f-droid):

termux-api termux-tools termux-styling
 - tokyonight dark
 - source code pro

adb patch (for android 12+, to prevent killing phantom processes):
```
adb shell "settings put global settings_enable_monitor_phantom_procs false"
```

other notes:

ctrl+b then I to install plugins from tmux

ctrl+v to paste, ctrl+x to copy from android clipboard in fish

ctrl+e to interrupt

ctrl+c to switch to normal mode in fish shell

ctrl+e to remove suggestions in nvim

must use physical keyboard to do alt+hjkl window resizing

---

rust-analyzer's autocomplete doesn't work in a single .rs file.

---

remap caps lock to esc for physical keyboard:

https://github.com/ris58h/exkeymo-web
