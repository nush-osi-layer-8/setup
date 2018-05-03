echo "Upgrading and updating existing packages ..."
sudo apt-get update
sudo apt-get -y upgrade

# v. impt tools setup
echo "\nInstalling build tools ...\n"
sudo apt-get --assume-yes install build-essential libssl-dev libffi-dev python-dev

echo "\nInstalling Python 2 ...\n"
sudo apt-get --assume-yes install -y python2.7 python-pip

echo "\nInstalling Python 3 ...\n"
sudo apt-get --assume-yes install -y python3.6 python3-pip

echo "\nInstalling 32-bit support ...\n"
sudo dpkg --add-architecture i386
sudo apt-get --assume-yes install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt-get --assume-yes install multiarch-support

echo "\nInstalling curl ... \n"
sudo apt-get --assume-yes install curl

echo "\nInstalling radare2 ...\n"
git clone https://github.com/radare/radare2.git
./radare2/sys/install.sh

echo "\nInstalling Ruby ... \n"
sudo apt-get --assume-yes install ruby-full

echo "\nInstalling one-gadget ... \n"
sudo gem install one_gadget

echo "\nInstalling pwntools ...\n"
pip install pwntools
pip3 install pwntools

echo "\nInstalling libc6-dbg and gdb ... \n"
sudo apt-get --assume-yes install libc6-dbg gdb valgrind

echo "\nInstalling libc-database ... \n"
git clone https://github.com/niklasb/libc-database.git

echo "\nInstalling Terminator ...\n"
sudo apt-get --assume-yes install terminator

echo "\nCopying datfiles into ~/. If you have existing dotfiles with the same name"
echo -n "they will be overwritten. Continue? (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "\nUnderstood"
else
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cp $DIR/config/.* ~/
    sh $DIT/config/config.sh
fi



