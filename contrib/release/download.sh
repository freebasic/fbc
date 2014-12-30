#!/bin/bash

filename="$1"
url="$2"

if [ -f "$filename" ]; then
	echo "cached      $filename"
else
	echo "downloading $filename"
	#if ! wget -O "$filename" "$url"; then
	if ! curl -L -o "$filename" "$url"; then
		echo "download failed"
		rm -f "$filename"
		exit 1
	fi
fi
