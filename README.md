Others:
(https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29)

Neovim setup:
in /usr/share/applications/nvim.desktop and ~/.local/share/applications/nvim.desktop:
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

In `/etc/X11/xorg.conf.d/00-keyboard.conf`:
```
Section "InputClass"
        MatchIsKeyboard "on"
        Option "XkbOptions" "caps:swapescape"
EndSection
```

Firefox:
1. type about:config in the address bar.
2. in the search bar type gfx.webrender.all and set it to true.
3. in the search bar type media.ffmpeg.vaapi.enabled and set it to true.
4. in the search bar type toolkit.tabbox.switchByScrolling and set it to true.


Nvidia-settings:
```
sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support

sudo nvidia-settings
# then enable full composition pipeline and correct refresh rate
```

Packages:
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
# Fedora 40 https://software.opensuse.org//download.html?project=home%3ATheLocehiliosan%3Ayadm&package=yadm
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_40/home:TheLocehiliosan:yadm.repo

sudo dnf copr enable yorickpeterse/lua-language-server -y
sudo dnf upgrade -y
sudo dnf install jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip ranger pandoc clang-tools-extra go python3-pip luarocks lua-language-server fzf rofi vlc xset syncthing mupdf xdotool kernel-tools xarchiver thunar-archive-plugin libasan valgrind qutebrowser st flatpak python-pillow -y
chsh -s $(which fish)

sudo dnf debuginfo-install gdb glibc

sudo systemctl stop pcscd
sudo systemctl stop pcscd.socket


sudo dnf remove mousepad azote

git config --global user.email "80515759+zj-0@users.noreply.github.com"
git config --global user.name "henrlly"

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

# pygements, pyright and autopep8
pip install autopep8 pyright pygments

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# markdown-toc
sudo npm install -g markdown-toc
```

Copilot:
```
gh extensions install github/gh-copilot
```

Stremio:
```
https://github.com/alexandru-balan/Stremio-Install-Scripts
```

In startup (`~/.config/i3/config`) (depending on graphics card):
```
xrandr --output HDMI-0 --gamma 1.0:0.869:0.737

# or in ~/.nvidia-settings-rc
# [DPY:HDMI-0]/RedGamma=1.000000
# [DPY:HDMI-0]/GreenGamma=0.868607
# [DPY:HDMI-0]/BlueGamma=0.736888
```

In `/etc/lightdm/lightdm-gtk-greeter.conf` (background color):
```
[greeter]
background=#808080
```

Other notes:
ctrl+e to interrupt
