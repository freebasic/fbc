#!/bin/sh

# The package will be created based on the contents of this directory
mkdir package

# Copy all files listed in the manifest into a temp directory
# (the manifest filters out some non-linux specific files)
cd ../../..
tar -c -T manifest/linux.lst -f temp.tar
cd src/contrib/deb
mkdir temp
cd temp
mv ../../../../temp.tar .
tar -xf temp.tar
rm temp.tar
cd ..

# Create package/DEBIAN/control file and package/usr directory
cd package
mkdir DEBIAN
cp ../control DEBIAN
mkdir usr
cd ..

# "install" FreeBASIC from the temp directory into the package directory
# This will create the required directory structures for the package content.
cd temp
./install.sh -i ../package/usr
cd ..

# Run du to find out the size, then fill in the placeholder in the control file.
cd package
installedsize=`du -s usr | sed "s/usr//"`
cd DEBIAN
sed "s/<installedsize>/$installedsize/" control > control-new
mv control-new control
cd ..
cd ..

# Create the .deb from the 'package' directory, with our first command line
# argument as output file name.
fakeroot dpkg-deb --build package "$1"

# Clean up
rm -r temp package

