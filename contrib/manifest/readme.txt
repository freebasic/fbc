These are lists of files contained in the last FB release archives.
When making a new release they can be used to check for missing files and such,
by running something like this:

	find releasedir/ -type f | sed -e 's,^releasedir/,,g' > contrib/manifest/linux.lst
	git diff contrib/manifest/linux.lst
