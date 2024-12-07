## Dotfiles for fedora i3

Included in config:
 - i3
 - kitty
 - nvim
 - fish
 - starship
 - ranger
 - tokyonight theme

This works on my desktop with:
 - Ryzen 3600
 - Nvidia 1070
 - Username: h

### Instructions

#### Packages
```
# Add rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Add yadm repo
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_40/home:TheLocehiliosan:yadm.repo

# Add github desktop package feed (https://github.com/shiftkey/desktop)
sudo rpm --import https://mirror.mwt.me/shiftkey-desktop/gpgkey
sudo sh -c 'echo -e "[mwt-packages]\nname=GitHub Desktop\nbaseurl=https://mirror.mwt.me/shiftkey-desktop/rpm\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://mirror.mwt.me/shiftkey-desktop/gpgkey" > /etc/zypp/repos.d/mwt-packages.repo'

# Lua LS
sudo dnf copr enable yorickpeterse/lua-language-server -y

sudo dnf upgrade -y

# Configure multimedia - https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29
# Switch to full ffmpeg
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
# Install additional codecs
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# Install packages
sudo dnf install conda jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip pandoc clang-tools-extra go python3-pip luarocks lua-language-server fzf rofi vlc xset syncthing mupdf xdotool kernel-tools xarchiver thunar-archive-plugin libasan valgrind qutebrowser st flatpak python-pillow flameshot github-desktop -y

# Install ranger
# ranger installed with dnf doesn't work in python 3.13
# https://github.com/ranger/ranger/issues/3019
pip install git+https://github.com/ranger/ranger.git

# Change shell to fish
chsh -s $(which fish)

# Install gdb
sudo dnf debuginfo-install gdb glibc

# Disable smart card daemon
sudo systemctl stop pcscd
sudo systemctl stop pcscd.socket

# Remove mousepad text editor and azote picture browser and background setter
sudo dnf remove mousepad azote

# Git config
git config --global user.email "80515759+henrlly@users.noreply.github.com"
git config --global user.name "Henry Lee"

# Power menu
chmod +x .config/i3/rofi-power-menu

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

# python type checker, formatter, and syntax highlighter
pip install autopep8 pyright pygments

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# markdown table of contents
sudo npm install -g markdown-toc
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

#### Swap caps lock and escape for keyboard
Add to `/etc/X11/xorg.conf.d/00-keyboard.conf`
```
Section "InputClass"
        MatchIsKeyboard "on"
        Option "XkbOptions" "caps:swapescape"
EndSection
```

#### Firefox
1. Type `about:config` in the address bar.
2. In the search bar, type `gfx.webrender.all` and set it to `true`.
3. In the search bar, type `media.ffmpeg.vaapi.enabled` and set it to `true`.
4. In the search bar, type `toolkit.tabbox.switchByScrolling` and set it to `true`.
5. In the search bar, type `browser.zoom.siteSpecific` and set it to `false`.
6. In the search bar, type `layout.css.devPixelsPerPx` and set it to `1.0`.


#### Nvidia settings
```
sudo dnf install akmod-nvidia
# optional for cuda/nvdec/nvenc support
sudo dnf install xorg-x11-drv-nvidia-cuda 

sudo nvidia-settings
# then enable full composition pipeline and correct refresh rate
```

#### Night light
Add to  `~/.config/i3/config` (to execute during startup)
```
xrandr --output HDMI-0 --gamma 1.0:0.869:0.737

# Or add to ~/.nvidia-settings-rc
# [DPY:HDMI-0]/RedGamma=1.000000
# [DPY:HDMI-0]/GreenGamma=0.868607
# [DPY:HDMI-0]/BlueGamma=0.736888
```

#### Background color for desktop and greeter
Add to `/etc/lightdm/lightdm-gtk-greeter.conf`
 - `#808080` is gray color
```
[greeter]
background=#808080
```

#### Github Copilot CLI
```
gh extensions install github/gh-copilot

# To use
ghcs "${DESCRIBE_COMMAND}"
```

#### Stremio
https://github.com/alexandru-balan/Stremio-Install-Scripts

