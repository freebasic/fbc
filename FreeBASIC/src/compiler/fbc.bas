''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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



#include once "inc\fb.bi"
#include once "inc\hash.bi"
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"

declare sub 	 fbcInit( )

declare sub 	 fbcEnd 				(  _
											byval errnum as integer _
										)

declare sub 	 parseCmd 				( _
											byref argc as integer, _
											argv() as string _
										)

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
	dim shared as FBCCTX fbc

	dim shared as integer argc
	dim shared as string argv(0 to FB_MAXARGS-1)

	'' command-line options
	dim shared as FBC_OPTION optionTb(0 to FBC_OPTS-1) = _
	{ _
		( FBC_OPT_E				, @"e"			 ), _
		( FBC_OPT_EX			, @"ex"          ), _
		( FBC_OPT_EXX			, @"exx"         ), _
		( FBC_OPT_MT			, @"mt"          ), _
		( FBC_OPT_PROFILE		, @"profile"     ), _
		( FBC_OPT_NOERRLINE		, @"noerrline"   ), _
		( FBC_OPT_NODEFLIBS		, @"nodeflibs"   ), _
		( FBC_OPT_EXPORT		, @"export"      ), _
		( FBC_OPT_NOSTDCALL		, @"nostdcall"   ), _
		( FBC_OPT_STDCALL		, @"stdcall"     ), _
		( FBC_OPT_NOUNDERSCORE	, @"nounderscore"), _
		( FBC_OPT_UNDERSCORE	, @"underscore"  ), _
		( FBC_OPT_SHOWSUSPERR	, @"showsusperr" ), _
		( FBC_OPT_ARCH			, @"arch"        ), _
		( FBC_OPT_DEBUG			, @"g"           ), _
		( FBC_OPT_COMPILEONLY	, @"c"           ), _
		( FBC_OPT_SHAREDLIB		, @"dylib"       ), _
		( FBC_OPT_SHAREDLIB		, @"dll"         ), _
		( FBC_OPT_STATICLIB		, @"lib"         ), _
		( FBC_OPT_PRESERVEFILES	, @"r"           ), _
		( FBC_OPT_VERBOSE		, @"v"           ), _
		( FBC_OPT_VERSION		, @"version"     ), _
		( FBC_OPT_OUTPUTNAME	, @"x"           ), _
		( FBC_OPT_MAINMODULE	, @"m"           ), _
		( FBC_OPT_MAPFILE		, @"map"         ), _
		( FBC_OPT_MAXERRORS		, @"maxerr"      ), _
		( FBC_OPT_WARNLEVEL		, @"w"           ), _
		( FBC_OPT_LIBPATH		, @"p"           ), _
		( FBC_OPT_INCPATH		, @"i"           ), _
		( FBC_OPT_DEFINE		, @"d"           ), _
		( FBC_OPT_INPFILE		, @"b"           ), _
		( FBC_OPT_OUTFILE		, @"o"           ), _
		( FBC_OPT_OBJFILE		, @"a"           ), _
		( FBC_OPT_LIBFILE		, @"l"           ), _
		( FBC_OPT_INCLUDE		, @"include"     ), _
		( FBC_OPT_LANG			, @"lang"     	 ), _
		( FBC_OPT_WA			, @"Wa"     	 ), _
		( FBC_OPT_WL			, @"Wl"     	 ) _
	}

	'on error goto runtime_err

	''
    fbcInit( )

    ''
    setDefaultOptions( )

    ''
    parseCmd( argc, argv() )

    if( argc = 0 ) then
    	printOptions( )
    	fbcEnd( 1 )
    end if

    ''
    if( processTargetOptions( ) = FALSE ) then
    	fbcEnd( 1 )
    end if

    ''
    initTarget( )

    ''
    if( processOptions( ) = FALSE ) then
    	fbcEnd( 1 )
    end if

    ''
    setCompOptions( )

    '' list
    if( listFiles( ) = FALSE ) then
    	printOptions( )
    	fbcEnd( 1 )
    end if

    ''
    if( fbc.showversion = FALSE ) then
    	if( (fbc.inps = 0) and (fbc.objs = 0) and (fbc.libs = 0) ) then
    		printOptions( )
    		fbcEnd( 1 )
    	end if
    end if

    ''
    if( fbc.verbose or fbc.showversion ) then
    	print "FreeBASIC Compiler - Version "; FB_VERSION; " for "; FB_HOST; " (target:"; FB_TARGET; ")"
    	print "Copyright (C) 2004-2006 The FreeBASIC development team."
    	print
    	if( fbc.showversion ) then
    		fbcEnd( 0 )
    	end if
    end if

    ''
    fbSetPaths( fbc.target )

    ''
    setMainModule( )

    '' compile
    if( compileFiles( ) = FALSE ) then
    	delFiles( )
    	fbcEnd( 1 )
    end if

    '' assemble
   	if( assembleFiles( ) = FALSE ) then
   		delFiles( )
   		fbcEnd( 1 )
   	end if

	if( fbc.compileonly ) then

	else
    	'' link
    	if( fbc.outtype = FB_OUTTYPE_STATICLIB ) then
    		if( archiveFiles( ) = FALSE ) then
    			delFiles( )
    			fbcEnd( 1 )
    		end if

    	else
			'' resource files..
			if( compileResFiles( ) = FALSE ) then
				delFiles( )
				fbcEnd( 1 )
			end if

    		if( linkFiles( ) = FALSE ) then
    			delFiles( )
    			fbcEnd( 1 )
    		end if
    	end if
    end if

    '' del temps
    if( delFiles( ) = FALSE ) then
    	fbcEnd( 1 )
    end if

    fbcEnd( 0 )

runtime_err:
#ifdef erfn
	fbReportRtError( ermn, erfn, err )
#else
	fbReportRtError( NULL, NULL, err )
#endif
	end 1

''':::::
private sub fbcInit( )
    dim as integer i

	hashInit( )

	'' create teh cmd-line options hash
	hashNew( @fbc.opthash, 32, FALSE )

	for i = 0 to FBC_OPTS-1
		hashAdd( @fbc.opthash, _
				 optionTb(i).name, _
				 cast( any ptr, optionTb(i).id ), _
				 INVALID )
	next

end sub

''':::::
private sub fbcEnd _
	(  _
		byval errnum as integer _
	)

    '' free the cmd-line options hash
	hashFree( @fbc.opthash )

	hashEnd( )

	''
	end errnum

end sub

'':::::
private sub initTarget( )

	select case as const fbc.target
#if defined(TARGET_WIN32) or defined(CROSSCOMP_WIN32)
	case FB_COMPTARGET_WIN32
		fbcInit_win32( )
#endif

#if defined(TARGET_CYGWIN) or defined(CROSSCOMP_CYGWIN)
	case FB_COMPTARGET_CYGWIN
		fbcInit_cygwin( )
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
private sub setCompOptions( )

	fbSetOption( FB_COMPOPT_TARGET, fbc.target )

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
private function compileFiles as integer
	dim as integer i, checkmain, ismain

	function = FALSE

	''
	select case fbc.outtype
	case FB_OUTTYPE_EXECUTABLE, FB_OUTTYPE_DYNAMICLIB
    	checkmain = TRUE
    case else
    	checkmain = fbc.mainset
    end select

    ismain = FALSE

    '' for each input file..
    for i = 0 to fbc.inps-1

    	if( checkmain ) then
    		ismain = fbc.mainfile = hStripPath( hStripExt( fbc.inplist(i) ) )
    	end if

    	'' init the parser
    	if( fbInit( ismain ) = FALSE ) then
    		exit function
    	end if

    	'' add include paths and defines
    	processCompLists( )

    	'' if no output file given, assume it's the
    	'' same name as input, with the .o extension
    	if( len( fbc.outlist(i) ) = 0 ) then
    		fbc.outlist(i) = hStripExt( fbc.inplist(i) ) + ".o"
    	end if

    	'' create output asm name
    	fbc.asmlist(i) = hStripExt( fbc.outlist(i) ) + ".asm"

    	if( fbc.verbose ) then
    		print "compiling: ", fbc.inplist(i); " -o "; fbc.asmlist(i)
    	end if

    	if( fbCompile( fbc.inplist(i), _
    				   fbc.asmlist(i), _
    				   ismain, _
    				   fbc.preinclist(), _
    				   fbc.preincs ) = FALSE ) then
    		exit function
    	end if

		'' get list with all referenced libraries
		getLibList( )

		'' shutdown the parser
		fbEnd( )

	next

    '' no default libs would be added if no inp files were given
    if( fbc.inps = 0 ) then
   		fbInit( FALSE )
   		fbAddDefaultLibs( )
   		getLibList( )
   		fbEnd( )
    end if

	function = TRUE

end function

'':::::
private function assembleFiles as integer
	dim i as integer, f as integer
	dim as string aspath, ascline, binpath

	function = FALSE

    '' get path to assembler
    aspath = environ( "AS" ) '' check the environment variable first
    if( len( aspath ) = 0 ) then
        '' when not set, then simply use some default value
        binpath = exepath( ) + *fbGetPath( FB_PATH_BIN )

#ifdef TARGET_LINUX
		aspath = binpath + "as"
#else
		aspath = binpath + "as.exe"
#endif
    end if

    ''
    if( hFileExists( aspath ) = FALSE ) then
		errReportEx( FB_ERRMSG_EXEMISSING, aspath, -1 )
		exit function
    end if

    '' set input files (.asm's) and output files (.o's)
    for i = 0 to fbc.inps-1

    	'' as' options
    	if( fbc.debug = FALSE ) then
			ascline = "--strip-local-absolute "
    	else
    		ascline = ""
    	end if

		ascline += QUOTE + fbc.asmlist(i) + _
				   (QUOTE + " -o " + QUOTE) + _
				   fbc.outlist(i) + (QUOTE) + _
                   fbc.extopt.gas

    	'' invoke as
    	if( fbc.verbose ) then
    		print "assembling: ", aspath + " " + ascline
    	end if

    	if( exec( aspath, ascline ) <> 0 ) then
    		exit function
    	end if
    next

    function = TRUE

end function

'':::::
private function archiveFiles as integer
    dim as integer i
    dim as string arcline

	function = FALSE

    ''
    fbc.outname = hStripFilename( fbc.outname ) + "lib" + _
				  hStripPath( fbc.outname ) + ".a"

    arcline = "-rsc "

    '' output library file name
    arcline += QUOTE + fbc.outname + (QUOTE + " ")

    '' add objects from output list
    for i = 0 to fbc.inps-1
    	arcline += QUOTE + fbc.outlist(i) + (QUOTE + " ")
    next

    '' add objects from cmm-line
    for i = 0 to fbc.objs-1
    	arcline += QUOTE + fbc.objlist(i) + (QUOTE + " ")
    next

    '' invoke ar
    if( fbc.verbose ) then
       print "archiving: ", arcline
    end if

    fbc.archiveFiles( arcline )

    function = TRUE

end function

'':::::
private function linkFiles as integer

	function = fbc.linkFiles( )

end function

'':::::
private function compileResFiles as integer

	function = fbc.compileResFiles( )

end function

'':::::
private function delFiles as integer
	dim as integer i

    function = FALSE

    for i = 0 to fbc.inps-1
		if( fbc.preserveasm = FALSE ) then
			safeKill( fbc.asmlist(i) )
		end if
		if( fbc.compileonly = FALSE ) then
			safeKill( fbc.outlist(i) )
		end if
    next

    function = fbc.delFiles( )

end function

'':::::
private sub setMainModule( )

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
#define printOption(_opt,_desc) print _opt, " "; _desc

'':::::
private sub printOptions( )
	dim as string desc

	print "Usage: fbc [options] inputlist"
	print

	printOption( "inputlist:", "*.a = library, *.o = object, *.bas = source" )
	if( fbc.target = FB_COMPTARGET_WIN32 or fbc.target = FB_COMPTARGET_CYGWIN ) then
		printOption( "", "*.rc = resource script, *.res = compiled resource" )
	elseif( fbc.target = FB_COMPTARGET_LINUX ) then
		printOption( "", "*.xpm = icon resource" )
	end if

	print
	print "options:"

	printOption( "-a <name>", "Add an object file to linker's list" )
	printOption( "-arch <type>", "Set target architecture (default: 486)" )
	printOption( "-b <name>", "Add a source file to compilation" )
	printOption( "-c", "Compile only, do not link" )
	printOption( "-d <name=val>", "Add a preprocessor's define" )
	if( (fbc.target = FB_COMPTARGET_WIN32) or (fbc.target = FB_COMPTARGET_LINUX) ) then
		printOption( "-dll", "Same as -dylib" )
		if( fbc.target = FB_COMPTARGET_WIN32 ) then
			printOption( "-dylib", "Create a DLL, including the import library" )
		elseif( fbc.target = FB_COMPTARGET_LINUX ) then
			printOption( "-dylib", "Create a shared library" )
		end if
	end if
	printOption( "-e", "Add error checking" )
	printOption( "-ex", "Add error checking with RESUME support" )
	printOption( "-exx", "Same as above plus array bounds and null-pointer checking" )
	printOption( "-export", "Export symbols for dynamic linkage" )
	printOption( "-g", "Add debug info" )
	printOption( "-i <name>", "Add a path to search for include files" )
	print "-include <name>"; " Include a header file on each source compiled"
	printOption( "-l <name>", "Add a library file to linker's list" )
	printOption( "-lang <name>", "Select language compatibility: deprecated, qb" )
	printOption( "-lib", "Create a static library" )
	printOption( "-m <name>", "Main file w/o ext, the entry point (def: 1st .bas on list)" )
	printOption( "-map <name>", "Save the linking map to file name" )
	printOption( "-maxerr <val>", "Only stop parsing if <val> errors occurred" )
	if( fbc.target <> FB_COMPTARGET_DOS ) then
		printOption( "-mt", "Link with thread-safe runtime library" )
	end if
	printOption( "-nodeflibs", "Do not include the default libraries" )
	printOption( "-noerrline", "Do not show source line where error occured" )
	printOption( "-o <name>", "Set output name (in the same number as source files)" )
	printOption( "-p <name>", "Add a path to search for libraries" )
	printOption( "-profile", "Enable function profiling" )
	printOption( "-r", "Do not delete the asm file(s)" )
	if( fbc.target = FB_COMPTARGET_WIN32 or fbc.target = FB_COMPTARGET_CYGWIN ) then
		printOption( "-s <name>", "Set subsystem (gui, console)" )
	end if
	if( fbc.target = FB_COMPTARGET_WIN32 or fbc.target = FB_COMPTARGET_CYGWIN or fbc.target = FB_COMPTARGET_DOS) then
		printOption( "-t <value>", "Set stack size in kbytes (default: 1M)" )
	end if

#if defined(CROSSCOMP_WIN32) or _
	defined(CROSSCOMP_CYGWIN) or _
	defined(CROSSCOMP_DOS) or _
	defined(CROSSCOMP_LINUX) or _
	defined(CROSSCOMP_XBOX)
	desc = " Cross-compile to:"
 #ifdef CROSSCOMP_CYGWIN
	desc += " cygwin"
 #endif
 #ifdef CROSSCOMP_DOS
	desc += " dos"
 #endif
 #ifdef CROSSCOMP_LINUX
	desc += " linux"
 #endif
 #ifdef CROSSCOMP_WIN32
	desc += " win32"
 #endif
 #ifdef CROSSCOMP_XBOX
	desc += " xbox"
 #endif

	print "-target <name>"; desc
#endif

	if( fbc.target = FB_COMPTARGET_XBOX ) then
		printOption( "-title <name>", "Set XBE display title" )
	end if
	printOption( "-v", "Be verbose" )
	printOption( "-version", "Show compiler version" )
	printOption( "-w <value>", "Set min warning level: all, pedantic or a value" )
	printOption( "-Wa <opt>", "Pass options to GAS (separated by commas)" )
	printOption( "-Wl <opt>", "Pass options to LD (separated by commas)" )
	printOption( "-x <name>", "Set executable/library name" )

end sub


'':::::
private sub setDefaultOptions( )

	fbSetDefaultOptions( )

	fbc.compileonly = FALSE
	fbc.preserveasm	= FALSE
	fbc.verbose		= FALSE
	fbc.debug 		= FALSE
	fbc.stacksize	= FB_DEFSTACKSIZE
	fbc.outtype 	= FB_OUTTYPE_EXECUTABLE
	fbc.target		= fbGetOption( FB_COMPOPT_TARGET )

	fbc.mainfile	= ""
	fbc.mainpath	= ""
    fbc.mapfile     = ""
	fbc.mainset 	= FALSE
	fbc.outname		= ""
	fbc.outaddext   = FALSE

	fbc.extopt.gas	= ""
	fbc.extopt.ld	= ""

    fbc.libs		= 0
    fbc.objs		= 0
    fbc.inps		= 0
    fbc.outs		= 0
    fbc.defs		= 0
    fbc.incs		= 0
    fbc.pths		= 0
    fbc.preincs		= 0

end sub

'':::::
private sub printInvalidOpt( byval argn as integer )

	if( len( argv(argn+1) ) > 0 ) then
		errReportEx( FB_ERRMSG_INVALIDCMDOPTION, QUOTE + argv(argn+1) + QUOTE, -1 )
	else
		errReportEx( FB_ERRMSG_MISSINGCMDOPTION, QUOTE + argv(argn) + QUOTE, -1 )
	end if

end sub

'':::::
private function processTargetOptions( ) as integer
    dim as integer i

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

			if( mid( argv(i), 2 ) = "target" ) then
				select case argv(i+1)
#if defined(TARGET_DOS) or defined(CROSSCOMP_DOS)
				case "dos"
					fbc.target = FB_COMPTARGET_DOS
#endif

#if defined(TARGET_CYGWIN) or defined(CROSSCOMP_CYGWIN)
				case "cygwin"
					fbc.target = FB_COMPTARGET_CYGWIN
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

			end if

		end if

	next

	function = TRUE

end function

'':::::
private function processOptions( ) as integer
    dim as integer i, value
    dim as FBC_OPT id

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

			id = cast( FBC_OPT, hashLookUp( @fbc.opthash, _
											strptr( argv(i) ) + 1 ) )

			'' not found?
			if( id = 0 ) then
				'' target-dependent options?
				if( fbc.processOptions( argv(i), argv(i+1) ) = FALSE ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

				continue for
			end if

			select case as const id
			case FBC_OPT_E
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )

				argv(i) = ""

			case FBC_OPT_EX
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )

				argv(i) = ""

			case FBC_OPT_EXX
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
				fbSetOption( FB_COMPOPT_EXTRAERRCHECK, TRUE )

				argv(i) = ""

			case FBC_OPT_MT
				fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )

				argv(i) = ""

			case FBC_OPT_PROFILE
				fbSetOption( FB_COMPOPT_PROFILE, TRUE )

				argv(i) = ""

			case FBC_OPT_NOERRLINE
				fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )

				argv(i) = ""

			case FBC_OPT_NODEFLIBS
				fbSetOption( FB_COMPOPT_NODEFLIBS, TRUE )

				argv(i) = ""

			case FBC_OPT_EXPORT
				fbSetOption( FB_COMPOPT_EXPORT, TRUE )

				argv(i) = ""

			case FBC_OPT_NOSTDCALL
				fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )

				argv(i) = ""

			case FBC_OPT_STDCALL
				fbSetOption( FB_COMPOPT_NOSTDCALL, FALSE )

				argv(i) = ""

			case FBC_OPT_NOUNDERSCORE
				fbSetOption( FB_COMPOPT_NOUNDERPREFIX, TRUE )

				argv(i) = ""

			case FBC_OPT_UNDERSCORE
				fbSetOption( FB_COMPOPT_NOUNDERPREFIX, FALSE )

				argv(i) = ""

			case FBC_OPT_SHOWSUSPERR
				fbSetOption( FB_COMPOPT_SHOWSUSPERRORS, FALSE )

				argv(i) = ""

			case FBC_OPT_ARCH
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

			case FBC_OPT_DEBUG
				fbc.debug = TRUE

				argv(i) = ""

			case FBC_OPT_COMPILEONLY
				fbc.outtype = FB_OUTTYPE_OBJECT
				fbc.compileonly = TRUE

				argv(i) = ""

			case FBC_OPT_SHAREDLIB
				fbc.outtype = FB_OUTTYPE_DYNAMICLIB

				argv(i) = ""

			case FBC_OPT_STATICLIB
				fbc.outtype = FB_OUTTYPE_STATICLIB

				argv(i) = ""

			case FBC_OPT_PRESERVEFILES
				fbc.preserveasm = TRUE

				argv(i) = ""

			case FBC_OPT_VERBOSE
				fbc.verbose = TRUE

				argv(i) = ""

			case FBC_OPT_VERSION
				fbc.showversion = TRUE

				argv(i) = ""

			case FBC_OPT_OUTPUTNAME
				fbc.outname = argv(i+1)
				if( len( fbc.outname ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_MAINMODULE
				fbc.mainfile = hStripPath( argv(i+1) )
				if( len( fbc.mainfile ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.mainpath = hStripFilename( argv(i+1) )
				fbc.mainset = TRUE

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_MAPFILE
				fbc.mapfile = argv(i+1)
				if( len( fbc.mapfile ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_MAXERRORS
				if( argv(i+1) = "inf" ) then
					value = FB_ERR_INFINITE
				else
					value = valint( argv(i+1) )
					if( value <= 0 ) then
						value = 1
						printInvalidOpt( i )
					end if
				end if

				fbSetOption( FB_COMPOPT_MAXERRORS, value )

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_WARNLEVEL

				value = -2

				select case argv(i+1)
				case "all"
					value = -1

				case "param"
					fbSetOption( FB_COMPOPT_PEDANTICCHK, _
								 fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_PARAMMODE )

				case "escape"
					fbSetOption( FB_COMPOPT_PEDANTICCHK, _
								 fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_ESCSEQ )

				case "pedantic"
					fbSetOption( FB_COMPOPT_PEDANTICCHK, FB_PDCHECK_ALL )
					value = -1

				case else
					value = valint( argv(i+1) )
				end select

				if( value >= -1 ) then
					fbSetOption( FB_COMPOPT_WARNINGLEVEL, value )
				end if

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_LIBPATH
				if( fbAddLibPath( argv(i+1) ) = FALSE ) then
					printInvalidOpt( i )
					exit function
				end if

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_INCPATH
				fbc.inclist(fbc.incs) = argv(i+1)
				if( len( fbc.inclist(fbc.incs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.incs += 1

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_DEFINE
				fbc.deflist(fbc.defs) = argv(i+1)
				if( len( fbc.deflist(fbc.defs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.defs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' source files
			case FBC_OPT_INPFILE
				fbc.inplist(fbc.inps) = argv(i+1)
				if( len( fbc.inplist(fbc.inps) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.inps += 1

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_OUTFILE
				fbc.outlist(fbc.outs) = argv(i+1)
				if( len( fbc.outlist(fbc.outs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.outs += 1

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_OBJFILE
				fbc.objlist(fbc.objs) = argv(i+1)
				if( len( fbc.objlist(fbc.objs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.objs += 1

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_LIBFILE
				fbc.liblist(fbc.libs) = argv(i+1)
				if( len( fbc.liblist(fbc.libs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.libs += 1

				argv(i) = ""
				argv(i+1) = ""

			'' pre-include files
			case FBC_OPT_INCLUDE
				fbc.preinclist(fbc.preincs) = argv(i+1)
				if( len( fbc.preinclist(fbc.preincs) ) = 0 ) then
					printInvalidOpt( i )
					exit function
				end if
				fbc.preincs += 1

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_LANG
				select case lcase( argv(i+1) )
				case "fb"
					value = FB_LANG_FB
				case "deprecated"
					value = FB_LANG_FB_DEPRECATED
				case "qb"
					value = FB_LANG_QB
				case else
					printInvalidOpt( i )
					exit function
				end select

				fbSetOption( FB_COMPOPT_LANG, value )

				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_WA
				fbc.extopt.gas = " " + hReplace( argv(i+1), ",", " " ) + " "
				argv(i) = ""
				argv(i+1) = ""

			case FBC_OPT_WL
				fbc.extopt.ld = " " + hReplace( argv(i+1), ",", " " ) + " "
				argv(i) = ""
				argv(i+1) = ""
			end select
		end if

	next

	function = TRUE

end function

'':::::
private function processCompLists( ) as integer
    dim as integer i, p
    dim as string dname, dtext

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
    next

    function = FALSE

end function

'':::::
private function listFiles( ) as integer
    dim as integer i

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
	next

	function = TRUE

end function

'':::::
private sub parseCmd _
	( _
		byref argc as integer, _
		argv() as string _
	)

	argc = 0
	do
		argv(argc) = command( 1 + argc )
		if( len( argv(argc) ) = 0 ) then
			exit do
		end if
		argc += 1
	loop while( argc < FB_MAXARGS )

end sub

'':::::
private sub getLibList( )

	fbc.libs = fbListLibs( fbc.liblist(), fbc.libs )

end sub

'':::::
function fbAddLibPath ( byval path as zstring ptr ) as integer
	dim as integer i

	function = FALSE

	if( ( len( *path ) = 0 ) or ( fbc.pths = FB_MAXARGS-1 ) ) then
		exit function
	end if

	for i = 0 to fbc.pths-1
		if( fbc.pthlist(i) = *path ) then
			return TRUE
		end if
	next

	fbc.pthlist(fbc.pths) = *path
	fbc.pths += 1

	function = TRUE

end function


