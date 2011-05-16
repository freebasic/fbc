#!/usr/bin/make -f
# Usage: 'make' or 'make ARCH=i386' to build freebasic_*_i386.deb,
# 'make ARCH=amd64' to build freebasic_*_amd64.deb.

FB_VERSION := 0.23.0
DEB_VERSION := $(FB_VERSION)-1
FB_TITLE := FreeBASIC-$(FB_VERSION)-linux
FB_TARBALL := $(FB_TITLE).tar.gz
ARCH := i386

ifeq ($(ARCH),i386)
    depends := \
        libc6, libncurses5, binutils, gcc, g++, \
        libc6-dev, libncurses5-dev, \
        libx11-dev, libxext-dev, libxpm-dev, libxrandr-dev, libxrender-dev
else ifeq ($(ARCH),amd64)
    depends := \
        ia32-libs, ia32-libs-dev, gcc-multilib, g++-multilib, \
        lib32ncurses5-dev, getlibs
else
    $(error Unexpected ARCH)
endif

suggests := gdb, geany

PACKAGE := freebasic_$(DEB_VERSION)_$(ARCH).deb

$(PACKAGE): $(FB_TARBALL) control
    # Create directory structure for the package build
	mkdir -p package/DEBIAN/ package/usr/

    # Unpack the FB files into '.', resulting in a FreeBASIC-x.xx.x-linux directory
	tar -xzf $(FB_TARBALL)

    # Install that FB into the package build directory
	cd $(FB_TITLE) && ./install.sh -i ../package/usr/

    # Generate the md5sums
	cd package && find usr/ -type f | xargs md5sum > DEBIAN/md5sums

    # Copy in the DEBIAN/control file, and fill in the placeholder strings in
    # it. 'du' is used to find out the installed size.
	installedsize=`du -s package/usr/ | sed "s,	package/usr/,,g"` && \
    sed -e "s/<version>/$(DEB_VERSION)/g"         \
        -e "s/<arch>/$(ARCH)/g"                  \
        -e "s/<depends>/$(depends)/g"            \
        -e "s/<suggests>/$(suggests)/g"          \
        -e "s/<installedsize>/$$installedsize/g" \
        control > package/DEBIAN/control

ifeq ($(ARCH),amd64)
	cp postinst package/DEBIAN/
	chmod +x package/DEBIAN/postinst
endif

    # Create the .deb package
	fakeroot dpkg-deb --build package $@

    # Clean up
	rm -r $(FB_TITLE) package

.PHONY: clean
clean:
	-rm -f $(PACKAGE)
