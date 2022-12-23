'' sanitize whitespace in compiler source
''
'' Usage: check-whitespace [options] [files...]
''   --help               show help screen
''   -c, --check-only     check only, do not write
''   -f, --force-write    always write (ignored with -c, --check-only)
''   -v, --verbose        verbose output
''
'' Example:
''   check-whitespace src/compiler/*.bi src/compiler/*.bas

const CHAR_TAB = 9
const CHAR_SPACE = 32

const DEFAULT_TAB_SIZE = 4

type CODELINE
	original as string
	text as string
end type

sub initSource( source() as CODELINE, byref nlines as integer )
	redim source(1 to 1024) as CODELINE
	nlines = 0
end sub

sub addSourceLine( source() as CODELINE, byref nlines as integer, byref s as string )
	nlines += 1
	if( nlines > ubound(source) ) then
		redim preserve source( 1 to ubound(source)*2 )
	end if
	source(nlines).original = s
	source(nlines).text = s
end sub

function CountChanges( source() as CODELINE, byref nlines as integer ) as integer
	dim changes as integer = 0
	for i as integer = 1 to nlines
		if( source(i).original <> source(i).text ) then
			changes += 1
		endif
	next
	return changes
end function

function LoadFile( source() as CODELINE, byref nlines as integer, byref filename as const string ) as boolean
	dim s as string
	initSource( source(), nlines )
	if( open( filename for input as #1 ) = 0 ) then
		while not eof(1)
			line input #1, s
			addSourceLine( source(), nlines, s )
		wend
		close #1
		return true
	else
		print "Unable to read '" & filename & "'"
		return false
	end if
end function

function WriteFile( source() as const CODELINE, byval nlines as integer, byref filename as const string ) as boolean
	if( open( filename for output as #1 ) = 0 ) then
		for i as integer = 1 to nlines
			print #1, source(i).text
		next
		close #1
		return true
	else
		print "Unable to write '" & filename & "'"
		return false
	end if
end function

function RemoveTrailingWhitespace( byref s as const string ) as string
	'' this will clear whitespace only lines as well
	return rtrim( s, any chr( CHAR_TAB, CHAR_SPACE ) )
end function

type WHITESPACEINFO
	kind as integer  '' 32 = space, 9 = tab
	count as integer '' number of tabs or spaces
	start as integer '' first char index of the group in original string
end type

'' fix leading whitespace by counting up the groups of tabs or spaces
'' before the first non-whitespace character on the line
function FixMixedLeadingWhiteSpace _
	( _
		byref s as const string, _
		byval opt_tab_size as integer, _
		byval opt_old_tab_size as integer _
	) as string
	dim info(1 to 50) as WHITESPACEINFO
	dim index as integer = 0

	'' no string? then no change
	if( len(s) = 0 ) then
		return s
	end if

	for i as integer = 1 to len( s )
		select case mid( s, i , 1 )
		case chr(CHAR_SPACE)
			if( index = 0 orelse info(index).kind <> CHAR_SPACE ) then
				index += 1
				info(index).kind = CHAR_SPACE
				info(index).start = i
			end if
			info(index).count += 1
		case chr(CHAR_TAB)
			if( index = 0 orelse info(index).kind <> CHAR_TAB ) then
				index += 1
				info(index).kind = CHAR_TAB
				info(index).start = i
			end if
			info(index).count += 1
		case else
			info(index + 1).start = i
			exit for
		end select
	next

	select case index
	case 0
		'' ok, no leading whitespace
	case 1
		'' it's only spaces or only tabs, just process it
		'' we shouldn't have leading spaces only (unless it is a
		'' multi-line comment)
	case else
		'' it's mixed
		'' if the last group is spaces, don't convert it
		if(info(index).kind = CHAR_SPACE ) then
			index -= 1
		end if
	end select

	dim ws as string

	for i as integer = 1 to index
		select case info(i).kind
		case CHAR_TAB
			ws &= string( info(i).count, CHAR_TAB )
		case CHAR_SPACE
			ws &= string( (info(i).count) \ opt_old_tab_size, CHAR_TAB )
		end select
	next

	return ws & mid( s, info(index + 1).start )

end function

function FixInteriorTabs _
	( _
		byref s as const string, _
		byval opt_tab_size as integer _
	) as string
	dim ret as string
	dim chars as integer = 0

	dim i as integer = 1
	while( i <= len(s) )
		if( mid( s, i , 1 ) = chr(CHAR_TAB) ) then
			ret &= chr( CHAR_TAB )
		else
			exit while
		end if
		i += 1
	wend

	while( i <= len(s) )
		select case mid( s, i , 1 )
		case chr(CHAR_TAB)
			ret &= string( opt_tab_size - (chars mod opt_tab_size), CHAR_SPACE )
			chars = 0
		case else
			ret &= mid( s, i , 1 )
			chars += 1
			chars mod= opt_tab_size
		end select
		i += 1
	wend

	return ret

end function

sub CheckWhiteSpace _
	( _
		source() as CODELINE, _
		byval nlines as integer, _
		byval opt_tab_size as integer, _
		byval opt_old_tab_size as integer _
		)
	for i as integer = 1 to nlines
		dim s as string = source( i ).original
		s = RemoveTrailingWhiteSpace( s )
		s = FixMixedLeadingWhiteSpace( s, opt_tab_size, opt_old_tab_size )
		s = FixInteriorTabs( s, opt_tab_size )
		source( i ).text = s
	next
end sub

sub addFile( files() as string, byref nfiles as integer, byref f as const string )
	if( nfiles = ubound(files) ) then
		redim preserve files( 1 to ubound(files)*2 )
	end if
	nfiles += 1
	files( nfiles ) = f
end sub

'' ------------------------------------
'' MAIN
'' ------------------------------------

dim opt_help as boolean = false
dim opt_check_only as boolean = false
dim opt_force_write as boolean = false
dim opt_verbose as boolean = false
dim opt_tab_size as integer = DEFAULT_TAB_SIZE
dim opt_old_tab_size as integer = DEFAULT_TAB_SIZE

redim files(1 to 100) as string
dim nfiles as integer = 0

redim source(1 to 1024) as CODELINE
dim nlines as integer

dim i as integer = 1
while i < __FB_ARGC__

	select case command(i)
	case "--help"
		opt_help = true
	case "-c", "--check-only"
		opt_check_only = true
	case "-f", "--force-write"
		opt_force_write = true
	case "-v", "--verbose"
		opt_verbose = true
	case "-t", "--tab-size"
		i += 1
		opt_tab_size = valint( command(i) )
		if( opt_tab_size < 1 or opt_tab_size > 8 ) then
			print "invalid tab size " & opt_tab_size
			opt_tab_size = DEFAULT_TAB_SIZE
		end if
	case "--old-tab-size"
		i += 1
		opt_old_tab_size = valint( command(i) )
		if( opt_old_tab_size < 1 or opt_old_tab_size > 8 ) then
			print "invalid tab size " & opt_tab_size
			opt_old_tab_size = DEFAULT_TAB_SIZE
		end if
	case else
		addFile files(), nfiles, command(i)
	end select

	i += 1
wend

if( command(1) = "" ) then
	opt_help = true
end if

if( opt_help ) then
	print "Usage: check-whitespace [options] [files...]"
	print "options:"
	print "   --help               show help screen"
	print "   -c, --check-only     check only, do not write"
	print "   -f, --force-write    always write (ignored with -c, --check-only)"
	print "   -v, --verbose        verbose output"
	print "   -t N, --tab-size N   tab size (default " & DEFAULT_TAB_SIZE & ")"
	print "   --old-tab-size N     old tab size (default " & DEFAULT_TAB_SIZE & ")"
	print
	print "Example:"
	print "   check-whitespace src/compiler/*.bi src/compiler/*.bas"
	end
end if

if( nfiles = 0 ) then
	print "error: no files specified"
	end
end if

for i as integer = 1 to nfiles

	dim filename as string = files(i)

	if( LoadFile( source(), nlines, filename ) ) then

		CheckWhitespace( source(), nlines, opt_tab_size, opt_old_tab_size )
		dim n as integer = CountChanges( source(), nlines )

		if( (n > 0) orelse (opt_verbose = true) or (opt_force_write = true) ) then
			print filename & ": " & n
		end if

		if( opt_check_only = false ) then
			if( (n > 0) orelse (opt_force_write = true) ) then
				WriteFile( source(), nlines, filename )
			end if
		end if

	end if

next
