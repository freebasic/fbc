''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' main module, front-end
''
'' chng: sep/2004 written [v1ctor]
''		 dec/2004 linux support added [lillo]
''		 jan/2005 dos support added [DrV]


defint a-z
option explicit
option private
option escape

#include once "inc\fb.bi"
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"

declare sub 	 parseCmd 				( argc as integer, argv() as string )

declare sub 	 setDefaultOptions		( )
declare function processOptions			( ) as integer
declare function processCompOptions  	( ) as integer
declare function processCompLists 		( ) as integer
declare sub 	 printOptions			( )
declare sub 	 getLibList 			( )

declare function listFiles 				( ) as integer
declare function compileFiles 			( ) as integer
declare function assembleFiles 			( ) as integer
declare function linkFiles 				( ) as integer
declare function archiveFiles 			( ) as integer
declare function compileResFiles 		( ) as integer
declare function delFiles 				( ) as integer


''globals
	dim shared fbc as FBCCTX

	dim shared argc as integer, argv(0 to FB_MAXARGS-1) as string

    ''
    parseCmd( argc, argv() )

    if( argc = 0 ) then
    	printOptions( )
    	end 1
    end if

    ''
    fbcInit( )

    ''
    setDefaultOptions( )

    ''
    if( not processOptions( ) ) then
    	end 1
    end if

    '' list
    if( not listFiles( ) ) then
    	printOptions( )
    	end 1
    end if

    ''
    if( not fbc.showversion ) then
    	if( (fbc.inps = 0) and (fbc.objs = 0) and (fbc.libs = 0) ) then
    		printOptions( )
    		end 1
    	end if
    end if

    ''
    if( fbc.verbose or fbc.showversion ) then
    	print "FreeBASIC Compiler - Version " + FB_VERSION
    	print "Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)"
    	
    	print "Built with TARGET=";
    	#ifdef TARGET_WIN32
    	print "win32";
    	#elseif defined(TARGET_LINUX)
    	print "linux";
    	#elseif defined(TARGET_DOS)
    	print "dos";
    	#elseif defined(TARGET_XBOX)
    	print "xbox";
    	#endif
    	
    	print ", HOST=";
    	#ifdef __FB_WIN32__
    	print "win32"
    	#elseif defined(__FB_LINUX__)
    	print "linux"
    	#elseif defined(__FB_DOS__)
    	print "dos"
    	#elseif defined(__FB_XBOX__)
    	print "xbox"
    	#endif
    	
    	print
    	if( fbc.showversion ) then
    		end 0
    	end if
    end if

    ''
    fbSetPaths( fbc.target )

    '' compile
    if( not compileFiles( ) ) then
    	delFiles( )
    	end 1
    end if

    '' assemble
   	if( not assembleFiles( ) ) then
   		delFiles( )
   		end 1
   	end if

	if( not fbc.compileonly ) then

    	'' link
    	if( fbc.outtype <> FB_OUTTYPE_STATICLIB ) then
			'' resource files..
			if( not compileResFiles( ) ) then
				delFiles( )
				end 1
			end if

    		if( not linkFiles( ) ) then
    			delFiles( )
    			end 1
    		end if
    	else
    		if( not archiveFiles( ) ) then
    			delFiles( )
    			end 1
    		end if
    	end if
    end if

    '' del temps
    if( not delFiles( ) ) then
    	end 1
    end if

    end 0

'':::::
function compileFiles as integer
	dim i as integer

	function = FALSE

    for i = 0 to fbc.inps-1

    	'' this must be done before Init coz rtlib initialization depends on nostdcall to be defined
    	if( not processCompOptions( ) ) then
    		exit function
    	end if

    	'' init the parser
    	if( not fbInit( ) ) then
    		exit function
    	end if

    	'' add include paths and defines
    	processCompLists( )

    	'' if no output file given, assume it's the same name as input, with the .o extension
    	if( len( fbc.outlist(i) ) = 0 ) then
    		fbc.outlist(i) = hStripExt( fbc.inplist(i) ) + ".o"
    	end if

    	'' create output asm name
    	fbc.asmlist(i) = hStripExt( fbc.outlist(i) ) + ".asm"

    	if( fbc.verbose ) then
    		print "compiling: ", fbc.inplist(i); " -o "; fbc.asmlist(i)
    	end if

    	if( not fbCompile( fbc.inplist(i), fbc.asmlist(i) ) ) then
    		exit function
    	end if

		'' get list with all referenced libraries
		getLibList( )

		'' shutdown the parser
		fbEnd( )

	next i

    '' no default libs would be added if no inp files were given
    if( fbc.inps = 0 ) then
   		fbInit( )
   		fbAddDefaultLibs( )
   		getLibList( )
   		fbend( )
    end if

	function = TRUE

end function

'':::::
function assembleFiles as integer
	dim i as integer, f as integer
	dim aspath as string, ascline as string

	function = FALSE

    '' get path to assembler
    aspath = environ$("AS") '' check the environment variable first
    if len(aspath)=0 then
        '' when not set, then simply use some default value
#if defined(TARGET_WIN32) or defined(TARGET_DOS) or defined(TARGET_XBOX)
		aspath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "as.exe"
#elseif defined(TARGET_LINUX)
		aspath = "as"
#endif
    end if

    '' set input files (.asm's) and output files (.o's)
    for i = 0 to fbc.inps-1

    	'' as' options
    	if( not fbc.debug ) then
    		ascline = "--strip-local-absolute "
    	else
    		ascline = ""
    	end if

		ascline += "\"" + fbc.asmlist(i) + "\" -o \"" + fbc.outlist(i) + "\" "

    	'' invoke as
    	if( fbc.verbose ) then
    		print "assembling: ", aspath + " " + ascline
    	end if

    	if( exec( aspath, ascline ) <> 0 ) then
    		exit function
    	end if
    next i

    function = TRUE

end function

'':::::
function archiveFiles as integer
    dim i as integer
    dim arcline as string

	function = FALSE

    '' if no exe file name given, assume "lib" + first source name + ".a"
    '' ( exe filename is actually lib filename for static libs )
    if( len( fbc.outname ) = 0 ) then

		if( fbc.inps > 0 ) then
			fbc.outname = hStripFilename( fbc.inplist(0) ) + "lib" + _
										  hStripPath( hStripExt( fbc.inplist(0) ) ) + ".a"
		else
			if( fbc.objs > 0 ) then
				fbc.outname = hStripFilename( fbc.objlist(0) ) + "lib" + _
											  hStripPath( hStripExt( fbc.objlist(0) ) ) + ".a"
			else
				fbc.outname = "libnoname.a"
			end if
		end if

    end if

    arcline = "-rsc "

    '' output library file name
    arcline += QUOTE + fbc.outname + "\" "

    '' add objects from output list
    for i = 0 to fbc.inps-1
    	arcline += QUOTE + fbc.outlist(i) + "\" "
    next i

    '' add objects from cmm-line
    for i = 0 to fbc.objs-1
    	arcline += QUOTE + fbc.objlist(i) + "\" "
    next i

    '' invoke ar
    if( fbc.verbose ) then
       print "archiving: ", arcline
    end if

    fbc.archiveFiles( arcline )

    function = TRUE

end function

'':::::
function linkFiles as integer

	function = fbc.linkFiles( )

end function

'':::::
function compileResFiles as integer

	function = fbc.compileResFiles( )

end function

'':::::
function delFiles as integer
	dim i as integer

    function = FALSE

    for i = 0 to fbc.inps-1
		if( not fbc.preserveasm ) then
			safeKill( fbc.asmlist(i) )
		end if
		if( not fbc.compileonly ) then
			safeKill( fbc.outlist(i) )
		end if
    next i

    function = fbc.delFiles( )

end function

'':::::
sub printOptions

	print "Usage: fbc [options] inputlist"
	print
	print "inputlist:", "xxx.a = library, xxx.o = object, xxx.bas = source"
#ifdef TARGET_WIN32
	print " "         , "xxx.rc = resource script, xxx.res = compiled resource"
#elseif defined(TARGET_LINUX)
	print " "         , "xxx.xpm = icon resource"
#endif
	print
	print "options:"
	print "-a <name>", "Add an object file to linker's list"
	print "-arch <type>", "Set target architecture (def: 486)"
	print "-b <name>", "Add a source file to compilation"
	print "-c", "Compile only, do not link"
	print "-d <name=val>", "Add a preprocessor's define"
#if defined(TARGET_WIN32) or defined(TARGET_LINUX)
	print "-dll", "Same as -dylib"
#endif
#ifdef TARGET_WIN32
	print "-dylib", "Create a DLL, including the import library"
#elseif defined(TARGET_LINUX)
	print "-dylib", "Create a shared library"
#endif
	print "-e", "Add error checking"
	print "-entry <name>", "Set a non-standard entry point, see -m"
	print "-ex", "Add error checking with RESUME support"
	print "-export", "Export symbols for dynamic linkage"
	print "-g", "Add debug info (testing)"
	print "-i <name>", "Add a path to search for include files"
	print "-l <name>", "Add a library file to linker's list"
	print "-lib", "Create a static library"
	print "-m <name>", "Main file w/o ext, the entry point (def: 1st .bas on list)"
	print "-mt", "Link with thread-safe runtime library for multithreaded apps"
	print "-nodeflibs", "Do not include the default libraries"
	print "-noerrline", "Do not show source line where error occured"
#ifdef TARGET_WIN32
	'''''print "-nostdcall", "Treat stdcall calling convention as cdecl"
	'''''print "-nounderscore", "Don't add the underscore prefix to function names"
#endif
	print "-o <name>", "Set output name (in the same number as source files)"
	print "-p <name>", "Add a path to search for libraries"
	print "-profile", "Enable function profiling"
	print "-r", "Do not delete the asm file(s)"
#ifdef TARGET_WIN32
	print "-s <name>", "Set subsystem (gui, console)"
	print "-t <value>", "Set stack size in kbytes (default: 1M)"
	'''''print "-target <name>", "Change the default target platform (dos, win32 or linux)"
#endif
#ifdef TARGET_XBOX
	print "-title <name>", "Set XBE display title"
#endif
	print "-v", "Be verbose"
	print "-version", "Show compiler version"
	print "-x <name>", "Set executable/library name"
	print "-w <value>", "Set min warning level"

end sub


'':::::
sub setDefaultOptions

	fbSetDefaultOptions( )

	fbc.compileonly = FALSE
	fbc.preserveasm	= FALSE
	fbc.verbose		= FALSE
	fbc.debug 		= FALSE
	fbc.stacksize	= FB_DEFSTACKSIZE
	fbc.outtype 	= FB_OUTTYPE_EXECUTABLE
	fbc.target		= fbGetOption( FB_COMPOPT_TARGET )
	fbc.naming		= fbGetOption( FB_COMPOPT_NAMING )
	fbc.cputype		= fbGetOption( FB_COMPOPT_CPUTYPE )
	fbc.warnlevel	= fbGetOption( FB_COMPOPT_WARNINGLEVEL )

end sub

'':::::
function processOptions as integer
    dim i as integer

	function = FALSE

	''
	for i = 0 to argc-1

		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( argv(i)[0] = asc( "-" ) ) then

			if( len( argv(i) ) = 1 ) then
				exit function
			end if

			select case mid$( argv(i), 2 )

			'' compiler options, will be processed by processCompOptions
			case "e", "ex", "mt", "profile", _
				 "nodeflibs", "noerrline", "nostdcall", _
				 "nounderscore", "export", "underscore", "stdcall"

			'' cpu type
			case "arch"
				select case argv(i+1)
				case "386"
					fbc.cputype = FB_CPUTYPE_386
				case "486"
					fbc.cputype = FB_CPUTYPE_486
				case "586"
					fbc.cputype = FB_CPUTYPE_586
				case "686"
					fbc.cputype = FB_CPUTYPE_686
				case else
					exit function
				end select

				argv(i) = ""
				argv(i+1) = ""

			'' debug symbols
			case "g"
				fbc.debug = TRUE

				argv(i) = ""

			'' don't link
			case "c"
				fbc.compileonly = TRUE

				argv(i) = ""

			'' dll
			case "dylib", "dll"
				fbc.outtype = FB_OUTTYPE_DYNAMICLIB

				argv(i) = ""

			'' no std entry-point
			case "entry"
				fbc.entrypoint = argv(i+1)
				if( len( fbc.entrypoint ) = 0 ) then
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' static lib
			case "lib"
				fbc.outtype = FB_OUTTYPE_STATICLIB

				argv(i) = ""

			'' preserve asm
			case "r"
				fbc.preserveasm = TRUE

				argv(i) = ""

			'' verbose
			case "v"
				fbc.verbose = TRUE

				argv(i) = ""

			'' compiler version
			case "version"
				fbc.showversion = TRUE

				argv(i) = ""

			'' out name
			case "x"
				fbc.outname = argv(i+1)
				if( len( fbc.outname ) = 0 ) then
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' main module
			case "m"
				fbc.entrypoint = hMakeEntryPointName( hStripPath( hStripExt( argv(i+1) ) ) )
				if( len( fbc.entrypoint ) = 0 ) then
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' warning level
			case "w"
				if( argv(i+1) = "all" ) then
					fbc.warnlevel = 0
				else
					fbc.warnlevel = valint( argv(i+1) )
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' library paths
			case "p"
				if( not fbAddLibPath( argv(i+1) ) ) then
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' include paths
			case "i"
				fbc.inclist(fbc.incs) = argv(i+1)
				if( len( fbc.inclist(fbc.incs) ) = 0 ) then
					exit function
				end if
				fbc.incs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' defines
			case "d"
				fbc.deflist(fbc.defs) = argv(i+1)
				if( len( fbc.deflist(fbc.defs) ) = 0 ) then
					exit function
				end if
				fbc.defs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' source files
			case "b"
				fbc.inplist(fbc.inps) = argv(i+1)
				if( len( fbc.inplist(fbc.inps) ) = 0 ) then
					exit function
				end if
				fbc.inps += 1

				argv(i) = ""
				argv(i+1) = ""

			'' outputs
			case "o"
				fbc.outlist(fbc.outs) = argv(i+1)
				if( len( fbc.outlist(fbc.outs) ) = 0 ) then
					exit function
				end if
				fbc.outs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' objects
			case "a"
				fbc.objlist(fbc.objs) = argv(i+1)
				if( len( fbc.objlist(fbc.objs) ) = 0 ) then
					exit function
				end if
				fbc.objs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' libraries
			case "l"
				fbc.liblist(fbc.libs) = argv(i+1)
				if( len( fbc.liblist(fbc.libs) ) = 0 ) then
					exit function
				end if
				fbc.libs += 1

				argv(i) = ""
				argv(i+1) = ""

			case else
				if( not fbc.processOptions( argv(i), argv(i+1) ) ) then
					hReportErrorEx( FB_ERRMSG_INVALIDCMDOPTION, "\"" + argv(i) + "\"", -1 )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""
			end select
		end if

	next i

	function = TRUE

end function

'':::::
function processCompOptions as integer
    dim i as integer

	function = FALSE

	'' reset options
	fbSetDefaultOptions( )

	''
	for i = 0 to argc-1

		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( argv(i)[0] = asc( "-" ) ) then

			if( len( argv(i) ) = 1 ) then
				exit function
			end if

			select case mid$( argv(i), 2 )
			case "e"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )

			case "ex"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )

			case "mt"
				fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )

			case "profile"
				fbSetOption( FB_COMPOPT_PROFILE, TRUE )

			case "noerrline"
				fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )

			case "nodeflibs"
				fbSetOption( FB_COMPOPT_NODEFLIBS, TRUE )

			case "export"
				fbSetOption( FB_COMPOPT_EXPORT, TRUE )

			case else
				fbc.processCompOptions( argv(i) )

			end select

		else
			hReportErrorEx( FB_ERRMSG_INVALIDCMDOPTION, "\"" + argv(i) + "\"", -1 )
			exit function
		end if

	next i

	''
	fbc.setCompOptions( )

	fbSetOption( FB_COMPOPT_TARGET, fbc.target )
	fbSetOption( FB_COMPOPT_NAMING, fbc.naming )
	fbSetOption( FB_COMPOPT_DEBUG, fbc.debug )
	fbSetOption( FB_COMPOPT_OUTTYPE, fbc.outtype )
	fbSetOption( FB_COMPOPT_CPUTYPE, fbc.cputype )
	fbSetOption( FB_COMPOPT_WARNINGLEVEL, fbc.warnlevel )

	function = TRUE

end function

'':::::
function processCompLists as integer
    dim i as integer, p as integer
    dim dname as string, dtext as string

	function = FALSE

    '' add inc files
    for i = 0 to fbc.incs-1
    	fbAddIncPath( fbc.inclist(i) )
    next i

    '' add defines
    for i = 0 to fbc.defs-1
    	p = instr( fbc.deflist(i), "=" )
    	if( p = 0 ) then
    		p = len( fbc.deflist(i) ) + 1
    	end if

    	dname = left$( fbc.deflist(i), p-1 )

		if( p < len( fbc.deflist(i) ) ) then
			dtext = mid$( fbc.deflist(i), p+1 )
		else
			dtext = "1"
    	end if

    	fbAddDefine( dname, dtext )
    next i

    function = FALSE

end function

'':::::
function listFiles as integer
    dim i as integer

	function = FALSE

	''
	for i = 0 to argc-1
		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		select case hGetFileExt( argv(i) )
		case "bas"
			fbc.inplist(fbc.inps) = argv(i)
			fbc.inps += 1
			argv(i) = ""
		case "a"
			fbc.liblist(fbc.libs) = argv(i)
			fbc.libs += 1
			argv(i) = ""
		case "o"
			fbc.objlist(fbc.objs) = argv(i)
			fbc.objs += 1
			argv(i) = ""

		case else
			if( fbc.listFiles( argv(i) ) ) then
				argv(i) = ""
			end if
		end select
	next i

	function = TRUE

end function

'':::::
sub parseCmd ( argc as integer, argv() as string )
    dim cmd as string
    dim p as integer, char as uinteger
    dim isstr as integer

	cmd = command$ + "\r"

	p = 0
	argc = 0

	do
		do
			char = cmd[p]
			p += 1
		loop while ( (char = 32) or (char = 7) )

		if( char = 13 ) then exit do

		isstr = 0
		do
			if( char = 34 ) then
				isstr = not isstr
            else
				argv(argc) += chr$( char )
			end if

			char = cmd[p]
			p += 1

			if( not isstr ) then
				if( (char = 32) or (char = 7) ) then
					exit do
				end if
			end if

		loop until ( char = 13 )

		argc += 1
		if( argc >= FB_MAXARGS ) then
			exit do
		end if
	loop while ( char <> 13 )

end sub

'':::::
sub getLibList

	fbc.libs = fbListLibs( fbc.liblist(), fbc.libs )

end sub

'':::::
public function fbAddLibPath ( byval path as string ) as integer
	dim i as integer

	function = FALSE

	if( ( len( path ) = 0 ) or ( fbc.pths = FB_MAXARGS-1 ) ) then
		exit function
	end if

	function = TRUE

	for i = 0 to fbc.pths-1
		if( fbc.pthlist(i) = path ) then
			exit function
		end if
	next i

	fbc.pthlist(fbc.pths) = path
	fbc.pths += 1

end function


