#!/bin/bash (This file should be sourced rather than executed.)
# Sourcing allows environment variables to be used outside the script, but other
# changes also persist. (If you change directory then remember to change back!)

if [ "$(basename "$0")" == "environment.sh" ]; then
  echo "$0 was executed but it should have been sourced."
  exit 1
fi

initial_dir="${PWD}"
set -e # exit on error
set -x # echo commands

# Install packages
brew update

brew install cmake \
curl \
libsamplerate \
ninja \
pkg-config \
qt5 \
quazip \
sdl2 \
xz \
zsh \
p7zip \

# Don't pollute the source tree
cd ..

# Artifact uploading
wget "https://s3.amazonaws.com/travis-ci-gmbh/artifacts/stable/build/darwin/amd64/artifacts"
chmod +x artifacts
export PATH=`pwd`:$PATH

# Qt is keg-only
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:"/usr/local/opt/qt/lib/cmake/Qt5/"

# Return shell to its initial state:
set +x
set +e
cd "${initial_dir}"