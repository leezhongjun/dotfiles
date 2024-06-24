others:
https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29

neovim terminal setup:
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

nvidia-settings:
```
sudo nvidia-settings
# then enable full composition pipeline and correct refresh rate
```

i3-restore:
https://github.com/jdholtz/i3-restore
cp utils/ and programs/ too

packages:
```
# Fedora 40 https://software.opensuse.org//download.html?project=home%3ATheLocehiliosan%3Ayadm&package=yadm
dnf config-manager --add-repo https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_40/home:TheLocehiliosan:yadm.repo

sudo dnf copr enable yorickpeterse/lua-language-server
sudo dnf upgrade
sudo dnf install jq cmake which fish tmux neovim yadm gh git wget ripgrep make clang unzip ranger pandoc clang-tools-extra go python3-pip luarocks lua-language-server fzf rofi vlc xset syncthing mupdf xdotool kernel-tools xarchiver thunar-archive-plugin libasan valgrind
chsh -s $(which fish)

sudo dnf debuginfo-install gdb glibc

sudo systemctl stop pcscd
sudo systemctl stop pcscd.socket
sudo systemctl disable pcscd
sudo systemctl disable pcscd.socket

sudo dnf remove mousepad azote

git config --global user.email "80515759+zj-0@users.noreply.github.com"
git config --global user.name "zj"

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

# markdown-toc
sudo npm install -g markdown-toc
```

copilot:
```
gh extensions install github/gh-copilot
```

stremio:
```
https://github.com/alexandru-balan/Stremio-Install-Scripts
```

put in startup (depending on graphics card):
```
xrandr --output HDMI-0 --gamma 1.0:0.869:0.737

# or in ~/.nvidia-settings-rc
# [DPY:HDMI-0]/RedGamma=1.000000
# [DPY:HDMI-0]/GreenGamma=0.868607
# [DPY:HDMI-0]/BlueGamma=0.736888
```

background:

in `/etc/lightdm/lightdm-gtk-greeter.conf`

```
[greeter]
background=#808080
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

