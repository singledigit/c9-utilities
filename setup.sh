# Increase hard drive too 100 GB
./c9sizer.sh 100

# Update installed packages
sudo yum update -y

# Create Virtual Environments
mkdir /home/ec2-user/environment/penv
python3 -m venv /home/ec2-user/environment/penv/sam

# load venv, upgarde pip and install boto3
source /home/ec2-user/environment/penv/sam/bin/activate
pip install --upgrade pip
pip install boto3

# Install latest SAM
mkdir /home/ec2-user/environment/installs
cd /home/ec2-user/environment/installs
wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
sudo ./sam-installation/install --upgrade

# Create new key
ssh-keygen -f id_rsa -t rsa -N ''

# install required packages
sudo yum install -y util-linux-user zsh jq

# Change root password
sudo passwd ec2-user

# Install ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Update rc files
mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak
cp ~/c9-utilities/.bashrc ~/c9-utilities/.zshrc ~/

# Output public key
cat ~/.ssh/id_rsa.pub