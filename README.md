## Dotfiles for ish

Included in config:
 - vim
 - ash
 - git

### Instructions

#### Packages
```
apk update -y && apk upgrade -y
apk add bash vim gcc g++ git openssh openrc -y
```

#### Github auth via ssh
Refer to https://github.com/januszoles/ish

1. Add email and start ssh agent
```
# Replace with your email
ssh-keygen -t ed25519 -C "MY@EMAIL.COM"
eval "$(ssh-agent -s)"
```

2. Add to `~/.ssh/config`
```
#---------------------------------
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
#---------------------------------
```

3. Add private ssh key to ssh agent
```
ssh-add ~/.ssh/id_ed25519
```

4. Copy output and paste into https://github.com/settings/ssh/new
```
cat ~/.ssh/id_ed25519.pub 
```

5. Clone github repos via ssh
```
git clone git@github.com:henrlly/dotfiles.git
```

