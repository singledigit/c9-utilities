# Update rc files
mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak
cp ~/environment/c9-utilities/.bashrc ~/environment/c9-utilities/.zshrc ~/
source ~/.zshrc

# Output public key
cat ~/.ssh/id_rsa.pub
