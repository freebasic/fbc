#ifndef __FBCHKDOC_FBCHKDOC_BI__
#define __FBCHKDOC_FBCHKDOC_BI__

/'
	The hard-coded defaults are the option values used
	when:
		1) ini file not found, or
		2) ini file was found but option not present; and
		3) no option was given on the command line

	In otherwords, provide hard-coded defaults to work with 
	the FreeBASIC development tree, when no other options
	are specified in the ini file or on command line.
'/

namespace hardcoded

	'' configuration file
	const default_ini_file = "fbchkdoc.ini"

	const default_manual_dir = "../manual/"

	'' cache dirs
	const default_def_cache_dir = "../manual/cache/"
	const default_web_cache_dir = "../manual/cache.web/"
	const default_dev_cache_dir = "../manual/cache.dev/"

	'' url defaults
	const default_web_wiki_url = "https://www.freebasic.net/wiki/wikka.php"
	
	'' other common defaults
	const default_index_file = "PageIndex.txt"
	const default_recent_file = "RecentChanges.txt"
	const default_image_dir = "../manual/html/images/"
	const default_fb_dir = "../../"

end namespace

#endif
