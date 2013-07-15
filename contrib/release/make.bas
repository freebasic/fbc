''
'' 1 program to
''
'' - assuming we're in an FB tree containing an FB build and needed binaries
''   and libraries
'' - create file list of all files in the FB tree
'' - create various zips/tarballs for a certain target OS
'' - based on include/exclude patterns
'' - report unpackaged, missing or repeatedly packaged (duplicate) files
''

#define NULL 0
#define TRUE (-1)
#define FALSE 0

#include once "dir.bi"
#include once "string.bi"
#include once "datetime.bi"

dim shared as string target

private function strReplace _
	( _
		byref text as string, _
		byref a as string, _
		byref b as string _
	) as string

	dim as string keep, result
	dim as integer alen = any, blen = any, i = any

	result = text

	alen = len( a )
	blen = len( b )

	i = 0
	do
		'' Does result contain an occurence of a?
		i = instr( i + 1, result, a )
		if( i = 0 ) then
			exit do
		end if

		'' Cut out a and insert b in its place
		'' result  =  front  +  b  +  back
		keep = right( result, len( result ) - ((i - 1) + alen) )
		result = left( result, i - 1 )
		result += b
		result += keep

		i += blen - 1
	loop

	function = result
end function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace files
	type ENTRY
		filename		as string
		pack			as integer
	end type

	dim shared as ENTRY list()
	dim shared as integer count, room
end namespace

private sub hAddFile( byref filename as string )
	if( files.count >= files.room ) then
		files.room += 1 shl 10
		redim preserve files.list(0 to files.room-1)
	end if

	files.list(files.count).filename = strReplace( filename, "\", "/" )
	files.list(files.count).pack = -1
	files.count += 1
end sub

private function pathAddDiv( byref path as string ) as string
	dim as string s
	dim as integer length = any

	s = path
	length = len( s )

	if( length > 0 ) then
#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
		select case( s[length-1] )
		case asc( "\" ), asc( "/" )

		case else
			s += "\"
		end select
#else
		if( s[length-1] <> asc( "/" ) ) then
			s += "/"
		end if
#endif
	end if

	function = s
end function

type DIRNODE
	next		as DIRNODE ptr
	path		as string
end type

type DIRQUEUE
	head		as DIRNODE ptr
	tail		as DIRNODE ptr
end type

dim shared as DIRQUEUE dirs

private sub dirsAppend( byref path as string )
	dim as DIRNODE ptr node = any

	node = callocate( sizeof( DIRNODE ) )
	node->path = pathAddDiv( path )

	if( dirs.tail ) then
		dirs.tail->next = node
	end if
	dirs.tail = node
	if( dirs.head = NULL ) then
		dirs.head = node
	end if
end sub

private sub dirsDropHead( )
	dim as DIRNODE ptr node = any
	if( dirs.head ) then
		node = dirs.head
		dirs.head = node->next
		if( dirs.head = NULL ) then
			dirs.tail = NULL
		end if
		node->path = ""
		deallocate( node )
	end if
end sub

private sub hScanParent( byref parent as string )
	dim as string found

	'' Scan for files
	found = dir( parent + "*", fbNormal )
	while( len( found ) > 0 )
		'' Add the file name to the result list
		hAddFile( parent + found )

		found = dir( )
	wend

	'' Scan for subdirectories
	found = dir( parent + "*", fbDirectory or fbReadOnly )
	while( len( found ) > 0 )
		select case( found )
		case ".", ".."
			'' Ignore these special subdirectories

		case else
			'' Remember the subdirectory for further scanning
			dirsAppend( parent + found )
		end select

		found = dir( )
	wend
end sub

private sub hScanDirectory( byref rootdir as string )
	dirsAppend( rootdir )

	'' Work off the queue -- each subdir scan can append new subdirs
	while( dirs.head )
		hScanParent( dirs.head->path )
		dirsDropHead( )
	wend
end sub

private sub hRemoveRootDirPrefix( byref rootdir as string )
	for i as integer = 0 to files.count-1
		dim as string ptr p = @files.list(i).filename
		assert( left( *p, len( rootdir ) ) = rootdir )
		'' -1 to strip the '/' path divider too
		*p = right( *p, len( *p ) - len( rootdir ) - 1 )
	next
end sub

private function hPartition _
	( _
		byval l as integer, _
		byval m as integer, _
		byval r as integer _
	) as integer

	dim as string pivot = files.list(m).filename
	dim as integer store = l

	swap files.list(m), files.list(r)

	for i as integer = l to r - 1
		if( lcase( files.list(i).filename ) <= lcase( pivot ) ) then
			swap files.list(i), files.list(store)
			store += 1
		end if
	next

	swap files.list(store), files.list(r)

	function = store
end function

'' In-place quicksort
private sub hQuickSort( byval l as integer, byval r as integer )
	if( l < r ) then
		dim as integer m = l + ((r - l) \ 2)
		m = hPartition( l, m, r )
		hQuickSort( l, m - 1 )
		hQuickSort( m + 1, r )
	end if
end sub

private sub hSortFiles( )
	hQuickSort( 0, files.count - 1 )
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace packs
	type ENTRY
		id		as string  '' "win32" or "win32-x-dos" etc.
		version		as string
		manifest	as string
	end type

	dim shared as ENTRY list()
	dim shared as integer count, room
end namespace

namespace parser
	dim shared as integer linenum
end namespace

private function hAddOrLookupPack( byref pack as string ) as integer
	'' Package already exists?
	for i as integer = 0 to packs.count-1
		if( packs.list(i).id = pack ) then
			return i
		end if
	next

	'' Add new
	if( packs.count >= packs.room ) then
		packs.room += 1 shl 10
		redim preserve packs.list(0 to packs.room-1)
	end if

	packs.list(packs.count).id = pack
	function = packs.count
	packs.count += 1
end function

private function hTrim( byref s as string ) as string
	function = trim( s, any !" \t" )
end function

private sub hSplit _
	( _
		byref origs as string, _
		byref delimiter as string, _
		byref l as string, _
		byref r as string _
	)
	dim as string s = origs
	dim as integer leftlen = instr( s, delimiter ) - 1
	if( leftlen > 0 ) then
		l = hTrim( left( s, leftlen ) )
		r = hTrim( right( s, len( s ) - leftlen - len( delimiter ) ) )
	else
		l = hTrim( s )
		r = ""
	end if
end sub

private sub hParserOops( byref message as string )
	print "(" & parser.linenum & "): " & message
end sub

private function hIsMatch _
	( _
		byref origpattern as string, _
		byref file as string _
	) as integer

	dim as string pattern = origpattern
	dim as integer wildcard = instr( pattern, "*" )
	if( instr( wildcard + 1, pattern, "*" ) > 0 ) then
		hParserOops( "pattern with more than one wildcard" )
		end 1
	end if

	if( wildcard > 0 ) then
		dim as integer lhs = wildcard - 1
		dim as integer rhs = len( pattern ) - wildcard
		function = (( left( file, lhs ) =  left( pattern, lhs )) and _
		            (right( file, rhs ) = right( pattern, rhs )))
	else
		function = (pattern = file)
	end if
end function

private sub hApplyPattern _
	( _
		byval is_add as integer, _
		byref pattern as string, _
		byval pack as integer _
	)

	dim as integer found_match = FALSE

	for i as integer = 0 to files.count-1
		if( hIsMatch( pattern, files.list(i).filename ) ) then
			found_match = TRUE

			if( files.list(i).pack >= 0 ) then
				if( is_add ) then
					hParserOops( "added twice: " & files.list(i).filename )
				else
					if( pack = 0 ) then
						'' Remove from main package
						files.list(i).pack = -1
					else
						'' Move from main package to different package
						files.list(i).pack = pack
					end if
				end if
			else
				if( is_add ) then
					'' Add matching files to package
					files.list(i).pack = pack
				else
					hParserOops( "remove without prior add: " & files.list(i).filename )
				end if
			end if
		end if
	next

	if( found_match = FALSE ) then
		hParserOops( "not found: " & pattern )
	end if

end sub

private sub hLoadPatterns( byref patternfile as string )
	dim as string ln, comment, id, op, pattern, packname, packversion

	dim as integer f = freefile( )
	if( open( patternfile, for input, as #f ) <> 0 ) then
		print "could not open input file: '" + patternfile + "'"
		end 1
	end if

	'' Read in the patterns, but skip all patterns in [sections] for
	'' different release names, and ignore commentary/whitespace
	dim as integer skip = FALSE, pack = -1
	parser.linenum = 0
	while( eof( f ) = FALSE )
		'' Read next line
		parser.linenum += 1
		line input #f, ln
		ln = hTrim( ln )

		if( len( ln ) = 0 ) then
			continue while
		end if

		'' Strip comments
		hSplit( ln, ";", ln, comment )
		if( len( ln ) = 0 ) then
			continue while
		end if

		'' ('[' id ']')?
		if( left( ln, 1 ) = "[" ) then
			id = right( ln, len( ln ) - 1 )
			if( right( id, 1 ) = "]" ) then
				id = left( id, len( id ) - 1 )
			end if

			'' Skip everything except the target section
			skip = (id <> target)
			continue while
		end if

		'' Don't process section content while skipping
		if( skip ) then
			continue while
		end if

		'' '+'|'-' pattern ['>' packagename ['=' packageversion]]
		op = left( ln, 1 )
		ln = hTrim( right( ln, len( ln ) - 1 ) )
		hSplit( ln, ">", pattern, packname )

		hSplit( packname, "=", packname, packversion )

		if( len( packname ) > 0 ) then
			packname = target + "-" + packname
		else
			packname = target
		end if

		select case( op )
		case "+", "-"
			pack = hAddOrLookupPack( packname )
			if( len( packversion ) > 0 ) then
				if( (len( (packs.list(pack).version) ) > 0) and _
				    (packs.list(pack).version <> packversion) ) then
					hParserOops( "version '" & packversion & "' given for package '" & packname & "', but it already has version '" & packs.list(pack).version & "' from before" )
				else
					packs.list(pack).version = packversion
				end if
			end if
			hApplyPattern( (op = "+"), pattern, pack )
		case else
			hParserOops( "invalid command" )
		end select
	wend

	close #f
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

private function hCountPackFiles( byval pack as integer ) as integer
	dim as integer count = 0

	for i as integer = 0 to files.count-1
		if( files.list(i).pack = pack ) then
			count += 1
		end if
	next

	function = count
end function

private sub hWriteManifest( byval pack as integer, byref manifest as string )
	dim as integer f = freefile( )
	if( open( manifest, for output, as #f ) <> 0 ) then
		print "could not open output file: '" + manifest + "'"
		end 1
	end if

	for i as integer = 0 to files.count-1
		if( files.list(i).pack = pack ) then
			print #f, files.list(i).filename
		end if
	next

	close #f
end sub

private function hShell( byref ln as string ) as integer
	print "$ " + ln
	dim as integer result = shell( ln )

	if( result = 0 ) then
		function = TRUE
	elseif( result = -1 ) then
		print "command not found: '" + ln + "'"
	else
		print "'" + ln + "' terminated with exit code " + str( result )
	end if
end function

private sub hShowUsage( )
	print "usage: contrib/release/make [<id>] [manifest]"
	print "<id> = dos|linux|win32|etc., from pattern.txt"
	print "If ""manifest"" is given, generate manifest only"
	end 1
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	var manifest_only = FALSE

	select case( __FB_ARGC__ )
	case 1
		#if defined( __FB_WIN32__ )
			target = "win32"
		#elseif defined( __FB_DOS__ )
			target = "dos"
		#else
			target = "linux"
		#endif
		print "using default target '" & target & "'"

	case 2
		target = *__FB_ARGV__[1]

	case 3
		target = *__FB_ARGV__[1]
		if( *__FB_ARGV__[2] <> "manifest" ) then
			hShowUsage( )
		end if
		manifest_only = TRUE

	case else
		hShowUsage( )
	end select

	dim as string rootdir = strReplace( pathAddDiv( exepath( ) ) + "../..", "\", "/" )
	chdir( rootdir )

	'' For non-standalone releases, copy the includes into the proper directory
	select case( target )
	case "linux", "mingw32"
		mkdir( "include" )
		mkdir( "include/freebasic" )
		hShell( "cp -r inc/* include/freebasic" )
	case "djgpp"
		mkdir( "include" )
		mkdir( "include/freebas" )
		hShell( "cp -r inc/* include/freebas" )
	end select

	'' Collect file list
	print "collecting file list for '" + rootdir + "'... ";
	hScanDirectory( rootdir )
	hRemoveRootDirPrefix( rootdir )
	hSortFiles( )
	print "ok"

	'' Add main package
	hAddOrLookupPack( target )

	'' Load and apply patterns
	dim as string patternfile = "contrib/release/pattern.txt"
	print "loading patterns from '" & patternfile & "'..."
	hLoadPatterns( patternfile )
	print "done: " & files.count & " files, " & packs.count & " packs"

	'' Create manifests and show some stats
	for i as integer = 0 to packs.count-1
		packs.list(i).manifest = "contrib/release/manifest/" + packs.list(i).id + ".lst"
		print hCountPackFiles( i ) & " files = " & packs.list(i).manifest
		hWriteManifest( i, packs.list(i).manifest )
	next
	print hCountPackFiles( -1 ) & " files = unpackaged"

	if( manifest_only = FALSE ) then
		'' Create zip/tar packages
		for i as integer = 0 to packs.count-1
			dim as string title
			if( i = 0 ) then
				dim as string fbversion = format( now( ), "yyyy-mm-dd" )
				title = "FreeBASIC-" & fbversion & "-" & packs.list(i).id
			else
				title = "FB-" & packs.list(i).id
				if( len( (packs.list(i).version) ) > 0 ) then
					title &= "-" & packs.list(i).version
				end if
			end if

			dim as string manifest = packs.list(i).manifest

			''
			'' Main package:
			'' - is given a toplevel dir to prevent extracted files
			''   from spilling all over the current dir
			''   (tar bombs, especially annoying for "tar xf" users)
			'' - is made available in two formats: old school (.zip,
			''   .tar.gz) and new fancy (.tar.xz, .7z)
			''
			'' Add-on packages:
			'' - no toplevel dir, so they can be extracted right
			''   into the main FB dir
			'' - only old school format, to avoid making them even
			''   more complicated, since there are so many add-ons
			''

			if( i = 0 ) then
				hShell( "tar -cf temp.tar -T " + manifest )
				mkdir( title )
				hShell( "tar xf temp.tar -C " + title )
				kill( "temp.tar" )

				select case( target )
				case "dos", "dos-mini", "djgpp"
					'' Using 7z to create a .zip with small word size/fast bytes setting,
					'' which should reduce the memory needed to extract (?),
					'' which should be nice for DOS systems...
					hShell( "7z a -tzip -mfb=8 " + title + ".zip " + title + " > nul" )
				case "win32", "win32-mini", "mingw32"
					hShell( "zip -q " + title + ".zip " + title )
					hShell( "7z a " + title + ".7z " + title + " > nul" )
				case else
					hShell( "tar -czf " + title + ".tar.gz " + title )
					hShell( "tar -cJf " + title + ".tar.xz " + title )
				end select

				hShell( "rm -rf " + title )
			else
				select case( target )
				case "dos", "dos-mini", "djgpp"
					hShell( "7z a -tzip -mfb=8 " + title + ".zip -i@" + manifest + " > nul" )
				case "win32", "win32-mini", "mingw32"
					hShell( "zip -q " + title + ".zip -@ < " + manifest )
				case else
					hShell( "tar -czf " + title + ".tar.gz -T " + manifest )
				end select
			end if
		next
	end if

	'' Remove the non-standalone include directory again (if any)
	select case( target )
	case "linux", "mingw32", "djgpp"
		hShell( "rm -rf include" )
	end select
