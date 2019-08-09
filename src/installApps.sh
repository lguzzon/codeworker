#!/bin/bash

# Tips: all the quotes  --> "'`
# Tips: script path --> $(readlink -f "${0%/*}")

current_dir=$(pwd)
script_dir="$0"
# Need this for relative symlinks.
while [ -h "$script_dir" ] ; do
  ls=`ls -ld "$script_dir"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    script_dir="$link"
  else
    script_dir=`dirname "$script_dir"`"/$link"
  fi
done
script_dir=$(readlink -f "${script_dir%/*}")

#echo "current_dir [$current_dir]"
#echo "script_dir [$script_dir]"

function installIfNotExist() {
  local app=${1}
  local appPackage=${2}
  echo "Check if exist command [${app}]"
  if [ -z $(command -v ${app}) ]; then
    echo "Installing package [${appPackage}] for command [${app}]"
    sudo apt-get install --yes ${appPackage}
    if [ -z $(command -v ${app}) ]; then
      echo "Error can not find app [${app}]"
    else
      echo "Installed and exists app [${app}]"
    fi
  else
    echo "Exists app [${app}]"
  fi
}

# Install libcurl, libreadline, ...
sudo -s -- apt-get install --yes libcurl4-gnutls-dev
sudo -s -- apt-get install --yes libreadline-dev
sudo -s -- apt-get install --yes libncurses5-dev 
installIfNotExist "g++" "build-essential"
installIfNotExist "upx" "upx-ucl"
