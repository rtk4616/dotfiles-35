#!/usr/bin/env bash
set -eu

readonly TMUX_BUILD_DIR=$(mktemp -d)
readonly TMUX_VERSION="2.3"

# Ubuntu16
if [ -x "/usr/bin/apt-get" ]; then
  sudo apt-get install libevent-dev libncurses5-dev
fi
# CentOS7
if [ -x "/usr/bin/yum" ]; then
  sudo yum -y install libevent-devel ncurses-devel
fi

curl -sL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz | tar zxC ${TMUX_BUILD_DIR}
cd "${TMUX_BUILD_DIR}/tmux-${TMUX_VERSION}"
./configure --prefix=/usr/local && make -j$(nproc)
sudo make install

trap "
rm -rf ${TMUX_BUILD_DIR}
" 0
