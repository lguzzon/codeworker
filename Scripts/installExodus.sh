#!/bin/bash

# Tips: all the quotes  --> "'`
# Tips: script path --> $(readlink -f "${0%/*}")

sudo apt-get -y -q install python-pip python-dev build-essential && \
  sudo pip install --upgrade pip && \
  sudo pip install --upgrade virtualenv && \
  pip install --user --upgrade exodus-bundler
# ~/.local/bin/exodus