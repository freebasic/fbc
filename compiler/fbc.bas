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


defint a-z
option explicit

'$include: 'inc\fb.bi'
'$include: 'inc\hlp.bi'

const FB_MINSTACKSIZE =   32 * 1024
const FB_DEFSTACKSIZE = 1024 * 1024

type FBCCTX
    libs			as integer
    objs			as integer
    inps			as integer
    outs			as integer
    defs			as integer
    incs			as integer

	compileonly		as integer
	preserveasm		as integer
	verbose			as integer
	debug 			as integer
	stacksize		as integer

	exefile 		as string
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
declare function 	delFiles 			( ) as integer


''globals
	dim shared argc as integer, argv(0 to 99) as string
	dim shared inplist(0 to 99) as string
	dim shared asmlist(0 to 99) as string
	dim shared outlist(0 to 99) as string
	dim shared liblist(0 to 99) as string
	dim shared objlist(0 to 99) as string
	dim shared deflist(0 to 99) as string
	dim shared inclist(0 to 99) as string
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
    if( (not listFiles) or (ctx.inps = 0) ) then
    	printOptions
    	end 1
    end if

    ''
    if( not processOptions ) then
    	printOptions
    	end 1
    end if

    ''
    if( ctx.verbose ) then
    	print "FreeBASIC Compiler - Version " + FB.VERSION
    	print "Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)"
    	print
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
    	if( not linkFiles ) then
    		end 1
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
    		end 1
    	end if

    	'' init the parser
    	if( not fbcInit ) then
    		end 1
    	end if

    	'' add include paths and defines
    	processCompLists

    	'' if no output file define, assume it's the same name as input, with the .o extension
    	if( len( outlist(i) ) = 0 ) then
    		outlist(i) = hStripExt( inplist(i) ) + ".o"
    	end if

    	'' create output asm name
    	asmlist(i) = hStripExt( outlist(i) ) + ".asm"

    	if( ctx.verbose ) then
    		print "compiling: ", inplist(i); " -o "; asmlist(i)
    	end if

    	if( not fbcCompile( inplist(i), asmlist(i) ) ) then
    		end 1
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
#endif
#ifdef TARGET_LINUX
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

	linkFiles = FALSE

	QUOTE = chr$( 34 )

	'' if no executable name was defined, assume it's the same as the first source file
	if( len( ctx.exefile ) = 0 ) then
		ctx.exefile = hStripExt( inplist(0) )
#ifdef TARGET_WIN32
		ctx.exefile = ctx.exefile + ".exe"
#endif
	end if

    '' if entry point was not defined, assume it's at the first source file
	if( len( ctx.entrypoint ) = 0 ) then
		ctx.entrypoint = hStripPath( hStripExt( inplist(0) ) )
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
#endif
#ifdef TARGET_LINUX
	ldcline = "-dynamic-linker /lib/ld-linux.so.2"
#endif

	if( not ctx.debug ) then
		ldcline = ldcline + " -s"
	end if

#ifdef TARGET_WIN32
	'' stack size
	ldcline = ldcline + " --stack " + str$( ctx.stacksize ) + "," + + str$( ctx.stacksize )
#endif

	'' set entry point
	ldcline = ldcline + " -e fb_" + ctx.entrypoint + "_entry "

    '' add objects from output list
    for i = 0 to ctx.inps-1
    	ldcline = ldcline + QUOTE + outlist(i) + QUOTE + " "
    next i

    '' add objects from cmm-line
    for i = 0 to ctx.objs-1
    	ldcline = ldcline + QUOTE + objlist(i) + QUOTE + " "
    next i

    '' set executable name
    ldcline = ldcline + "-o " + QUOTE + ctx.exefile + QUOTE

    '' default lib path
    ldcline = ldcline + " -L " + QUOTE + exepath$ + FB.LIBPATH + QUOTE

    '' init lib group
    ldcline = ldcline + " -( "

    '' add libraries from cmm-line and found when parsing
    for i = 0 to ctx.libs-1
    	ldcline = ldcline + "-l" + liblist(i) + " "
    next i

    '' end lib group
    ldcline = ldcline + "-) "

    '' invoke ld
    if( ctx.verbose ) then
    	print "linking: ", ldcline
    end if

#ifdef TARGET_WIN32
	ldpath = exepath$ + FB.BINPATH + "ld.exe"
#endif
#ifdef TARGET_LINUX
	ldpath = "ld"
#endif
    if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
    end if

    linkFiles = TRUE

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
	print "-e", "add error checking"
	print "-g", "add debug info (testing)"
	print "-i <name>", "add a path to search for include files"
	print "-l <name>", "add a library file to linker's list"
	print "-m <name>", "main file w/o .ext (entry point)"
	print "-o <name>", "output name (in the same number as source files)"
	print "-r", "do not delete the asm file(s)"
#ifdef TARGET_WIN32
	print "-s <name>", "subsystem (gui, console)"
	print "-t <value>", "stack size in kbytes (default: 1M)"
#endif
	print "-v", "verbose"
	print "-x <name>", "executable name"

end sub

'':::::
sub setDefaultOptions

	ctx.compileonly = FALSE
	ctx.preserveasm	= FALSE
	ctx.verbose		= FALSE
	ctx.debug 		= FALSE
	ctx.stacksize	= FB_DEFSTACKSIZE

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

			select case lcase$( mid$( argv(i), 2, 1 ) )
			'' compiler options, will be processed by processCompOptions
			case "g", "e", "w"

			case "c"
				ctx.compileonly = TRUE
				argv(i) = ""

			case "r"
				ctx.preserveasm = TRUE
				argv(i) = ""

			case "v"
				ctx.verbose = TRUE
				argv(i) = ""

			case "x"
				ctx.exefile = argv(i+1)
				if( len( ctx.exefile ) = 0 ) then
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

#ifndef TARGET_WIN32
	fbcSetOption FB.COMPOPT.NOSTDCALL, TRUE
#endif

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

			select case lcase$( mid$( argv(i), 2, 1 ) )
			case "g"
				fbcSetOption FB.COMPOPT.DEBUG, TRUE
				ctx.debug = TRUE
			case "e"
				fbcSetOption FB.COMPOPT.ERRORCHECK, TRUE
#ifdef TARGET_WIN32
			case "w"
				fbcSetOption FB.COMPOPT.NOSTDCALL, TRUE
#endif
			end select
		end if

	next i

	processCompOptions = TRUE

end function

'':::::
function processCompLists as integer
    dim i as integer, p as integer

	processCompLists = FALSE

    '' add inc files
    for i = 0 to ctx.incs-1
    	fbcAddIncPath inclist(i)
    next i

    '' add defines
    for i = 0 to ctx.defs-1
    	p = instr( deflist(i), "=" )
    	if( (p > 0) and (p < len( deflist(i) )) ) then
    		fbcAddDefine left$( deflist(i), p-1 ), mid$( deflist(i), p+1 )
    	end if
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
			select case lcase$( mid$( argv(i), 2, 1 ) )
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
	loop while ( char <> 13 )

end sub

'':::::
sub getLibList

	ctx.libs = ctx.libs + fbcListLibs( liblist(), ctx.libs )

end sub
