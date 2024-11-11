## Dotfiles for fedora sway

**Note: This is pretty old and outdated**

Included in config:
 - i3
 - kitty
 - nvim
 - fish
 - starship
 - ranger
 - tokyonight theme

This works on my laptop:

*ASUS Vivobook S15 M533IA*

### Instructions

#### Packages
```
# Add rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Add yadm repo
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_40/home:TheLocehiliosan:yadm.repo

# Lua LS
sudo dnf copr enable yorickpeterse/lua-language-server -y

sudo dnf upgrade -y

# Configure multimedia - https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29
# Switch to full ffmpeg
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
# Install additional codecs
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

sudo dnf install -y jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip ranger pandoc clang-tools-extra go python3-pip luarocks lua-language-server fzf vlc syncthing mupdf kernel-tools xarchiver thunar-archive-plugin libasan valgrind surf flatpak

chsh -s $(which fish)

sudo dnf debuginfo-install gdb glibc

git config --global user.email "80515759+henrlly@users.noreply.github.com"
git config --global user.name "Henry Lee"

chmod +x .config/sway/rofi-power-menu

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

# pygements, pyright and autopep8
pip install autopep8 pyright pygments

# markdown-toc
sudo npm install -g markdown-toc

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

#### Additonal Neovim settings
Add to `/usr/share/applications/nvim.desktop` and `~/.local/share/applications/nvim.desktop`
```
[Desktop Entry]
Name=Neovim
Exec=kitty -e nvim %F
Terminal=false
Type=Application
Keywords=Text;editor;
Icon=nvim
Categories=Utility;TextEditor;
StartupNotify=false
```

#### Github Copilot CLI
```
gh extensions install github/gh-copilot
```

#### Stremio
```
https://github.com/alexandru-balan/Stremio-Install-Scripts
```

#### Night light
Add to startup
```
xrandr --output HDMI-0 --gamma 1.0:0.869:0.737
```

#### Other notes:

 - `ctrl+e` to interrupt
 - `ctrl+c` to switch to normal mode in fish shell
 - `ctrl+e` to remove suggestions in nvim
 - rust-analyzer's autocomplete doesn't work in a single .rs file.

