#!/bin/bash
set -ex

# Install/upgrade gcc, otherwise installing gcc-multilib may fail
sudo apt-get -y --no-install-recommends install \
	gcc \
	g++ \
	libgl1-mesa-dev \
	libglu1-mesa-dev \
	libgpm-dev
if [ "$FBTRAVIS_TARGET_BITS" = "32" ]; then
	# Installing gcc-multilib separately from the 32bit libs,
	# because apparently it can fail otherwise.
	sudo apt-get -y --no-install-recommends install \
		gcc-multilib \
		g++-multilib
	sudo apt-get -y --no-install-recommends install \
		lib32ncurses5-dev \
		libffi-dev:i386 \
		libcunit1-dev:i386 \
		libx11-dev:i386 \
		libxext-dev:i386 \
		libxpm-dev:i386 \
		libxrender-dev:i386 \
		libxrandr-dev:i386 \
		libcurl4-openssl-dev:i386 \
		libmysqlclient-dev:i386 \
		libaspell-dev:i386 \
		libpcre3-dev:i386
else
	sudo apt-get -y --no-install-recommends install \
		libncurses-dev \
		libffi-dev \
		libcunit1-dev \
		libx11-dev \
		libxext-dev \
		libxpm-dev \
		libxrender-dev \
		libxrandr-dev \
		libcurl4-openssl-dev \
		libmysqlclient-dev \
		libaspell-dev \
		libpcre3-dev
fi

source "$(dirname "$0")/bootstrap-settings.sh"

wget -O $bootstrap_package.tar.xz \
  https://github.com/freebasic/fbc/releases/download/$bootstrap_version/$bootstrap_package.tar.xz
tar xf $bootstrap_package.tar.xz

cd $bootstrap_package
if [ "$FBTRAVIS_TARGET_BITS" = "32" ]; then
	echo "CC = gcc -m32" > config.mk
	echo "AS = as --32" >> config.mk
	echo "TARGET_ARCH = x86" >> config.mk
fi
make -j$(nproc) bootstrap
cd ..
