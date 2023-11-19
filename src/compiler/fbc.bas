'' main module, front-end
''
'' chng: sep/2004 written [v1ctor]
''       dec/2004 linux support added [lillo]
''       jan/2005 dos support added [DrV]

#include once "fb.bi"
#include once "hlp.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "objinfo.bi"

#include once "file.bi"

#if defined( ENABLE_STANDALONE ) and defined( __FB_WIN32__ )
	#define ENABLE_GORC
#endif

enum
	PRINT_HOST
	PRINT_TARGET
	PRINT_X
	PRINT_FBLIBDIR
	PRINT_SHA1
end enum

type FBC_EXTOPT
	gas         as string
	ld          as string
	gcc         as string
end type

type FBCIOFILE
	'' Input file name (usually *.bas, but also *.rc, *.res, *.xpm)
	srcfile         as string     '' input file

	'' Output .o file
	'' - for modules from the command line this points to a node from
	''   fbc.objlist, see also fbcAddObj()
	'' - for example in hCompileFbctinf(), add temporary FBCIOFILE is used,
	''   with objfile pointing to a string var on stack
	objfile         as string ptr

	'' Whether -o was used to override the default .o file name
	is_custom_objfile   as integer
end type

type FBC_OBJINF
	lang        as FB_LANG
	mt          as integer
end type

type FBCCTX
	'' For command line parsing
	optid               as integer     '' Current option
	lastmodule          as FBCIOFILE ptr '' module for last input file, so the default .o name can be overwritten with a following -o filename
	objfile             as string      '' -o filename waiting for next input file
	backend             as integer     '' FB_BACKEND_* given via -gen, or -1 if -gen wasn't given
	cputype             as integer     '' FB_CPUTYPE_* (-arch's argument), or -1
	cputype_is_native   as integer     '' Whether -arch native was used
	asmsyntax           as integer     '' FB_ASMSYNTAX_* from -asm, or -1 if not given

	emitasmonly         as integer     '' write out FB backend output file only (.asm/.c)
	keepasm             as integer     '' preserve FB backend output file (.asm/.c)
	emitfinalasmonly    as integer     '' write out final .asm file only
	keepfinalasm        as integer     '' preserve final .asm
	keepobj             as integer
	verbose             as integer
	showversion         as integer
	showhelp            as integer
	print               as integer     '' PRINT_* (-print option)

	'' Command line input
	modules             as TLIST    '' FBCIOFILE's for input .bas files
	rcs                 as TLIST    '' FBCIOFILE's for input .rc/.res files
	xpm                 as FBCIOFILE '' .xpm input file
	temps               as TSTRSET  '' Temporary files to delete at shutdown
	objlist             as TLIST    '' Objects from command line and from compilation
	libfiles            as TLIST
	libs                as TSTRSET
	libpaths            as TSTRSET
	excludedlibs        as TSTRSET  '' lib names explicitly excluded via -nodeflib option(s)

	'' Final list of libs and paths for linking
	'' (each module can have #inclibs and #libpaths and add more, and for
	'' objinfo emitting only the module-specific libs are wanted, so there
	'' are multiple lists necessary to allow each module to start fresh
	'' with the same input libs)
	finallibs           as TSTRSET
	finallibpaths       as TSTRSET

	outname             as zstring * FB_MAXPATHLEN+1
	mainname            as zstring * FB_MAXPATHLEN+1
	entry               as zstring * FB_MAXNAMELEN+1
	mainset             as integer
	mapfile             as zstring * FB_MAXPATHLEN+1
	subsystem           as zstring * FB_MAXNAMELEN+1
	extopt              as FBC_EXTOPT
#ifndef ENABLE_STANDALONE
	target              as zstring * FB_MAXNAMELEN+1  '' Target system identifier (e.g. a name like "win32", or a GNU triplet) to prefix in front of cross-compiling tool names
	targetprefix        as zstring * FB_MAXNAMELEN+1  '' same, but with "-" appended, if there was a target id given; otherwise empty.
#endif
	xbe_title           as zstring * FB_MAXNAMELEN+1  '' For the '-title <title>' xbox option
	nodeflibs           as integer
	staticlink          as integer
	stripsymbols        as integer

	'' Compiler paths
	prefix              as zstring * FB_MAXPATHLEN+1  '' Path from -prefix or empty
	binpath             as zstring * FB_MAXPATHLEN+1  '' standalone=prefix/bin/target/  normal=prefix/<fbname>/(target|build)prefix
	incpath             as zstring * FB_MAXPATHLEN+1  '' standalone=prefix/inc          normal=prefix/include/<fbname>
	libpath             as zstring * FB_MAXPATHLEN+1  '' standalone=prefix/lib/target   normal=prefix/lib[64]/<fbname>/target

	'' Tool prefix
	buildprefix         as zstring * FB_MAXPATHLEN+1  '' command line option to override target prefix (affects tool names executed)

	objinf              as FBC_OBJINF
end type

enum FBCTOOL
	FBCTOOL_AS = 0
	FBCTOOL_AR
	FBCTOOL_LD
	FBCTOOL_GCC
	FBCTOOL_LLC
	FBCTOOL_CLANG
	FBCTOOL_DLLTOOL
	FBCTOOL_GORC
	FBCTOOL_WINDRES
	FBCTOOL_CXBE
	FBCTOOL_DXEGEN
	FBCTOOL_EMAS
	FBCTOOL_EMAR
	FBCTOOL_EMLD
	FBCTOOL_EMCC
	FBCTOOL__COUNT
end enum

enum FBCTOOLFLAG
	FBCTOOLFLAG_INVALID            = 0  '' tool is disabled
	FBCTOOLFLAG_ASSUME_EXISTS      = 1  '' assume the tool exists
	FBCTOOLFLAG_CAN_USE_ENVIRON    = 2  '' allow path to tool to specified by environment variable
	FBCTOOLFLAG_FOUND              = 4  '' tool was checked for
	FBCTOOLFLAG_RELYING_ON_SYSTEM  = 8  '' tool is expected to be on system PATH

	FBCTOOLFLAG_DEFAULT = FBCTOOLFLAG_ASSUME_EXISTS or FBCTOOLFLAG_CAN_USE_ENVIRON
end enum

type FBCTOOLINFO
	name as zstring * 16
	flags as FBCTOOLFLAG
	path as zstring * (FB_MAXPATHLEN + 1)
end type

#define fbctoolGetFlags( tool, f )   ((fbctoolTB( tool ).flags and (f)) <> 0)
#define fbctoolSetFlags( tool, f )   fbctoolTB( tool ).flags or= f
#define fbctoolUnsetFlags( tool, f ) fbctoolTB( tool ).flags and= not f

'' must be same order as enum FBCTOOL
static shared as FBCTOOLINFO fbctoolTB(0 to FBCTOOL__COUNT-1) = _
{ _
	/' FBCTOOL_AS      '/ ( "as"     , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_AR      '/ ( "ar"     , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_LD      '/ ( "ld"     , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_GCC     '/ ( "gcc"    , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_LLC     '/ ( "llc"    , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_CLANG   '/ ( "clang"  , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_DLLTOOL '/ ( "dlltool", FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_GORC    '/ ( "GoRC"   , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_WINDRES '/ ( "windres", FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_CXBE    '/ ( "cxbe"   , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_DXEGEN  '/ ( "dxe3gen", FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_EMAS    '/ ( "emcc"   , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_EMAR    '/ ( "emar"   , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_EMLD    '/ ( "emcc"   , FBCTOOLFLAG_DEFAULT  ), _
	/' FBCTOOL_EMCC    '/ ( "emcc"   , FBCTOOLFLAG_DEFAULT  )  _
}

declare sub fbcFindBin _
	( _
		byval tool as integer, _
		byref path as string _
	)

declare sub hPrintVersion( byval verbose as integer )

#macro safeKill(f)
	if( kill( f ) <> 0 ) then
	end if
#endmacro

dim shared as FBCCTX fbc

private sub fbcInit( )
	const FBC_INITFILES = 64

	fbc.backend = -1
	fbc.cputype = -1
	fbc.asmsyntax = -1

	listInit( @fbc.modules, FBC_INITFILES, sizeof(FBCIOFILE) )
	listInit( @fbc.rcs, FBC_INITFILES\4, sizeof(FBCIOFILE) )
	strsetInit( @fbc.temps, FBC_INITFILES\4 )
	strlistInit( @fbc.objlist, FBC_INITFILES )
	strlistInit( @fbc.libfiles, FBC_INITFILES\4 )
	strsetInit( @fbc.libs, FBC_INITFILES\4 )
	strsetInit( @fbc.libpaths, FBC_INITFILES\4 )
	strsetInit( @fbc.excludedlibs, FBC_INITFILES\4 )

	strsetInit(@fbc.finallibs, FBC_INITFILES\2)
	strsetInit(@fbc.finallibpaths, FBC_INITFILES\2)

	fbGlobalInit()

#ifdef ENABLE_STRIPALL
	fbc.stripsymbols = TRUE
#endif

	fbc.objinf.lang = fbGetOption( FB_COMPOPT_LANG )

	fbc.print = -1
end sub

private sub hSetOutName( )
	'' Determine the output binary/archive's name if not given via -x
	if( len( fbc.outname ) > 0 ) then
		exit sub
	end if

	'' Creating a static lib?
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_STATICLIB ) then
		fbc.outname = hStripFilename( fbc.mainname ) + _
			"lib" + hStripPath( fbc.mainname ) + ".a"
		exit sub
	end if

	'' Otherwise, we're creating an .exe or DLL/shared lib
	fbc.outname = fbc.mainname

	select case( fbGetOption( FB_COMPOPT_OUTTYPE ) )
	case FB_OUTTYPE_EXECUTABLE
		select case( fbGetOption( FB_COMPOPT_TARGET ) )
		case FB_COMPTARGET_DOS, FB_COMPTARGET_CYGWIN, _
			FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
			'' Note: XBox target creates an .exe first,
			'' then uses cxbe to turn it into an .xbe later
			fbc.outname += ".exe"
		case FB_COMPTARGET_JS
			fbc.outname += ".html"
		end select
	case FB_OUTTYPE_DYNAMICLIB
		select case( fbGetOption( FB_COMPOPT_TARGET ) )
		case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
			fbc.outname += ".dll"
		case FB_COMPTARGET_LINUX, FB_COMPTARGET_DARWIN, _
			FB_COMPTARGET_FREEBSD, FB_COMPTARGET_OPENBSD, _
			FB_COMPTARGET_NETBSD, FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS
			fbc.outname = hStripFilename( fbc.outname ) + _
				"lib" + hStripPath( fbc.outname ) + ".so"
		case FB_COMPTARGET_DOS
			fbc.outname += ".dxe"
		end select
	end select
end sub

private sub fbcEnd( byval errnum as integer )
	'' Clean up temporary files
	dim as TSTRSETITEM ptr file = listGetHead(@fbc.temps.list)
	while( file )
		safeKill( file->s )
		file = listGetNext( file )
	wend

	end errnum
end sub

private sub fbcAddTemp(byref file as string)
	strsetAdd(@fbc.temps, file, 0)
end sub

private sub fbcRemoveTemp(byref file as string)
	strsetDel(@fbc.temps, file)
end sub

private function fbcAddObj( byref file as string ) as string ptr
	'' .o's should be linked/archived in the order they were found on
	'' command line, so callers of this function must take care to preserve
	'' the order...
	dim as string ptr s = listNewNode( @fbc.objlist )
	*s = file
	function = s
end function

private function hGet1stOutputLineFromCommand( byref cmd as string ) as string
	var f = freefile( )
	if( open pipe( cmd, for input, as f ) <> 0 ) then
		exit function
	end if

	dim ln as string
	input #f, ln

	close f
	return ln
end function

'' Pass some arguments to gcc and read the results. Returns an empty string on
'' an error.
private function fbcQueryGcc( byref options as string ) as string
	dim as string path
	fbcFindBin( FBCTOOL_GCC, path )

	select case( fbGetCpuFamily( ) )
	case FB_CPUFAMILY_X86
		path += " -m32"
	case FB_CPUFAMILY_X86_64
		path += " -m64"
	case FB_CPUFAMILY_PPC
		path += " -m32"
	case FB_CPUFAMILY_PPC64, FB_CPUFAMILY_PPC64LE
		path += " -m64"
	end select

	path += options

	dim as integer ff = freefile( )
	if( open pipe( path, for input, as ff ) <> 0 ) then
		exit function
	end if

	dim ret as string
	input #ff, ret

	close ff

	return ret
end function

''
'' Build the path to a certain file in our lib/ directory (or, in case of
'' non-standalone, somewhere in a system directory such as /usr/lib).
''
'' standalone: Will always return the path to lib/<target>/<file>, no matter
''             whether it exists or not - because that's where it should be.
''             This way the "file not found" errors will be prettier.
''
'' normal: Will check lib/ and query gcc if not found. Querying gcc may fail,
''         because of that an empty string may be returned.
''
private function fbcBuildPathToLibFile( byval file as zstring ptr ) as string
	dim as string found

	''
	'' The Standalone build expects to have all needed files in its lib/,
	'' so it needs to do nothing but build up the path and use that.
	''
	'' Normal however wants to use the "system's" files (and only has few
	'' files in its own lib/).
	''
	'' Typically libgcc.a, crtbegin.o, crtend.o will be inside
	'' gcc's sub-directory in lib/gcc/target/version, i.e. Normal can only
	'' find them via 'gcc -print-file-name=foo' (except for hard-coding
	'' against a specific gcc target/version, but that's not a good option).
	''

	found = fbc.libpath + FB_HOST_PATHDIV + *file

#ifndef ENABLE_STANDALONE
	'' Does it exist in our lib/?
	if( hFileExists( found ) ) then
		'' Overrides anything else
		return found
	end if

	'' Not found in our lib/, query the target-specific gcc
	dim as string path
	fbcFindBin( FBCTOOL_GCC, path )

	select case( fbGetCpuFamily( ) )
	case FB_CPUFAMILY_X86
		path += " -m32"
	case FB_CPUFAMILY_X86_64
		path += " -m64"
	case FB_CPUFAMILY_PPC
		path += " -m32"
	case FB_CPUFAMILY_PPC64, FB_CPUFAMILY_PPC64LE
		path += " -m64"
	end select

	path += " -print-file-name=" + *file

	found = hGet1stOutputLineFromCommand( path )
	if( len( found ) = 0 ) then
		exit function
	end if

	if( found = hStripPath( found ) ) then
		exit function
	end if
#endif

	function = found
end function

'' Retrieve the path to a library file, or an empty string if it can't be found.
private function fbcFindLibFile( byval file as zstring ptr ) as string
	dim as string found
	found = fbcBuildPathToLibFile( file )
	if( len( found ) > 0 ) then
		if( hFileExists( found ) = FALSE ) then
			found = ""
		end if
	end if
	function = found
end function

private sub fbcAddDefLibPath(byref path as string)
	strsetAdd(@fbc.finallibpaths, path, TRUE)
end sub

#ifndef ENABLE_STANDALONE
private sub fbcAddLibPathFor( byval libname as zstring ptr )
	dim as string path
	path = hStripFilename( fbcBuildPathToLibFile( libname ) )
	path = pathStripDiv( path )
	if( len( path ) > 0 ) then
		fbcAddDefLibPath( path )
	end if
end sub
#endif

private sub fbcFindBin _
	( _
		byval tool as integer, _
		byref path as string _
	)

	'' Re-use path from last time if possible
	if( fbctoolGetFlags( tool, FBCTOOLFLAG_FOUND ) ) then
		path = fbctoolTB( tool ).path
		exit sub
	end if

	fbctoolUnsetFlags( tool, FBCTOOLFLAG_RELYING_ON_SYSTEM )

	'' a) Use the path from the corresponding environment variable if it's set
	if( (fbctoolTB(tool).flags and FBCTOOLFLAG_CAN_USE_ENVIRON) <> 0 ) then
		path = environ( ucase( fbctoolTB(tool).name ) )
	end if

	if( len( path ) = 0 ) then
		'' b) Try bin/ directory
		#ifndef ENABLE_STANDALONE
			'' normal build, the build/target prefix is already appended to binpath
			path = fbc.binpath + fbctoolTB(tool).name + FB_HOST_EXEEXT
		#else
			'' standalone build, we need to use insert it here
			path = fbc.binpath + fbc.buildprefix + fbctoolTB(tool).name + FB_HOST_EXEEXT
		#endif

		#ifndef ENABLE_STANDALONE
			if( hFileExists( path ) = FALSE ) then
				select case fbGetOption( FB_COMPOPT_BACKEND )
				case FB_BACKEND_GCC
					'' c) Ask GCC where it is, if applicable (GCC might have its
					'' own copy which we must use instead of the system one)
					if( tool = FBCTOOL_AS ) then
						path = fbcQueryGcc( " -print-prog-name=as" )
					elseif( tool = FBCTOOL_LD ) then
						path = fbcQueryGcc( " -print-prog-name=ld" )
					end if
				case FB_BACKEND_GAS, FB_BACKEND_GAS64
					#if defined( __FB_FREEBSD__ )
						'' gas backend? and we are looking for the linker? and we're hosted freebsd?
						'' switch to ld.bfd instead...
						if( tool = FBCTOOL_LD ) then
							fbctoolTB(tool).name = "ld.bfd"
							path = fbc.binpath + fbctoolTB(tool).name + FB_HOST_EXEEXT
						end if
					#endif
				end select
			end if

			if( hFileExists( path ) = FALSE ) then
				'' d) Rely on PATH
				if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
					if( len(fbc.buildprefix) > 0 ) then
						path = fbc.buildprefix + fbctoolTB(tool).name + FB_HOST_EXEEXT
					else
						path = fbc.targetprefix + fbctoolTB(tool).name + FB_HOST_EXEEXT
					end if
				else
					path = fbctoolTB(tool).name
				end if
				fbctoolSetFlags( tool, FBCTOOLFLAG_RELYING_ON_SYSTEM )
			end if
		#endif
	end if

	fbctoolTB( tool ).path = path
	fbctoolSetFlags( tool, FBCTOOLFLAG_FOUND )
end sub

private function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byval tool as integer, _
		byref ln as string _
	) as integer

	dim as integer result = any
	dim as string path

	fbcFindBin( tool, path )

	if( fbc.verbose ) then
		print *action + ": ", path + " " + ln
	end if

	'' Always use exec() on Unix or for standalone because
	'' - Unix exec() already searches the PATH, so shell() isn't needed,
	'' - standalone doesn't use system-wide tools
	#if defined( __FB_UNIX__ ) or defined( ENABLE_STANDALONE )
		result = exec( path, ln )
	#else
		'' Found at bin/?
		if( fbctoolGetFlags( tool, FBCTOOLFLAG_RELYING_ON_SYSTEM ) = FALSE ) then
			result = exec( path, ln )
		else
			result = shell( path + " " + ln )
		end if
	#endif

	if( result = 0 ) then
		function = TRUE
	elseif( result < 0 ) then
		errReportEx( FB_ERRMSG_EXEMISSING, path, -1, FB_ERRMSGOPT_ADDCOLON or FB_ERRMSGOPT_ADDQUOTES )
	else
		'' Report bad exit codes only in verbose mode; normally the
		'' program should already have shown an error message, and the
		'' exit code is only interesting for debugging purposes.
		if( fbc.verbose ) then
			print *action + " failed: '" + path + "' terminated with exit code " + str( result )
		end if
	end if
end function

#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
private function hPutLdArgsIntoFile( byref ldcline as string ) as integer
	dim as string argsfile, ln
	dim as integer f = any

	argsfile = hStripFilename( fbc.outname ) + "ldopt.tmp"

	f = freefile( )
	if( open( argsfile, for output, as #f ) ) then
		exit function
	end if

	''
	'' MinGW ld (including the MinGW-to-DJGPP cross-compiling ld) treats \
	'' backslashes in @files (response files) as escape sequence, so \ must
	'' be escaped as \\. ld seems to behave pretty much like Unixish shells
	'' would: all \'s indicate an escape sequence. (For reference,
	'' binutils/libiberty source code: expandargv(), buildargv())
	''
	'' With DJGPP ld however, \ chars do not seem to indicate escape
	'' sequences, despite the DJGPP FAQ (http://www.delorie.com/djgpp/v2faq/faq16_3.html)
	'' which says that \ is special in some cases such as \" or \\.
	'' Thus we mustn't (and don't need to) use \\ when using DJGPP ld.
	''
	ln = ldcline
	#ifdef __FB_WIN32__
		ln = hReplace( ln, $"\", $"\\" )
	#endif

	print #f, ln

	close #f

	'' Clean up the @file if -R wasn't given
	if( fbc.keepasm = FALSE ) then
		fbcAddTemp( argsfile )
	end if

	if( fbc.verbose ) then
		print "ld options in '" & argsfile & "': ", ldcline
	end if

	ldcline = "@" + argsfile
	function = TRUE
end function
#endif

private function clearDefList(byref deffile as string) as integer
	dim as integer fi = freefile()
	if (open(deffile, for input, as #fi)) then
		return FALSE
	end if

	dim as string cleaned = hStripExt(deffile) + ".clean.def"
	dim as integer fo = freefile()
	if (open(cleaned, for output, as #fo)) then
		close #fi
		return FALSE
	end if

	dim as string ln
	while (eof(fi) = FALSE)
		line input #fi, ln

		if (right(ln, 4) = "DATA") then
			ln = left(ln, len(ln) - 4)
		end if

		print #fo, ln
	wend

	close #fo
	close #fi

	kill(deffile)
	return (name(cleaned, deffile) = 0)
end function

private function hGenerateEmptyDefFile( byref deffile as string ) as integer
	var f = freefile( )
	if( open( deffile, for output, as #f ) ) then
		exit function
	end if

	print #f, "EXPORTS"

	close #f
	function = TRUE
end function

private function makeImpLib _
	( _
		byref dllname as string, _
		byref deffile as string _
	) as integer

	'' for some weird reason, LD will declare all functions exported as if they were
	'' from DATA segment, causing an exception (UPPERCASE'd symbols assumption??)
	if( clearDefList( deffile ) = FALSE ) then
		exit function
	end if

	'' If the .def file is empty (happens if there were no EXPORTs),
	'' then add a single "EXPORTS" line, otherwise dlltool will complain
	'' about a syntax error. (ld --output-def should probably do this
	'' automatically, or dlltool should be fixed, but oh well)
	if( filelen( deffile ) = 0 ) then
		if( hGenerateEmptyDefFile( deffile ) = FALSE ) then
			exit function
		end if
	end if

	dim as string ln
	ln += "--def """ + deffile + """"
	ln += " --dllname """ + hStripPath( fbc.outname ) + """"
	ln += " --output-lib """ + hStripFilename( fbc.outname ) + "lib" + dllname + ".dll.a"""

	if( fbcRunBin( "creating import library", FBCTOOL_DLLTOOL, ln ) = FALSE ) then
		exit function
	end if

	'' Clean up the .def file if -R wasn't given
	if( fbc.keepasm = FALSE ) then
		fbcAddTemp( deffile )
	end if

	function = TRUE
end function

'' Find a library file and wrap it into ""'s for passing it on the ld command
'' line. Or if it couldn't be found, show an error.
private function hFindLib( byval file as zstring ptr ) as string
	dim as string found = fbcBuildPathToLibFile( file )
	if( len( found ) > 0 ) then
		function = " """ + found + """"
	else
		errReportEx( FB_ERRMSG_FILENOTFOUND, file, -1 )
	end if
end function

private function fbcLinkerIsGold( ) as integer
	'' This is needed otherwise it will wrongly pass --version into the linker on Solaris
	'' caused the linker version to be printed everytime we compile with fbc
	if(fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_SOLARIS) then
		return FALSE
	else
		dim ldcmd as string
		fbcFindBin( FBCTOOL_LD, ldcmd )
		ldcmd += " --version"
		return (instr( hGet1stOutputLineFromCommand( ldcmd ), "GNU gold" ) > 0)
	end if
end function

'' Check whether we're using the gold linker.
private function fbcIsUsingGoldLinker( ) as integer
	'' gold only supports ELF, we only need to check for it when targetting ELF.
	if( fbTargetSupportsELF( ) ) then
		return fbcLinkerIsGold( )
	end if
	return FALSE
end function

private function hLinkFiles( ) as integer
	dim as string ldcline, dllname, deffile

	function = FALSE

	hSetOutName( )

	select case( fbGetOption( FB_COMPOPT_TARGET ) )
	case FB_COMPTARGET_WIN32
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86
			ldcline += "-m i386pe "
		case FB_CPUFAMILY_X86_64
			ldcline += "-m i386pep "
		end select
	case FB_COMPTARGET_LINUX
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86
			ldcline += "-m elf_i386 "
		case FB_CPUFAMILY_X86_64
			ldcline += "-m elf_x86_64 "
		case FB_CPUFAMILY_ARM
			ldcline += "-m armelf_linux_eabi "
		end select
	case FB_COMPTARGET_DARWIN
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86
			ldcline += "-arch i386 "
		case FB_CPUFAMILY_X86_64
			ldcline += "-arch x86_64 "
		case FB_CPUFAMILY_ARM
			'' fixme: this is clearly too specific
			ldcline += "-arch armv6 "
		end select
	end select

	'' Set executable name
	ldcline += "-o " + QUOTE + fbc.outname + QUOTE

	'' dll dos targets need to run DXE3GEN
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) and _
	(fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB) then
		'' Building an import library is usable but need to watch
		'' the initialization order.  libfb exports need to be
		'' initialized before trying to load the DXE.  FYI, if this
		'' is handled at load time by the loader code (global
		'' constructor) user may have issues with the ctor order.
		'' Which means that user is expected to have called
		'' defined a call to DyLibLoad("") in a global ctor and
		'' no other global ctors that depend on libfb functions
		''
		ldcline += " -I ""lib" + hStripExt( fbc.outname ) + "_il.a"""
		''
		'' the -U switch allows the DXE to be created with unresolved
		'' symbols.  FYI, we won't know which symbols are needed until
		'' the loader tries to load the DXE.  This seems to be the only
		'' kind we can make (i.e. not possible to build a fully resolved DXE
		'' because dxe3gen seems to only resolve with in the current DXE and
		'' not any statically linked library)
		''
		ldcline += " -U"
		''
		scope
			dim as string ptr objfile = listGetHead( @fbc.objlist )
			while( objfile )
				ldcline += " """ + *objfile + """"
				objfile = listGetNext( objfile )
			wend
		end scope
		scope
			dim as string ptr libfile = listGetHead(@fbc.libfiles)
			if (libfile) then
				ldcline +=  " -lc"
			end if
			while (libfile)
				ldcline += " """ + *libfile + """"
				libfile = listGetNext(libfile)
			wend
		end scope
		#ifdef __FB_DOS__
			'' windows (maybe others) version of DXE3GEN doesn't seem to be able
			'' to handle @ldopt.tmp argument when cross compiling - only write to
			'' lpopt.tmp if we are hosted on DOS
			if( hPutLdArgsIntoFile( ldcline ) = FALSE ) then
				exit function
			end if
		#endif
		#ifdef ENABLE_STANDALONE
			dim as string dxepath = environ( "DXE_LD_LIBRARY_PATH" )
			if( dxepath = "" ) then
				setenviron "DXE_LD_LIBRARY_PATH=" + fbc.libpath + FB_HOST_PATHDIV
				if( fbc.verbose ) then
					print "DXE_LD_LIBRARY_PATH=" + fbc.libpath + FB_HOST_PATHDIV
				end if
			end if
		#endif
		function = fbcRunBin( "making DXE", FBCTOOL_DXEGEN, ldcline )
		exit function
	end if

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32

		'' set default subsystem mode
		if( len( fbc.subsystem ) = 0 ) then
			fbc.subsystem = "console"
		else
			if( fbc.subsystem = "gui" ) then
				fbc.subsystem = "windows"
			end if
		end if

		ldcline += " -subsystem " + fbc.subsystem

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			''
			dllname = hStripPath( hStripExt( fbc.outname ) )

			'' create a dll
			ldcline += " --dll --enable-stdcall-fixup"

			'' Specify the DLL entry-point, like gcc:
			'' with underscore and @N stdcall suffix on x86,
			'' but without that for x86_64.
			if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86 ) then
				ldcline += " -e _DllMainCRTStartup@12"
			else
				ldcline += " -e DllMainCRTStartup"
			end if
		end if

	case FB_COMPTARGET_LINUX, FB_COMPTARGET_DARWIN, _
		FB_COMPTARGET_FREEBSD, FB_COMPTARGET_OPENBSD, _
		FB_COMPTARGET_NETBSD, FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			dllname = hStripPath( hStripExt( fbc.outname ) )
			ldcline += " -shared -h" + hStripPath( fbc.outname )

			'' Turn libfoo into foo, so it can be checked against -l foo below
			if( left( dllname, 3 ) = "lib" ) then
				dllname = right( dllname, len( dllname ) - 3 )
			end if
		else
			select case as const fbGetOption( FB_COMPOPT_TARGET )
			case FB_COMPTARGET_FREEBSD
				ldcline += " -dynamic-linker /libexec/ld-elf.so.1"
			case FB_COMPTARGET_DRAGONFLY
				ldcline += " -dynamic-linker /libexec/ld-elf.so.2"
			case FB_COMPTARGET_SOLARIS
				ldcline += " --dynamic-linker /lib/64/ld.so.1"
			case FB_COMPTARGET_LINUX
				select case( fbGetCpuFamily( ) )
				case FB_CPUFAMILY_X86
					ldcline += " -dynamic-linker /lib/ld-linux.so.2"
				case FB_CPUFAMILY_X86_64
					ldcline += " -dynamic-linker /lib64/ld-linux-x86-64.so.2"
				case FB_CPUFAMILY_ARM
					ldcline += " -dynamic-linker /lib/ld-linux-armhf.so.3"
				case FB_CPUFAMILY_AARCH64
					ldcline += " -dynamic-linker /lib/ld-linux-aarch64.so.1"
				end select
			case FB_COMPTARGET_NETBSD
				ldcline += " -dynamic-linker /usr/libexec/ld.elf_so"
			case FB_COMPTARGET_OPENBSD
				ldcline += " -dynamic-linker /usr/libexec/ld.so"
			end select
		end if

		'' Add all symbols to the dynamic symbol table
		'' The Solaris linker doesn't support --export-dynamic
		'' I don't know the equivalent option for it so I just disable this for Solaris
		'' Don't know the side effects, though
		'' But able to have shared library generated successfully afterward
		if( (fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB) or _
			fbGetOption( FB_COMPOPT_EXPORT ) ) and _
			(fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_SOLARIS) then
			ldcline += " --export-dynamic"
		end if

	case FB_COMPTARGET_XBOX
		ldcline += " -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared"

	case FB_COMPTARGET_JS
		ldcline += " -O" + str( fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) )

		static as zstring*32 emscripten_options(...) = _
		{ _
			"CASE_INSENSITIVE_FS=1", _
			"TOTAL_MEMORY=67108864", _
			"ALLOW_MEMORY_GROWTH=1", _
			"RETAIN_COMPILER_SETTINGS=1", _
			"ASYNCIFY=1" _
		}
			'"WARN_UNALIGNED=1", _

		ldcline += " -Wno-warn-absolute-paths"
		for i as integer = 0 to ubound(emscripten_options)
			ldcline += " -s " + emscripten_options(i)
		next

		ldcline += " --shell-file" + hFindLib("fb_shell.html")
		ldcline += " --post-js" + hFindLib("fb_rtlib.js")
		if( len(fbc.subsystem) = 0 ) then
			ldcline += " --post-js" + hFindLib("termlib_min.js")
		end if

	end select

	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		'' For DJGPP, the custom ldscript must always be used,
		'' to get ctors/dtors into the correct order that lets
		'' fbrt0's c/dtor be the first/last respectively.
		'' (needed until binutils' default DJGPP ldscripts are fixed)
		ldcline += " -T """ + fbc.libpath + (FB_HOST_PATHDIV + "i386go32.x""")
	else
		'' Supplementary ld script to drop the fbctinf objinfo section
		''  - only if objinfo is enabled
		''  - only with ld.bfd, not ld.gold, because gold doesn't support this kind
		''    of linker script (results in broken binaries).

		'' Solaris uses it own linker
		''  - don't know if it support this kind of linker script or not
		''  - so just disable it for the solaris target, too
		''  - the solaris linker will cause major problems
		''  - because of imcompatibilities with the GNU linker
		''  - we can only know if when really testing on the platform
		''  - and adapt the code over time
		if( fbGetOption( FB_COMPOPT_OBJINFO ) and _
			(fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DARWIN) and _
			(fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_SOLARIS) and _
			( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) and _
			(not fbcIsUsingGoldLinker( )) ) then
			ldcline += " -T """ + fbc.libpath + (FB_HOST_PATHDIV + "fbextra.x""")
		end if
	end if

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
		'' stack size
		dim as integer stacksize = fbGetOption(FB_COMPOPT_STACKSIZE)
		ldcline += " --stack " + str(stacksize) + "," + str(stacksize)

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			'' When building DLLs, we also create an import library, as
			'' convenience for the user. There are several ways to do this:
			''    a) ld --output-def + dlltool
			''    b) ld --output-def --out-implib
			''    c) pexports + dlltool
			'' At the moment it seems like "ld --out-implib" alone
			'' does not work, and b) shows a verbose message that
			'' wouldn't be nice to have, so a) is the best way.
			deffile = hStripExt( fbc.outname ) + ".def"
			ldcline += " --output-def """ + deffile + """"
		end if

	case FB_COMPTARGET_XBOX
		'' set entry point
		ldcline += " -e _WinMainCRTStartup"

	end select

	if (fbc.staticlink) then
		ldcline += " -Bstatic"
	end if

	if( len( fbc.mapfile ) > 0) then
		ldcline += " -Map " + fbc.mapfile
	end if

	if( fbGetOption( FB_COMPOPT_DEBUGINFO ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			if(( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DARWIN ) and _
				( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS )) then

				if( fbc.stripsymbols ) then
					ldcline += " -s"
				end if
			end if
		end if
	end if

	'' Add the library search paths
	scope
		dim as TSTRSETITEM ptr i = listGetHead(@fbc.finallibpaths.list)

		dim as string L
		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			L = " -L """
		else
			L = " -L"""
		end if

		while (i)
			ldcline += L + i->s + """"
			i = listGetNext(i)
		wend
	end scope

	'' crt begin objects
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			ldcline += hFindLib( "crt0.o" )
		else
			'' TODO
			ldcline += hFindLib( "crt0.o" )
			'' additional support for gmon
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				ldcline += hFindLib( "gcrt0.o" )
			end if
		end if

	case FB_COMPTARGET_WIN32
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			ldcline += hFindLib( "dllcrt2.o" )
		else
			ldcline += hFindLib( "crt2.o" )
			'' additional support for gmon
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				ldcline += hFindLib( "gcrt2.o" )
			end if
		end if

		ldcline += hFindLib( "crtbegin.o" )

	case FB_COMPTARGET_DOS
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += hFindLib( "gcrt0.o" )
		else
			ldcline += hFindLib( "crt0.o" )
		end if

	case FB_COMPTARGET_LINUX, FB_COMPTARGET_DARWIN, _
		FB_COMPTARGET_FREEBSD, FB_COMPTARGET_OPENBSD, _
		FB_COMPTARGET_NETBSD, FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD
					ldcline += hFindLib( "gcrt0.o" )
				case else
					ldcline += hFindLib( "gcrt1.o" )
				end select
			else
				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD
					ldcline += hFindLib( "crt0.o" )
				case else
					ldcline += hFindLib( "crt1.o" )
				end select
			end if
		end if

		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DARWIN) then
			'' All have crti.o, except OpenBSD and Darwin
			if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
				ldcline += hFindLib( "crti.o" )
			end if

			if( fbGetOption( FB_COMPOPT_PIC ) ) then
				ldcline += hFindLib( "crtbeginS.o" )
			else
				ldcline += hFindLib( "crtbegin.o" )
			end if
		end if

	case FB_COMPTARGET_XBOX
		'' link with crt0.o (C runtime init)
		ldcline += hFindLib( "crt0.o" )

	end select

	if( fbc.nodeflibs = FALSE ) then
		'' don't add the fbrt0 if compiling for javascript, because global constructors and destructors are not supported by emscripten
		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			ldcline += " """ + fbc.libpath + FB_HOST_PATHDIV
			if( fbGetOption( FB_COMPOPT_PIC ) ) then
				ldcline += "fbrt0pic.o"
			else
				ldcline += "fbrt0.o"
			end if
			ldcline += """"
		end if
	end if

	scope
		dim as string ptr objfile = listGetHead( @fbc.objlist )
		while( objfile )
			ldcline += " """ + *objfile + """"
			objfile = listGetNext( objfile )
		wend
	end scope

	'' Begin of lib group
	'' All libraries are passed inside -( -) so we don't need to worry as
	'' much about their order and/or listing them repeatedly.
	if ( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DARWIN ) then
		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			ldcline += " ""-("""
		end if
	end if

	'' Add libraries passed by file name
	scope
		dim as string ptr libfile = listGetHead(@fbc.libfiles)
		while (libfile)
			ldcline += " """ + *libfile + """"
			libfile = listGetNext(libfile)
		wend
	end scope

	'' Add libraries from command-line, those found during parsing, and
	'' the default ones
	scope
		dim as TSTRSETITEM ptr i = listGetHead(@fbc.finallibs.list)
		dim as integer checkdllname = (fbGetOption(FB_COMPOPT_OUTTYPE) = FB_OUTTYPE_DYNAMICLIB)
		while (i)
			'' Prevent linking DLLs against their own import library,
			'' or .so's against themselves (ld will fail to read in
			'' its output file...)
			if ((checkdllname = FALSE) orelse (i->s <> dllname)) then
				ldcline += " -l" + i->s
			end if
			i = listGetNext(i)
		wend
	end scope

	if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DARWIN) then
		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			'' End of lib group
			ldcline += " ""-)"""
		else
			ldcline += " -lfb"
		end if
	end if

	'' crt end
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
		FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD, _
		FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS
		if( fbGetOption( FB_COMPOPT_PIC ) ) then
			ldcline += hFindLib( "crtendS.o" )
		else
			ldcline += hFindLib( "crtend.o" )
		end if
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += hFindLib( "crtn.o" )
		end if

	case FB_COMPTARGET_WIN32
		ldcline += hFindLib( "crtend.o" )

	end select

	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DARWIN ) then
		ldcline += " -macosx_version_min 10.4"
	end if

	'' This is required for 64-bit modules on *nix-y platforms
	'' for the unwind tables to have any effect
	'' Windows doesn't need this option
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
		FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD, _
		FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS, _
		FB_COMPTARGET_DARWIN
		dim as long outtype = fbGetOption( FB_COMPOPT_OUTTYPE )
		if outtype = FB_OUTTYPE_EXECUTABLE OrElse outtype = FB_OUTTYPE_DYNAMICLIB Then
			dim as long cpufamily = fbGetCpuFamily( )
			if cpufamily = FB_CPUFAMILY_X86_64 OrElse cpufamily = FB_CPUFAMILY_AARCH64 OrElse _
				cpuFamily = FB_CPUFAMILY_PPC64 OrElse cpufamily = FB_CPUFAMILY_PPC64LE Then
				ldcline += " --eh-frame-hdr"
			end if
		end if
	end select

	'' extra options
	ldcline += " " + fbc.extopt.ld

	'' On some systems there are certain command line length limits which we
	'' can easily hit with our ld invocation, especially when linking huge
	'' programs, with lots of *.o files with long file names, such as the
	'' FB test suite.
	'' Typically > 127 chars but < 8k, but with huge programs, even > 32k.
	''
	'' On DOS there's a 127 char command line length limit. Our ld command
	'' line will typically be much longer than that, so we use ld's @file
	'' feature ("ld @file") and put the command line into that file.
	''
	'' The same happens on Win32 when we're invoking DOS .exes (some people
	'' use DOS binutils, instead of proper Win32-to-DOS binutils, to compile
	'' for DOS on Win32).
	''
	'' On Win32, there are multiple command line length limits to worry
	'' about:
	''    - cmd.exe (applies to FB shell()): 8192 on Windows XP+,
	''      2047 on Windows NT 4.0/2000
	''    - 32767 for CreateProcess() (applies to FB exec())
	'' fbcRunBin() can use either shell() or exec() depending on whether
	'' it's a normal/standalone build and whether the binutils were found.
	'' For standalone, it will always use exec(), but for non-standalone,
	'' we don't know what it'll do, so we should use the minimum limit.
	'' For shell() the full command line will also include the ld.exe
	'' command, i.e. "[<target>-]ld.exe ", which reduces the amount of room
	'' left over for the ld arguments.
	''
	'' On Linux/BSD systems there's typically some 100k or 200k limit which
	'' we usually don't hit.
	#ifdef __FB_DOS__
		if( hPutLdArgsIntoFile( ldcline ) = FALSE ) then
			exit function
		end if
	#elseif defined( __FB_WIN32__ )
		#ifdef ENABLE_STANDALONE
			'' "cross"-compiling? djgpp cross tools and emscripten
			'' build tools can't seem to handle the long command line
			'' created when linking ./tests/fbc-tests
			select case fbGetOption( FB_COMPOPT_TARGET )
			case FB_COMPTARGET_DOS, FB_COMPTARGET_JS
				if( hPutLdArgsIntoFile( ldcline ) = FALSE ) then
					exit function
				end if
			end select
		#else
			dim toolnamelen as integer = len( "ld.exe " ) + _
				iif( len( fbc.targetprefix ) > len( fbc.buildprefix ), len( fbc.targetprefix ), len( fbc.buildprefix ) )
			if( (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) or _
				(len( ldcline ) > (2047 - toolnamelen)) ) then
				if( hPutLdArgsIntoFile( ldcline ) = FALSE ) then
					exit function
				end if
			end if
		#endif
	#endif

	'' invoke ld
	var ld = FBCTOOL_LD
	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_JS ) then
		ld = FBCTOOL_EMLD
	end if

	if( fbcRunBin( "linking", ld, ldcline ) = FALSE ) then
		exit function
	end if

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_DOS
		'' patch the exe to change the stack size
		dim as integer f = freefile()

		if (open(fbc.outname, for binary, access read write, as #f) <> 0) then
			exit function
		end if

		dim value as long = clng( fbGetOption( FB_COMPOPT_STACKSIZE ) )
		put #f, 533, value

		close #f

	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			'' Create the .dll.a import library from the generated .def
			if (makeImpLib(dllname, deffile) = FALSE) then
				exit function
			end if
		end if

	case FB_COMPTARGET_XBOX
		'' Turn .exe into .xbe
		dim as string cxbepath, cxbecline
		dim as integer res = any

		'' xbe title
		if( len(fbc.xbe_title) = 0 ) then
			fbc.xbe_title = hStripExt(fbc.outname)
		end if

		cxbecline = "-TITLE:" + QUOTE + fbc.xbe_title + (QUOTE + " ")

		if( fbGetOption( FB_COMPOPT_DEBUGINFO ) ) then
			cxbecline += "-DUMPINFO:" + QUOTE + hStripExt(fbc.outname) + (".cxbe" + QUOTE)
		end if

		'' output xbe filename
		cxbecline += " -OUT:" + QUOTE + hStripExt(fbc.outname) + ".xbe" + QUOTE

		'' input exe filename
		cxbecline += " " + QUOTE + fbc.outname + QUOTE

		'' don't echo cxbe output
		if( fbc.verbose = FALSE ) then
			cxbecline += " >nul"
		end if

		'' invoke cxbe (exe -> xbe)
		if( fbc.verbose ) then
			print "cxbe: ", cxbecline
		end if

		fbcFindBin( FBCTOOL_CXBE, cxbepath )

		'' have to use shell instead of exec in order to use >nul
		res = shell(cxbepath + " " + cxbecline)
		if( res <> 0 ) then
			if( fbc.verbose ) then
				print "cxbe failed: exit code " & res
			end if
			exit function
		end if

		'' remove .exe
		kill fbc.outname

	end select

	function = TRUE

end function

private sub hReadObjinfo( )
	dim as string dat
	dim as integer lang = any

	#macro hReportErr( num )
		errReportWarnEx( num, objinfoGetFilename( ), -1 )
	#endmacro

	do
		select case as const( objinfoReadNext( dat ) )
		case OBJINFO_LIB
			strsetAdd( @fbc.finallibs, dat, FALSE )

		case OBJINFO_LIBPATH
			strsetAdd( @fbc.finallibpaths, dat, FALSE )

		case OBJINFO_MT
			if( fbc.objinf.mt = FALSE ) then
				hReportErr( FB_WARNINGMSG_MIXINGMTMODES )

				fbc.objinf.mt = TRUE
				fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )
			end if

		case OBJINFO_GFX
			fbSetOption( FB_COMPOPT_FBGFX, TRUE )

		case OBJINFO_LANG
			lang = fbGetLangId( dat )

			'' bad objinfo value?
			if( lang = FB_LANG_INVALID ) then
				lang = FB_LANG_FB
			end if

			if( lang <> fbc.objinf.lang ) then
				hReportErr( FB_WARNINGMSG_MIXINGLANGMODES )
				fbc.objinf.lang = lang
				fbSetOption( FB_COMPOPT_LANG, lang )
			end if

		case else
			exit do
		end select
	loop

	objinfoReadEnd( )
end sub

private sub hCollectObjinfo( )
	dim as string ptr s = any
	dim as TSTRSETITEM ptr i = any

	'' for each object passed in the cmd-line
	s = listGetHead( @fbc.objlist )
	while( s )
		objinfoReadObj( *s )
		hReadObjinfo( )
		s = listGetNext( s )
	wend

	'' for each library found (must be done after processing all objects)
	i = listGetHead( @fbc.finallibs.list )
	while( i )
		'' Not default?
		if( i->userdata = FALSE ) then
			objinfoReadLib( i->s, @fbc.finallibpaths.list )
			hReadObjinfo( )
		end if
		i = listGetNext( i )
	wend

	'' Search libs given as *.a input files instead of -l or #inclib
	s = listGetHead( @fbc.libfiles )
	while( s )
		objinfoReadLibfile( *s )
		hReadObjinfo( )
		s = listGetNext( s )
	wend
end sub

private sub hFatalInvalidOption _
	( _
		byref arg as string, _
		byval is_source as integer _
	)
	'' if 'is_source' then show a line number, otherwise it's the actual command line and line number is undefined
	errReportEx( FB_ERRMSG_INVALIDCMDOPTION, QUOTE + arg + QUOTE, iif( is_source, 0, -1 ) )
	fbcEnd( 1 )
end sub

private sub hCheckWaitingObjfile( )
	if( len( fbc.objfile ) > 0 ) then
		errReportEx( FB_ERRMSG_OBJFILEWITHOUTINPUTFILE, "-o " & fbc.objfile, -1 )
		fbc.objfile = ""
	end if
end sub

private sub hSetIofile _
	( _
		byval module as FBCIOFILE ptr, _
		byref srcfile as string, _
		byval is_rc as integer _
	)

	module->srcfile = srcfile

	'' No objfile name set yet (from the -o <file> option)?
	if( len( fbc.objfile ) = 0 ) then
		module->is_custom_objfile = FALSE

		'' Choose default *.o name based on input file name
		if( is_rc ) then
#ifdef ENABLE_GORC
			'' GoRC only accepts *.obj
			'' foo.rc -> foo.obj, so there is no collision with foo.bas' foo.o
			fbc.objfile = hStripExt( srcfile ) + ".obj"
#else
			'' windres doesn't care, so we use the default *.o
			'' foo.rc -> foo.rc.o to avoid collision with foo.bas' foo.o
			fbc.objfile = srcfile + ".o"
#endif
		else
			'' foo.bas -> foo.o
			fbc.objfile = hStripExt( srcfile ) + ".o"
		end if

		'' Since there was no preceding -o for this module, allow
		'' -o <file> to follow later
		fbc.lastmodule = module
	else
		module->is_custom_objfile = TRUE
	end if

	module->objfile = fbcAddObj( fbc.objfile )
	fbc.objfile = ""

end sub

private sub hAddBas( byref basfile as string )
	hSetIofile( listNewNode( @fbc.modules ), basfile, FALSE )
end sub

type FBGNUOSINFO
	gnuid       as zstring ptr  '' Part of GNU triplet identifying a certain OS
	os          as integer      '' Corresponding FB_COMPTARGET_*
end type

type FBGNUARCHINFO
	gnuid       as zstring ptr  '' Part of GNU triplet identifying a certain architecture
	cputype     as integer      '' Corresponding FB_CPUTYPE_*
end type

'' OS name strings recognized when parsing GNU triplets (-target option)
dim shared as FBGNUOSINFO gnuosmap(0 to ...) => _
{ _
	(@"linux"      , FB_COMPTARGET_LINUX    ), _
	(@"mingw"      , FB_COMPTARGET_WIN32    ), _
	(@"djgpp"      , FB_COMPTARGET_DOS      ), _
	(@"msdosdjgpp" , FB_COMPTARGET_DOS      ), _
	(@"cygwin"     , FB_COMPTARGET_CYGWIN   ), _
	(@"darwin"     , FB_COMPTARGET_DARWIN   ), _
	(@"freebsd"    , FB_COMPTARGET_FREEBSD  ), _
	(@"dragonfly"  , FB_COMPTARGET_DRAGONFLY), _
	(@"solaris"    , FB_COMPTARGET_SOLARIS  ), _
	(@"netbsd"     , FB_COMPTARGET_NETBSD   ), _
	(@"openbsd"    , FB_COMPTARGET_OPENBSD  ), _
	(@"xbox"       , FB_COMPTARGET_XBOX     )  _
}

'' Architectures recognized when parsing GNU triplets (-target option)
dim shared as FBGNUARCHINFO gnuarchmap(0 to ...) => _
{ _
	(@"i386"       , FB_CPUTYPE_386            ), _
	(@"i486"       , FB_CPUTYPE_486            ), _
	(@"i586"       , FB_CPUTYPE_586            ), _
	(@"i686"       , FB_CPUTYPE_686            ), _
	(@"x86"        , FB_DEFAULT_CPUTYPE_X86    ), _
	(@"x86_64"     , FB_DEFAULT_CPUTYPE_X86_64 ), _
	(@"amd64"      , FB_DEFAULT_CPUTYPE_X86_64 ), _
	(@"armv6"      , FB_CPUTYPE_ARMV6          ), _
	(@"armv7a"     , FB_CPUTYPE_ARMV7A         ), _
	(@"arm"        , FB_DEFAULT_CPUTYPE_ARM    ), _
	(@"aarch64"    , FB_DEFAULT_CPUTYPE_AARCH64), _
	(@"ppc"        , FB_DEFAULT_CPUTYPE_PPC    ), _
	(@"powerpc"    , FB_DEFAULT_CPUTYPE_PPC    ), _
	(@"ppc64  "    , FB_DEFAULT_CPUTYPE_PPC64  ), _
	(@"powerpc64"  , FB_DEFAULT_CPUTYPE_PPC64  ),  _
	(@"ppc64le  "  , FB_DEFAULT_CPUTYPE_PPC64LE), _
	(@"powerpc64le", FB_DEFAULT_CPUTYPE_PPC64LE)  _
}

'' Identify OS (FB_COMPTARGET_*) and architecture (FB_CPUTYPE_*) in a GNU
'' triplet string (gcc toolchain target name).
private sub hParseGnuTriplet _
	( _
		byref arg as string, _
		byval separator as integer, _
		byref os as integer, _
		byref cputype as integer _
	)

	'' Search for OS, it be anywere in the triplet:
	''    mingw32              -> mingw
	''    arm-linux-gnueabihf  -> linux
	''    i686-w64-mingw32     -> mingw
	''    i686-pc-linux-gnu    -> linux
	''    i386-pc-msdosdjgpp   -> dos386
	''    i486-pc-msdosdjgpp   -> dos486
	''    i586-pc-msdosdjgpp   -> dos586
	for i as integer = 0 to ubound( gnuosmap )
		if( instr( arg, *gnuosmap(i).gnuid ) > 0 ) then
			os = gnuosmap(i).os
			exit for
		end if
	next

	'' If the triplet has at least two components (<arch>-<...>),
	'' extract the first (the architecture and try to identify it.
	if( separator > 0 ) then
		var arch = left( arg, separator - 1 )
		for i as integer = 0 to ubound( gnuarchmap )
			if( arch = *gnuarchmap(i).gnuid ) then
				cputype = gnuarchmap(i).cputype
				exit for
			end if
		next
	end if

end sub

function fbCpuTypeFromGNUArchInfo( byref arch as string ) as integer
	for i as integer = 0 to ubound( gnuarchmap )
		if( arch = *gnuarchmap(i).gnuid ) then
			return gnuarchmap(i).cputype
		end if
	next
	return -1
end function

type FBOSARCHINFO
	targetid    as zstring ptr  '' -target option argument
	os          as integer      '' FB_COMPTARGET_*
	cputype     as integer      '' FB_CPUTYPE_*
end type

'' Simple free-form arguments accepted by -target option
dim shared as FBOSARCHINFO fbosarchmap(0 to ...) => _
{ _
	_ '' win32/win64 refer to specific OS/arch combinations
	(@"win32"  , FB_COMPTARGET_WIN32  , FB_DEFAULT_CPUTYPE_X86   ), _
	(@"win64"  , FB_COMPTARGET_WIN32  , FB_DEFAULT_CPUTYPE_X86_64), _
	_ '' dragonfly is 64 bit only
	(@"dragonfly", FB_COMPTARGET_DRAGONFLY, FB_DEFAULT_CPUTYPE_X86_64), _
	_ '' solaris is 64 bit only
	(@"solaris", FB_COMPTARGET_SOLARIS, FB_DEFAULT_CPUTYPE_X86_64), _
	_
	_ '' OS given without arch, using the default arch, except for dos/xbox
	_ ''  which only work with x86, so we can always default to x86 for them.
	_ '' (these are supported for backwards compatibility with x86-only FB)
	(@"dos"    , FB_COMPTARGET_DOS    , FB_DEFAULT_CPUTYPE_X86   ), _
	(@"xbox"   , FB_COMPTARGET_XBOX   , FB_DEFAULT_CPUTYPE_X86   ), _
	(@"cygwin" , FB_COMPTARGET_CYGWIN , FB_DEFAULT_CPUTYPE       ), _
	(@"darwin" , FB_COMPTARGET_DARWIN , FB_DEFAULT_CPUTYPE       ), _
	(@"freebsd", FB_COMPTARGET_FREEBSD, FB_DEFAULT_CPUTYPE       ), _
	(@"linux"  , FB_COMPTARGET_LINUX  , FB_DEFAULT_CPUTYPE       ), _
	(@"netbsd" , FB_COMPTARGET_NETBSD , FB_DEFAULT_CPUTYPE       ), _
	(@"openbsd", FB_COMPTARGET_OPENBSD, FB_DEFAULT_CPUTYPE       )  _
}

''
'' Parse the -target option's argument.
''
'' Examples:
''    -target win32           ->    Windows + default x86 arch
''    -target win64           ->    Windows + x86_64
''    -target dos             ->    DOS + x86
''    -target linux           ->    Linux + default arch
''    -target linux-x86       ->    Linux + default x86 arch
''    -target linux-x86_64    ->    Linux + x86_64
''    ...
''
'' The normal (non-standalone) build also accepts GNU triplets:
'' (the rough format is <arch>-<vendor>-<os> but it can vary a lot)
''    -target i686-pc-linux-gnu      ->    Linux + i686
''    -target arm-linux-gnueabihf    ->    Linux + default ARM arch
''    -target x86_64-w64-mingw32     ->    Windows + x86_64
''    ...
''
'' The normal build uses the -target argument as prefix for binutils/gcc tools.
'' This allows fbc to work well with gcc/binutils cross-compiling toolchains,
'' for example: -target i686-pc-mingw32 causes it to use i686-pc-mingw32-ld
'' instead of the native ld.
''
'' Something like -target win32 is mostly useful for the standalone build, where
'' binutils/gcc tools are arranged into the bin/win32/ld.exe etc. directory
'' layout. -target win32 is less useful for the normal build, because typically
'' binutils/gcc toolchains for cross-compiling to Windows are named something
'' like "i686-pc-mingw32", not just "win32". Nevertheless, even the normal build
'' should accept these options -- it can be useful for debugging purposes or
'' with the -print option. Furthermore, people (unnecessarily) specify -target
'' for native compilation (e.g. using -target linux on Linux), and this supports
'' that.
''
'' This function should just do parsing, without any validation. It would be
'' nice if
''    -target linux-x86_64
'' would just be the same as
''    -target linux -arch x86_64
'' Thus, any validation should be done later when the command line has been
'' parsed completely.
''
'' It's up to the caller to report an error if only one of OS/arch (but not
'' both) could be identified.
''
private sub hParseTargetArg _
	( _
		byref arg as string, _
		byref os as integer, _
		byref cputype as integer, _
		byref is_gnu_triplet as integer _
	)

	os = -1
	cputype = -1
	is_gnu_triplet = FALSE

	'' Case-insensitive so "-target WIN32" etc. works too
	var lcasearg = lcase( arg )

	'' Check for simple arguments (dos, linux, win32, etc.)
	for i as integer = 0 to ubound( fbosarchmap )
		if( lcasearg = *fbosarchmap(i).targetid ) then
			os = fbosarchmap(i).os
			cputype = fbosarchmap(i).cputype
			exit sub
		end if
	next

	'' <os>-<cpufamily>
	var separator = instr( arg, "-" )
	if( separator > 0 ) then
		os = fbIdentifyOs( left( lcasearg, separator - 1 ) )
		cputype = fbCpuTypeFromCpuFamilyId( right( lcasearg, len( lcasearg ) - separator ) )

		'' allow normalizing on gnu arch types to determine the standalone targetid
		#ifdef ENABLE_STANDALONE
			if( (os < 0) and (cputype < 0) ) then
				cputype = fbCpuTypeFromGNUArchInfo( right( lcasearg, len( lcasearg ) - separator ) )
			end if
		#endif
	end if

	'' Normal build: Check for GNU triplets, if the above checks failed.
	#ifndef ENABLE_STANDALONE
		if( (os < 0) and (cputype < 0) ) then
			hParseGnuTriplet( arg, separator, os, cputype )
			is_gnu_triplet = TRUE
		end if
	#else
		if( (os < 0) and (cputype < 0) ) then
			hParseGnuTriplet( arg, separator, os, cputype )
		end if
	#endif
end sub

enum
	OPT_A = 0
	OPT_ARCH
	OPT_ASM
	OPT_B
	OPT_BUILDPREFIX
	OPT_C
	OPT_CKEEPOBJ
	OPT_D
	OPT_DLL
	OPT_DYLIB
	OPT_E
	OPT_EARRAY
	OPT_EASSERT
	OPT_EDEBUG
	OPT_EDEBUGINFO
	OPT_ELOCATION
	OPT_ENULLPTR
	OPT_EUNWIND
	OPT_ENTRY
	OPT_EX
	OPT_EXX
	OPT_EXPORT
	OPT_FBGFX
	OPT_FORCELANG
	OPT_FPMODE
	OPT_FPU
	OPT_G
	OPT_GEN
	OPT_HELP
	OPT_I
	OPT_INCLUDE
	OPT_L
	OPT_LANG
	OPT_LIB
	OPT_M
	OPT_MAP
	OPT_MAXERR
	OPT_MT
	OPT_NODEFLIBS
	OPT_NOERRLINE
	OPT_NOLIB
	OPT_NOOBJINFO
	OPT_NOSTRIP
	OPT_O
	OPT_OPTIMIZE
	OPT_P
	OPT_PIC
	OPT_PP
	OPT_PREFIX
	OPT_PRINT
	OPT_PROFILE
	OPT_R
	OPT_RKEEPASM
	OPT_RR
	OPT_RRKEEPASM
	OPT_S
	OPT_SHOWINCLUDES
	OPT_STATIC
	OPT_STRIP
	OPT_T
	OPT_TARGET
	OPT_TITLE
	OPT_V
	OPT_VEC
	OPT_VERSION
	OPT_W
	OPT_WA
	OPT_WC
	OPT_WL
	OPT_X
	OPT_Z
	OPT__COUNT
end enum

type FBC_CMDLINE_OPTION
	takes_argument as boolean          '' true = option requires argument
	allowed_in_source as boolean       '' true = can be used with #cmdline directive
	parser_restart as boolean          '' true = restart of parser is required when used with #cmdline directive
	fbc_restart as integer             '' true = major restart of fbc required
end type

dim shared as FBC_CMDLINE_OPTION cmdlineOptionTB(0 to (OPT__COUNT - 1)) = _
{ _
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_A            add files to link, affects link
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_ARCH         affects major initialization
	( TRUE , TRUE , FALSE, TRUE  ), _ '' OPT_ASM          affects major initialization,affects second stage compile
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_B            adds files to compile
	( TRUE , TRUE , FALSE, TRUE  ), _ '' OPT_BUILDPREFIX  affects tools executed (fbcSetupCompilerPaths(), so restart is required)
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_C            affects code generation / compile / assemble /link process
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_CKEEPOBJ     affects removal of temporary files
	( TRUE , TRUE , FALSE, TRUE  ), _ '' OPT_D            add symbols to current source also, not just the preDefines, affects global defines
	( FALSE, TRUE , TRUE , TRUE  ), _ '' OPT_DLL          affects major initialization, affects output format
	( FALSE, TRUE , TRUE , TRUE  ), _ '' OPT_DYLIB        affects major initialization, affects output format
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_E            affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EARRAY       affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EASSERT      affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EDEBUG       affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EDEBUGINFO   affects code generation, affects link
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_ELOCATION    affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_ENULLPTR     affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EUNWIND      affects code generation
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_ENTRY        affects major initialization, affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EX           affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EXX          affects code generation
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_EXPORT       affects code generation
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_FBGFX        affects link
	( TRUE , TRUE , TRUE , FALSE ), _ '' OPT_FORCELANG    never allow, command line only
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_FPMODE       affects major initialization, affects code generation
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_FPU          affects major initialization,affects code generation, affects second stage compile, affects link
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_G            affects code generation, affects link
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_GEN          affects major initialization
	( FALSE, FALSE, FALSE, FALSE ), _ '' OPT_HELP         never allow, real command line only, makes no sense to have in source
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_I            add include path before the default one
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_INCLUDE      restart required to inject preInclude
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_L            affects link, same as #inclib
	( TRUE , TRUE , TRUE , FALSE ), _ '' OPT_LANG         affects code generation, affects initialization
	( FALSE, TRUE , TRUE , TRUE  ), _ '' OPT_LIB          affects major initialization, affects output format
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_M            affects major initialization for all modules
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_MAP          affects output files
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_MAXERR       affects compile process
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_MT           affects link, __FB_MT__
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_NODEFLIBS    affects link
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_NOERRLINE    affects compiler output display
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_NOLIB        affects link
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_NOOBJINFO    affects post compile process
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_NOSTRIP      affects link
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_O            affects output file naming with initialization before compile
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_OPTIMIZE     affects link
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_P            affects link, same as #libpath
	( FALSE, TRUE , FALSE, TRUE  ), _ '' OPT_PIC          affects major initialization, affects link
	( FALSE, TRUE , FALSE, TRUE  ), _ '' OPT_PP           affects major initialization
	( TRUE , TRUE , FALSE, TRUE  ), _ '' OPT_PREFIX       affects major initialization
	( TRUE , FALSE, FALSE, FALSE ), _ '' OPT_PRINT        never allow, makes no sense to have in source
	( FALSE, TRUE , TRUE , TRUE  ), _ '' OPT_PROFILE      affects major initialization, affects initialization, affects code generation, affects link
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_R            affects compile / assemble / link process, removal of temporary files
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_RKEEPASM     affects removal of temporary files
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_RR           affects compile / assemble / link process, removal of temporary files
	( FALSE, TRUE , TRUE , FALSE ), _ '' OPT_RRKEEPASM    affects removal of temporary files
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_S            affects link
	( FALSE, TRUE , FALSE, TRUE  ), _ '' OPT_SHOWINCLUDES affects compiler output display
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_STATIC       affects link
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_STRIP        affects link
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_T            affects link
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_TARGET       affects major initialization
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_TITLE        affects link
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_V            affects nothing
	( TRUE , TRUE , TRUE , TRUE  ), _ '' OPT_VEC          affects major initialization, affects code generation
	( FALSE, TRUE , FALSE, FALSE ), _ '' OPT_VERSION      print version information
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_W            affects compiler display output
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_WA           affects assembly
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_WC           affects second stage compile
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_WL           affects link
	( TRUE , TRUE , FALSE, FALSE ), _ '' OPT_X            affects output file
	( TRUE , TRUE , TRUE , TRUE  )  _ '' OPT_Z            affects various - code generation
}

private sub handleOpt _
	( _
		byval optid as integer, _
		byref arg as string, _
		byval is_source as integer _
	)

	select case as const (optid)
	case OPT_A
		fbcAddObj( arg )

	case OPT_ARCH
		fbc.cputype_is_native = (arg = "native")
		fbc.cputype = fbIdentifyFbcArch( arg )
		if( fbc.cputype < 0 ) then
			hFatalInvalidOption( "-arch " + arg, is_source )
		end if

	case OPT_ASM
		select case( arg )
		case "att"
			fbc.asmsyntax = FB_ASMSYNTAX_ATT
		case "intel"
			fbc.asmsyntax = FB_ASMSYNTAX_INTEL
		case else
			hFatalInvalidOption( arg, is_source )
		end select

	case OPT_B
		hAddBas( arg )

	case OPT_BUILDPREFIX
		fbc.buildprefix = arg

	case OPT_C
		'' -c changes the output type to from exe/lib/dll to object,
		'' overwriting previous -dll, -lib or the default exe.
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
		fbc.keepobj = TRUE

	case OPT_CKEEPOBJ
		fbc.keepobj = TRUE

	case OPT_D
		fbAddPreDefine(arg)

	case OPT_DLL, OPT_DYLIB
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_DYNAMICLIB )

	case OPT_E
		fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
		fbSetOption( FB_COMPOPT_UNWINDINFO, TRUE )

	case OPT_EARRAY
		fbSetOption( FB_COMPOPT_ARRAYBOUNDCHECK, TRUE )

	case OPT_EASSERT
		fbSetOption( FB_COMPOPT_ASSERTIONS, TRUE )

	case OPT_EDEBUG
		fbSetOption( FB_COMPOPT_DEBUG, TRUE )

	case OPT_EDEBUGINFO
		fbSetOption( FB_COMPOPT_DEBUGINFO, TRUE )

	case OPT_ELOCATION
		fbSetOption( FB_COMPOPT_ERRLOCATION, TRUE )

	case OPT_ENULLPTR
		fbSetOption( FB_COMPOPT_NULLPTRCHECK, TRUE )

	case OPT_EUNWIND
		fbSetOption( FB_COMPOPT_UNWINDINFO, TRUE )

	case OPT_ENTRY
		fbc.entry = arg

	case OPT_EX
		fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
		fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
		fbSetOption( FB_COMPOPT_UNWINDINFO, TRUE )

	case OPT_EXX
		fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
		fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
		fbSetOption( FB_COMPOPT_EXTRAERRCHECK, TRUE )
		fbSetOption( FB_COMPOPT_ERRLOCATION, TRUE )
		fbSetOption( FB_COMPOPT_ARRAYBOUNDCHECK, TRUE )
		fbSetOption( FB_COMPOPT_NULLPTRCHECK, TRUE )
		fbSetOption( FB_COMPOPT_UNWINDINFO, TRUE )

	case OPT_EXPORT
		fbSetOption( FB_COMPOPT_EXPORT, TRUE )

	case OPT_FBGFX
		fbSetOption( FB_COMPOPT_FBGFX, TRUE )

	case OPT_FORCELANG
		dim as integer value = fbGetLangId(strptr(arg))
		if( value = FB_LANG_INVALID ) then
			hFatalInvalidOption( arg, is_source )
		end if

		'' show a warning only if forcelang was already set and
		'' we are handling this from a #cmdline.  We'd like that
		'' -forcelang from the real command line takes priority
		'' over source code #cmdline "-forcelang"
		if( is_source and fbGetOption( FB_COMPOPT_FORCELANG ) ) then
			errReportWarn( FB_WARNINGMSG_CMDLINEOVERRIDES )
		else
			fbSetOption( FB_COMPOPT_LANG, value )
			fbSetOption( FB_COMPOPT_FORCELANG, TRUE )
			fbc.objinf.lang = value

			if( is_source ) then
				fbSetOption( FB_COMPOPT_RESTART_LANG, value )
			end if
		end if

	case OPT_FPMODE
		dim as integer value = any

		select case ucase(arg)
		case "PRECISE"
			value = FB_FPMODE_PRECISE
		case "FAST"
			value = FB_FPMODE_FAST
		case else
			hFatalInvalidOption( arg, is_source )
		end select

		fbSetOption( FB_COMPOPT_FPMODE, value )

	case OPT_FPU
		dim as integer value = any

		select case ucase(arg)
		case "X87", "FPU"
			value = FB_FPUTYPE_FPU
		case "SSE"
			value = FB_FPUTYPE_SSE
		case else
			hFatalInvalidOption( arg, is_source )
		end select

		fbSetOption( FB_COMPOPT_FPUTYPE, value )

	case OPT_G
		fbSetOption( FB_COMPOPT_DEBUG, TRUE )
		fbSetOption( FB_COMPOPT_DEBUGINFO, TRUE )
		fbSetOption( FB_COMPOPT_ASSERTIONS, TRUE )

	case OPT_GEN
		select case( lcase( arg ) )
		case "gas"
			fbc.backend = FB_BACKEND_GAS
		case "gcc"
			fbc.backend = FB_BACKEND_GCC
		case "llvm"
			fbc.backend = FB_BACKEND_LLVM
		Case "gas64"
			fbc.backend = FB_BACKEND_GAS64
		case else
			hFatalInvalidOption( arg, is_source )
		end select

	case OPT_HELP
		fbc.showhelp = TRUE

	case OPT_I
		fbAddIncludePath(pathStripDiv(arg))

	case OPT_INCLUDE
		fbAddPreInclude(arg)

	case OPT_L
		strsetAdd(@fbc.libs, arg, FALSE)

	case OPT_LANG
		dim as integer value = fbGetLangId( strptr(arg) )
		if( value = FB_LANG_INVALID ) then
			hFatalInvalidOption( arg, is_source )
		end if

		'' don't let '-lang' option or #cmdline "-lang" overide -forcelang
		if( fbGetOption( FB_COMPOPT_FORCELANG ) = FALSE ) then
			fbSetOption( FB_COMPOPT_LANG, value )
			fbc.objinf.lang = value

			if( is_source ) then
				fbSetOption( FB_COMPOPT_RESTART_LANG, value )
			endif
		end if

	case OPT_LIB
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_STATICLIB )

	case OPT_M
		fbc.mainname = arg
		fbc.mainset = TRUE

	case OPT_MAP
		fbc.mapfile = arg

	case OPT_MAXERR
		dim as integer value = any

		if( arg = "inf" ) then
			value = FB_ERR_INFINITE
		else
			value = clng( arg )
			if( value <= 0 ) then
				hFatalInvalidOption( arg, is_source )
			end if
		end if

		fbSetOption( FB_COMPOPT_MAXERRORS, value )

	case OPT_MT
		fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )
		fbc.objinf.mt = TRUE

	case OPT_NODEFLIBS
		fbc.nodeflibs = TRUE

	case OPT_NOERRLINE
		fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )

	case OPT_NOLIB
		dim libs() as string
		hSplitStr(arg, ",", libs())
		for i as integer = lbound(libs) to ubound(libs)
			if len(libs(i)) > 0 then
				strsetAdd(@fbc.excludedlibs, libs(i), 0 /'unused userdata'/)
			end if
		next

	case OPT_NOOBJINFO
		fbSetOption( FB_COMPOPT_OBJINFO, FALSE )

	case OPT_NOSTRIP
		fbc.stripsymbols = FALSE

	case OPT_O
		'' Error if there already is an -o waiting to be assigned
		hCheckWaitingObjfile( )

		'' Assign it to the last module, if it doesn't have an
		'' -o filename yet, or store it for later otherwise.
		if( fbc.lastmodule ) then
			*fbc.lastmodule->objfile = arg
			fbc.lastmodule->is_custom_objfile = TRUE
		else
			fbc.objfile = arg
		end if

	case OPT_OPTIMIZE
		dim as integer value = any

		if (arg = "max") then
			value = 3
		else
			value = clng( arg )
			if (value < 0) then
				value = 0
			elseif (value > 3) then
				value = 3
			end if
		end if

		fbSetOption( FB_COMPOPT_OPTIMIZELEVEL, value )

	case OPT_P
		strsetAdd(@fbc.libpaths, pathStripDiv(arg), FALSE)

	case OPT_PIC
		fbSetOption( FB_COMPOPT_PIC, TRUE )

	case OPT_PP
		'' -pp doesn't change the output type, but like -r we want to
		'' stop fbc very early.
		fbSetOption( FB_COMPOPT_PPONLY, TRUE )
		fbc.emitasmonly = TRUE

	case OPT_PREFIX
		fbc.prefix = pathStripDiv(arg)
		hReplaceSlash( fbc.prefix, asc( FB_HOST_PATHDIV ) )

	case OPT_PRINT
		select case( arg )
		case "host"   : fbc.print = PRINT_HOST
		case "target" : fbc.print = PRINT_TARGET
		case "x"      : fbc.print = PRINT_X
		case "fblibdir" : fbc.print = PRINT_FBLIBDIR
		case "sha-1"  : fbc.print = PRINT_SHA1
		case else
			hFatalInvalidOption( arg, is_source )
		end select

	case OPT_PROFILE
		fbSetOption( FB_COMPOPT_PROFILE, TRUE )

	case OPT_R
		'' -r changes the output type to .o, like -c, i.e. -m may have
		'' to be used to mark the main module, just like -c.
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
		'' -r will stop fbc earlier than -c though.
		fbc.emitasmonly = TRUE
		fbc.keepasm = TRUE

	case OPT_RKEEPASM
		fbc.keepasm = TRUE

	case OPT_RR
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
		fbc.emitfinalasmonly = TRUE
		fbc.keepfinalasm = TRUE

	case OPT_RRKEEPASM
		fbc.keepfinalasm = TRUE

	case OPT_S
		fbc.subsystem = arg
		select case( arg )
		case "gui"
			fbSetOption( FB_COMPOPT_MODEVIEW, FB_MODEVIEW_GUI )

		end select

	case OPT_SHOWINCLUDES
		fbSetOption( FB_COMPOPT_SHOWINCLUDES, TRUE )

	case OPT_STATIC
		fbc.staticlink = TRUE

	case OPT_STRIP
		fbc.stripsymbols = TRUE

	case OPT_T
		fbSetOption( FB_COMPOPT_STACKSIZE, clng( arg ) * 1024 )

	case OPT_TARGET
		dim as integer os, cputype, is_gnu_triplet
		hParseTargetArg( arg, os, cputype, is_gnu_triplet )

		if( (os < 0) or (cputype < 0) ) then
			hFatalInvalidOption( arg, is_source )
		end if

		'' Store the OS/cputype, overwriting the values from any
		'' previous -target options.
		fbSetOption( FB_COMPOPT_TARGET, os )
		fbSetOption( FB_COMPOPT_CPUTYPE, cputype )

		#ifndef ENABLE_STANDALONE
			'' Normal build: Store the original -target argument
			'' for use as prefix for binutils/gcc tools, but only
			'' when cross-compiling or if it's really a GNU triplet.
			if( (os <> FB_DEFAULT_TARGET) or _
				(cputype <> FB_DEFAULT_CPUTYPE) or _
				is_gnu_triplet ) then
				fbc.target = arg
				fbc.targetprefix = fbc.target + "-"
			end if
		#endif

	case OPT_TITLE
		fbc.xbe_title = arg

	case OPT_V
		fbc.verbose = TRUE

	case OPT_VEC
		dim as integer value = any

		select case (ucase(arg))
		case "NONE", "0"
			value = FB_VECTORIZE_NONE
		case "1"
			value = FB_VECTORIZE_NORMAL
		case "2"
			value = FB_VECTORIZE_INTRATREE
		case else
			hFatalInvalidOption( arg, is_source )
		end select

		fbSetOption( FB_COMPOPT_VECTORIZE, value )

	case OPT_VERSION
		if( is_source ) then
			if( fbc.showversion = FALSE ) then
				hPrintVersion( fbc.verbose )
			end if
		end if
		fbc.showversion = TRUE

	case OPT_W
		dim as integer value = FB_WARNINGMSGS_LOWEST_LEVEL - 1

		select case (arg)
		case "all"
			value = FB_WARNINGMSGS_LOWEST_LEVEL

		case "none"
			value = FB_WARNINGMSGS_HIGHEST_LEVEL + 1

		case "param"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_PARAMMODE )

		case "escape"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_ESCSEQ )

		case "next"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_NEXTVAR )

		case "signedness"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_SIGNEDNESS )

		case "constness"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
						fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_CONSTNESS )
			value = FB_WARNINGMSGS_LOWEST_LEVEL

		case "funcptr"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_CASTFUNCPTR )
			value = FB_WARNINGMSGS_LOWEST_LEVEL

		case "suffix"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_SUFFIX )

		case "pedantic"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, FB_PDCHECK_DEFAULT )
			if( value > FB_WARNINGMSGS_DEFAULT_LEVEL ) then
				value = FB_WARNINGMSGS_DEFAULT_LEVEL
			end if

		case "error"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_ERROR )

		case "upcast"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
				fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_UPCAST )

		case else
			value = clng( arg )
		end select

		if( value >= FB_WARNINGMSGS_LOWEST_LEVEL ) then
			fbSetOption( FB_COMPOPT_WARNINGLEVEL, value )
		end if

	case OPT_WA
		fbc.extopt.gas += " " + hReplace( arg, ",", " " ) + " "

	case OPT_WC
		fbc.extopt.gcc += " " + hReplace( arg, ",", " " ) + " "

	case OPT_WL
		fbc.extopt.ld += " " + hReplace( arg, ",", " " ) + " "

	case OPT_X
		fbc.outname = arg

	case OPT_Z
		select case( lcase( arg ) )
		case "gosub-setjmp"
			fbSetOption( FB_COMPOPT_GOSUBSETJMP, TRUE )
		case "valist-as-ptr"
			fbSetOption( FB_COMPOPT_VALISTASPTR, TRUE )
		case "no-thiscall"
			fbSetOption( FB_COMPOPT_NOTHISCALL, TRUE )
		case "no-fastcall"
			fbSetOption( FB_COMPOPT_NOFASTCALL, TRUE )
		case "fbrt"
			fbSetOption( FB_COMPOPT_FBRT, TRUE )
		case "nocmdline"
			fbSetOption( FB_COMPOPT_NOCMDLINE, TRUE )
		case "retinflts"
			fbSetOption( FB_COMPOPT_RETURNINFLTS, TRUE )
		case else
			hFatalInvalidOption( arg, is_source )
		end select

	end select
end sub

private function parseOption(byval opt as zstring ptr) as integer
	#macro CHECK(opttext, optid)
		if (*opt = opttext) then
			return optid
		end if
	#endmacro

	#macro ONECHAR(optid)
		if (cptr(ubyte ptr, opt)[1] = 0) then
			return optid
		end if
	#endmacro

	select case as const (cptr(ubyte ptr, opt)[0])
	case asc("a")
		ONECHAR(OPT_A)
		CHECK("arch", OPT_ARCH)
		CHECK("asm", OPT_ASM)

	case asc("b")
		ONECHAR(OPT_B)
		CHECK("buildprefix", OPT_BUILDPREFIX)

	case asc("c")
		ONECHAR(OPT_C)

	case asc("C")
		ONECHAR(OPT_CKEEPOBJ)

	case asc("d")
		ONECHAR(OPT_D)
		CHECK("dll", OPT_DLL)
		CHECK("dylib", OPT_DYLIB)

	case asc("e")
		ONECHAR(OPT_E)
		CHECK("ex", OPT_EX)
		CHECK("earray", OPT_EARRAY)
		CHECK("eassert", OPT_EASSERT)
		CHECK("edebug", OPT_EDEBUG)
		CHECK("edebuginfo", OPT_EDEBUGINFO)
		CHECK("elocation", OPT_ELOCATION)
		CHECK("enullptr", OPT_ENULLPTR)
		CHECK("eunwind", OPT_EUNWIND)
		CHECK("entry", OPT_ENTRY)
		CHECK("exx", OPT_EXX)
		CHECK("export", OPT_EXPORT)

	case asc("f")
		CHECK("fbgfx", OPT_FBGFX)
		CHECK("forcelang", OPT_FORCELANG)
		CHECK("fpmode", OPT_FPMODE)
		CHECK("fpu", OPT_FPU)

	case asc("g")
		ONECHAR(OPT_G)
		CHECK("gen", OPT_GEN)

	case asc( "h" )
		CHECK( "help", OPT_HELP )

	case asc("i")
		ONECHAR(OPT_I)
		CHECK("include", OPT_INCLUDE)

	case asc("l")
		ONECHAR(OPT_L)
		CHECK("lang", OPT_LANG)
		CHECK("lib", OPT_LIB)

	case asc("m")
		ONECHAR(OPT_M)
		CHECK("map", OPT_MAP)
		CHECK("maxerr", OPT_MAXERR)
		CHECK("mt", OPT_MT)

	case asc("n")
		CHECK("noerrline", OPT_NOERRLINE)
		CHECK("nodeflibs", OPT_NODEFLIBS)
		CHECK("nolib", OPT_NOLIB)
		CHECK("noobjinfo", OPT_NOOBJINFO)
		CHECK("nostrip", OPT_NOSTRIP)

	case asc("o")
		ONECHAR(OPT_O)

	case asc("O")
		ONECHAR(OPT_OPTIMIZE)

	case asc("p")
		ONECHAR(OPT_P)
		CHECK("pic", OPT_PIC)
		CHECK("pp", OPT_PP)
		CHECK("prefix", OPT_PREFIX)
		CHECK("print", OPT_PRINT)
		CHECK("profile", OPT_PROFILE)

	case asc("r")
		ONECHAR(OPT_R)
		CHECK("rr", OPT_RR)

	case asc("R")
		ONECHAR(OPT_RKEEPASM)
		CHECK("RR", OPT_RRKEEPASM)

	case asc("s")
		ONECHAR(OPT_S)
		CHECK("showincludes", OPT_SHOWINCLUDES)
		CHECK("static", OPT_STATIC)
		CHECK("strip", OPT_STRIP)

	case asc("t")
		ONECHAR(OPT_T)
		CHECK("target", OPT_TARGET)
		CHECK("title", OPT_TITLE)

	case asc("v")
		ONECHAR(OPT_V)
		CHECK("vec", OPT_VEC)
		CHECK("version", OPT_VERSION)

	case asc("w")
		ONECHAR(OPT_W)

	case asc("W")
		CHECK("Wa", OPT_WA)
		CHECK("Wl", OPT_WL)
		CHECK("Wc", OPT_WC)

	case asc("x")
		ONECHAR(OPT_X)

	case asc("z")
		ONECHAR(OPT_Z)

	case asc( "-" )
		CHECK( "-version", OPT_VERSION )
		CHECK( "-help", OPT_HELP )

	end select

	return -1
end function

declare sub parseArgsFromFile _
	( _
		byref filename as string, _
		byval is_source as integer _
	)

private sub handleArg _
	( _
		byref arg as string, _
		byval is_source as integer, _
		byval is_file as integer _
	)
	'' If the previous option wants this argument as parameter,
	'' call the handler with it, now that it's known.
	'' Note: Anything is accepted, even if it starts with '-' or '@'.
	if( fbc.optid >= 0 ) then
		'' Complain about empty next argument
		if (len(arg) = 0) then
			hFatalInvalidOption( arg, is_source )
		end if

		handleOpt( fbc.optid, arg, is_source )
		fbc.optid = -1
		return
	end if

	if (len(arg) = 0) then
		'' Ignore empty argument
		return
	end if

	select case (arg[0])
	case asc("-")
		dim as zstring ptr opt = strptr(arg) + 1

		'' Complain about '-' only
		if (cptr(ubyte ptr, opt)[0] = 0) then
			'' Incomplete command line option
			hFatalInvalidOption( arg, is_source )
		end if

		'' Parse the option after the '-'
		dim as integer optid = parseOption(opt)
		if (optid < 0) then
			'' Unrecognized command line option
			hFatalInvalidOption( arg, is_source )
		end if

		'' Are we in source and option not allowed in source?
		if( is_source ) then
			if( not cmdlineOptionTB( optid ).allowed_in_source ) then
				hFatalInvalidOption( arg, is_source )
			endif
		end if

		'' Does this option take a parameter?
		if( cmdlineOptionTB( optid ).takes_argument ) then
			'' Delay handling it, until the next argument is known.
			fbc.optid = optid
		else
			'' Handle this option now
			handleOpt( optid, arg, is_source )
		end if

		'' even if the handling of the option is delayed, check the restart options here
		if( is_source ) then
			if( cmdlineOptionTB( optid ).parser_restart ) then
				fbRestartBeginRequest( FB_RESTART_PARSER_CMDLINE )
			end if

			if( cmdlineOptionTB( optid ).fbc_restart ) then
				fbRestartBeginRequest( FB_RESTART_FBC_CMDLINE )
			end if
		end if

	case asc("@")
		'' Maximum nesting/recursion level
		const MAX_LEVELS = 128
		static as integer reclevel = 0

		if (reclevel > MAX_LEVELS) then
			'' Options file nesting level too deep (recursion?)
			errReportEx( FB_ERRMSG_RECLEVELTOODEEP, arg, -1 )
			fbcEnd(1)
		end if

		'' Cut off the '@' at the front to get just the file name
		arg = right(arg, len(arg) - 1)

		'' Complain about '@' only
		if (len(arg) = 0) then
			'' Missing file name after '@'
			hFatalInvalidOption( arg, is_source )
		end if

		'' Recursively read in the additional options from the file
		reclevel += 1
		parseArgsFromFile( arg, is_source )
		reclevel -= 1

	case else
		'' Input file, get its extension to determine what it is
		dim as string ext = hGetFileExt(arg)

		#if defined(__FB_WIN32__) or _
			defined(__FB_DOS__) or _
			defined(__FB_CYGWIN__)
			'' For case in-sensitive file systems
			ext = lcase(ext)
		#endif

		select case (ext)
		case "bas"
			hAddBas( arg )

		case "o"
			fbcAddObj( arg )

		case "a"
			strlistAppend( @fbc.libfiles, arg )

		case "rc", "res"
			hSetIofile( listNewNode( @fbc.rcs ), arg, TRUE )

		case "xpm"
			'' Can have only one .xpm, or the fb_program_icon
			'' symbol will be duplicated
			if( len( fbc.xpm.srcfile ) > 0 ) then
				hFatalInvalidOption( arg, is_source )
			end if

			hSetIofile( @fbc.xpm, arg, TRUE )

		case else
			'' Input file without or with unknown extension
			hFatalInvalidOption( arg, is_source )

		end select
	end select
end sub

sub fbcParseArgsFromString _
	( _
		byval args_in as zstring ptr, _
		byval is_source as integer, _
		byval is_file as integer _
	)

	dim as string args = *args_in
	dim as string arg

	'' Parse the line containing command line arguments,
	'' separated by spaces. Double- and single-quoted strings
	'' are handled too, but nothing else.
	do
		dim as integer length = len(args)
		if (length = 0) then
			exit do
		end if

		dim as integer i = 0
		dim as integer quotech = 0

		while (i < length)
			dim as integer ch = args[i]

			select case as const (ch)
			case asc(" ")
				if (quotech = 0) then
					exit while
				end if

			case asc(""""), asc("'")
				if (quotech = ch) then
					'' String closed
					quotech = 0
				elseif (quotech = 0) then
					'' String opened
					quotech = ch
				end if

			end select

			i += 1
		wend

		if (i = 0) then
			'' Just space, skip it
			i = 1
		else
			arg = left(args, i)
			arg = trim(arg)
			arg = strUnquote(arg)
			handleArg( arg, is_source, is_file )
		end if

		args = right(args, length - i)
	loop

end sub

private sub parseArgsFromFile _
	( _
		byref filename as string, _
		byval is_source as integer _
	)
	dim as integer f = freefile()
	if (open(filename, for input, as #f)) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, filename, -1 )
		fbcEnd(1)
	end if

	dim as string args

	while (eof(f) = FALSE)
		line input #f, args
		args = trim(args)
		fbcParseArgsFromString( strptr( args ), is_source, TRUE )
	wend

	close #f
end sub

private function hTargetNeedsPIC( ) as integer
	function = FALSE
	if( fbGetCpuFamily( ) <> FB_CPUFAMILY_X86 ) then
		select case as const( fbGetOption( FB_COMPOPT_TARGET ) )
		case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
			FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD, _
			FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS
			function = TRUE
		end select
	end if
end function

private sub hParseArgs( byval argc as integer, byval argv as zstring ptr ptr )
	fbc.optid = -1

	'' Note: ignoring argv[0], assuming it's the path used to run fbc
	dim as string arg
	for i as integer = 1 to (argc - 1)
		arg = *argv[i]
		handleArg( arg, FALSE, FALSE )
	next

	'' Waiting for argument to an option? If the user did something like
	'' 'fbc foo.bas -o' this shows the error.
	if (fbc.optid >= 0) then
		'' Missing argument for command line option
		hFatalInvalidOption( *argv[argc - 1], FALSE )
	end if
end sub

private sub hCheckArgs()
	'' In case there was an '-o <file>', but no corresponding input file,
	'' this will report the error.
	hCheckWaitingObjfile( )

	''
	'' Check for incompatible options etc.
	''

	if ( fbGetOption( FB_COMPOPT_FPUTYPE ) = FB_FPUTYPE_FPU ) then
		if( fbGetOption( FB_COMPOPT_VECTORIZE ) >= FB_VECTORIZE_NORMAL ) or _
			( fbGetOption( FB_COMPOPT_FPMODE ) = FB_FPMODE_FAST ) then
				errReportEx( FB_ERRMSG_OPTIONREQUIRESSSE, "", -1 )
			fbcEnd( 1 )
		end if
	end if

	'' 1. The compiler (fb.bas) starts with default target settings for
	''    native compilation.

	'' 2. -target option handling has already switched the target if given.

	'' 3. -arch overrides any other arch settings.
	if( fbc.cputype >= 0 ) then
		fbSetOption( FB_COMPOPT_CPUTYPE, fbc.cputype )
	end if

	'' 4. Check for target/arch conflicts, e.g. dos and non-x86
	if( (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) and _
		(fbGetCpuFamily( ) <> FB_CPUFAMILY_X86) ) then
		errReportEx( FB_ERRMSG_DOSWITHNONX86, fbGetFbcArch( ), -1 )
		fbcEnd( 1 )
	end if

	'' 5. Select default backend based on selected arch, e.g. when compiling
	''    for x86-64 or ARM, we shouldn't default to -gen gas anymore (as
	''    long as it doesn't support it).
	''
	'' This should be done no matter whether compiling for the native system
	'' or cross-compiling. Even on a 64bit x86_64 host where
	'' FB_DEFAULT_BACKEND is -gen gcc, we still prefer using -gen gas when
	'' cross-compiling to 32bit x86.
	'' (Apple gas assembler has such broken support for intel syntax
	'' (see https://discussions.apple.com/message/10163960#10163960)
	'' that it can't work for non-trivial programs, so default to -gen gcc.)
	if( (fbGetCpuFamily( ) = FB_CPUFAMILY_X86) and _
		(fbGetOption(FB_COMPOPT_TARGET) <> FB_COMPTARGET_DARWIN) ) then
		fbSetOption( FB_COMPOPT_BACKEND, FB_BACKEND_GAS )
	else
		fbSetOption( FB_COMPOPT_BACKEND, FB_BACKEND_GCC )
	end if

	'' 6. -gen overrides any other backend setting.
	if( fbc.backend >= 0 ) then
		fbSetOption( FB_COMPOPT_BACKEND, fbc.backend )
	end if

	'' 7. Check whether backend supports the target/arch.
	'' -gen gas with non-x86 arch isn't possible.
	if( ((fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GAS) and _
		(fbGetCpuFamily( ) <> FB_CPUFAMILY_X86)) _
		or ((fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GAS64) and _
		(fbGetCpuFamily( ) <> FB_CPUFAMILY_X86_64)) ) then
		errReportEx( FB_ERRMSG_GENGASWITHNONX86, fbGetFbcArch( ), -1 )
		fbcEnd( 1 )
	end if

	'' Resource scripts are only allowed for win32 & co,
	select case as const (fbGetOption(FB_COMPOPT_TARGET))
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX

	case else
		dim as FBCIOFILE ptr rc = listGetHead(@fbc.rcs)
		if (rc) then
			errReportEx(FB_ERRMSG_RCFILEWRONGTARGET, rc->srcfile, -1)
			fbcEnd(1)
		end if
	end select

	'' The embedded .xpm is only useful for the X11 gfxlib
	select case as const (fbGetOption(FB_COMPOPT_TARGET))
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_DARWIN, _
		FB_COMPTARGET_FREEBSD, FB_COMPTARGET_OPENBSD, _
		FB_COMPTARGET_NETBSD, FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS

	case else
		if (len(fbc.xpm.srcfile) > 0) then
			errReportEx(FB_ERRMSG_RCFILEWRONGTARGET, fbc.xpm.srcfile, -1)
			fbcEnd(1)
		end if
	end select

	'' On darwin need to change the default asm syntax when using gen gcc because
	'' most C compilers on OSX seem to be configured without intel syntax support;
	'' probably because Apple as and llvm-mc have horribly broken intel support.
	if( (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DARWIN) and _
		(fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS) ) then
		fbSetOption( FB_COMPOPT_ASMSYNTAX, FB_ASMSYNTAX_ATT )
	end if

	if( fbc.asmsyntax >= 0 ) then
		'' -asm only applies to x86 and x86_64
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86, FB_CPUFAMILY_X86_64
		case else
			errReportEx( FB_ERRMSG_ASMOPTIONGIVENFORNONX86, fbGetTargetId( ), -1 )
		end select

		'' -gen gas only supports -asm intel
		if( ( (fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GAS) or (fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GAS64) ) and _
			(fbc.asmsyntax <> FB_ASMSYNTAX_INTEL) ) then
			errReportEx( FB_ERRMSG_GENGASWITHOUTINTEL, "", -1 )
		end if

		'' -asm overrides the target's default
		fbSetOption( FB_COMPOPT_ASMSYNTAX, fbc.asmsyntax )
	end if

	'' Enable -pic automatically when building a shared library on non-x86 Unixes
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		if( hTargetNeedsPIC( ) ) then
			fbSetOption( FB_COMPOPT_PIC, TRUE )
		end if
	end if

	'' Complain if -pic was given in cases where it's not needed/supported
	if( fbGetOption( FB_COMPOPT_PIC ) ) then
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE ) then
			errReportEx( FB_ERRMSG_PICNOTSUPPORTEDFOREXE, "", -1 )
		elseif( hTargetNeedsPIC( ) = FALSE ) then
			errReportEx( FB_ERRMSG_PICNOTSUPPORTEDFORTARGET, "", -1 )
		end if
	end if

	'' Update the stacksize for the current target options if
	'' stacksize was never set yet by passing a negative stacksize
	fbSetOption( FB_COMPOPT_STACKSIZE, -1 )

	'' TODO: Check whether subsystem/stacksize/xboxtitle were set and
	'' complain about it when the target doesn't allow it, or just
	'' ignore silently (that might not even be too bad for portability)?
end sub

'' Determine base/prefix path
private sub fbcDeterminePrefix( )
	'' Not already set from -prefix command line option?
	if( len( fbc.prefix ) = 0 ) then
		'' Then default to exepath() or the hard-coded prefix
		#ifdef ENABLE_PREFIX
			fbc.prefix = ENABLE_PREFIX + FB_HOST_PATHDIV
		#else
			fbc.prefix = pathStripDiv( exepath( ) ) + FB_HOST_PATHDIV
			#ifndef ENABLE_STANDALONE
				'' Non-standalone fbc is in prefix/bin,
				'' just add '..' to get to prefix
				fbc.prefix += ".." + FB_HOST_PATHDIV
			#endif
		#endif
	else
		fbc.prefix = pathStripDiv( fbc.prefix ) + FB_HOST_PATHDIV
	end if
end sub

private sub fbcSetupCompilerPaths( )
	''
	'' Standalone (classic FB):
	''
	''    bin/os[-arch]/
	''    inc/
	''    lib/os[-arch]/
	''
	'' Normal (unix-style):
	''
	''    bin/[target-]
	''    include/freebasic[suffix]/
	''    lib/freebasic[suffix]/{target | os[-arch]}/
	''
	'' x86 standalone traditionally uses the win32/dos/linux subdirs in bin/
	'' and lib/, named after the target OS. For other architectures, the
	'' arch name needs to be added to distinguish the subdir from the x86
	'' version. (especially for cross-compiling)
	''
	'' Normal has additional support for gcc targets (e.g. i686-pc-mingw32),
	'' which have to be prefixed to the executable names of cross-compiling
	'' tools in the bin/ directory (e.g. bin/i686-pc-mingw32-ld). However,
	'' for native compilation, no target is prefixed to bin/ tools at all.
	''
	'' Normal uses include/freebasic/ and lib/freebasic/ to hold FB includes
	'' and libraries, to stay out of the way of the C ones in include/ and
	'' lib/ and to conform to Linux distro packaging standards.
	''
	'' With ENABLE_LIB64, we put 64bit libs into
	''    lib64/freebasic/<target>/
	'' instead of the default
	''    lib/freebasic/<target>/
	'' lib/ is then used for 32bit libs only. This is useful for some Linux
	'' distros which use lib/ and lib64/ this way.
	''
	'' - The paths are not terminated with [back]slashes here,
	''   except for the bin/ path. fbcFindBin() expects to only have to
	''   append the file name, for example:
	''     "prefix/bin/win32/" + "as.exe"
	''     "prefix/bin/" + "ld"
	''     "prefix/bin/i686-w64-mingw32-" + "ld"
	''

	dim as string targetid = fbGetTargetId( )

#ifdef ENABLE_STANDALONE
	'' Use default target name
	fbc.binpath = fbc.prefix + "bin" + FB_HOST_PATHDIV + targetid + FB_HOST_PATHDIV
	fbc.incpath = fbc.prefix + "inc"
	fbc.libpath = fbc.prefix + "lib" + FB_HOST_PATHDIV + targetid
#else
	dim as string fbname
	#ifdef __FB_DOS__
		'' Our subdirectory in include/ and lib/ is usually called
		'' freebasic/, but on DOS that's too long... of course almost
		'' no targetid or suffix can be used either.
		fbname = "freebas"
	#else
		fbname = "freebasic"
	#endif
	#ifdef ENABLE_SUFFIX
		fbname += ENABLE_SUFFIX
	#endif

	dim libdirname as string = "lib"
	#ifdef ENABLE_LIB64
		if( fbIs64Bit( ) ) then
			libdirname = "lib64"
		end if
	#endif

	if( len(fbc.buildprefix) > 0 ) then
		fbc.binpath = fbc.prefix + "bin"     + FB_HOST_PATHDIV + fbc.buildprefix
	else
		fbc.binpath = fbc.prefix + "bin"     + FB_HOST_PATHDIV + fbc.targetprefix
	end if
	fbc.incpath = fbc.prefix + "include" + FB_HOST_PATHDIV + fbname
	fbc.libpath = fbc.prefix + libdirname + FB_HOST_PATHDIV + fbname + FB_HOST_PATHDIV + targetid
#endif
end sub

private sub fbcPrintTargetInfo( )
	var s = fbGetTargetId( )
	s += ", " + *fbGetFbcArch( )
	s += ", " & fbGetBits( ) & "bit"
	#ifndef ENABLE_STANDALONE
		if( len( fbc.target ) > 0 ) then
			s += " (" + fbc.target + ")"
		end if
	#endif
	print "target:", s
	print "backend:", fbGetBackendName( fbGetOption( FB_COMPOPT_BACKEND ) )
end sub

private sub fbcDetermineMainName( )
	'' Determine the main module path/name if not given via -m
	if (len(fbc.mainname) = 0) then
		'' 1) First input .bas module
		dim as FBCIOFILE ptr m = listGetHead( @fbc.modules )
		if( m ) then
			fbc.mainname = m->srcfile
		else
			'' 2) First input .o
			dim as string ptr objf = listGetHead( @fbc.objlist )
			if( objf <> NULL ) then
				fbc.mainname = *objf
			else
				'' 3) Neither input .bas nor .o, that is rare,
				'' but happens in this case:
				''      $ fbc a.bas -lib -m a
				''      $ fbc b.bas -lib
				''      $ fbc -l a -l b
				'' Usually -x is used too though, so this
				'' fallback name won't be seen often.
				'' This name should be 8.3 compatible (for DOS)
				fbc.mainname = "unnamed"
			end if
		end if
		fbc.mainname = hStripExt(fbc.mainname)
	end if
end sub

'' Build the intermediate file name for the given module and step
private function hGetAsmName _
	( _
		byval module as FBCIOFILE ptr, _
		byval stage as integer _
	) as string

	dim as zstring ptr ext = any
	dim as string asmfile

	'' Based on the objfile name so it's also affected by -o
	asmfile = hStripExt( *module->objfile )

	if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
		ext = @".asm"
	else
		ext = @".o"
	end if
	if( stage = 1 ) then
		select case( fbGetOption( FB_COMPOPT_BACKEND ) )
		case FB_BACKEND_GCC
			ext = @".c"
		case FB_BACKEND_LLVM
			ext = @".ll"
		end select
	end if

	asmfile += *ext

	function = asmfile
end function

private sub hCompileBas _
	( _
		byval module as FBCIOFILE ptr, _
		byval is_main as integer, _
		byval is_fbctinf as integer, _
		byval module_count as integer _
	)

	dim as integer prevlang = any, prevouttype = any
	dim as string asmfile, pponlyfile

	asmfile = hGetAsmName( module, 1 )

	'' -pp?
	if( fbGetOption( FB_COMPOPT_PPONLY ) ) then
		'' Re-use the full -o path/filename for the -pp output file,
		'' since no .o will be generated anyways (if -o was given)
		pponlyfile = *module->objfile
		if( module->is_custom_objfile = FALSE ) then
			'' Otherwise, use a default file name
			pponlyfile = hStripExt( pponlyfile ) + ".pp.bas"
		end if
	end if

	if( fbc.verbose ) then
		print "compiling: ", module->srcfile; " -o "; asmfile;
		if( fbGetOption( FB_COMPOPT_PPONLY ) ) then
			print " -pp " + pponlyfile;
		end if
		if( is_main ) then
			print " (main module)";
		elseif( is_fbctinf ) then
			print " (FB compile-time info)";
		end if
		print
	end if

	'' Restarting with a new lang option?
	'' We need to initialize with the restart lang
	if( fbGetOption( FB_COMPOPT_RESTART_LANG ) <> FB_LANG_INVALID ) then
		fbSetOption( FB_COMPOPT_LANG, fbGetOption( FB_COMPOPT_RESTART_LANG ) )
	end if

	'' preserve orginal values that might have to restored
	'' (e.g. -lang mode could be overwritten while parsing due to #lang,
	'' but that shouldn't affect other modules)
	prevlang = fbGetOption( FB_COMPOPT_LANG )
	prevouttype = fbGetOption( FB_COMPOPT_OUTTYPE )

	if( is_fbctinf ) then
		'' Switch to -c mode temporarily to get the compiler to write objinfo
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
	end if

	do
		'' Clean up stage 1 output (FB backend's output, *.asm/*.c/*.ll),
		'' unless -R was given, and additionally in case of -gen gas, unless -RR
		'' was given (because for -gen gas, the FB backend's .asm output is also
		'' the final .asm which -RR is supposed to preserve).
		if( (not fbc.keepasm) and _
			(((fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS) and (fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS64) ) or _
			(not fbc.keepfinalasm)) ) then
			fbcAddTemp( asmfile )

		'' first module? handle side effects of #cmdline
		elseif( module_count = 1 ) then
			'' Keep the asm file.  If the keep option was in a #cmdline then
			'' the temporary file probably was already added to the fbc.temps
			'' list on the first pass in to the parser (unless real command
			'' line also had an option to keep the asm file).

			if( fbRestartGetCount() > 0 ) then
				fbcRemoveTemp( asmfile )
			end if
		end if

		'' init the parser (note: initializes env)
		fbInit( is_main, fbc.entry, module_count )

		if( is_fbctinf ) then
			'' Let the compiler know about all libs collected so far,
			'' so the fbctinf module represents all the other modules
			'' compiled/included in this fbc invocation.
			fbSetLibs( @fbc.finallibs, @fbc.finallibpaths )
		else
			'' Add only the libs and paths passed on the command line,
			'' so this module will only include objinfo for those libs
			'' and the ones found while parsing it, but not unrelated
			'' libs from other modules.
			fbSetLibs( @fbc.libs, @fbc.libpaths )
		end if

		fbCompile( module->srcfile, asmfile, pponlyfile, is_main )

		'' If there were any errors during parsing, just exit without
		'' doing anything else.
		if( errGetCount( ) > 0 ) then
			fbcEnd( 1 )
		end if

		'' Don't restart unless asked for
		if( fbShouldRestart( ) = FALSE ) then
			exit do
		end if

		'' Close the request to restart the parser
		fbRestartEndRequest( FB_RESTART_PARSER )

		'' Shutdown the parser before restarting
		fbEnd( )

		'' Still have restart set?  It must be a request to restart fbc
		if( fbShouldRestart( ) ) then
			'' Restore original #lang? only if we didn't set a new lang to restart with
			if( fbGetOption( FB_COMPOPT_RESTART_LANG ) = FB_LANG_INVALID ) then
				fbSetOption( FB_COMPOPT_LANG, prevlang )
			end if
			exit sub
		end if
	loop

	'' (unnecessary for the empty fbctinf module, it won't add anything new)
	if( is_fbctinf = FALSE ) then
		'' Update the list of libs and paths with the ones found when parsing
		fbGetLibs( @fbc.finallibs, @fbc.finallibpaths )
	end if

	'' Shutdown the parser
	fbEnd( )

	'' Restore original options
	if( is_fbctinf ) then
		fbSetOption( FB_COMPOPT_OUTTYPE, prevouttype )
	end if
	fbSetOption( FB_COMPOPT_LANG, prevlang )
end sub

private sub hCompileModules( )
	dim as integer ismain = any, checkmain = any
	dim as string mainfile
	dim as FBCIOFILE ptr module = any

	ismain = FALSE

	select case fbGetOption( FB_COMPOPT_OUTTYPE )
	case FB_OUTTYPE_EXECUTABLE, FB_OUTTYPE_DYNAMICLIB
		checkmain = TRUE
	case else
		'' When building an object or a library (-c/-r, -lib), nothing
		'' is compiled with ismain = TRUE until -m was given for it.
		'' This makes sense because -c is usually used to compile
		'' single modules of which only a very specific one is the
		'' main one (nobody would want -c to include main() everywhere),
		'' and because -lib is for making libraries which generally
		'' don't include a main module for programs to use.
		checkmain = fbc.mainset
	end select

	if( checkmain ) then
		'' Note: This causes the path given with -m to be ignored in
		'' the ismain check below. This is good because -m is easier
		'' to use that way (e.g. fbc ../../main.bas -m main), and bad
		'' because then modules with the same name but in different
		'' directories will both be seen as the main one.
		mainfile = hStripPath( fbc.mainname )
	end if

	module = listGetHead( @fbc.modules )

	if( module = NULL ) then
		'' No input .bas files to compile - make sure to add the libs
		'' from the command line to the final lists anyways.
		strsetCopy( @fbc.finallibs, @fbc.libs )
		strsetCopy( @fbc.finallibpaths, @fbc.libpaths )
		exit sub
	end if

	'' We have input .bas files to compile - hCompileBas() will take care of
	'' copying the command line libs into the final lists:
	'' 1. into the compiler
	''    (fbc.libs -> fbSetLibs() -> compiler)
	'' 2. compiler collects additional #inclibs etc...
	'' 3. and copy back into final lists
	''    (compiler -> fbGetLibs() -> fbc.finallibs)

	dim as integer module_count = 0
	do
		if( checkmain ) then
			ismain = (mainfile = hStripPath( hStripExt( module->srcfile ) ))
			'' Note: checking continues for all modules, because
			'' "the" main module could be passed multiple times,
			'' and it makes sense to always treat it the same,
			'' so that <fbc 1.bas 1.bas -c> generates the same 1.o
			'' twice and <fbc 1.bas 1.bas> causes a duplicated
			'' definition of main().
			/'checkmain = not ismain'/
		end if

		module_count += 1
		hCompileBas( module, ismain, FALSE, module_count )

		if( fbShouldRestart( ) ) then
			exit sub
		end if

		module = listGetNext( module )
	loop while( module )
end sub

private function hParseXpm _
	( _
		byref xpmfile as string, _
		byref code as string _
	) as integer

	code += !"\ndim shared as zstring ptr "
	code += "fb_program_icon_data"
	code += !"(0 to ...) = _\n{ _\n"

	dim as integer f = freefile( )
	if( open( xpmfile, for input, as #f ) ) then
		exit function
	end if

	dim as string ln

	'' Check for the header line
	line input #f, ln
	if( ucase( ln ) <> "/* XPM */" ) then
		'' Invalid XPM header
		close #f
		exit function
	end if

	'' Check for lines containing strings (color and pixel lines)
	'' Other lines (declaration line, empty lines, C comments, ...) aren't
	'' explicitely handled, but should automatically be ignored, as long as
	'' they don't contain strings.
	dim as integer saw_rows = FALSE
	while( eof( f ) = FALSE )
		line input #f, ln

		'' Strip everything in front of the first '"'
		ln = right( ln, len( ln ) - (instr( ln, """" ) - 1) )

		'' Strip everything behind the second '"'
		ln = left( ln, instr( 2, ln, """" ) )

		'' Got something left?
		if( len( ln ) > 0 ) then
			'' Add an entry to the array, in a new line,
			'' separated by a comma, if it's not the first one.
			if( saw_rows ) then
				code += !", _\n"
			end if
			code += !"\t@" + ln
			saw_rows = TRUE
		end if
	wend

	close #f

	if( saw_rows = FALSE ) then
		'' No image data found
		exit function
	end if

	'' Line break after the last entry
	code += !" _ \n"

	code += !"}\n\n"

	'' Symbol for the gfxlib
	code += !"extern as zstring ptr ptr fb_program_icon alias ""fb_program_icon""\n"
	code += "dim shared as zstring ptr ptr fb_program_icon = " & _
					!"@fb_program_icon_data(0)\n"

	function = TRUE
end function

'' Turns the .xpm icon resource into a .bas file,
'' then compiles that using the normal FB compilation process.
private function hCompileXpm( ) as integer
	dim as string xpmfile, code
	dim as integer fo = any

	if( len( fbc.xpm.srcfile ) = 0 ) then
		return TRUE
	end if

	'' Remember *.xpm file name
	xpmfile = fbc.xpm.srcfile

	'' Set *.bas name based on input file name or -o <file>:
	if( len( *fbc.xpm.objfile ) > 0 ) then
		fbc.xpm.srcfile = hStripExt( *fbc.xpm.objfile )
	end if

	'' foo.xpm -> foo.xpm.bas to avoid collision with foo.bas
	fbc.xpm.srcfile &= ".bas"

	if( fbc.verbose ) then
		print "parsing xpm: ", xpmfile & " -o " & fbc.xpm.srcfile
	end if

	if( hParseXpm( xpmfile, code ) = FALSE ) then
		'' TODO: show error message
		exit function
	end if

	fo = freefile( )
	if( open( fbc.xpm.srcfile, for output, as #fo ) ) then
		'' TODO: show error message
		exit function
	end if
	print #fo, code;
	close #fo

	'' Clean up the temp .bas if -R wasn't given
	if( fbc.keepasm = FALSE ) then
		fbcAddTemp( fbc.xpm.srcfile )
	end if

	hCompileBas( @fbc.xpm, FALSE, FALSE, -1 )
	function = TRUE
end function

private function hCompileStage2Module( byval module as FBCIOFILE ptr ) as integer
	dim as string ln, asmfile

	asmfile = hGetAsmName( module, 2 )
	'' Clean up stage 2 output (the final .asm for -gen gcc/llvm) unless
	'' -RR was given.
	if( (not fbc.keepfinalasm) and _
		((fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS) or _
		(not fbc.keepobj)) ) then
		fbcAddTemp( asmfile )
	end if

	select case( fbGetOption( FB_COMPOPT_BACKEND ) )
	case FB_BACKEND_GCC
		dim as boolean ism64target = false
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86
			ln += "-m32 "
		case FB_CPUFAMILY_X86_64
			ln += "-m64 "
			ism64Target = True
		case FB_CPUFAMILY_PPC
			ln += "-m32 "
		case FB_CPUFAMILY_PPC64, FB_CPUFAMILY_PPC64LE
			ln += "-m64 "
			ism64Target = True
		end select

		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			'' GCC doesn't recognize the -march option and PowerPC combination and recommendeds
			'' the -mcpu option be used for PowerPC.
			if( (fbGetCpuFamily( ) = FB_CPUFAMILY_PPC) orelse (fbGetCpuFamily( ) = FB_CPUFAMILY_PPC64) orelse (fbGetCpuFamily( ) = FB_CPUFAMILY_PPC64LE) ) then
				if( fbc.cputype_is_native ) then
					ln += "-mcpu=native "
				else
					ln += "-mcpu=" + *fbGetGccArch( ) + " "
				end if
			else
				if( fbc.cputype_is_native ) then
					ln += "-march=native "
				else
					ln += "-march=" + *fbGetGccArch( ) + " "
				end if
			end if
		end if

		if( fbGetOption( FB_COMPOPT_PIC ) ) then
			ln += "-fPIC "
		end if

		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			ln += "-S -nostdlib -nostdinc -Wall "

			'' -Wno-unused-but-set-variable and the warning it suppresses were introduced
			'' in GCC 4.6. Don't pass that flag to avoid an error on earlier GCC. As a
			'' result, to disable the warning on 4.6+ need to disable all unused warnings...
			' ln += "-Wno-unused-label -Wno-unused-function -Wno-unused-variable "
			' ln += "-Wno-unused-but-set-variable "
			ln += "-Wno-unused "
		else
			'if Emscripten is used, we will skip the assembly generation and compile directly to object code
			ln += "-c -nostdlib -nostdinc -Wall -Wno-unused-label " + _
				"-Wno-unused-function -Wno-unused-variable "
			ln += "-Wno-warn-absolute-paths "
		end if

		'' Don't warn about non-standard main() signature
		'' (we emit "ubyte **argv" instead of "char **argv")
		ln += "-Wno-main "

		'' helps finding ir-hlc bugs
		ln += "-Werror-implicit-function-declaration "

		ln += "-O" + str( fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) ) + " "

		'' Do not let gcc make assumptions about pointers; FB isn't strict about it.
		ln += "-fno-strict-aliasing "

		'' Ignore .ident directives on win32 targets to prevent identification strings
		'' from accumulating in the final binary (each .ident string from every object
		'' module is added to the final binary even when strings are identical).
		select case as const( fbGetOption( FB_COMPOPT_TARGET ) )
		case FB_COMPTARGET_WIN32
			ln += "-fno-ident "
		end select

		'' The rtlib sets its own rounding mode, don't let gcc make assumptions.
		if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
			ln += "-frounding-math "
		end if

		'' ?
		ln += "-fno-math-errno "

		'' Note: we shouldn't use some options like e.g. -ffast-math, because
		'' they cause incompatibilities with the ASM backend. For example:
		''    dim as double d = INF
		''    print d - d
		'' prints -NaN (IND) under the ASM backend because the FPU does the
		'' subtraction, however with the C backend with, gcc -ffast-math
		'' optimizes out the subtraction (even under -O0) and inserts 0 instead.

		'' Define signed integer overflow
		ln += "-fwrapv "

		'' Avoid gcc exception handling bloat
		ln += "-fno-exceptions -fno-asynchronous-unwind-tables "

		'' But enable unwind-tables on x64, these GREATLY increase the accuracy of
		'' debuggers and crash tools across platforms for minimal overhead
		if( (ism64Target = TRUE) or (fbGetOption( FB_COMPOPT_UNWINDINFO ) = TRUE) ) then
			ln += "-funwind-tables "
		else
			ln += "-fno-unwind-tables "
		end if

		'' Prevent format string errors on gcc 9.x. (enabled by default with '-Wall')
		'' TODO: fbc currently emits the ZSTRING type as 'uint8' when it
		'' should probably preserve the 'char' type.  In C, there are 3
		'' distinct types, 'char', 'unsigned char', 'signed char'.
		'' See ir-hlc.bas:hEmitType()
		ln += "-Wno-format "

		if( fbGetOption( FB_COMPOPT_DEBUGINFO ) ) then
			ln += "-g "
		end if

		if( fbGetOption( FB_COMPOPT_FPUTYPE ) = FB_FPUTYPE_SSE ) then
			ln += "-mfpmath=sse -msse2 "
		end if

		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86, FB_CPUFAMILY_X86_64
			if( fbGetOption( FB_COMPOPT_ASMSYNTAX ) = FB_ASMSYNTAX_INTEL ) then
				ln += "-masm=intel "
			end if
		end select

	case FB_BACKEND_LLVM
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86
			ln += "-march=x86 "
		case FB_CPUFAMILY_X86_64
			ln += "-march=x86-64 "
		case FB_CPUFAMILY_ARM
			ln += "-march=arm "
		case FB_CPUFAMILY_AARCH64
			'' From the GCC manual:
			'' -march=name
			'' Specify the name of the target architecture and,
			'' optionally, one or more feature modifiers. This option
			'' has the form -march=arch{+[no]feature}*.
			''
			'' The permissible values for arch are
			'' 'armv8-a'
			'' 'armv8.1-a' = 'armv8-a' + ARMv8.1-A
			'' 'armv8.2-a' = 'armv8.1-a' + ARMv8.2-A
			'' 'armv8.3-a' = 'armv8.2-a' + ARMv8.3-A
			'' 'armv8.4-a' = 'armv8.3-a' + ARMv8.4-A
			'' 'armv8.5-a' = 'armv8.4-a' + ARMv8.5-A
			'' 'native' = architecture of the host system
			''
			'' It enables the '+crc', '+lse', and '+rdma' features.
			''
			'' The value 'native' is available on native AArch64
			'' GNU/Linux and causes the compiler to pick the
			'' architecture of the host system. This option has no
			'' effect if the compiler is unable to recognize the
			'' architecture of the host system, The permissible
			'' values for feature are listed in the sub-section on
			'' ['-march' and '-mcpu' Feature Modifiers]. Where
			'' conflicting feature modifiers are specified, the
			'' right-most feature is used. GCC uses name to determine
			'' what kind of instructions it can emit when generating
			'' assembly code. If '-march' is specified without either
			'' of '-mtune' or '-mcpu' also being specified, the code
			'' is tuned to perform well across a range of target
			'' processors implementing the target architecture.

			ln += "-march=armv8-a "
		case FB_CPUFAMILY_PPC
			ln += "-mcpu=powerpc "
		case FB_CPUFAMILY_PPC64
			ln += "-mcpu=powerpc64 "
		case FB_CPUFAMILY_PPC64LE
			ln += "-mcpu=powerpc64le "
		end select

		if( fbGetOption( FB_COMPOPT_PIC ) ) then
			ln += "-relocation-model=pic "
		end if

		ln += "-O" + str( fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) ) + " "

		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86, FB_CPUFAMILY_X86_64
			if( fbGetOption( FB_COMPOPT_ASMSYNTAX ) = FB_ASMSYNTAX_INTEL ) then
				ln += "--x86-asm-syntax=intel "
			end if
		end select

	end select

	ln += """" + hGetAsmName( module, 1 ) + """ "
	ln += "-o """ + asmfile + """"
	ln += fbc.extopt.gcc

	select case( fbGetOption( FB_COMPOPT_BACKEND ) )
	case FB_BACKEND_GCC
		var gcc = FBCTOOL_GCC
		if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_JS ) then
			gcc = FBCTOOL_EMCC
		end if
		function = fbcRunBin( "compiling C", gcc, ln )
	case FB_BACKEND_LLVM
		function = fbcRunBin( "compiling LLVM IR", FBCTOOL_LLC, ln )
	end select
end function

private sub hCompileStage2Modules( )
	dim as FBCIOFILE ptr module = listGetHead( @fbc.modules )
	while( module )
		if( hCompileStage2Module( module ) = FALSE ) then
			fbcEnd( 1 )
		end if
		module = listGetNext( module )
	wend
end sub

private function hAssembleModule( byval module as FBCIOFILE ptr ) as integer
	dim as string ln

	select case( fbGetCpuFamily( ) )
	case FB_CPUFAMILY_X86
		if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DARWIN) then
			ln += "-arch i386 "
		else
			ln += "--32 "
		endif
	case FB_CPUFAMILY_X86_64
		if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DARWIN) then
			ln += "-arch x86_64 "
		else
			ln += "--64 "
		endif
	end select

	if( fbGetOption( FB_COMPOPT_DEBUGINFO ) = FALSE ) then
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DARWIN) then
			if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
				ln += "--strip-local-absolute "
			end if
		endif
	end if

	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_JS ) then
		'' We will skip assemble stage, since it is already performed by Emscripten
		function = TRUE
		exit function
	end if

	ln += """" + hGetAsmName( module, 2 ) + """ "
	ln += "-o """ + *module->objfile + """"
	ln += fbc.extopt.gas

	var gas = FBCTOOL_AS
	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_JS ) then
		gas = FBCTOOL_EMAS
	end if

	if( fbcRunBin( "assembling", gas, ln ) = FALSE ) then
		exit function
	end if

	'' Clean up the .o if -C wasn't given
	if( fbc.keepobj = FALSE ) then
		fbcAddTemp( *module->objfile )
	end if

	function = TRUE
end function

private sub hAssembleModules( )
	dim as FBCIOFILE ptr module = listGetHead( @fbc.modules )
	while( module )
		if( hAssembleModule( module ) = FALSE ) then
			fbcEnd( 1 )
		end if
		module = listGetNext( module )
	wend
end sub

private function hAssembleRc( byval rc as FBCIOFILE ptr ) as integer
#ifdef ENABLE_GORC
	'' Using GoRC for the classical native win32 standalone build
	'' Note: GoRC /fo doesn't accept anything except *.obj, not even *.o,
	'' so we need to make it *.obj and then rename it afterwards.

	dim as integer need_rename = FALSE

	'' Ensure to use *.obj so GoRC accepts it
	if( hGetFileExt( *rc->objfile ) <> "obj" ) then
		need_rename = TRUE
		*rc->objfile += ".obj"
	end if

	'' Change the include env var to point to the (hopefully present)
	'' win/rc/*.h headers.
	dim as string oldinclude = trim( environ( "INCLUDE" ) )
	setenviron "INCLUDE=" + fbc.incpath + _
			(FB_HOST_PATHDIV + "win" + FB_HOST_PATHDIV + "rc")

	dim as string ln = "/ni /nw /o "

	if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86_64 ) then
		ln += "/machine X64 "
	end if

	ln &= "/fo """ & *rc->objfile & """"
	ln &= " """ & rc->srcfile & """"

	if( fbcRunBin( "compiling rc", FBCTOOL_GORC, ln ) = FALSE ) then
		exit function
	end if

	'' restore the include env var
	if( len( oldinclude ) > 0 ) then
		setenviron "INCLUDE=" + oldinclude
	end if

	if( need_rename ) then
		dim as string badname = *rc->objfile
		*rc->objfile = hStripExt( *rc->objfile )
		'' Rename back so it will be found by ld/the user
		function = (name( badname, *rc->objfile ) = 0)
	else
		function = TRUE
	end if
#else
	'' Using binutils' windres for all other setups (e.g. cross-compiling
	'' linux -> win32)
	'' Note: windres uses gcc -E to preprocess the .rc by default,
	'' that may not be 100% compatible to GoRC.

	dim as string ln = "--output-format=coff --include-dir=."
	ln += " """ + rc->srcfile + """"
	ln += " """ + *rc->objfile + """"

	function = fbcRunBin( "compiling rc", FBCTOOL_WINDRES, ln )
#endif

	'' Clean up the .o if -C wasn't given
	if( fbc.keepobj = FALSE ) then
		fbcAddTemp( *rc->objfile )
	end if
end function

private sub hAssembleRcs( )
	'' Compile .rc/.res files
	dim as FBCIOFILE ptr rc = listGetHead( @fbc.rcs )
	while( rc )
		if( hAssembleRc( rc ) = FALSE ) then
			fbcEnd( 1 )
		end if
		rc = listGetNext( rc )
	wend
end sub

private sub hAssembleXpm( )
	if( len( fbc.xpm.srcfile ) > 0 ) then
		if( fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS ) then
			hCompileStage2Module( @fbc.xpm )
		end if
		if( hAssembleModule( @fbc.xpm ) = FALSE ) then
			fbcEnd( 1 )
		end if
	end if
end sub

private function hCompileFbctinf( ) as integer
	dim as FBCIOFILE fbctinf
	dim as string objfile
	dim as integer fo = any

	'' Compile an empty .bas into the fbctinf object file
	'' (it will contain only objinfo)
	fbctinf.srcfile = FB_INFOSEC_BASNAME
	objfile = FB_INFOSEC_OBJNAME
	fbctinf.objfile = @objfile

	if( fbc.verbose ) then
		print "creating: ", fbctinf.srcfile
	end if

	'' Create the empty .bas file
	fo = freefile( )
	if( open( fbctinf.srcfile, for output, as #fo ) ) then
		exit function
	end if
	close #fo

	'' Clean up the temp .bas if -R wasn't given
	if( fbc.keepasm = FALSE ) then
		fbcAddTemp( fbctinf.srcfile )
	end if

	hCompileBas( @fbctinf, FALSE, TRUE, -1 )
	if( fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS ) then
		hCompileStage2Module( @fbctinf )
	end if
	function = hAssembleModule( @fbctinf )
end function

private function hArchiveFiles( ) as integer
	hSetOutName( )

	'' Remove lib*.a if it already exists, because ar doesn't overwrite
	safeKill( fbc.outname )

	dim as string ln = "-rsc " + QUOTE + fbc.outname + (QUOTE + " ")

	if( fbGetOption( FB_COMPOPT_OBJINFO ) and (not fbIsCrossComp( )) ) then
		if( hCompileFbctinf( ) ) then
			'' The objinfo reader expects the fbctinf object to be
			'' the first object file in libraries, so it must be
			'' specified first on the archiver command line:
			ln += QUOTE + FB_INFOSEC_OBJNAME + QUOTE + " "
		end if
		fbcAddTemp( FB_INFOSEC_OBJNAME )
	end if

	dim as string ptr objfile = listGetHead( @fbc.objlist )
	while( objfile )
		ln += """" + *objfile + """ "
		objfile = listGetNext( objfile )
	wend

	var ar = FBCTOOL_AR
	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_JS ) then
		ar = FBCTOOL_EMAR
	end if

	'' invoke ar
	function = fbcRunBin( "archiving", ar, ln )
end function

private sub hSetDefaultLibPaths( )
	'' compiler's lib/
	fbcAddDefLibPath( fbc.libpath )

	'' and the current path
	fbcAddDefLibPath( "." )

#ifndef ENABLE_STANDALONE
	'' Add gcc's private lib directory, to find libgcc
	'' This is for installing into Unix-like systems, and not for
	'' standalone, which has libgcc in the main lib/.
	if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_JS ) then
		fbcAddLibPathFor( "libgcc.a" )

		#ifndef DISABLE_STDCXX_PATH
			'' we don't specifically need c++, but for some users that do want to
			'' interop with c++ and to allow some of the tests/cpp tests to pass
			'' it's helpful to also query for a c++ library.
			select case fbGetOption( FB_COMPOPT_TARGET )
			case FB_COMPTARGET_FREEBSD
				fbcAddLibPathFor( "libc++.so" )
			case FB_COMPTARGET_DOS
				fbcAddLibPathFor( "libstdcx.a" )
			case else
				fbcAddLibPathFor( "libstdc++.so" )
			end select
		#endif
	end if

	select case( fbGetOption( FB_COMPOPT_TARGET ) )
	case FB_COMPTARGET_DOS
		'' Help out the DJGPP linker to find DJGPP's lib/ dir.
		'' It doesn't seem to add it by default like on other systems.
		'' Note: Can't use libc here, we have a fixed copy of that in
		'' the compiler's lib/ dir.
		fbcAddLibPathFor( "libm.a" )
	case FB_COMPTARGET_WIN32
		'' Help the MinGW linker to find MinGW's lib/ dir, allowing
		'' the C:\MinGW dir to be renamed and linking to still work.
		fbcAddLibPathFor( "libmingw32.a" )
	end select
#endif
end sub

private sub fbcAddDefLib(byval libname as zstring ptr)
	strsetAdd(@fbc.finallibs, *libname, TRUE)
end sub

private function hGetFbLibNameSuffix( ) as string
	dim s as string
	if( fbGetOption( FB_COMPOPT_MULTITHREADED ) ) then
		s += "mt"
	end if
	if( fbGetOption( FB_COMPOPT_PIC ) ) then
		s += "pic"
	end if
	function = s
end function

private sub hAddDefaultLibs( )
	'' select the right FB rtlib
	if( fbGetOption( FB_COMPOPT_FBRT ) ) then
		fbcAddDefLib( "fbrt" + hGetFbLibNameSuffix( ) )
	else
		fbcAddDefLib( "fb" + hGetFbLibNameSuffix( ) )
	end if

	'' and the gfxlib, if gfx functions were used
	if( fbGetOption( FB_COMPOPT_FBGFX ) ) then
		fbcAddDefLib( "fbgfx" + hGetFbLibNameSuffix( ) )

		select case as const( fbGetOption( FB_COMPOPT_TARGET ) )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbcAddDefLib( "gdi32" )
			fbcAddDefLib( "winmm" )

		case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
			FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD, _
			FB_COMPTARGET_DARWIN, FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS

			#if defined(__FB_LINUX__) or _
				defined(__FB_FREEBSD__) or _
				defined(__FB_DRAGONFLY__) or _
				defined(__FB_SOLARIS__) or _
				defined(__FB_OPENBSD__) or _
				defined(__FB_NETBSD__)
				fbcAddDefLibPath( "/usr/X11R6/lib" )
			#endif

			#if defined(__FB_DARWIN__) and defined(ENABLE_XQUARTZ)
				fbcAddDefLibPAth( "/opt/X11/lib" )
			#endif

			#if (not defined(__FB_DARWIN__)) or defined(ENABLE_XQUARTZ)
				fbcAddDefLib( "X11" )
				fbcAddDefLib( "Xext" )
				fbcAddDefLib( "Xpm" )
				fbcAddDefLib( "Xrandr" )
				fbcAddDefLib( "Xrender" )
			#endif

		end select
	end if

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "cygwin" )
		fbcAddDefLib( "kernel32" )
		fbcAddDefLib( "user32" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			fbcAddDefLib( "gmon" )
		end if

	case FB_COMPTARGET_DARWIN
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "System" )
		fbcAddDefLib( "pthread" )
		fbcAddDefLib( "ncurses" )

	case FB_COMPTARGET_DOS
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "c" )
		fbcAddDefLib( "m" )
		if( fbGetOption( FB_COMPOPT_MULTITHREADED ) ) then
			fbcAddDefLib( "pthread" )
			fbcAddDefLib( "socket" )
		end if

	case FB_COMPTARGET_FREEBSD
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "pthread" )
		fbcAddDefLib( "c" )
		fbcAddDefLib( "m" )
		fbcAddDefLib( "ncurses" )

	case FB_COMPTARGET_DRAGONFLY, FB_COMPTARGET_SOLARIS
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "pthread" )
		fbcAddDefLib( "c" )
		fbcAddDefLib( "m" )
		fbcAddDefLib( "ncurses" )

	case FB_COMPTARGET_LINUX
		''
		'' Notes:
		''
		'' When linking statically, -lpthread apparently should be
		'' linked before -lc. Otherwise there can be errors due to
		'' -lpthread/-lc containing overlapping symbols (but the pthread
		'' ones should be used). This is confirmed by minimal testing,
		'' searching the web and 'gcc -pthread' behavior.
		''
		'' libncurses and libtinfo: FB's rtlib depends on the libtinfo
		'' part of ncurses, which sometimes is included in libncurses
		'' and sometimes separate (depending on how ncurses was built).

		'' Prefer libtinfo over libncurses
		if( (len( fbcFindLibFile( "libtinfo.a"  ) ) > 0) or _
			(len( fbcFindLibFile( "libtinfo.so" ) ) > 0) ) then
			fbcAddDefLib( "tinfo" )
		else
			fbcAddDefLib( "ncurses" )
		end if

		fbcAddDefLib( "m" )
		fbcAddDefLib( "dl" )
		fbcAddDefLib( "pthread" )
		fbcAddDefLib( "gcc" )
		'' Link libgcc_eh if it exists (it depends on the gcc build)
		if( (len( fbcFindLibFile( "libgcc_eh.a"  ) ) > 0) or _
			(len( fbcFindLibFile( "libgcc_eh.so" ) ) > 0) ) then
			fbcAddDefLib( "gcc_eh" )
		end if
		fbcAddDefLib( "c" )

	case FB_COMPTARGET_NETBSD
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "pthread" )
		fbcAddDefLib( "c" )
		fbcAddDefLib( "m" )
		fbcAddDefLib( "ncurses" )

	case FB_COMPTARGET_OPENBSD
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "pthread" )
		fbcAddDefLib( "c" )
		fbcAddDefLib( "m" )
		fbcAddDefLib( "ncurses" )

	case FB_COMPTARGET_WIN32
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "msvcrt" )
		fbcAddDefLib( "kernel32" )
		fbcAddDefLib( "user32" )
		fbcAddDefLib( "mingw32" )
		fbcAddDefLib( "mingwex" )
		fbcAddDefLib( "moldname" )

		'' Link libgcc_eh if it exists
		if( (len( fbcFindLibFile( "libgcc_eh.a"     ) ) > 0) or _
			(len( fbcFindLibFile( "libgcc_eh.dll.a" ) ) > 0) ) then
			'' Needed by mingw.org toolchain, but not TDM-GCC
			fbcAddDefLib( "gcc_eh" )
		end if

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			fbcAddDefLib( "gmon" )
		end if

	case FB_COMPTARGET_XBOX
		fbcAddDefLib( "gcc" )
		fbcAddDefLib( "fbgfx" )
		fbcAddDefLib( "openxdk" )
		fbcAddDefLib( "hal" )
		fbcAddDefLib( "c" )
		fbcAddDefLib( "usb" )
		fbcAddDefLib( "xboxkrnl" )
		fbcAddDefLib( "m" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			fbcAddDefLib( "gmon" )
		end if

	end select

end sub

private sub hExcludeLibsFromLink( )
	'' Remove any excluded libs from fbc.finallibs list
	dim as TSTRSETITEM ptr i = listGetHead(@fbc.excludedlibs.list)
	while i
		strsetDel(@fbc.finallibs, i->s)
		i = listGetNext(i)
	wend
end sub

private sub hPrintOptions( byval verbose as integer )
	'' Note: must print each line separately to let the rtlib print the
	'' proper line endings even if redirected to file/pipe, hard-coding \n
	'' here isn't enough for DOS/Windows.

	print "usage: fbc [options] <input files>"
	print "input files:"
	print "  *.a = static library, *.o = object file, *.bas = source"
	print "  *.rc = resource script, *.res = compiled resource (win32)"
	print "  *.xpm = icon resource (*nix/*bsd)"
	print "options:"
	print "  @<file>          Read more command line arguments from a file"
	print "  -a <file>        Treat file as .o/.a input file"
	print "  -arch <type>     Set target architecture (default: 686)"
	print "  -asm att|intel   Set asm format (-gen gcc|llvm, x86 or x86_64 only)"
	print "  -b <file>        Treat file as .bas input file"
	if( verbose ) then
	print "  -buildprefix <name>  specify prefix on tool names (as, ar, ld)"
	end if
	print "  -c               Compile only, do not link"
	print "  -C               Preserve temporary .o files"
	print "  -d <name>[=<val>]  Add a global #define"
	print "  -dll             Same as -dylib"
	print "  -dylib           Create a DLL (win32) or shared library (*nix/*BSD)"
	print "  -e               Enable runtime error checking"

	if( verbose ) then
	print "  -earray          Enable array bounds checking"
	print "  -eassert         Enable assert() and assertwarn() checking"
	print "  -edebug          Enable __FB_DEBUG__"
	print "  -edebuginfo      Add debug info"
	print "  -elocation       Enable error location reporting"
	print "  -enullptr        Enable null-pointer checking"
	print "  -eunwind         Enable call stack unwind information"
	print "  -entry           Change the entry point of the program from main()"
	end if

	print "  -ex              -e plus RESUME support"
	print "  -exx             -ex plus array bounds/null-pointer checking"
	print "  -export          Export symbols for dynamic linkage"
	if( verbose ) then
	print "  -fbgfx           Link to the appropriate libfbgfx variant (normally automatic)"
	end if
	print "  -forcelang <name>  Override #lang statements in source code"
	if( verbose ) then
	print "  -fpmode fast|precise  Select floating-point math accuracy/speed"
	print "  -fpu x87|sse     Set target FPU"
	end if
	print "  -g               Add debug info, enable __FB_DEBUG__, and enable assert()"

	if( verbose ) then
	print "  -gen gas         Select GNU gas 32-bit assembler backend"
	print "  -gen gas64       Select GNU gas 64-bit assembler backend"
	print "  -gen gcc         Select GNU gcc C backend"
	print "  -gen llvm        Select LLVM backend"
	else
	print "  -gen gas|gas64|gcc|llvm  Select code generation backend"
	end if

	print "  [-]-help         Show this help output; use '-help -v' to show verbose help"
	print "  -i <path>        Add an include file search path"
	print "  -include <file>  Pre-#include a file for each input .bas"
	print "  -l <name>        Link in a library"
	print "  -lang <name>     Select FB dialect: fb, deprecated, fblite, qb"
	print "  -lib             Create a static library"
	print "  -m <name>        Specify main module (default if not -c: first input .bas)"
	print "  -map <file>      Save linking map to file"
	print "  -maxerr <n>      Only show <n> errors"
	print "  -mt              Use thread-safe FB runtime"
	print "  -nodeflibs       Do not include the default libraries when linking"
	print "  -noerrline       Do not show source context in error messages"
	print "  -nolib <a,b,c>   Do not include the specified libraries when linking"
	print "  -noobjinfo       Do not read/write compile-time info from/to .o and .a files"
	print "  -nostrip         Do not strip symbol information from the output file"
	print "  -o <file>        Set .o (or -pp .bas) file name for prev/next input file"
	print "  -O <value>       Optimization level (default: 0)"
	print "  -p <path>        Add a library search path"
	print "  -pic             Generate position-independent code (non-x86 Unix shared libs)"
	print "  -pp              Write out preprocessed input file (.pp.bas) only"
	print "  -prefix <path>   Set the compiler prefix path"
	print "  -print host|target  Display host/target system name"
	print "  -print fblibdir  Display the compiler's lib/ path"
	print "  -print x         Display output binary/library file name (if known)"
	if( verbose ) then
	print "  -print sha-1     Display compiler's source code commit sha-1 (if known)"
	end if
	print "  -profile         Enable function profiling"
	print "  -r               Write out .asm/.c/.ll (-gen gas/gcc/llvm) only"
	print "  -rr              Write out the final .asm only"
	print "  -R               Preserve temporary .asm/.c/.ll/.def files"
	print "  -RR              Preserve the final .asm file"
	print "  -s console|gui   Select win32 subsystem"
	print "  -showincludes    Display a tree of file names of #included files"
	print "  -static          Prefer static libraries over dynamic ones when linking"
	print "  -strip           Omit all symbol information from the output file"
	print "  -t <value>       Set .exe stack size in kbytes, default: 1024 (win32/dos)"
	if( verbose ) then
	'' !!!TODO!!! provide more examples of available targets
	print "  -target <name>   Set cross-compilation target"
	else
	print "  -target <name>   Set cross-compilation target"
	end if
	print "  -title <name>    Set XBE display title (xbox)"
	print "  -v               Be verbose"
	print "  -vec <n>         Automatic vectorization level (default: 0)"
	print "  [-]-version      Show compiler version"
	print "  -w all|pedantic|<n>  Set min warning level: all, pedantic or a value"
	if( verbose ) then
	print "  -w all           Enable all warnings"
	print "  -w none          Disable all warnings"
	print "  -w param         Enable parameter warnings"
	print "  -w escape        Enable string escape sequence warnings"
	print "  -w next          Enable next statement warnings"
	print "  -w signedness    Enable type signedness warnings"
	print "  -w constness     Enable const type warnings"
	print "  -w suffix        Enable invalid suffix warnings"
	print "  -w error         Report warnings as errors"
	print "  -w upcast        Enable warning when up-casting discards initializers"
	end if
	print "  -Wa <a,b,c>      Pass options to 'as'"
	print "  -Wc <a,b,c>      Pass options to 'gcc' (-gen gcc) or 'llc' (-gen llvm)"
	print "  -Wl <a,b,c>      Pass options to 'ld'"
	print "  -x <file>        Set output executable/library file name"

	if( verbose ) then
	print "  -z gosub-setjmp  Use setjmp/longjmp to implement GOSUB"
	print "  -z valist-as-ptr Use pointer expressions to implement CVA_*() macros"
	print "  -z no-thiscall   Don't use '__thiscall' calling convention"
	print "  -z no-fastcall   Don't use '__fastcall' calling convention"
	print "  -z fbrt          Link with 'fbrt' instead of 'fb' runtime library"
	print "  -z nocmdline     Disable #cmdline source directives"
	print "  -z retinflts     Enable returning some types in floating point registers"
	end if

end sub

private sub hAppendConfigInfo( byref config as string, byval info as zstring ptr )
	if( len( config ) > 0 ) then
		config += ", "
	end if
	config += *info
end sub

private sub hPrintVersion( byval verbose as integer )
	dim as string config

	print "FreeBASIC Compiler - Version " + FB_VERSION + _
		" (" + FB_BUILD_DATE_ISO + "), built for " + fbGetHostId( ) + " (" & fbGetHostBits( ) & "bit)"
	print "Copyright (C) 2004-2023 The FreeBASIC development team."

	#ifdef ENABLE_STANDALONE
		hAppendConfigInfo( config, "standalone" )
	#endif

	#ifdef ENABLE_PREFIX
		hAppendConfigInfo( config, "prefix: '" + ENABLE_PREFIX + "'" )
	#endif

	if( len( config ) > 0 ) then
		print config
	end if

	if( verbose ) then
		fbcPrintTargetInfo( )
		if( FB_BUILD_SHA1 > "" ) then
			print "source sha-1: " & FB_BUILD_SHA1
		end if
	end if
end sub

	fbcInit( )

	if( __FB_ARGC__ = 1 ) then
		hPrintOptions( FALSE )
		fbcEnd( 1 )
	end if

	hParseArgs( __FB_ARGC__, __FB_ARGV__ )

	hCheckArgs( )

	if( fbc.showversion ) then
		hPrintVersion( fbc.verbose )
		fbcEnd( 0 )
	end if

	if( fbc.verbose ) then
		fbc.showversion = TRUE
		hPrintVersion( FALSE )
	end if

	'' Show help if -help was given
	if( fbc.showhelp ) then
		hPrintOptions( fbc.verbose )
		fbcEnd( 1 )
	end if

	do
		fbcDeterminePrefix( )
		fbcSetupCompilerPaths( )

		if( fbc.verbose ) then
			fbcPrintTargetInfo( )
		end if

		'' Tell the compiler about the default include path (added after
		'' the command line ones, so those will be searched first)
		fbAddIncludePath( fbc.incpath )

		var have_input_files = (listGetHead( @fbc.modules   ) <> NULL) or _
			(listGetHead( @fbc.objlist   ) <> NULL) or _
			(listGetHead( @fbc.libs.list ) <> NULL) or _
			(listGetHead( @fbc.libfiles  ) <> NULL)

		'' Answer -print query, if any, and stop
		'' The -print option is intended to allow shell scripts, makefiles, etc.
		'' to query information from fbc.
		if( fbc.print >= 0 ) then
			select case( fbc.print )
			case PRINT_HOST
				print fbGetHostId( )
			case PRINT_TARGET
				print fbGetTargetId( )
			case PRINT_X
				'' If we have input files, -print x should give the output name that we'd normally get.
				'' However, a plain "fbc -print x" without input files should just give the .exe extension.
				if( have_input_files ) then
					fbcDetermineMainName( )
				end if
				hSetOutName( )
				print fbc.outname
			case PRINT_FBLIBDIR
				print fbc.libpath
			case PRINT_SHA1
				print FB_BUILD_SHA1
			end select
			fbcEnd( 0 )
		end if

		fbcDetermineMainName( )

		'' Show help if there are no input files
		if( have_input_files = FALSE ) then
			hPrintOptions( fbc.verbose )
			fbcEnd( 1 )
		end if

		''
		'' Compile .bas modules
		''
		hCompileModules( )

		if( fbShouldRestart( ) = FALSE ) then
			exit do
		end if

		fbRestartEndRequest( FB_RESTART_FBC_CMDLINE )

		'' we are restarting, so show errors again
		errPreInit( )

		'' command line arguments have changed, check them again
		hCheckArgs( )

		if( fbc.verbose ) then
			print "Restarting fbc ..."
		end if
	loop

	if( hCompileXpm( ) = FALSE ) then
		fbcEnd( 1 )
	end if

	if( fbc.emitasmonly ) then
		fbcEnd( 0 )
	end if

	if( (fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS)  and _
		fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS64 ) then
		''
		'' Compile intermediate .c modules produced by -gen gcc
		''
		hCompileStage2Modules( )
	end if

	if( fbc.emitfinalasmonly ) then
		fbcEnd( 0 )
	end if

	''
	'' Assemble into .o files
	''
	hAssembleModules( )
	hAssembleRcs( )
	hAssembleXpm( )

	'' Stop for -c
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_OBJECT ) then
		fbcEnd( 0 )
	end if

	'' Set the default lib paths before scanning for other libs
	hSetDefaultLibPaths( )

	'' Scan objects and libraries for more libraries and paths,
	'' before adding the default libs, which don't need to be searched,
	'' because they don't contain objinfo anyways.
	if( fbGetOption( FB_COMPOPT_OBJINFO ) and (not fbIsCrossComp( )) ) then
		hCollectObjinfo( )
	end if

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_STATICLIB ) then
		if( hArchiveFiles( ) = FALSE ) then
			fbcEnd( 1 )
		end if
		fbcEnd( 0 )
	end if

	'' Link

	'' Add default libs for linking, unless -nodeflibs was given
	'' Note: These aren't added into objinfo sections of objects or
	'' static libraries. Only the non-default libs are needed there.
	if( fbc.nodeflibs = FALSE ) then
		hAddDefaultLibs( )
	end if

	hExcludeLibsFromLink( )

	if( hLinkFiles( ) = FALSE ) then
		fbcEnd( 1 )
	end if

	fbcEnd( 0 )
