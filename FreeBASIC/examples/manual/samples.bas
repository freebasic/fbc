'' --------------------------------------------------------
'' FBWIKI Samples Builder
'' --------------------------------------------------------
''
'' compile with
''   fbc samples.bas
''
'' then execute with
''   samples[.exe]
''
'' --------------------------------------------------------

#include once "dir.bi"
#include once "file.bi"

#if (defined( __FB_LINUX__ ) or defined( __FB_FREEBSD__ ))
#define __UNIX__
#endif
	
#ifdef __UNIX__
	const exe_ext = ""
	const psc = "/"
#else
	const exe_ext = ".exe"
	const psc = "\"
#endif

#define FALSE  0
#define TRUE   1
#define NULL   0

'' --------------------------------------------------------
'' HELPERS
'' --------------------------------------------------------

function SetPathChars( byref s as string, byref p as string ) as string
	dim i as integer, r as string

	r = s
	for i = 0 to len(s) - 1
		if(( r[i] = asc("\") ) or ( r[i] = asc("/") )) then
			r[i] = asc(p)
		end if
	next
	function = r

end function

function AdjustPath( byref s as string, byval addsep as integer ) as string
	dim ret as string
	#ifdef __UNIX__
		ret = s
	#else
		ret = lcase(s)
	#endif
	if( addsep <> 0 ) then
		select case right(ret,1)
		case "/", "\"
		case else
			ret &= psc
		end select
	end if
	function = ret
end function

'' --------------------------------------------------------

sub ScanDirectories _
	( _
		byref sourcedir as string, _
		dirs() as string, byref ndirs as integer, _
		filters() as string, byref nfilters as integer _
	)

	dim d as string, i as integer, b as integer

	'' get directories
	ndirs = 0
	d = dir( sourcedir & "*.*", fbDirectory )
	while( d > "" )
		if(( d <> "." ) and ( d <> ".." )) then

			b = FALSE
			if( nfilters > 0 ) then
				for i = 1 to nfilters
					if( lcase(filters(i)) = lcase(d)) then
						b = TRUE
						exit for
					end if
				next
			else
				b = TRUE
			end if

			if( b = TRUE ) then
				ndirs += 1
				if ndirs = 1 then
					redim dirs( 1 to ndirs )
				else
					redim preserve dirs( 1 to ndirs )
				end if
				dirs( ndirs ) = d & psc
			end if

		end if
		d = dir()
	wend

end sub

sub ScanFiles _
	( _
		byref sourcedir as string, _
		dirs() as string, byval ndirs as integer, _
		files() as string, byref nfiles as integer _
	)

	dim d as string, i as integer

	'' get files
	nfiles = 0
	for i = 1 to ndirs
		d = dir( sourcedir & dirs(i) & "*.bas" )
		while( d > "" )
			nfiles += 1
			if nfiles = 1 then
				redim files( 1 to nfiles)
			else
				redim preserve files( 1 to nfiles )
			end if
			files( nfiles ) = dirs(i) & d
			d = dir()
		wend
	next

end sub

function DoCompile _
	( _
		byref sourcedir as string, _
		byref fbc as string, _
		byref source as string, _
		byref target as string _
	) as integer

	dim b as integer, ret as integer, i as integer
	dim args as string

	ret = 0

	if( dir( sourcedir & target ) > "" ) then
		if FileDateTime( sourcedir & source ) > FileDateTime( sourcedir & target ) then
			b = TRUE
		else
			b = FALSE
		end if
	else
		b = TRUE
	end if

	if( b = TRUE ) then

		if( source > "" ) then

			dim h as integer = freefile, idx as integer
			if open( sourcedir & source for input access read as #h ) = 0 then

				dim body as string
				body = space( lof( h ))
				get #h,,body
				close #h

				args = sourcedir & source

				if instr( lcase(body), "-lang deprecated" ) > 0 then
					args += " -lang deprecated"

				elseif instr( lcase(body), "-lang qb" ) > 0 then
					args += " -lang qb"

				end if

				args += " -x " & sourcedir & target
			else
				print "Error reading '" & sourcedir & source & "'"
				b = FALSE

			end if
		end if
	end if

	if( b = TRUE ) then
		print fbc & " " & args
		ret = exec( fbc, args )
		print
	end if

	function = ret

end function

function DoClean _
	( _
		byref sourcedir as string, _
		byref source as string, _
		byref target as string _
	) as integer

	if( dir(sourcedir & source) > "" ) then
		if( dir(sourcedir & target) > "" ) then
			print "removing " & sourcedir & target
			if( kill( sourcedir & target ) <> 0 ) then
				print "error removing " & sourcedir & target
			end if
		end if
	end if

	function = 0

end function

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

enum COMMAND_ID
	CMD_COMPILE = 1
	CMD_CLEAN = 2
end enum

dim fbc as string, sourcedir as string, i as integer

dim dirs() as string, ndirs as integer
dim files() as string, nfiles as integer
dim filters() as string, nfilters as integer

ndirs = 0
nfiles = 0
nfilters = 0

dim cmd as COMMAND_ID

'' parse command line command
i = 1
select case lcase(command(i))
case "compile"
	cmd = CMD_COMPILE

case "clean"
	cmd = CMD_CLEAN

case else
	print "samples command [-fbc path" & psc & "fbc" & exe_ext & "] [-sourcedir path] [dirs...]"
	print
	print "   Command:"
	print "      compile"
	print "      clean"
	print
	print "   Options:"
	print "      -fbc path" & psc & "fbc" & exe_ext
	print "         Sets path and name of the fbc compiler to use when
	print "         building the samples.  Default is .." & psc & ".." & psc & "fbc" & exe_ext
	print
	print "      -srcdir path"
	print "         Set the base directory of the samples to build.
	print "         Default is " & exepath & psc
	print
	print "      dirs"
	print "         Specify the names of the directories (without paths) to build."
	print "         Default is to build all."
	print
	end
end select

'' parse command line options
i += 1
while( command(i) > "" )
	if( left( command(i), 1 ) = "-" ) then

		select case lcase(command(i))
		case "-fbc"
			i += 1
			fbc = AdjustPath( command(i), FALSE )

		case "-srcdir"
			i += 1
			sourcedir = AdjustPath( command(i), TRUE )

		case else
			print "Unrecognized option '" & command(i) & "'"
			end 1
		end select

	else
		nfilters += 1
		if( nfilters = 1 ) then
			redim filters(1 to nfilters)
		else
			redim preserve filters( 1 to nfilters )
		end if
		filters(nfilters) = command(i)

	end if

	i += 1

wend

if( sourcedir = "" ) then
	sourcedir = AdjustPath( exepath & psc, TRUE )
end if

if( cmd = CMD_COMPILE ) then
	if( fbc = "" ) then
		fbc = AdjustPath( ".." & psc & ".." & psc & "fbc" & exe_ext, FALSE )
	end if

	if( dir( fbc ) = "" ) then
		print "'" + fbc + "' not found"
		end
	end if

	#ifdef __FB_DOS__
		'' On dos we need to flip \'s to /'s since we are calling
		'' another gnu-like exe (fbc.exe)
		fbc = SetPathChars( fbc, "/" )
	#endif
end if

'' Scan for directories and files
ScanDirectories( sourcedir, dirs(), ndirs, filters(), nfilters )
ScanFiles( sourcedir, dirs(), ndirs, files(), nfiles )

dim as string source, target

'' compile the sources
for i = 1 to nfiles

	select case cmd
	case CMD_COMPILE

		source = files(i)
		target = left(files(i), len(files(i))-4) & exe_ext

		DoCompile( sourcedir, fbc, source, target )

	case CMD_CLEAN

		source = files(i)
		target = left(files(i), len(files(i))-4) & exe_ext

		DoClean( sourcedir, source, target )

	end select

next
