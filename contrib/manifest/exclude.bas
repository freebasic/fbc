'' This program reads in a list of file names and applies the exclude patterns
'' found in exclude.ini

#define NULL 0
#define TRUE (-1)
#define FALSE 0

dim shared as string release '' release name from command line

const MAX_FILES = 1024*4
const MAX_PATTERNS = 128

dim shared as string patterns(0 to MAX_PATTERNS-1)
dim shared as integer patterncount

'' Loads the pattern.ini
private sub hLoadPatterns( byref file as string )
	dim as integer f = any, skip = any
	dim as string ln

	f = freefile( )
	if( open( file, for input, as #f ) <> 0 ) then
		print "could not open file: '" + file + "'"
		end 1
	end if

	'' Read in the patterns, but skip all patterns in [sections] for
	'' different release names, and ignore commentary/whitespace
	skip = FALSE
	while( eof( f ) = FALSE )
		line input #f, ln

		ln = trim( ln )

		if( len( ln ) = 0 ) then
			continue while
		end if

		select case( left( ln, 1 ) )
		case ";"
			continue while
		case "["
			ln = right( ln, len( ln ) - 1 )
			if( right( ln, 1 ) = "]" ) then
				ln = left( ln, len( ln ) - 1 )
			end if

			skip = (ln <> release)

			continue while
		end select

		if( skip = FALSE ) then
			patterns(patterncount) = ln
			patterncount += 1
		end if
	wend

	close #f
end sub

private function hIsMatch _
	( _
		byref origpattern as string, _
		byref file as string _
	) as integer

	dim as string pattern
	dim as integer wildcard = any, lhs = any, rhs = any

	pattern = origpattern

	wildcard = instr( pattern, "*" )
	if( instr( wildcard + 1, pattern, "*" ) > 0 ) then
		print "error: pattern with more than one wildcard"
		end 1
	end if

	if( wildcard > 0 ) then
		lhs = wildcard - 1
		rhs = len( pattern ) - wildcard
		function = (( left( file, lhs ) =  left( pattern, lhs )) and _
		            (right( file, rhs ) = right( pattern, rhs )))
	else
		function = (pattern = file)
	end if
end function

private sub hHandleFile( byref file as string )
	dim as integer exclude = any

	'' Compare the file name against all patterns, and write it out into
	'' the manifest file if it matches
	exclude = FALSE
	for i as integer = 0 to (patterncount - 1)
		exclude or= hIsMatch( patterns(i), file )
	next

	if( exclude = FALSE ) then
		print file
	end if
end sub

private sub hReadStdin( )
	dim as integer f = any
	dim as string ln

	f = freefile( )
	open cons for input as #f

	while( eof( f ) = FALSE )
		line input #f, ln
		ln = trim( ln )

		if( len( ln ) > 0 ) then
			hHandleFile( ln )
		end if
	wend

	close #f
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

release = command( 1 )
if( len( release ) = 0 ) then
	print "usage: contrib/manifest/exclude <release-name>"
	end 1
end if

hLoadPatterns( exepath( ) + "/exclude.ini" )

hReadStdin( )
