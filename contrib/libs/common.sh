srcdir="$scriptdir/../src"

my_report()
{
	echo "------------------------------------------------------------"
	echo $@
}

my_fetch()
{
	local tarball="$1"
	local url="$2"

	# download
	if [ ! -f src/$tarball ]; then
		my_report "downloading $tarball"
		wget $url -O src/$tarball
	fi
}

my_fixdir()
{
	local top="$1"
	local name="$2"

	cd "$top"

	# If the archive included one or multiple prefix directories,
	# remove them

	# Just one dir in current dir?
	# (note: ignoring hidden files here, which helps at least with some
	# packages that have .hg_archival.txt etc. at the toplevel but all other
	# files in a subdir)
	if [ "`ls -1 | wc -l`" = "1" ] && [ -d "`ls -1`" ]; then
		# Recursion to handle nested dirs
		my_fixdir "`ls -1`" "$name"

		mv "$name" ..
		cd ..
		rm -rf "$top"
	else
		cd ..
		if [ "$top" != "$name" ]; then
			mv "$top" "$name"
		fi
	fi
}

my_extract()
{
	local name="$1"
	local tarball="$2"

	# unpack
	if [ ! -d $name ]; then
		my_report "extracting $tarball -> $name"

		# Extract archive inside tmpextract/
		mkdir tmpextract
		cd tmpextract

		if [ -n "`echo $tarball | grep '\.zip$'`" ]; then
			unzip -q ../src/$tarball
		else
			tar -xf ../src/$tarball
		fi

		cd ..

		my_fixdir tmpextract $name

		# assert that these files don't exist yet
		test ! -f $name/patch-done
		test ! -f $name/build-done
	fi
}
