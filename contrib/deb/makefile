#!/usr/bin/make -f

FB_VERSION := 0.22.0
DEB_VERSION := $(FB_VERSION)-2

FOR_UBUNTU := no
ifeq ($(FOR_UBUNTU),yes)
    DEB_VERSION := $(DEB_VERSION)ubuntu1
endif

ARCH := i386

FB_TITLE := FreeBASIC-$(FB_VERSION)-linux
FB_TARBALL := $(FB_TITLE).tar.gz

ifeq ($(ARCH),i386)
    depends := \
        libc6, libncurses5, binutils, gcc, g++, \
        libc6-dev, libncurses5-dev, \
        libx11-dev, libxext-dev, libxpm-dev, libxrandr-dev, libxrender-dev
else ifeq ($(ARCH),amd64)
    ifeq ($(FOR_UBUNTU),yes)
        depends := \
            ia32-libs, gcc-multilib, g++-multilib, \
            lib32ncurses5-dev, getlibs
    else
        depends := \
            ia32-libs-dev, gcc-multilib, g++-multilib, \
            lib32ncurses5-dev
	endif
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

	# install.sh currently installs the man page into prefix/man/,
	# but it should be in prefix/share/man/ (lintian...).
	mkdir -p -m 0755 package/usr/share/man/man1/
	cp package/usr/man/man1/fbc.1.gz package/usr/share/man/man1/
	rm -r package/usr/man/

	# Repackage the fbc.1.gz with best compression (lintian...).
	gzip -d -c package/usr/share/man/man1/fbc.1.gz > package/usr/share/man/man1/fbc.1
	rm package/usr/share/man/man1/fbc.1.gz
	gzip -9 -c package/usr/share/man/man1/fbc.1    > package/usr/share/man/man1/fbc.1.gz
	rm package/usr/share/man/man1/fbc.1

	# Copy in the copyright file
	mkdir -p package/usr/share/doc/freebasic/
	cp copyright package/usr/share/doc/freebasic/copyright

	# And changelogs
	gzip -9 -c $(FB_TITLE)/changelog.txt > package/usr/share/doc/freebasic/changelog.gz
ifeq ($(FOR_UBUNTU),yes)
	gzip -9 -c changelog.Debian          > package/usr/share/doc/freebasic/changelog.Debian.gz
else
	gzip -9 -c changelog.Ubuntu          > package/usr/share/doc/freebasic/changelog.Debian.gz
endif

	# Generate the md5sums
	cd package && find usr/ -type f | xargs md5sum > DEBIAN/md5sums

	# Copy in the DEBIAN/control file, and fill in the placeholder strings in
	# it. 'du' is used to find out the installed size.
	installedsize=`du -s package/usr/ | sed "s,	package/usr/,,g"` && \
	sed -e "s/<version>/$(DEB_VERSION)/g"            \
		-e "s/<arch>/$(ARCH)/g"                  \
		-e "s/<depends>/$(depends)/g"            \
		-e "s/<suggests>/$(suggests)/g"          \
		-e "s/<installedsize>/$$installedsize/g" \
		control > package/DEBIAN/control

ifeq ($(ARCH),amd64)
ifeq ($(FOR_UBUNTU),yes)
	cp postinst-ubuntu package/DEBIAN/postinst
else
	cp postinst-debian package/DEBIAN/postinst
endif
	chmod +x package/DEBIAN/postinst
endif

    # Create the .deb package
	fakeroot dpkg-deb --build package $@

    # Clean up
	rm -r $(FB_TITLE) package

.PHONY: clean
clean:
	-rm -f $(PACKAGE)
