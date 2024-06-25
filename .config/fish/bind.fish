bind -M insert \cf accept-autosuggestion
bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
stty intr ^E
