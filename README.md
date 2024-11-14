## Dotfiles for macos (sequoia)

Included in config:
 - kitty
 - nvim
 - fish
 - starship
 - ranger
 - tokyonight theme

This works with M3 MacBook Air

### Instructions

#### Fish
Install fish shell from the macos installer at https://fishshell.com

#### Packages
```
brew update && brew upgrade

# Install packages
brew install node miniconda jq cmake neovim yadm gh git wget ripgrep make unzip pandoc go luarocks lua-language-server fzf vlc ranger python autopep8 pyright pygments

# Change shell to fish
sudo bash -c 'echo $(which fish) >> /etc/shells'
chsh -s $(which fish)
# Reboot after changing shell

# starship prompt
curl -sS https://starship.rs/install.sh | sh

# glow (for markdown rendering)
go install github.com/charmbracelet/glow@latest

# gopls
go install golang.org/x/tools/gopls@latest

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# stylua and mdbook
cargo install stylua mdbook

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# markdown table of contents
npm install -g markdown-toc

# nerd font
brew tap epk/epk
brew install font-sf-mono-nerd-font
```

#### Alfred
1. Open Alfred 5 from applications and go through setup
2. Open Alfred preferences and set Alfred Hotkey to `cmd+space`
2. Go to settings --> keyboard --> keyboard shortcuts --> spotlight --> uncheck both boxes


#### Github Copilot CLI
```
gh extensions install github/gh-copilot

# To use
ghcs "${DESCRIBE_COMMAND}"
ghce "${EXPLAIN_COMMAND}"
```
