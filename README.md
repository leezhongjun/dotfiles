## Dotfiles for ubuntu wsl

**Note: this is pretty old and outdated**

Included in config:
 - tmux
 - nvim
 - fish
 - starship
 - ranger
 - termux settings
 - tokyonight theme

### Instructions

#### Commands for one-time-setup
```
set -Ux EDITOR nvim
fish_vi_key_bindings
chsh -s $(which fish)
fish_add_path ~/.local/bin/
mkdir .virtualenvs
fish_add_path ~/go/bin/
fish_add_path ~/.cargo/bin/
set -gx TERM tmux-256color
```

#### Packages
```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt install jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang clangd unzip ranger pandoc clang-format

# starship prompt
curl -sS https://starship.rs/install.sh | sh

# glow (for markdown rendering)
go install github.com/charmbracelet/glow@latest

# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# brew
sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | /bin/bash
fish_add_path /home/linuxbrew/.linuxbrew/bin/

# languages
sudo apt install gopls luarocks python3-venv python-is-python3 python3-pip

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# rust_analyzer
rustup component add rust-analyzer

# stylua and mdbook
cargo install stylua mdbook

# go and luaLS
brew install go lua-language-server

# nvm and latest node
fisher install jorgebucaran/nvm.fish
nvm install latest

# pygements, pyright and autopep8
pip install autopep8 pyright pygments

# markdown-toc
npm install -g markdown-toc
```

#### tmux plugins:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
set -Ux TMUX_MANAGER_PLUGIN_PATH ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# ctrl+b then I to install plugins from tmux
```

#### Github Copilot CLI
```
gh extensions install github/gh-copilot
```

#### Other notes:

 - `ctrl+v` to paste, `ctrl+x` to copy from android clipboard in fish
 - `ctrl+e` to interrupt
 - `ctrl+c` to switch to normal mode in fish shell
 - `ctrl+e` to remove suggestions in nvim
 - rust-analyzer's autocomplete doesn't work in a single .rs file.

#### Swap caps lock and esc for keyboard (windows)

https://renenyffenegger.ch/notes/Windows/registry/tree/HKEY_LOCAL_MACHINE/System/CurrentControlSet/Control/Keyboard-Layout/index

```
$s_ESC  = 0x01, 0x00
$s_CAPS = 0x3a, 0x00
$s_RWIN = 0x5c, 0xe0
$s_RCTR = 0x1d, 0xe0

$mapping = [byte[]] (
  0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00,
  0x04, 0x00, 0x00, 0x00+  # 3 mapping + 1 ending = 0x04
  $s_ESC    + $s_CAPS   +  # 1st mapping: caps lock -> escape
  $s_CAPS   + $s_ESC    +  # 2nd mapping: escape -> caps lock
  $s_RCTR   + $s_RWIN   +  # 3rd mapping: right windows -> right control
  0x00, 0x00, 0x00, 0x00   # final four bytes
)

$null = new-itemProperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" -name "Scancode Map" -value $mapping -force
```

#### For wsl
```
sudo apt install wslu
```

#### wsl dns error fix

https://askubuntu.com/a/1353199

#### For alacritty

https://github.com/alacritty/alacritty/issues/1663#issuecomment-1917418514

In `alacritty.toml`:
```
### SETTINGS ###
[shell]
program = "ubuntu"

[window]
startup_mode = "Maximized"

# Ctrl+Space fix
[keyboard]
bindings = [
	{key = "Space", mods = "Control", chars = "\u0000"},
]

### FONT ###
# Download and install: https://www.nerdfonts.com/font-downloads
[font]
normal = { family = "SauceCodePro Nerd Font Mono" }
bold = { family = "SauceCodePro Nerd Font Mono" }
italic = { family = "SauceCodePro Nerd Font Mono" }
bold_italic = { family = "SauceCodePro Nerd Font Mono" }
size = 12


### THEME ###

# Colors (Tokyo Night)
# Source https//github.com/zatchheems/tokyo-night-alacritty-theme

# Default colors
[colors.primary]
background = '#1a1b26'
foreground = '#a9b1d6'

# Normal colors
[colors.normal]
black   = '#32344a'
red     = '#f7768e'
green   = '#9ece6a'
yellow  = '#e0af68'
blue    = '#7aa2f7'
magenta = '#ad8ee6'
cyan    = '#449dab'
white   = '#787c99'

# Bright colors
[colors.bright]
black   = '#444b6a'
red     = '#ff7a93'
green   = '#b9f27c'
yellow  = '#ff9e64'
blue    = '#7da6ff'
magenta = '#bb9af7'
cyan    = '#0db9d7'
white   = '#acb0d0'
```

#### For wezterm
In `wezterm.lua`:
```
local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = {}

config.color_scheme = 'tokyonight'
config.font = wezterm.font 'SauceCodePro Nerd Font Mono'
config.default_domain = 'WSL:Ubuntu'
config.hide_tab_bar_if_only_one_tab = true

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)


return config
```
