## Create python env
```
mkdir ~/venv/
python3 -m venv python3_8
source /home/ec2-user/environment/venv/python3_8/bin/activate
```

## Increase storage
```
chmod +x /home/ec2-user/environment/c9-utilities/c9sizer.sh && /home/ec2-user/environment/c9-utilities/c9sizer.sh 100
```

## Install zsh
```
sudo passwd ec2-user
brew install zsh
sudo yum install util-linux-user
chsh -s $(which zsh)
command -v zsh | sudo tee -a /etc/shells
```