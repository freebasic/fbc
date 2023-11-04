'' sanitize whitespace in compiler source
''
'' Usage: check-whitespace [options] [files...]
''   --help               show help screen
''   -c, --check-only     check only, do not write
''   -f, --force-write    always write (ignored with -c, --check-only)
''   -v, --verbose        verbose output
''   -t N, --tab-size N   tab size
''   --old-tab-size N     old tab size
''   -i filename          single input file
''   -o filename          single output file (requires -i)
''   -s, --space-only     spaces only, convert tabs to spaces
''   -k, --keep-spaces    keep spaces when line begins with spaces
''
'' Example:
''   check-whitespace src/compiler/*.bi src/compiler/*.bas
''
'' default behaviour:
'' - remove trailing whtespace
'' - convert interior tabs to spaces (using --tab-size)
'' - normalize leading whitespace
''   1) if tabs only, keep as-is
''   2) if spaces only convert to tabs using --tab-size
''   3) tabs+spaces, keep as-is
''   4) spaces+tabs, convert to tabs
''   5) more than 3 groups of leading spaces and tabs, convert to tabs
''
'' '-s' behaviour
'' same as default behaviour except for leading whitespace
''   1) convert tabs and spaces to spaces using --tab-size
''   2) resize leading whitespace using --new-tab-size


const CHAR_TAB = 9
const CHAR_SPACE = 32

const DEFAULT_TAB_SIZE = 4

type OPTIONS
	help as boolean = false
	check_only as boolean = false
	force_write as boolean = false
	verbose as boolean = false
	tab_size as integer = 0
	new_tab_size as integer = 0
	have_input as boolean = false
	input_file as string
	have_output as boolean = false
	output_file as string
	spaces_only as boolean = false
	keep_spaces as boolean = false
end type

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
		redim preserve source( 1 to iif( ubound(source)>0, ubound(source)*2, 1 ))
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
		print "error: Unable to read '" & filename & "'"
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
		print "error: Unable to write '" & filename & "'"
		return false
	end if
end function

function RemoveTrailingWhitespace( byref s as const string ) as string
	'' this will clear whitespace only lines as well
	return rtrim( s, any chr( CHAR_TAB, CHAR_SPACE ) )
end function

type WHITESPACEINFO
	kind as integer  '' 32 = space, 9 = tab, 0 = anything else
	count as integer '' number of tabs or spaces
	start as integer '' first char index of the group in original string
end type

sub addWhiteSpaceChar _
	( _
		info() as WHITESPACEINFO, byref groups as integer, _
		byval kind as integer, byval start as integer _
	)

	'' groups
	''   0             empty line
	''   1 to N-1      whitespace groups (tabs or spaces)
	''   N             start of text

	if( (kind <> CHAR_SPACE) and (kind <> CHAR_TAB) ) then
		kind = 0
	end if

	if( groups = 0 orelse info(groups).kind <> kind ) then
		groups += 1
		if( groups > ubound(info) ) then
			redim preserve info(1 to iif( ubound(info) > 0, ubound(info)*2, 1 ))
		end if
		info(groups).kind = kind
		info(groups).count = 0
		info(groups).start = start
	end if

	info(groups).count += 1

end sub

function convertToTabs _
	( _
		info() as WHITESPACEINFO, byval groups as integer, _
		byref opts as const OPTIONS _
	) as string
	dim ws as string

	'' convert to tabs
	for i as integer = 1 to groups
		select case info(i).kind
		case CHAR_TAB
			ws &= string( info(i).count, CHAR_TAB )
		case CHAR_SPACE
			ws &= string( (info(i).count) \ opts.tab_size, CHAR_TAB )
		end select
	next
	return ws
end function

function convertToSpaces _
	( _
		info() as WHITESPACEINFO, byval groups as integer, _
		byref opts as const OPTIONS _
	) as string
	dim ws as string
	dim nspaces as integer
	dim rspaces as integer
	'' convert to spaces - resizing tabs as we go
	for i as integer = 1 to groups
		select case info(i).kind
		case CHAR_TAB
			nspaces = (nspaces \ opts.tab_size) * opts.tab_size
			nspaces += info(i).count * opts.tab_size  
		case CHAR_SPACE
			nspaces += info(i).count 
		end select
	next
	rspaces = nspaces mod opts.tab_size 
	return string( (nspaces \ opts.tab_size) * opts.tab_size + rspaces, CHAR_SPACE ) 
end function


'' fix leading whitespace by counting up the groups of tabs or spaces
'' before the first non-whitespace character on the line
function FixMixedLeadingWhiteSpace _
	( _
		byref s as const string, _
		byref opts as const OPTIONS _
	) as string

	redim info(1 to 10) as WHITESPACEINFO
	dim groups as integer = 0
	dim ws as string

	'' no string? then no change
	if( len(s) = 0 ) then
		return s
	end if

	for i as integer = 1 to len( s )
		select case mid( s, i , 1 )
		case chr(CHAR_SPACE)
			addWhiteSpaceChar( info(), groups, CHAR_SPACE, i )
		case chr(CHAR_TAB)
			addWhiteSpaceChar( info(), groups, CHAR_TAB, i )
		case else
			addWhiteSpaceChar( info(), groups, 0, i )
			exit for
		end select
	next

	'' no groups? then it was an empty line
	if( groups = 0 ) then 
		return ""
	end if

	'' no text following whitespace? remove the empty line
	'' RemoveTrailingWhitespace() should have removed empty lines, but
	'' in case that was disabled, remove empty line here.
	if( info(groups).kind <> 0 ) then
		return ""
	end if

	'' no leading whitespace? return as-is
	if( groups = 1 ) then
		return s
	end if

	'' if groups = 2 then it's only spaces or only tabs
	'' (i.e. one kind of whitespace)
	'' 
	'' default: always convert to tabs
	'' '-s'   : convert all to spaces (and resize based on [new-]tab-size)
	'' '-k'   : keep tabs or spaces as-is
	''
	'' Note: In fbc sources we shouldn't have leading spaces
	''       only, unless it is a multi-line comment
	''
	'' no adjustments needed, see below.

	'' more than 2 groups? it's mixed leading whitespace
	if( groups > 2 ) then
		'' default: convert to tabs, (except the last group of spaces)
		'' '-s'   : convert all to spaces (and resize based on [new-]tab-size)
		'' '-k'   : convert to tabs or spaces depending on first group

		if( (opts.spaces_only = false) andalso (opts.keep_spaces = false) ) then
			if(info(groups-1).kind = CHAR_SPACE ) then
				'' do not include last group and treat spaces as start of 'text'
				groups -= 1
			end if
		end if

	end if

	if( opts.spaces_only ) then
		ws = convertToSpaces( info(), groups-1, opts )
	elseif( opts.keep_spaces ) then
		select case info(1).kind
		case CHAR_TAB
			ws = convertToTabs( info(), groups-1, opts )
		case else
			ws = convertToSpaces( info(), groups-1, opts )
		end select
	else
		ws = convertToTabs( info(), groups-1, opts )
	end if

	'' last group is text - return all of it
	return ws & mid( s, info(groups).start )

end function

function FixInteriorTabs _
	( _
		byref s as const string, _
		opts as const OPTIONS _
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
			ret &= string( opts.tab_size - (chars mod opts.tab_size), CHAR_SPACE )
			chars = 0
		case else
			ret &= mid( s, i , 1 )
			chars += 1
			chars mod= opts.tab_size
		end select
		i += 1
	wend

	return ret

end function

sub CheckWhiteSpace _
	( _
		source() as CODELINE, _
		byval nlines as integer, _
		byref opts as const OPTIONS _
	)
	for i as integer = 1 to nlines
		dim s as string = source( i ).original
		s = RemoveTrailingWhiteSpace( s )
		s = FixMixedLeadingWhiteSpace( s, opts )
		s = FixInteriorTabs( s, opts )
		source( i ).text = s
	next
end sub

sub addFile( files() as string, byref nfiles as integer, byref f as const string )
	if( nfiles = ubound(files) ) then
		redim preserve files( 1 to iif( ubound(files) > 0, ubound(files)*2, 1 ))
	end if
	nfiles += 1
	files( nfiles ) = f
end sub

sub processFile _
	( _
		byref src_filename as string, _
		byref dst_filename as string, _
		byref opts as const OPTIONS _
	)

	redim source(1 to 1024) as CODELINE
	dim nlines as integer

	if( LoadFile( source(), nlines, src_filename ) ) then

		CheckWhitespace( source(), nlines, opts )
		dim n as integer = CountChanges( source(), nlines )

		if( (n > 0) orelse (opts.verbose = true) or (opts.force_write = true) ) then
			print src_filename & ": " & n
		end if

		if( opts.check_only = false ) then
			if( (cbool(n > 0) = true) orelse (opts.force_write = true) orelse (opts.have_output = true) ) then
				WriteFile( source(), nlines, dst_filename )
			end if
		end if

	end if

end sub

'' ------------------------------------
'' MAIN
'' ------------------------------------

dim opts as OPTIONS

redim files(1 to 100) as string
dim nfiles as integer = 0

dim i as integer = 1
while i < __FB_ARGC__

	select case command(i)
	case "--help"
		opts.help = true
	case "-c", "--check-only"
		opts.check_only = true
	case "-f", "--force-write"
		opts.force_write = true
	case "-v", "--verbose"
		opts.verbose = true
	case "-t", "--tab-size"
		i += 1
		opts.tab_size = valint( command(i) )
		if( opts.tab_size < 1 or opts.tab_size > 8 ) then
			print "error: invalid tab size " & opts.tab_size
			end 1
		end if
	case "--new-tab-size"
		i += 1
		opts.new_tab_size = valint( command(i) )
		if( opts.new_tab_size < 1 or opts.new_tab_size > 8 ) then
			print "error: invalid new tab size " & opts.new_tab_size
			end 1
		end if
	case "-i"
		i += 1
		if command(i) > "" then
			opts.input_file = command(i)
			opts.have_input = true
		else
			print "error: expected filename after '-i'"
		end if
	case "-o"
		i += 1
		if command(i) > "" then
			opts.output_file = command(i)
			opts.have_output = true
		else
			print "error: expected filename after '-o'"
		end if
	case "-s", "--space-only"
		opts.spaces_only = true
	case "-k", "--keep-spaces"
		opts.keep_spaces = true
	case else
		if opts.have_input then
			print "error: unexpected multiple input files used with -i option"
		else
			addFile files(), nfiles, command(i)
		end if
	end select

	i += 1
wend

if( opts.tab_size = 0 ) then
	opts.tab_size = DEFAULT_TAB_SIZE
end if

if( opts.new_tab_size = 0 ) then
	opts.new_tab_size = opts.tab_size
end if

if( opts.have_output = true and opts.have_input = false ) then
	print "error: output file was given without also giving an input file"
	end 1
end if

if( opts.have_input = true and opts.have_output = false ) then
	opts.output_file = opts.input_file
end if

if( command(1) = "" ) then
	opts.help = true
end if

if( opts.help ) then
	print "Usage: check-whitespace [options] [files...]"
	print "options:"
	print "   --help               show help screen"
	print "   -c, --check-only     check only, do not write"
	print "   -f, --force-write    always write (ignored with -c, --check-only)"
	print "   -v, --verbose        verbose output"
	print "   -t N, --tab-size N   tab size (default " & DEFAULT_TAB_SIZE & ")"
	print "   --new-tab-size N     new tab size (default " & DEFAULT_TAB_SIZE & ")"
	print "   -i filename          single input file"
	print "   -o filename          single output file (requires -i)"
	print "   -s, --space-only     spaces only, convert tabs to spaces"
	print "   -k, --keep-spaces    keep spaces when line begins with spaces"
	print
	print "Example:"
	print "   check-whitespace src/compiler/*.bi src/compiler/*.bas"
	end
end if

if( opts.have_input ) then
	processFile( opts.input_file, opts.output_file, opts )
else
	if( nfiles = 0 ) then
		print "error: no files specified"
		end 1
	end if

	for i as integer = 1 to nfiles
		processFile( files(i), files(i), opts )
	next
end if
