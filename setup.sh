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

# Install latest SAM/CDK nightly
mkdir cdk-beta && cd cdk-beta
wget https://github.com/aws/aws-sam-cli/releases/download/sam-cli-beta-cdk/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
sudo ./sam-installation/install
cd ~/

# Create new key
ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''

# attach projects volume
mkdir ~/environment/projects
EC2_INSTANCE_ID="`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`"
aws ec2 attach-volume --device /dev/sdf --instance-id $EC2_INSTANCE_ID --volume-id vol-05a2e99a36911f69d
SG_NAME="`wget -q -O - http://169.254.169.254/latest/meta-data/security-groups`"
aws ec2 authorize-security-group-ingress --group-name $SG_NAME --protocol tcp --port 22 --cidr 0.0.0.0/0

# Add auto mount
VOL_UUID="`blkid /dev/nvme1n1 | sed -n 's/.*UUID=\"\([^\"]*\)\".*/\1/p'`"
sudo cp /etc/fstab /etc/fstab.orig
sudo su -c "echo 'UUID=$VOL_UUID  /home/ec2-user/environment/projects  xfs  defaults,nofail  0  2' >> /etc/fstab"
sudo mount -a

# Attach elastic IP
aws ec2 associate-address --allocation-id eipalloc-0a0f891b99cd8f2fd --instance-id $EC2_INSTANCE_ID

# install required packages
sudo yum install -y util-linux-user zsh jq

# Change root password
sudo passwd ec2-user

# Install ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
