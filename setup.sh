echo "Upgrading and updating existing packages ... \n"
sudo apt-get update
sudo apt-get -y upgrade
# v. impt tools setup
echo "Installing build tools ... \n"
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
echo "Installing Python 3 (Python 2 pre-installed)\n"
sudo apt-get install -y python3-pip
echo "Installing zsh ...\n"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Installing radare2 ..."
git clone https://github.com/radare/radare2.git
./radare2/sys/install.sh
echo "Copying datfiles into ~/. If you have existing dotfiles with the same name"
echo -n "they will be overwritten. Continue? (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    cp ./dotfiles/.* ~/
else
fi



