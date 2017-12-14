#!/bin/bash

#Redirects file descriptors to created log file (date-time_Installation-log.txt), all console output is written to file.
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/home/$USER/Downloads/$(date +'%Y%m%d-%T')_Installation-log.txt 2>&1

#-------------------------------------------------------------------------------------------------

echo -e "Starting...\n"
cd ~
echo -e "Starting update...\n"
sudo apt-get update
echo -e "\nFinished update...\n"
echo -e "Staring upgrade...\n"
sudo apt-get upgrade -yy
echo -e "\nFinished upgrade...\n"
echo -e "Installing htop, vlc, default-jdk, python, python-setuptools, python-pip, git, fdupes...\n"
sudo apt-get install -yy htop vlc default-jdk python python-setuptools python-pip git fdupes
echo -e "\nFinished apt-get install...\n"

#Make folder for .deb packages/installers
echo -e "Making directory /home/$USER/Downloads/deb-packages ...\n"
mkdir -p /home/$USER/Downloads/deb-packages

#-------------------------------------------------------------------------------------------------------------

#Install Chrome 
echo -e "Downloading Google Chrome..."
cd /home/$USER/Downloads/deb-packages
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo -e "Installing Google Chrome...\n"
sudo dpkg -i google-chrome-stable_current_amd64.deb
cd ~

#--------------------------------------------------------------------------------------------------------------

#Install Spotify
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
echo -e "Adding Spotify repository signing keys...\n"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo -e "Adding Spotify repository...\n"
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
echo -e "Updating list of available packages...\n"
sudo apt-get update

# 4. Install Spotify
echo -e "Installgin Spotify...\n"
sudo apt-get install -yy spotify-client

#Blocking Adds
#Add contents of blockspotifyads.txt to /etc/hosts [sudo required]
echo -e "Blocking Spotify ads...\n"
cd /home/$USER/Downloads/
wget https://raw.githubusercontent.com/Decxcraft/dotfiles/master/PostInstallation/blockspotifyads.txt
sudo sh -c "cat blockspotifyads.txt >> /etc/hosts"
echo -e "Done blocking ads...\n"

#-----------------------------------------------------------------------------------------------------------------

#Installing Docky
echo -e "Adding Docky repository... \n"
sudo add-apt-repository ppa:docky-core/stable -y
echo -e "Updating list of available packages...\n"
sudo apt-get update
echo -e "\nInstalling Docky... \n"
sudo apte-get install -yy docky

#------------------------------------------------------------------------------------------------------------------

#Installing SublimeText
echo -e "Adding SublimeText keys...\n"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -yy apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo -e "Updating list of available packages...\n"
sudo apt-get update -qq
echo -e "\nInstalling SublimeText...\n"
sudo apt-get install -yy sublime-text

#---------------------------------------------------------------------------------------------------------------------

#Franz-Messaging app manager
cd /home/$USER/Downloads/deb-packages/
echo -e "Downloading Franz... \n"
wget https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.14/franz_5.0.0-beta.14_amd64.deb
echo -e "Installing Franz... \n"
sudo dpkg -i franz_5.0.0-beta.14_amd64.deb

#------------------------------------------------------------------------------------------------------------------------

#Better font rendering
echo -e "Installing Better font rendering...\n"
sudo add-apt-repository ppa:no1wantdthisname/ppa -y
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install fontconfig-infinality
echo -e "Finished installing Better font rendering...\n"

#----------------------------------------------------------------------------------------------------------------------------

#Installing instagram-scraper
echo -e "Installing instagram-scraper"
pip install instagram-scraper

#----------------------------------------------------------------------------------------------------------------------------