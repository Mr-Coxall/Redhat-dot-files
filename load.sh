#!/bin/bash

# you will need to install git, to even get this repo
# run ...
# sudo yum install git -y

# you will need to change permissions on the file before you can run it
# chmod +x ./load.sh

# then at the end, reboot for everything to take effect
# sudo reboot now

# update and upgrade system
echo Update and upgrade system
sudo yum check-update
sudo yum -y upgrade

# load some programs
echo Load programs
sudo yum install tree -y
# sudo apt install unzip

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
# sudo apt install vim-youcompleteme
# vim-addon-manager install youcompleteme

# load java programming software
echo load Java
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install java-11-openjdk-devel -y

# loading checkstyle for java
# https://github.com/checkstyle/checkstyle/releases
echo load CheckStyle for Java
wget https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.44/checkstyle-8.44-all.jar
cp ./checkstyle-8.44-all.jar ~/scripts/checkstyle.jar
cp ./mr-coxall_checks.xml ~/scripts/


# you might need to get a newer version of swift
# https://swift.org/download/
echo load Swift
# sudo yum install -y binutils gcc glibc-static libbsd libcurl libedit libicu libsqlite libstdc++-static libuuid libxml2 tar tzdata
sudo yum install -y binutils gcc glibc-static libcurl libedit libicu libstdc++-static libuuid libxml2 tar tzdata
wget https://swift.org/builds/swift-5.4.2-release/amazonlinux2/swift-5.4.2-RELEASE/swift-5.4.2-RELEASE-amazonlinux2.tar.gz
tar -zxvf swift-5.4.2-RELEASE-amazonlinux2.tar.gz
sudo mkdir /usr/bin/swift
sudo cp -R ./swift-5.4.2-RELEASE-amazonlinux2/usr/* /usr/bin/swift
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

echo ""
echo "# some more ls aliases"
echo "alias ll='ls -alF'"
echo "alias la='ls -A'"
echo "alias l='ls -CF'"


# load GitHub CLI
# from: https://computingforgeeks.com/how-to-install-github-cli-on-linux-and-windows/
echo load GitHub CLI
VERSION=`curl  "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-`
echo $VERSION
wget https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz
tar xvf gh_${VERSION}_linux_amd64.tar.gz
sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/
gh --version


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
sudo rm -R ~/Redhat-dot-files
