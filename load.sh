#!/bin/bash

# you will need to change permissions on the file before you can run it
# chmod +x ./load.sh

# then run this (so you do not have to type "yes" 3 times while it is running):
# yes yes yes | ./load.sh

# then at the end, reboot for everything to take effect
# sudo reboot now

# update and upgrade system
echo Update and upgrade system
sudo apt-get update && sudo apt-get dist-upgrade

# load some programs
echo Load programs
sudo apt install tree
sudo apt install unzip

# load .vimrc file
echo Load .vimrc file
cp ./.vimrc ~/.vimrc

# copy over shell script file
echo Load shell script files
mkdir ~/scripts
cp ./repo.sh ~/scripts/repo.sh
sudo chmod +x ~/scripts/repo.sh
cp ./repo.sh ~/scripts/git-push.sh
sudo chmod +x ~/scripts/git-push.sh
cp ./java-lint.sh ~/scripts/java-lint.sh
sudo chmod +x ~/scripts/java-lint.sh
cp ./main.yml ~/scripts/main.yml
cp ./swift.yml ~/scripts/swift.yml

# load YouCompleteMe
echo Load YouCompleteMe plugin for Vim
sudo apt install vim-youcompleteme
vim-addon-manager install youcompleteme

# load java programming software
echo load Java
sudo apt install default-jdk

# loading checkstyle for java
# https://github.com/checkstyle/checkstyle/releases
echo load CheckStyle for Java
wget https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.44/checkstyle-8.44-all.jar
cp ./checkstyle-8.44-all.jar ~/scripts/checkstyle.jar
wget https://raw.githubusercontent.com/Mr-Coxall/dot_files/main/mr-coxall_checks.xml
cp ./mr-coxall_checks.xml ~/scripts/


# you might need to get a newer version of swift
# https://swift.org/download/
echo load Swift
sudo apt-get install -y clang libblocksruntime0 libcurl4-openssl-dev
wget https://swift.org/builds/swift-5.4.1-release/ubuntu2004/swift-5.4.1-RELEASE/swift-5.4.1-RELEASE-ubuntu20.04.tar.gz
tar -zxvf swift-5.4.1-RELEASE-ubuntu20.04.tar.gz
sudo mkdir /usr/bin/swift
sudo cp -R ./swift-5.4.1-RELEASE-ubuntu20.04/usr/* /usr/bin/swift
echo "" >> ~/.bashrc
echo 'export PATH="${PATH}":/usr/bin/swift/bin' >> ~/.bashrc

# SwiftLint
# https://github.com/realm/SwiftLint/releases
echo load SwiftLint for Swift
wget https://github.com/realm/SwiftLint/releases/download/0.43.1/swiftlint_linux.zip
unzip -n swiftlint_linux.zip
sudo mkdir /usr/bin/swiftlint
sudo cp ./swiftlint /usr/bin/swiftlint/
echo 'export PATH="${PATH}":/usr/bin/swiftlint' >> ~/.bashrc
echo "" >> ~/.bashrc

# Swift syntax highlighting for Vim
# Original Source: http://wingsquare.com/blog/swift-script-syntax-highlighting-and-indentation-for-vim-text-editor/
# Another helpful article: https://billyto.github.io/blog/swift-syntax-vim
# More about Vim packages: http://vimcasts.org/episodes/packages/
echo "--- creating ~/.vim/pack/bundle/start dir.."
mkdir -p ~/.vim/pack/bundle/start
echo "--- Cloning Apple's Swift repo.."
git clone --depth=1 https://github.com/apple/swift/
echo "--- Copying plugin to Vim bundles.."
cp -r ./swift/utils/vim ~/.vim/pack/bundle/start/swift
# echo "--- Cleaning up, removing swift repo.."
# rm -rf ./swift/

# change some BASH settings
echo adding some BASH commands to .bashrc
echo "" >> ~/.bashrc
echo "parse_git_branch() {" >> ~/.bashrc
echo "      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> ~/.bashrc
echo "}" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "PS1='\[\033[01;32m\]\u:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ '" >> ~/.bashrc
echo "PROMPT_DIRTRIM=1" >> ~/.bashrc

# update Git
echo upgrade Git
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

# load GitHub CLI
echo load GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt install gh


# reboot
echo ---
echo rebooting now ...
echo ---
sudo reboot now


# after reboot, need to run the following by hand

# provision GitHub
ssh-keygen -t ed25519 -C "mr.coxall@mths.ca"
eval "$(ssh-agent -s)"
# then copy public key over to GitHub SSH keys
cat ~/.ssh/id_ ... .pub
# to test it out
ssh -T git@github.com
git config --global --edit

# configure GitHub CLI
gh auth login
# web method most likely the easiest
# use existing GitHub SSH keys

# then remove the dot_files firectory 
sudo rm -R ~/dot_files
