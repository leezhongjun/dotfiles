commands to run one-time to setup:
```
set -Ux EDITOR nvim
fish_vi_key_bindings
chsh -s fish
fish_add_path ~/.local/bin/
fish_add_path ~/go/bin/
fish_add_path ~/.cargo/bin/
```

tmux plugins:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
set -Ux TMUX_MANAGER_PLUGIN_PATH ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
```
then press ctrl+b I to install plugins

packages:
```
pkg install jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip

# languages
pkg install nodejs stylua luarocks lua-language-server golang gopls rust-analyzer rust

# starship prompt
curl -sS https://starship.rs/install.sh | sh

# glow (for markdown rendering)
go install github.com/charmbracelet/glow@latest
```

pip:
```
pip install pyright autopep8
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
