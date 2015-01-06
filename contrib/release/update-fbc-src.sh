#!/bin/bash

echo "updating input/fbc repo"

cd input

if [ ! -d fbc ]; then
	git clone https://github.com/freebasic/fbc.git
fi
cd fbc

git fetch
git fetch --tags
git remote prune origin

git reset --hard origin/master
