# This script is meant as a bootstrapper to get the basic
# dependencies setup, which is required by setup.sh

sudo apt-get install git
git clone https://github.com/nush-osi-layer-8/setup.git
sh ./setup/setup.sh