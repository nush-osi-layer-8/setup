echo "Upgrading and updating existing packages ..."
sudo apt-get update
sudo apt-get -y upgrade

# v. impt tools setup
echo "Installing build tools ..."
sudo apt-get install build-essential libssl-dev libffi-dev python-dev

echo "Installing Python 2 ..."
sudo apt-get install -y python2.7 python-pip

echo "Installing Python 3 ..."
sudo apt-get install -y python3.6 python3-pip

echo "Installing 32-bit support ..."
sudo dpkg --add-architecture i386
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt-get install multiarch-support

echo "Installing zsh ... "
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing radare2 ..."
git clone https://github.com/radare/radare2.git
./radare2/sys/install.sh

echo "Installing Ruby ... "
sudo apt-get install ruby-full

echo "Installing one-gadget ... "
gem install one_gadget

echo "Installing pwntools ..."
pip install pwntools
pip3 install pwntools

echo "Installing libc6-dbg and gdb ... "
sudo apt-get install libc6-dbg gdb valgrind

echo "Installing libc-database ... "
git clone https://github.com/niklasb/libc-database.git

echo "Installing Terminator ... "
sudo apt-get install terminator

echo "Copying datfiles into ~/. If you have existing dotfiles with the same name"
echo -n "they will be overwritten. Continue? (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    cp ./dotfiles/.* ~/
else
fi



