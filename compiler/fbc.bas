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


'' main module
''
'' chng: sep/2004 written [v1ctor]
''		 dec/2004 linux support added [lillo]


defint a-z
option explicit
option private

'$include: 'inc\fb.bi'
'$include: 'inc\hlp.bi'

const FB_MAXARGS	  = 100
const FB_MINSTACKSIZE =   32 * 1024
const FB_DEFSTACKSIZE = 1024 * 1024


type FBCCTX
    libs			as integer
    objs			as integer
    inps			as integer
    outs			as integer
    defs			as integer
    incs			as integer
    pths			as integer

	compileonly		as integer
	preserveasm		as integer
	verbose			as integer
	debug 			as integer
	stacksize		as integer
	outtype			as integer
	showversion		as integer

	outname 		as string
	entrypoint 		as string
	subsystem		as string
end type

declare sub 		parseCmd 			( argc as integer, argv() as string )

declare sub 		setDefaultOptions	( )
declare function 	processOptions		( ) as integer
declare function 	processCompOptions  ( ) as integer
declare function 	processCompLists 	( ) as integer
declare sub 		printOptions		( )
declare sub 		getLibList 			( )

declare function 	listFiles 			( ) as integer
declare function 	compileFiles 		( ) as integer
declare function 	assembleFiles 		( ) as integer
declare function 	linkFiles 			( ) as integer
declare function 	archiveFiles 		( ) as integer
declare function 	delFiles 			( ) as integer
declare function 	makeImpLib 			( dllname as string ) as integer


''globals
	dim shared argc as integer, argv(0 to FB_MAXARGS-1) as string
	dim shared inplist(0 to FB_MAXARGS-1) as string
	dim shared asmlist(0 to FB_MAXARGS-1) as string
	dim shared outlist(0 to FB_MAXARGS-1) as string
	dim shared liblist(0 to FB_MAXARGS-1) as string
	dim shared objlist(0 to FB_MAXARGS-1) as string
	dim shared deflist(0 to FB_MAXARGS-1) as string
	dim shared inclist(0 to FB_MAXARGS-1) as string
	dim shared pthlist(0 to FB_MAXARGS-1) as string
	dim shared ctx as FBCCTX

    ''
    parseCmd argc, argv()

    if( argc = 0 ) then
    	printOptions
    	end 1
    end if

    ''
    setDefaultOptions

    '' list
    if( not listFiles ) then
    	printOptions
    	end 1
    end if

    ''
    if( not processOptions ) then
    	printOptions
    	end 1
    end if

    ''
    if( (ctx.inps = 0) and (not ctx.showversion) ) then
    	printOptions
    	end 1
    end if

    ''
    if( ctx.verbose or ctx.showversion ) then
    	print "FreeBASIC Compiler - Version " + FB.VERSION
    	print "Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)"
    	print
    	if( ctx.showversion ) then
    		end 0
    	end if
    end if

    '' compile
    if( not compileFiles ) then
    	end 1
    end if

    '' assemble
   	if( not assembleFiles ) then
   		end 1
   	end if

	if( not ctx.compileonly ) then
    	'' link
    	if( ctx.outtype <> FB_OUTTYPE_STATICLIB ) then
    		if( not linkFiles ) then
    			end 1
    		end if
    	else
    		if( not archiveFiles ) then
    			end 1
    		end if
    	end if
    end if

    '' del temps
    if( not delFiles ) then
    	end 1
    end if

    end 0

'':::::
function compileFiles as integer
	dim i as integer

	compileFiles = FALSE

    for i = 0 to ctx.inps-1

    	'' this must be done before Init coz rtlib initialization depends on nostdcall to be defined
    	if( not processCompOptions ) then
    		printOptions
    		exit function
    	end if

    	'' init the parser
    	if( not fbcInit ) then
    		exit function
    	end if

    	'' add include paths and defines
    	processCompLists

    	'' if no output file given, assume it's the same name as input, with the .o extension
    	if( len( outlist(i) ) = 0 ) then
    		outlist(i) = hStripExt( inplist(i) ) + ".o"
    	end if

    	'' create output asm name
    	asmlist(i) = hStripExt( outlist(i) ) + ".asm"

    	if( ctx.verbose ) then
    		print "compiling: ", inplist(i); " -o "; asmlist(i)
    	end if

    	if( not fbcCompile( inplist(i), asmlist(i) ) ) then
    		exit function
    	end if

		'' get list with all referenced libraries
		getLibList

		'' shutdown the parser
		fbcEnd

	next i

	compileFiles = TRUE

end function

'':::::
function assembleFiles as integer
	dim i as integer, f as integer
	dim aspath as string, ascline as string
	dim QUOTE as string

	assembleFiles = FALSE

	QUOTE = chr$( 34 )

    ''
#ifdef TARGET_WIN32
    aspath = exepath$ + FB.BINPATH + "as.exe"
#elseif defined(TARGET_LINUX)
	aspath = "as"
#endif

    '' set input files (.asm's) and output files (.o's)
    for i = 0 to ctx.inps-1

    	'' as' options
    	if( not ctx.debug ) then
    		ascline = "--strip-local-absolute "
    	else
    		ascline = ""
    	end if

		ascline = ascline + QUOTE + asmlist(i) + QUOTE + " -o " + QUOTE + outlist(i) + QUOTE + " "

    	'' invoke as
    	if( ctx.verbose ) then
    		print "assembling: ", ascline
    	end if

    	if( exec( aspath, ascline ) <> 0 ) then
    		exit function
    	end if
    next i


    assembleFiles = TRUE

end function

'':::::
function linkFiles as integer
	dim i as integer, f as integer
	dim ldcline as string
	dim ldpath as string
	dim QUOTE as string
#ifdef TARGET_WIN32
	dim libname as string, dllname as string
#endif

	linkFiles = FALSE

	QUOTE = chr$( 34 )

	'' if no executable name was defined, assume it's the same as the first source file
	if( len( ctx.outname ) = 0 ) then
		ctx.outname = hStripExt( inplist(0) )
#ifdef TARGET_WIN32
		select case ctx.outtype
		case FB_OUTTYPE_EXECUTABLE
			ctx.outname = ctx.outname + ".exe"
		case FB_OUTTYPE_DYNAMICLIB
			ctx.outname = ctx.outname + ".dll"
		end select
#elseif defined(TARGET_LINUX)
		select case ctx.outtype
		case FB_OUTTYPE_DYNAMICLIB
			ctx.outname = "lib" + hStripPath( ctx.outname ) + ".so"
		end select
#endif
	end if

    '' if entry point was not defined, assume it's at the first source file
	if( len( ctx.entrypoint ) = 0 ) then
		select case ctx.outtype
		case FB_OUTTYPE_EXECUTABLE
			ctx.entrypoint = "fb_" + hStripPath( hStripExt( inplist(0) ) ) + "_entry"
#ifdef TARGET_WIN32
		case FB_OUTTYPE_DYNAMICLIB
            ctx.entrypoint = "_DLLMAIN"
#endif
		end select
	end if
	hClearName ctx.entrypoint

#ifdef TARGET_WIN32

	'' set default subsystem mode
	if( len( ctx.subsystem ) = 0 ) then
		ctx.subsystem = "console"
	else
		if( ctx.subsystem = "gui" ) then
			ctx.subsystem = "windows"
		end if
	end if

	'' set script file and subsystem
	ldcline = "-T " + QUOTE + exepath$ + FB.BINPATH + "i386pe.x" + QUOTE + " -subsystem " + ctx.subsystem

#elseif defined(TARGET_LINUX)

	if( ctx.outtype = FB_OUTTYPE_EXECUTABLE) then
		ldcline = "-dynamic-linker /lib/ld-linux.so.2"
	end if

#endif

    if( ctx.outtype = FB_OUTTYPE_DYNAMICLIB ) then
#ifdef TARGET_WIN32
		''
		dllname = hStripPath( hStripExt( ctx.outname ) )

		'' create a dll
		ldcline = ldcline + " --dll --enable-stdcall-fixup"

		'' add aliases for functions without @nn
		if( fbcGetOption( FB.COMPOPT.NOSTDCALL ) ) then
	   		ldcline = ldcline + " --add-stdcall-alias"
    	end if

		'' export all global symbols
		ldcline = ldcline + " --export-all-symbols"

    	'' don't export entry points
    	ldcline = ldcline + " --exclude-symbols DLLMAIN@12,_DLLMAIN"
    	for i = 0 to ctx.inps-1
        	ldcline = ldcline + ",fb_" + hStripExt(outlist(i)) + "_entry"
        	ldcline = ldcline + ",fb_" + ucase$(hStripExt(outlist(i))) + "_entry"
    	next i

    	'' don't export any symbol from rtlib
        ldcline = ldcline + " --exclude-libs libfb.a"

#elseif defined(TARGET_LINUX)

		''
		ldcline = "-shared --export-dynamic"

#endif
    end if

	if( not ctx.debug ) then
		ldcline = ldcline + " -s"
	end if

#ifdef TARGET_WIN32
	'' stack size
	ldcline = ldcline + " --stack " + str$( ctx.stacksize ) + "," + + str$( ctx.stacksize )
#endif

	'' set entry point
#ifdef TARGET_WIN32
	ldcline = ldcline + " -e " + ctx.entrypoint + " "
#else
	if ctx.outtype = FB_OUTTYPE_EXECUTABLE then
		ldcline = ldcline + " -e " + ctx.entrypoint + " "
	else
		ldcline = ldcline + " "
	end if
#endif

    '' add objects from output list
    for i = 0 to ctx.inps-1
    	ldcline = ldcline + QUOTE + outlist(i) + QUOTE + " "
    next i

    '' add objects from cmm-line
    for i = 0 to ctx.objs-1
    	ldcline = ldcline + QUOTE + objlist(i) + QUOTE + " "
    next i

    '' set executable name
    ldcline = ldcline + "-o " + QUOTE + ctx.outname + QUOTE

    '' default lib path
    ldcline = ldcline + " -L " + QUOTE + exepath$ + FB.LIBPATH + QUOTE
    '' and the current path to libs search list
    ldcline = ldcline + " -L " + QUOTE +  "./" + QUOTE

    '' add additional user-specified library search paths
    for i = 0 to ctx.pths-1
    	ldcline = ldcline + " -L " + QUOTE + pthlist(i) + QUOTE
    next i

    '' init lib group
    ldcline = ldcline + " -( "

    '' add libraries from cmm-line and found when parsing
    for i = 0 to ctx.libs-1
#ifdef TARGET_WIN32
    	libname = liblist(i)
    	if( ctx.outtype = FB_OUTTYPE_DYNAMICLIB ) then
    		'' check if the lib isn't the dll's import library itself
            if( libname = dllname ) then
            	libname = ""
            end if
    	end if

    	if( len( libname ) > 0 ) then
    		ldcline = ldcline + "-l" + libname + " "
    	end if
#else
		if ctx.outtype = FB_OUTTYPE_EXECUTABLE then
	    	ldcline = ldcline + "-l" + liblist(i) + " "
	    end if
#endif
    next i

    '' end lib group
    ldcline = ldcline + "-) "

#ifdef TARGET_WIN32
    if( ctx.outtype = FB_OUTTYPE_DYNAMICLIB ) then
        '' create the def list to use when creating the import library
        ldcline = ldcline + " --output-def " + QUOTE + dllname + ".def" + QUOTE
	end if
#endif

    '' invoke ld
    if( ctx.verbose ) then
    	print "linking: ", ldcline
    end if

#ifdef TARGET_WIN32
	ldpath = exepath$ + FB.BINPATH + "ld.exe"
#elseif defined(TARGET_LINUX)
	ldpath = "ld"
#endif
    if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
    end if

#ifdef TARGET_WIN32
    if( ctx.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		'' create the import library for the dll built
		if( makeImpLib( dllname ) = FALSE ) then
			exit function
		end if
	end if
#endif

    linkFiles = TRUE

end function

#ifdef TARGET_WIN32
'':::::
function makeDefList( dllname as string ) as integer
	dim pxpath as string
	dim pxcline as string

	makeDefList = FALSE

   	pxpath = exepath$ + FB.BINPATH + "pexports.exe"

   	pxcline = "-o " + dllname + ".dll >" + dllname + ".def"

    '' can't use EXEC coz redirection is needed, damn..
    '''''if( exec( pxpath, pxcline ) <> 0 ) then
	'''''	exit function
    '''''end if

	shell pxpath + " " + pxcline

    makeDefList = TRUE

end function

'':::::
function clearDefList( dllname as string ) as integer
	dim inpf as integer, outf as integer
	dim ln as string

	clearDefList = FALSE

    if( not hFileExists( dllname + ".def" ) ) then
    	exit function
    end if

    inpf = freefile
    open dllname + ".def" for input as #inpf
    outf = freefile
    open dllname + ".clean.def" for output as #outf

    do until eof( inpf )

    	line input #inpf, ln

    	if( right$( ln, 4 ) =  "DATA" ) then
    		ln = left$( ln, len( ln ) - 4 )
    	end if

    	print #outf, ln
    loop

    close #outf
    close #inpf

    kill dllname + ".def"
    rename dllname + ".clean.def", dllname + ".def"

    clearDefList = TRUE

end function

'':::::
function makeImpLib( dllname as string ) as integer
	dim dtpath as string
	dim dtcline as string

	makeImpLib = FALSE

	'' output def list
	'''''if( makeDefList( dllname ) = FALSE ) then
	'''''	exit function
	'''''end if

	'' for some weird reason, LD will declare all functions exported as if they were
	'' from DATA segment, causing an exception (UPPERCASE'd symbols assumption??)
	if( clearDefList( dllname ) = FALSE ) then
		exit function
	end if

	dtpath = exepath$ + FB.BINPATH + "dlltool.exe"

	dtcline = "--def " + dllname + ".def --dllname " + dllname + ".dll --output-lib lib" + dllname + ".dll.a"

    if( exec( dtpath, dtcline ) <> 0 ) then
		exit function
    end if

	''
	kill dllname + ".def"

    makeImpLib = TRUE

end function
#endif


'':::::
function archiveFiles as integer
    dim i as integer
    dim arcpath as string, arcline as string
  	dim QUOTE as string

	archiveFiles = FALSE

	QUOTE = chr$( 34 )

    '' if no exe file name given, assume "lib" + first source name + ".a"
    '' ( exe filename is actually lib filename for static libs )
    if( len( ctx.outname ) = 0 ) then
       ctx.outname = "lib" + hStripPath( hStripExt( inplist(0) ) ) + ".a"
    end if

    arcline = "-rsc "

    '' output library file name
    arcline = arcline + QUOTE + ctx.outname + QUOTE + " "

    '' add objects from output list
    for i = 0 to ctx.inps-1
    	arcline = arcline + QUOTE + outlist(i) + QUOTE + " "
    next i

    '' add objects from cmm-line
    for i = 0 to ctx.objs-1
    	arcline = arcline + QUOTE + objlist(i) + QUOTE + " "
    next i

    '' invoke ar
    if( ctx.verbose ) then
       print "archiving: ", arcline
    end if

#ifdef TARGET_WIN32
	arcpath = exepath$ + FB.BINPATH + "ar.exe"
#elseif defined(TARGET_LINUX)
	arcpath = "ar"
#endif

    if( exec( arcpath, arcline ) <> 0 ) then
		exit function
    end if

    archiveFiles = TRUE

end function

'':::::
function delFiles as integer
	dim i as integer

    delFiles = FALSE

    for i = 0 to ctx.inps-1
		if( not ctx.preserveasm ) then
			kill asmlist(i)
		end if
		if( not ctx.compileonly ) then
			kill outlist(i)
		end if
    next i

    delFiles = TRUE

end function

'':::::
sub printOptions

	print "Usage: fbc [options] inputlist"
	print
	print "inputlist:", "xxx.a = library, xxx.o = object, xxx.bas = source"
	print
	print "options:"
	print "-a <name>", "add an object file to linker's list"
	print "-b <name>", "add a source file to compilation"
	print "-c", "compile only, do not link"
	print "-d <name=val>", "add a preprocessor's define"
	print "-dll", "same as -dylib"
#ifdef TARGET_WIN32
	print "-dylib", "create a DLL, including the import library"
#elseif defined(TARGET_LINUX)
	print "-dylib", "create a shared library"
#endif
	print "-e", "add error checking"
	print "-g", "add debug info (testing)"
	print "-i <name>", "add a path to search for include files"
	print "-l <name>", "add a library file to linker's list"
	print "-lib", "create a static library"
	print "-m <name>", "main file w/o .ext (entry point)"
	print "-o <name>", "output name (in the same number as source files)"
	print "-p <name>", "add a path to search for libraries"
	print "-r", "do not delete the asm file(s)"
#ifdef TARGET_WIN32
	print "-s <name>", "subsystem (gui, console)"
	print "-t <value>", "stack size in kbytes (default: 1M)"
#endif
	print "-v", "verbose"
	print "-version", "show compiler version"
#ifdef TARGET_WIN32
	print "-w", "treat stdcall calling convention as cdecl"
#endif
	print "-x <name>", "executable/library name"

end sub


'':::::
sub setDefaultOptions

	ctx.compileonly = FALSE
	ctx.preserveasm	= FALSE
	ctx.verbose		= FALSE
	ctx.debug 		= FALSE
	ctx.stacksize	= FB_DEFSTACKSIZE
	ctx.outtype 	= FB_OUTTYPE_EXECUTABLE

end sub

'':::::
function processOptions as integer
    dim i as integer

	processOptions = FALSE

	''
	for i = 0 to argc-1

		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( left$( argv(i), 1 ) = "-" ) then

			if( len( argv(i) ) = 1 ) then
				exit function
			end if

			select case mid$( argv(i), 2 )
			case "e", "w"
				'' compiler options, will be processed by processCompOptions

			case "g"
				ctx.debug = TRUE
				argv(i) = ""

			case "c"
				ctx.compileonly = TRUE
				argv(i) = ""

			case "dylib", "dll"
				ctx.outtype = FB_OUTTYPE_DYNAMICLIB
				argv(i) = ""

			case "lib"
				ctx.outtype = FB_OUTTYPE_STATICLIB
				argv(i) = ""

			case "r"
				ctx.preserveasm = TRUE
				argv(i) = ""

			case "v"
				ctx.verbose = TRUE
				argv(i) = ""

			case "version"
				ctx.showversion = TRUE
				argv(i) = ""

			case "x"
				ctx.outname = argv(i+1)
				if( len( ctx.outname ) = 0 ) then
					exit function
				end if
				argv(i) = ""
				argv(i+1) = ""

			case "m"
				ctx.entrypoint = argv(i+1)
				if( len( ctx.entrypoint ) = 0 ) then
					exit function
				end if
				argv(i) = ""
				argv(i+1) = ""

#ifdef TARGET_WIN32
			case "s"
				ctx.subsystem = argv(i+1)
				if( len( ctx.subsystem ) = 0 ) then
					exit function
				end if
				argv(i) = ""
				argv(i+1) = ""

			case "t"
				ctx.stacksize = cint( val( argv(i+1) ) ) * 1024
				if( ctx.stacksize < FB_MINSTACKSIZE ) then
					ctx.stacksize = FB_MINSTACKSIZE
				end if
				argv(i) = ""
				argv(i+1) = ""
#endif

			case else
				exit function
			end select
		end if

	next i

	processOptions = TRUE

end function

'':::::
function processCompOptions as integer
    dim i as integer

	processCompOptions = FALSE

	'' reset options
	fbcSetDefaultOptions

	''
	for i = 0 to argc-1

		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( left$( argv(i), 1 ) = "-" ) then

			if( len( argv(i) ) = 1 ) then
				exit function
			end if

			select case mid$( argv(i), 2 )
			case "e"
				fbcSetOption FB.COMPOPT.ERRORCHECK, TRUE
#ifdef TARGET_WIN32
			case "w"
				fbcSetOption FB.COMPOPT.NOSTDCALL, TRUE
#endif
			end select
		end if

	next i

	''
	fbcSetOption FB.COMPOPT.DEBUG, ctx.debug
	fbcSetOption FB.COMPOPT.OUTTYPE, ctx.outtype
#ifndef TARGET_WIN32
	fbcSetOption FB.COMPOPT.NOSTDCALL, TRUE
#endif

	processCompOptions = TRUE

end function

'':::::
function processCompLists as integer
    dim i as integer, p as integer
    dim dname as string, dtext as string

	processCompLists = FALSE

    '' add inc files
    for i = 0 to ctx.incs-1
    	fbcAddIncPath inclist(i)
    next i

    '' add defines
    for i = 0 to ctx.defs-1
    	p = instr( deflist(i), "=" )
    	if( p = 0 ) then
    		p = len( deflist(i) ) + 1
    	end if

    	dname = left$( deflist(i), p-1 )

		if( p < len( deflist(i) ) ) then
			dtext = mid$( deflist(i), p+1 )
		else
			dtext = "1"
    	end if

    	fbcAddDefine dname, dtext
    next i

    processCompLists = FALSE

end function

'':::::
function getFileExt( fname as string ) as string
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, fname, "." )
		if( p = 0 ) then
			exit do
		end if
		lp = p
	loop

    if( lp = 0 ) then
    	getFileExt = ""
    else
    	getFileExt = lcase$( mid$( fname, lp+1 ) )
    end if

end function

'':::::
function listFiles as integer
    dim i as integer

	listFiles = FALSE

	''
	for i = 0 to argc-1
		if( len( argv(i) ) = 0 ) then
			continue for
		end if

		if( left$( argv(i), 1 ) = "-" ) then
			select case mid$( argv(i), 2 )
			'' source files
			case "b"
				inplist(ctx.inps) = argv(i+1)
				if( len( inplist(ctx.inps) ) = 0 ) then
					exit function
				end if
				ctx.inps = ctx.inps + 1
				argv(i) = ""
				argv(i+1) = ""

			'' outputs
			case "o"
				outlist(ctx.outs) = argv(i+1)
				if( len( outlist(ctx.outs) ) = 0 ) then
					exit function
				end if
				ctx.outs = ctx.outs + 1
				argv(i) = ""
				argv(i+1) = ""

			'' objects
			case "a"
				objlist(ctx.objs) = argv(i+1)
				if( len( objlist(ctx.objs) ) = 0 ) then
					exit function
				end if
				ctx.objs = ctx.objs + 1
				argv(i) = ""
				argv(i+1) = ""

			'' libraries
			case "l"
				liblist(ctx.libs) = argv(i+1)
				if( len( liblist(ctx.libs) ) = 0 ) then
					exit function
				end if
				ctx.libs = ctx.libs + 1
				argv(i) = ""
				argv(i+1) = ""

			'' library paths
			case "p"
				pthlist(ctx.pths) = argv(i+1)
				if( len( pthlist(ctx.pths) ) = 0 ) then
					exit function
				end if
				ctx.pths = ctx.pths + 1
				argv(i) = ""
				argv(i+1) = ""

			'' include paths
			case "i"
				inclist(ctx.incs) = argv(i+1)
				if( len( inclist(ctx.incs) ) = 0 ) then
					exit function
				end if
				ctx.incs = ctx.incs + 1
				argv(i) = ""
				argv(i+1) = ""

			'' defines
			case "d"
				deflist(ctx.defs) = argv(i+1)
				if( len( deflist(ctx.defs) ) = 0 ) then
					exit function
				end if
				ctx.defs = ctx.defs + 1
				argv(i) = ""
				argv(i+1) = ""
			end select

		else
			select case getFileExt( argv(i) )
			case "bas"
				inplist(ctx.inps) = argv(i)
				ctx.inps = ctx.inps + 1
				argv(i) = ""
			case "a"
				liblist(ctx.libs) = argv(i)
				ctx.libs = ctx.libs + 1
				argv(i) = ""
			case "o"
				objlist(ctx.objs) = argv(i)
				ctx.objs = ctx.objs + 1
				argv(i) = ""
			end select
		end if
	next i

	listFiles = TRUE

end function

'':::::
sub parseCmd ( argc as integer, argv() as string )
    dim cmd as string
    dim p as integer, char as integer
    dim isstr as integer

	cmd = command$ + chr$( 13 )

	p = 1
	argc = 0

	do
		do
			char = asc( mid$( cmd, p, 1 ) )
			p = p + 1
		loop while ( (char = 32) or (char = 7) )

		if( char = 13 ) then exit do

		isstr = 0
		do
			if( char = 34 ) then
				isstr = not isstr
            else
				argv(argc) = argv(argc) + chr$( char )
			end if

			char = asc( mid$( cmd, p, 1 ) )
			p = p + 1

			if( not isstr ) then
				if( (char = 32) or (char = 7) ) then
					exit do
				end if
			end if

		loop until ( char = 13 )

		argc = argc + 1
		if( argc >= FB_MAXARGS ) then
			exit do
		end if
	loop while ( char <> 13 )

end sub

'':::::
sub getLibList

	ctx.libs = ctx.libs + fbcListLibs( liblist(), ctx.libs )

end sub
