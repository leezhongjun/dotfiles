commands to run one-time to setup:
```
set -Ux EDITOR nvim
fish_vi_key_bindings
chsh -s fish
```

packages:
```
jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip
```

languages:
```
nodejs stylua luarocks lua-language-server golang gopls rust-analyzer rust pyright
```

pip:
```
autopep8
```

termux-specific (install from f-droid):
termux-api termux-tools termux-styling
 - tokyonight dark
 - source code pro

other notes:
ctrl+b then I to install plugins from tmux
ctrl+v to paste, ctrl+x to copy from android clipboard in fish
ctrl+e to interrupt
ctrl+c to switch to normal mode in fish shell
ctrl+e to remove suggestions in nvim
must use physical keyboard to do alt+hjkl window resizing

---

rust-analyzer's autocomplete doesn't work in a single .rs file.
