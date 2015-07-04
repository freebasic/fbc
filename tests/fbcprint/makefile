FBC := fbc

test = echo "$(1) = `$(FBC) $(1)`" >> results.txt

all:
	rm -f results.txt

	# -print x
	$(call test,-print x -target win32)
	$(call test,-print x -target linux)
	$(call test,-print x 1.bas -target win32)
	$(call test,-print x lib1.a -target win32)
	$(call test,-print x 1.o -target win32)
	$(call test,-print x -m 1 -target win32)

	# -print target with FB target ids passed to -target
	$(call test,-print target -target cygwin-x86)
	$(call test,-print target -target cygwin-x86_64)
	$(call test,-print target -target darwin-x86)
	$(call test,-print target -target darwin-x86_64)
	$(call test,-print target -target dos)
	$(call test,-print target -target freebsd-x86)
	$(call test,-print target -target freebsd-x86_64)
	$(call test,-print target -target linux-aarch64)
	$(call test,-print target -target linux-arm)
	$(call test,-print target -target linux-x86)
	$(call test,-print target -target linux-x86_64)
	$(call test,-print target -target netbsd-x86)
	$(call test,-print target -target netbsd-x86_64)
	$(call test,-print target -target openbsd-x86)
	$(call test,-print target -target openbsd-x86_64)
	$(call test,-print target -target win32)
	$(call test,-print target -target win64)

	# -print target gcc triplets passed to -target
	$(call test,-print target -target i686-w64-mingw32)
	$(call test,-print target -target i386-pc-mingw32)
	$(call test,-print target -target i486-pc-mingw32)
	$(call test,-print target -target i586-pc-mingw32)
	$(call test,-print target -target i686-pc-mingw32)
	$(call test,-print target -target x86_64-w64-mingw32)
	$(call test,-print target -target i386-pc-linux-gnu)
	$(call test,-print target -target arm-linux-gnueabihf)
