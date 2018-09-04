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
''
'' NOTES:
''
'' Internally, we use "/" for the path seperator *always*.
'' The special build file samples.ini uses "/" in all paths
'' The "/" is flipped to "\" only when needed.
''
'' IDEAS:
'' - add an option to generate a makefile that performs the
''   same function as this utility
'' - allow compiling for gcc (C/C++) programs
'' - more options (in samples.ini ) to exclude certain
''   samples based on platform DOS, LINUX, WIN32, etc
''
'' --------------------------------------------------------

#include once "dir.bi"

#ifndef false
#define FALSE  0
#endif
#ifndef true
#define TRUE   -1
#endif
#ifndef NULL
#define NULL   0
#endif

#include once "file.bi"

#if (defined( __FB_LINUX__ ) or defined( __FB_FREEBSD__ ))
#define __UNIX__
#define PLATFORM "LINUX"

#elseif (defined( __FB_WIN32__ ) or defined( __FB_CYGWIN__ ) or defined( __FB_XBOX__ ))
#define PLATFORM "WIN32"

#elseif (defined( __FB_DOS__ ))
#define PLATFORM "DOS32"

#else
#error TARGET NOT SUPPORTED

#endif

#define FWD_SLASH "/"
#define BACK_SLASH "\"
	
#ifdef __UNIX__
	const exe_ext = ""
	const dll_ext = ".so"
	const psc = FWD_SLASH
#else
	const exe_ext = ".exe"
	const psc = BACK_SLASH
	const dll_ext = ".dll"
#endif

enum COMMAND_ID
	CMD_COMPILE = 1
	CMD_CLEAN
	CMD_LIST
end enum

enum BUILD_RESULT
	BUILD_FAIL
	BUILD_SUCCESS
	BUILD_NOT_NEEDED
end enum

'' --------------------------------------------------------
'' HELPERS
'' --------------------------------------------------------

''
function SetPathChars( byref s as string, byref p as string ) as string
	dim i as integer, r as string

	r = s
	for i = 0 to len(s) - 1
		if(( r[i] = asc(FWD_SLASH) ) or ( r[i] = asc(BACK_SLASH) )) then
			r[i] = asc(p)
		end if
	next
	function = r

end function

''
function AdjustPath( byref s as string, byref p as string = "" ) as string
	dim ret as string
	#ifdef __UNIX__
		ret = s
	#else
		ret = lcase(s)
	#endif
	if( len(p) > 0 ) then
		select case right(ret,1)
		case FWD_SLASH, BACK_SLASH
		case else
			ret = ret & p
		end select
	end if
	function = ret
end function

''
function ReplaceSubStr _
	( _
		byref src as string, _
		byref old as string, _
		byref rep as string _
	) as string 

	dim i as integer = 1, ret as string 
	ret = src 
	do 
	  i = instr(i, ret, old) 
	  if i = 0 then exit do 
	  ret = left(ret, i - 1) + rep + mid(ret, i + len(old)) 
	  i += len(rep) 
	loop 
	return ret 

end function

'' --------------------------------------------------------
'' SPECIAL BUILDS
'' --------------------------------------------------------

type SpecialBuildFileT
	source as string
	index1 as integer
	index2 as integer
end type

enum SpecialBuildStep
	SBS_INVALID
	SBS_SRC
	SBS_DST
	SBS_CMD
	SBS_DEP
end enum

type SpecialBuildCmdT
	buildstep as SpecialBuildStep
	value as string
end type

'' Special Build Information
dim shared sbFiles() as SpecialBuildFileT
dim shared nsbFiles as integer
dim shared sbCmds() as SpecialBuildCmdT
dim shared nsbCmds as integer
dim shared opt_error as integer

''
sub ReadSampleIni( byref filename as string )
	
	dim h as integer, x as string, i as integer, skiptonext as integer
	dim v as string, t as string, p as string
	dim buildstep as SpecialBuildStep
	h = freefile

	nsbFiles = 0
	redim sbFiles(0)
	nsbCmds = 0
	redim sbCmds(0)

	if( open( filename for input access read as #h ) = 0 ) then
		skiptonext = FALSE
		while eof(h) = 0
			line input #h, x
			x = trim( x, any chr(9,32) )
			if( (x > "") and (left(x, 1) <> "#") ) then
				if( (left(x, 1) = "[") and (right(x, 1) = "]") ) then
					skiptonext = FALSE
					nsbfiles += 1
					redim preserve sbFiles( 0 to nsbFiles - 1 )
					with sbFiles( nsbFiles - 1 )
						.source = SetPathChars( trim( mid( x, 2, len(x) - 2), any chr(9,32) ), FWD_SLASH )
						.index1 = nsbCmds
						.index2 = nsbCmds
					end with
				else
					i = instr( x, "=" )
					if( i > 0 ) then
						v = trim( left( x, i - 1 ), any chr(9,32) )
						t = trim( mid( x, i + 1 ), any chr(9,32) )
						t = SetPathChars( t, FWD_SLASH )
						
						'' Does v have a conditional target
						i = instr( v, "," )
						if( i > 0 ) then
							p = ucase( trim( mid( v, i + 1 ), any chr(9,32) ) )
							v = trim( left( v, i - 1 ), any chr(9,32) )

						else
							p = PLATFORM
						end if

						if( p = PLATFORM ) then

							if( skiptonext = TRUE ) then
								buildstep = SBS_INVALID

							else

								select case ucase(v)
								case "SRC"	
									buildstep = SBS_SRC
								case "DST"
									buildstep = SBS_DST
								case "CMD"
									buildstep = SBS_CMD
								case "DEP"
									buildstep = SBS_DEP
								case "SKP"
									buildstep = SBS_INVALID
									skiptonext = TRUE
								case else
									buildstep = SBS_INVALID
								end select

							end if

							nsbCmds += 1
							redim preserve sbCmds( 0 to nsbCmds - 1 )
							with sbCmds( nsbCmds - 1 ) 
								.buildstep = buildstep
								.value = t
							end with
							sbFiles( nsbFiles - 1 ).index2 = nsbCmds

						end if

					end if

				end if
			end if
		wend
		close #h
	else
		print "Warning: Unable to open '" & filename & "'"
	end if
end sub

''
function GetSpecialBuildIndex( byref filename as string ) as integer
	function = FALSE
	dim i as integer
	function = -1
	for i = 0 to nsbFiles - 1
		if( filename = sbFiles(i).source ) then
			function = i
			exit for
		end if
	next
end function

''
function IsSpecialBuild( byref filename as string ) as integer
	function = ( GetSpecialBuildIndex( filename ) >= 0 )
end function

'' --------------------------------------------------------

''
sub AddDir( byref d as string, dirs() as string, byref ndirs as integer )
	dim i as integer
	for i = 1 to ndirs
		if( dirs(i) = d ) then
			exit for
		end if
	next
	if( i > ndirs ) then
		ndirs += 1
		if ndirs = 1 then
			redim dirs( 1 to ndirs )
		else
			redim preserve dirs( 1 to ndirs )
		end if
		dirs( ndirs ) = d
	end if
end sub

''
sub ScanDirectories _
	( _
		byref sourcedir as string, _
		byref sourcedir2 as string, _
		dirs() as string, byref ndirs as integer _
	)

	dim d as string, i as integer, b as integer, start as integer

	'' get directories
	start = ndirs + 1
	d = dir( sourcedir & sourcedir2 & "*.*", fbDirectory )
	while( d > "" )
		if(( d <> "." ) and ( d <> ".." )) then
			AddDir( sourcedir2 & d & FWD_SLASH, dirs(), ndirs )
		end if
		d = dir()
	wend

	for i = start to ndirs
		
		'' NOTE: we don't pass dirs(i) directly to ScanDirectories()
		'' because dirs() might get resized, and the descriptor
		'' relocated, corrupting the stack since ScanDirectories()
		'' is called recursively.

		dim tmp as string		
		tmp = dirs(i)
		ScanDirectories( sourcedir, tmp, dirs(), ndirs )

	next

end sub

''
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
		d = dir( sourcedir & dirs(i) & "*.*" )
		while( d > "" )
			if( lcase( right( d, 2 )) = ".c" or lcase(right( d, 4 )) = ".bas" ) then
				nfiles += 1
				if nfiles = 1 then
					redim files( 1 to nfiles)
				else
					redim preserve files( 1 to nfiles )
				end if
				files( nfiles ) = dirs(i) & d
			end if
			d = dir()
		wend
	next

end sub

''
function IsFileNewer _
	( _
		byref sourcedir as string, _
		byref source as string, _
		byref target as string _
	) as integer

	if(( source > "" ) and ( target > "" )) then
		if( fileexists( sourcedir & target ) <> FALSE ) then
			if FileDateTime( sourcedir & source ) > FileDateTime( sourcedir & target ) then
				function = TRUE
			else
				function = FALSE
			end if
		else
			function = TRUE
		end if
	else
		function = TRUE
	end if

end function

''
function DoCompile _
	( _
		byref sourcedir as string, _
		byref fbc as string, _
		byref source as string, _
		byref target as string, _
		byref opts as string _
	) as integer

	dim i as integer
	dim args as string

	if( IsFileNewer( sourcedir, source, target ) = TRUE ) then

		dim h as integer = freefile, idx as integer, ret as integer

		if open( sourcedir & source for binary access read as #h ) = 0 then

			dim body as string
			body = space( lof( h ))
			get #h,,body
			close #h

			args = sourcedir & source

			args += " " & opts & " -x " & sourcedir & target

			print fbc & " " & args
			ret = exec( fbc, args )
			print

			function = iif( ret = 0, BUILD_SUCCESS, BUILD_FAIL )

		else
			print "Error reading '" & sourcedir & source & "'"

			function = BUILD_FAIL

		end if

	else
		function = BUILD_NOT_NEEDED

	end if

end function

''
function DoClean _
	( _
		byref sourcedir as string, _
		byref source as string, _
		byref target as string _
	) as integer

	function = BUILD_SUCCESS

	if( fileexists(sourcedir & source) <> FALSE ) then
		if( fileexists(sourcedir & target) <> FALSE ) then
			print "removing " & sourcedir & target
			if( kill( sourcedir & target ) <> 0 ) then
				print "error removing " & sourcedir & target
				function = BUILD_FAIL
			end if
		end if
	end if

end function

''
function DoSpecialBuild _
	( _
		byval cmd as COMMAND_ID, _
		byref sourcedir as string, _
		byref fbc as string, _
		byref source as string, _
		byref newest as double = 0 _
	) as integer

	dim as integer i, j, k, ret
	dim as integer first, last
	dim as string v, args
	dim as integer haderror, hadbuild, dobuild
	dim as double d

	function = BUILD_FAIL
	haderror = FALSE

	i = GetSpecialBuildIndex( source )
	if( i < 0 ) then
		exit function
	end if
		
	first = sbFiles(i).index1
	last = sbFiles(i).index2 - 1

	if( last - first < 0 ) then
		function = BUILD_NOT_NEEDED
		exit function
	end if

	dobuild = FALSE   '' have option to force this?
	hadbuild = FALSE

	'' Do the dependencies first
	for j = first to last
		if( sbCmds(j).buildstep = SBS_DEP ) then				
			ret = DoSpecialBuild( cmd, sourcedir, fbc, sbCmds(j).value, newest )
			if( ret = BUILD_FAIL ) then
				haderror = TRUE
				if( opt_error ) then
					exit function
				end if
			elseif( ret = BUILD_SUCCESS ) then
				hadbuild = TRUE
			end if
		end if
	next

	select case cmd
	case CMD_COMPILE

		dobuild OR= hadbuild

		''
		if( dobuild = FALSE ) then

			'' Any DST file missing

			for j = first to last
				if( sbCmds(j).buildstep = SBS_DST ) then

					args = sbCmds(j).value
					args = ReplaceSubStr( args, "$(EXEEXT)", exe_ext )
					args = ReplaceSubStr( args, "$(DLLEXT)", dll_ext )

					if( fileexists( sourcedir & args ) = FALSE ) then
						dobuild = TRUE
						exit for
					end if
				end if
			next

		end if

		''
		if( dobuild = FALSE ) then

			'' Get newest SRC file (or DEP, it might already be set)

			if( fileexists( sourcedir & source ) ) then
				d = filedatetime( sourcedir & source )
				if( d > newest ) then
					newest = d
				end if
			end if

			for j = first to last
				if( sbCmds(j).buildstep = SBS_SRC ) then
					if( fileexists( sourcedir & sbCmds(j).value ) ) then
						d = filedatetime( sourcedir & sbCmds(j).value )
						if( d > newest ) then
							newest = d
						end if
					end if
				end if
			next j

			'' Any DST files older than newest date?
			for j = first to last
				if( sbCmds(j).buildstep = SBS_DST ) then

					args = sbCmds(j).value
					args = ReplaceSubStr( args, "$(EXEEXT)", exe_ext )
					args = ReplaceSubStr( args, "$(DLLEXT)", dll_ext )

					if( fileexists( sourcedir & args ) ) then

						d = filedatetime( sourcedir & args )
						if( d < newest ) then
							dobuild = TRUE
							exit for
						end if

					else

						'' This was already checked, but anyway ...
						dobuild = TRUE
						exit for

					end if
				end if
			next 
		end if

		''
		if( dobuild ) then
		
			'' At least one file is out of date or missing,
			'' so do this special build

			for j = first to last
				select case sbCmds(j).buildstep 
				case SBS_CMD

					args = sbCmds(j).value
					args = ReplaceSubStr( args, "$(EXEEXT)", exe_ext )
					args = ReplaceSubStr( args, "$(DLLEXT)", dll_ext )

					print fbc & " " & args
					ret = exec( fbc, args )
					if( ret <> 0 ) then
						haderror = TRUE
						if( opt_error ) then
							exit function
						end if
					end if
					print

				end select
			next

			function = iif( haderror = FALSE, BUILD_SUCCESS, BUILD_FAIL )
		
		else
			function = BUILD_NOT_NEEDED
		
		end if

		'' Get the newest date of all DST files
		for j = first to last
			if( sbCmds(j).buildstep = SBS_DST ) then
				if( fileexists( sbFiles(i).source ) ) then
					d = filedatetime( sbFiles(i).source )
					if( d > newest ) then
						newest = d
					end if
				end if
			end if
		next

	case CMD_CLEAN

		for j = first to last
			if( sbCmds(j).buildstep = SBS_DST ) then				

				args = sbCmds(j).value
				args = ReplaceSubStr( args, "$(EXEEXT)", exe_ext )
				args = ReplaceSubStr( args, "$(DLLEXT)", dll_ext )

				if( DoClean( sourcedir, sbFiles(i).source, args ) = BUILD_FAIL ) then
					haderror = TRUE
					if( opt_error ) then
						exit function
					end if
				end if

			end if
		next

		function = iif( haderror = FALSE, BUILD_SUCCESS, BUILD_FAIL )

	end select

	

end function


'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

dim fbc as string, sourcedir as string, i as integer
dim opt_specialonly as integer
dim dirs() as string, ndirs as integer
dim files() as string, nfiles as integer
dim haderror as integer
dim extra_opts as string = ""

ndirs = 0
nfiles = 0

opt_specialonly = FALSE
opt_error = FALSE
haderror = FALSE

dim cmd as COMMAND_ID

'' parse command line command
i = 1
select case lcase(command(i))
case "compile"
	cmd = CMD_COMPILE

case "clean"
	cmd = CMD_CLEAN

case "list"
	cmd = CMD_LIST

case else
	print "samples command [options] [dirs...]"
	print
	print "   Command:"
	print "      compile     compiles the samples"
	print "      clean       removes files created during compilation"
	print "      list        list the files only"
	print
	print "   Options:"
	print "      -fbc path" & psc & "fbc" & exe_ext
	print "         Sets path and name of the fbc compiler to use when"
	print "         building the samples.  Default is .." & psc & ".." & psc & "fbc" & exe_ext
	print
	print "      -srcdir path"
	print "         Set the base directory of the samples to build."
	print "         Default is " & exepath & psc
	print
	print "      dirs..."
	print "         Specify the names of the directories (without paths) to build."
	print "         Default is to build all. e.g. proguide/arrays"
	print
	print "      -special"
	print "         Only process the special builds.  (Files listed in samples.ini)"
	print
	print "      -error"
	print "         Abort on first error detected"
	print
	print "      -opts options"
	print "         Add options to the command line" 
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
			fbc = SetPathChars( command(i), psc )
			fbc = AdjustPath( fbc )

		case "-srcdir"
			i += 1
			sourcedir = SetPathChars( command(i), FWD_SLASH )
			sourcedir = AdjustPath( sourcedir, FWD_SLASH )

		case "-special"
			opt_specialonly = TRUE

		case "-error"
			opt_error = TRUE
		
		case "-opts"
			i += 1
			extra_opts = command(i)

		case else
			print "Unrecognized option '" & command(i) & "'"
			end 1

		end select

	else
		dim tmp as string
		tmp = SetPathChars( command(i), FWD_SLASH )
		tmp = AdjustPath( tmp, FWD_SLASH )
		AddDir( tmp, dirs(), ndirs )

	end if

	i += 1

wend

if( sourcedir = "" ) then
	sourcedir = SetPathChars( exepath, FWD_SLASH )
	sourcedir = AdjustPath( sourcedir, FWD_SLASH )
end if

if( cmd = CMD_COMPILE ) then

	if( fbc = "" ) then
		fbc = ".." & FWD_SLASH & ".." & FWD_SLASH & "fbc" & exe_ext
	end if

	if( fileexists( fbc ) = 0 ) then
		print "'" & fbc & "' not found"
		end 1
	end if

end if

'' Scan for directories and files
if( nDirs > 0 ) then
	for i = 1 to nDirs
		dim tmp as string
		tmp = dirs(i)
		ScanDirectories( sourcedir, tmp, dirs(), ndirs )
	next
else
	ScanDirectories( sourcedir, "", dirs(), ndirs )
end if

ScanFiles( sourcedir, dirs(), ndirs, files(), nfiles )

dim as string source, target

ReadSampleIni( exepath & FWD_SLASH & "samples.ini" )

select case cmd
case CMD_LIST
	for i = 1 to nfiles
		print files(i)
	next

case CMD_COMPILE, CMD_CLEAN

	for i = 1 to nfiles
		if( IsSpecialBuild( files(i) ) ) then
		
			if( DoSpecialBuild( cmd, sourcedir, fbc, files(i) ) = BUILD_FAIL ) then
				haderror = TRUE
				if( opt_error ) then
					exit for
				end if
			end if

		elseif( opt_specialonly = FALSE ) then

			dim target as string
			target = left(files(i), len(files(i))-4) & exe_ext

			if( cmd = CMD_COMPILE ) then
				if( DoCompile( sourcedir, fbc, files(i), target, extra_opts ) = BUILD_FAIL ) then
					haderror = TRUE
					if( opt_error ) then
						exit for
					end if
				end if

			else
				if( DoClean( sourcedir, files(i), target ) = BUILD_FAIL ) then
					haderror = TRUE
					if( opt_error ) then
						exit for
					end if
				end if

			end if

		end if
	next

end select

if( haderror ) then
	end 1
end if
