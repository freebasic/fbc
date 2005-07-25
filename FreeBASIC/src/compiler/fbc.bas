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
declare function processCompLists 		( ) as integer
declare function processTargetOptions  	( ) as integer
declare sub 	 printOptions			( )
declare sub 	 getLibList 			( )
declare sub 	 initTarget				( )

declare function listFiles 				( ) as integer
declare function compileFiles 			( ) as integer
declare function assembleFiles 			( ) as integer
declare function linkFiles 				( ) as integer
declare function archiveFiles 			( ) as integer
declare function compileResFiles 		( ) as integer
declare function delFiles 				( ) as integer
declare sub 	 setMainModule			( )
declare sub 	 setCompOptions			( )


''globals
	dim shared fbc as FBCCTX

	dim shared argc as integer, argv(0 to FB_MAXARGS-1) as string

    ''
    setDefaultOptions( )

    ''
    parseCmd( argc, argv() )

    if( argc = 0 ) then
    	printOptions( )
    	end 1
    end if

    ''
    if( not processTargetOptions( ) ) then
    	end 1
    end if

    ''
    initTarget( )

    ''
    if( not processOptions( ) ) then
    	end 1
    end if

    ''
    setCompOptions( )

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
    	print "FreeBASIC Compiler - Version "; FB_VERSION; " for "; FB_HOST; " (target:"; FB_TARGET; ")"
    	print "Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)"
    	print
    	if( fbc.showversion ) then
    		end 0
    	end if
    end if

    ''
    fbSetPaths( fbc.target )

    ''
    setMainModule( )

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
sub initTarget( )

	select case as const fbc.target
#if defined(TARGET_WIN32) or defined(CROSSCOMP_WIN32)
	case FB_COMPTARGET_WIN32
		fbcInit_win32( )
#endif

#if defined(TARGET_LINUX) or defined(CROSSCOMP_LINUX)
	case FB_COMPTARGET_LINUX
		fbcInit_linux( )
#endif

#if defined(TARGET_DOS) or defined(CROSSCOMP_DOS)
	case FB_COMPTARGET_DOS
		fbcInit_dos( )
#endif

#if defined(TARGET_XBOX) or defined(CROSSCOMP_XBOX)
	case FB_COMPTARGET_XBOX
		fbcInit_xbox( )
#endif
	end select

end sub

'':::::
sub setCompOptions( )

	fbSetOption( FB_COMPOPT_TARGET, fbc.target )
	fbSetOption( FB_COMPOPT_NAMING, fbc.naming )

	fbSetOption( FB_COMPOPT_DEBUG, fbc.debug )
	fbSetOption( FB_COMPOPT_OUTTYPE, fbc.outtype )

	select case fbc.target
	case FB_COMPTARGET_LINUX
		fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )
		fbSetOption( FB_COMPOPT_NOUNDERPREFIX, TRUE )
	case FB_COMPTARGET_DOS
		fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )
	end select

end sub

'':::::
function compileFiles as integer
	dim as integer i, checkmain, ismain

	function = FALSE

	''
	if( fbc.outtype = FB_OUTTYPE_EXECUTABLE ) then
    	checkmain = TRUE
    else
    	checkmain = fbc.mainset
    end if

    ismain = FALSE

    '' for each input file..
    for i = 0 to fbc.inps-1

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

    	if( checkmain ) then
    		ismain = fbc.mainfile = hStripPath( hStripExt( fbc.inplist(i) ) )
    	end if

    	if( not fbCompile( fbc.inplist(i), fbc.asmlist(i), ismain ) ) then
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
	dim as string aspath, ascline, binpath

	function = FALSE

    '' get path to assembler
    aspath = environ$("AS") '' check the environment variable first
    if len(aspath)=0 then
        '' when not set, then simply use some default value
        binpath = exepath( ) + *fbGetPath( FB_PATH_BIN )

		select case as const fbc.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
			aspath = binpath + "as.exe"

		case FB_COMPTARGET_LINUX
#ifdef TARGET_LINUX
			aspath = *fbGetPath( FB_PATH_BIN ) + "as"
#else
			aspath = binpath + "as.exe"
#endif
		end select
    end if

    ''
    if( not hFileExists( aspath ) ) then
		hReportErrorEx( FB_ERRMSG_EXEMISSING, aspath, -1 )
		exit function
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

    ''
    fbc.outname = hStripFilename( fbc.outname ) + "lib" + _
				  hStripPath( fbc.outname ) + ".a"

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
sub setMainModule( )

	if( len( fbc.mainfile ) = 0 ) then
		if( fbc.inps > 0 ) then
			fbc.mainfile = hStripPath( hStripExt( fbc.inplist(0) ) )
			fbc.mainpath = hStripFilename( fbc.inplist(0) )
		else
			if( fbc.objs > 0 ) then
				fbc.mainfile = hStripPath( hStripExt( fbc.objlist(0) ) )
				fbc.mainpath = hStripFilename( fbc.inplist(0) )
			else
				fbc.mainfile = "undefined"
				fbc.mainpath = ""
			end if
		end if
	end if

	'' if no executable name was defined, use the main module name
	if( len( fbc.outname ) = 0 ) then
		fbc.outname = fbc.mainpath + fbc.mainfile
		fbc.outaddext = TRUE
	end if

end sub

'':::::
sub printOptions( )

	print "Usage: fbc [options] inputlist"
	print
	print "inputlist:", "xxx.a = library, xxx.o = object, xxx.bas = source"
	if( fbc.target = FB_COMPTARGET_WIN32 ) then
		print " "         , "xxx.rc = resource script, xxx.res = compiled resource"
	elseif( fbc.target = FB_COMPTARGET_LINUX ) then
		print " "         , "xxx.xpm = icon resource"
	end if
	print
	print "options:"
	print "-a <name>", "Add an object file to linker's list"
	print "-arch <type>", "Set target architecture (default: 486)"
	print "-b <name>", "Add a source file to compilation"
	print "-c", "Compile only, do not link"
	print "-d <name=val>", "Add a preprocessor's define"
	if( (fbc.target = FB_COMPTARGET_WIN32) or (fbc.target = FB_COMPTARGET_LINUX) ) then
		print "-dll", "Same as -dylib"
		if( fbc.target = FB_COMPTARGET_WIN32 ) then
			print "-dylib", "Create a DLL, including the import library"
		elseif( fbc.target = FB_COMPTARGET_LINUX ) then
			print "-dylib", "Create a shared library"
		end if
	end if
	print "-e", "Add error checking"
	print "-ex", "Add error checking with RESUME support"
	print "-exx", "Same as above plus array bounds and null-pointer checking"
	print "-export", "Export symbols for dynamic linkage"
	print "-g", "Add debug info"
	print "-i <name>", "Add a path to search for include files"
	print "-l <name>", "Add a library file to linker's list"
	print "-lib", "Create a static library"
	print "-m <name>", "Main file w/o ext, the entry point (def: 1st .bas on list)"
	print "-map <name>", "Save the linking map to file name"
	if( fbc.target <> FB_COMPTARGET_DOS ) then
		print "-mt", "Link with thread-safe runtime library"
	end if
	print "-nodeflibs", "Do not include the default libraries"
	print "-noerrline", "Do not show source line where error occured"
	'''''print "-nostdcall", "Treat stdcall calling convention as cdecl"
	'''''print "-nounderscore", "Don't add the underscore prefix to function names"
	print "-o <name>", "Set output name (in the same number as source files)"
	print "-p <name>", "Add a path to search for libraries"
	print "-profile", "Enable function profiling"
	print "-r", "Do not delete the asm file(s)"
	if( fbc.target = FB_COMPTARGET_WIN32 ) then
		print "-s <name>", "Set subsystem (gui, console)"
		print "-t <value>", "Set stack size in kbytes (default: 1M)"
	end if

#if defined(CROSSCOMP_WIN32) or _
	defined(CROSSCOMP_DOS) or _
	defined(CROSSCOMP_LINUX) or _
	defined(CROSSCOMP_XBOX)
	print "-target <name>"; " Cross-compile to:";
 #ifdef CROSSCOMP_DOS
	print " dos";
 #endif
 #ifdef CROSSCOMP_LINUX
	print " linux";
 #endif
 #ifdef CROSSCOMP_WIN32
	print " win32";
 #endif
 #ifdef CROSSCOMP_XBOX
	print " xbox";
 #endif
	print
#endif

	if( fbc.target = FB_COMPTARGET_XBOX ) then
		print "-title <name>", "Set XBE display title"
	end if
	print "-v", "Be verbose"
	print "-version", "Show compiler version"
	print "-x <name>", "Set executable/library name"
	print "-w <value>", "Set min warning level"

end sub


'':::::
sub setDefaultOptions( )

	fbSetDefaultOptions( )

	fbc.compileonly = FALSE
	fbc.preserveasm	= FALSE
	fbc.verbose		= FALSE
	fbc.debug 		= FALSE
	fbc.stacksize	= FB_DEFSTACKSIZE
	fbc.outtype 	= FB_OUTTYPE_EXECUTABLE
	fbc.target		= fbGetOption( FB_COMPOPT_TARGET )
	fbc.naming		= fbGetOption( FB_COMPOPT_NAMING )

	fbc.mainfile	= ""
	fbc.mainpath	= ""
    fbc.mapfile     = ""
	fbc.mainset 	= FALSE
	fbc.outname		= ""
	fbc.outaddext   = FALSE

end sub

'':::::
sub printInvalidOpt( byval argn as integer )

	if( len( argv(argn+1) ) > 0 ) then
		hReportErrorEx( FB_ERRMSG_INVALIDCMDOPTION, "\"" + argv(argn+1) + "\"", -1 )
	else
		hReportErrorEx( FB_ERRMSG_MISSINGCMDOPTION, "\"" + argv(argn) + "\"", -1 )
	end if

end sub

'':::::
function processTargetOptions( ) as integer
    dim i as integer

	function = FALSE

	''
	for i = 0 to argc-1

		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( argv(i)[0] = asc( "-" ) ) then

			if( len( argv(i) ) = 1 ) then
				continue for
			end if

			select case mid( argv(i), 2 )
            ''
			case "target"
				select case argv(i+1)
#if defined(TARGET_DOS) or defined(CROSSCOMP_DOS)
				case "dos"
					fbc.target = FB_COMPTARGET_DOS
#endif

#if defined(TARGET_LINUX) or defined(CROSSCOMP_LINUX)
				case "linux"
					fbc.target = FB_COMPTARGET_LINUX
#endif

#if defined(TARGET_WIN32) or defined(CROSSCOMP_WIN32)
				case "win32"
					fbc.target = FB_COMPTARGET_WIN32
#endif

#if defined(TARGET_XBOX) or defined(CROSSCOMP_XBOX)
				case "xbox"
					fbc.target = FB_COMPTARGET_XBOX
#endif

				case else
					printInvalidOpt( i )
					return FALSE
				end select

				argv(i) = ""
				argv(i+1) = ""

			''
			case "naming"
				select case argv(i+1)
				case "dos"
					fbc.naming = FB_COMPNAMING_DOS

				case "linux"
					fbc.naming = FB_COMPNAMING_LINUX

				case "win32"
					fbc.naming = FB_COMPNAMING_WIN32

				case "xbox"
					fbc.naming = FB_COMPNAMING_XBOX

				case else
					printInvalidOpt( i )
					return FALSE
				end select

				argv(i) = ""
				argv(i+1) = ""

			end select

		end if

	next

	function = TRUE

end function

'':::::
function processOptions( ) as integer
    dim as integer i, value

	function = FALSE

	''
	for i = 0 to argc-1

		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( argv(i)[0] = asc( "-" ) ) then

			if( len( argv(i) ) = 1 ) then
				continue for
			end if

			select case mid( argv(i), 2 )
			case "e"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )

				argv(i) = ""

			case "ex"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )

				argv(i) = ""

			case "exx"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
				fbSetOption( FB_COMPOPT_EXTRAERRCHECK, TRUE )

				argv(i) = ""

			case "mt"
				fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )

				argv(i) = ""

			case "profile"
				fbSetOption( FB_COMPOPT_PROFILE, TRUE )

				argv(i) = ""

			case "noerrline"
				fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )

				argv(i) = ""

			case "nodeflibs"
				fbSetOption( FB_COMPOPT_NODEFLIBS, TRUE )

				argv(i) = ""

			case "export"
				fbSetOption( FB_COMPOPT_EXPORT, TRUE )

				argv(i) = ""

			case "nostdcall"
				fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )

				argv(i) = ""

			case "stdcall"
				fbSetOption( FB_COMPOPT_NOSTDCALL, FALSE )

				argv(i) = ""

			case "nounderscore"
				fbSetOption( FB_COMPOPT_NOUNDERPREFIX, TRUE )

				argv(i) = ""

			case "underscore"
				fbSetOption( FB_COMPOPT_NOUNDERPREFIX, FALSE )

				argv(i) = ""

			'' cpu type
			case "arch"
				select case argv(i+1)
				case "386"
					value = FB_CPUTYPE_386
				case "486"
					value = FB_CPUTYPE_486
				case "586"
					value = FB_CPUTYPE_586
				case "686"
					value = FB_CPUTYPE_686
				case else
					printInvalidOpt( i )
					exit function
				end select

				fbSetOption( FB_COMPOPT_CPUTYPE, value )

				argv(i) = ""
				argv(i+1) = ""

			'' debug symbols
			case "g"
				fbc.debug = TRUE

				argv(i) = ""

			'' don't link
			case "c"
				fbc.outtype = FB_OUTTYPE_OBJECT
				fbc.compileonly = TRUE

				argv(i) = ""

			'' dll
			case "dylib", "dll"
				fbc.outtype = FB_OUTTYPE_DYNAMICLIB

				argv(i) = ""

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
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' main module
			case "m"
				fbc.mainfile = hStripPath( argv(i+1) )
				if( len( fbc.mainfile ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.mainpath = hStripFilename( argv(i+1) )
				fbc.mainset = TRUE

				argv(i) = ""
				argv(i+1) = ""

			'' map file
			case "map"
				fbc.mapfile = argv(i+1)
				if( len( fbc.mapfile ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' warning level
			case "w"
				if( argv(i+1) = "all" ) then
					value = 0
				else
					value = valint( argv(i+1) )
				end if

				fbSetOption( FB_COMPOPT_WARNINGLEVEL, value )

				argv(i) = ""
				argv(i+1) = ""

			'' library paths
			case "p"
				if( not fbAddLibPath( argv(i+1) ) ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			'' include paths
			case "i"
				fbc.inclist(fbc.incs) = argv(i+1)
				if( len( fbc.inclist(fbc.incs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.incs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' defines
			case "d"
				fbc.deflist(fbc.defs) = argv(i+1)
				if( len( fbc.deflist(fbc.defs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.defs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' source files
			case "b"
				fbc.inplist(fbc.inps) = argv(i+1)
				if( len( fbc.inplist(fbc.inps) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.inps += 1

				argv(i) = ""
				argv(i+1) = ""

			'' outputs
			case "o"
				fbc.outlist(fbc.outs) = argv(i+1)
				if( len( fbc.outlist(fbc.outs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.outs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' objects
			case "a"
				fbc.objlist(fbc.objs) = argv(i+1)
				if( len( fbc.objlist(fbc.objs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.objs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' libraries
			case "l"
				fbc.liblist(fbc.libs) = argv(i+1)
				if( len( fbc.liblist(fbc.libs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.libs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' target-dependent options
			case else
				if( not fbc.processOptions( argv(i), argv(i+1) ) ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""
			end select
		end if

	next

	function = TRUE

end function

'':::::
function processCompLists( ) as integer
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

    	dname = left( fbc.deflist(i), p-1 )

		if( p < len( fbc.deflist(i) ) ) then
			dtext = mid( fbc.deflist(i), p+1 )
		else
			dtext = "1"
    	end if

    	fbAddDefine( dname, dtext )
    next i

    function = FALSE

end function

'':::::
function listFiles( ) as integer
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
sub getLibList( )

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


