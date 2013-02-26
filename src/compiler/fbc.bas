'' main module, front-end
''
'' chng: sep/2004 written [v1ctor]
''		 dec/2004 linux support added [lillo]
''		 jan/2005 dos support added [DrV]

#include once "fb.bi"
#include once "hlp.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "objinfo.bi"

#if defined( ENABLE_STANDALONE ) and defined( __FB_WIN32__ )
	#define ENABLE_GORC
#endif

type FBC_EXTOPT
	gas			as zstring * 128
	ld			as zstring * 128
	gcc			as zstring * 128
end type

type FBCIOFILE
	srcfile		as string     '' input file
	objfile		as string ptr '' output .o file
			              '' (for modules from the command line
			              '' this points to a node from fbc.objlist)
end type

type FBC_OBJINF
	lang		as FB_LANG
	mt			as integer
end type

type FBCCTX
	'' For command line parsing
	optid				as integer    '' Current option
	lastmoduleobj			as string ptr '' fbc.objlist node of last input file, so the default .o name can be overwritten with a following -o filename
	objfile				as string '' -o filename waiting for next input file
	backend				as integer  '' FB_BACKEND_* given via -gen, or -1 if -gen wasn't given
	cputype				as integer  '' FB_CPUTYPE_* given via -arch, or -1 if -arch wasn't given

	emitasmonly			as integer  '' write out FB backend output file only (.asm/.c)
	keepasm				as integer  '' preserve FB backend output file (.asm/.c)
	emitfinalasmonly		as integer  '' write out final .asm file only
	keepfinalasm			as integer  '' preserve final .asm
	keepobj				as integer
	verbose				as integer
	showversion			as integer
	showhelp			as integer

	'' Command line input
	modules				as TLIST '' FBCIOFILE's for input .bas files
	rcs				as TLIST '' FBCIOFILE's for input .rc/.res files
	xpm				as FBCIOFILE '' .xpm input file
	temps				as TLIST '' Temporary files to delete at shutdown
	objlist				as TLIST '' Objects from command line and from compilation
	libfiles			as TLIST
	libs				as TSTRSET
	libpaths			as TSTRSET

	'' Final list of libs and paths for linking
	'' (each module can have #inclibs and #libpaths and add more, and for
	'' objinfo emitting only the module-specific libs are wanted, so there
	'' are multiple lists necessary to allow each module to start fresh
	'' with the same input libs)
	finallibs			as TSTRSET
	finallibpaths			as TSTRSET

	outname 			as zstring * FB_MAXPATHLEN+1
	mainname			as zstring * FB_MAXPATHLEN+1
	mainset				as integer
	mapfile				as zstring * FB_MAXPATHLEN+1
	subsystem			as zstring * FB_MAXNAMELEN+1
	extopt				as FBC_EXTOPT
#ifndef ENABLE_STANDALONE
	targetprefix 			as zstring * FB_MAXNAMELEN+1  '' Target system identifier (e.g. a name like "win32", or a GNU triplet) to prefix in front of cross-compiling tool names
#endif
	xbe_title 			as zstring * FB_MAXNAMELEN+1  '' For the '-title <title>' xbox option
	nodeflibs			as integer
	staticlink			as integer

	'' Compiler paths
	prefix				as zstring * FB_MAXPATHLEN+1  '' Path from -prefix or empty
	binpath				as zstring * FB_MAXPATHLEN+1
	incpath				as zstring * FB_MAXPATHLEN+1
	libpath				as zstring * FB_MAXPATHLEN+1

	objinf				as FBC_OBJINF
end type

enum
	FBCTOOL_AS = 0
	FBCTOOL_AR
	FBCTOOL_LD
	FBCTOOL_GCC
	FBCTOOL_LLC
	FBCTOOL_DLLTOOL
	FBCTOOL_GORC
	FBCTOOL_WINDRES
	FBCTOOL_CXBE
	FBCTOOL__COUNT
end enum

static shared as zstring * 8 toolnames(0 to FBCTOOL__COUNT-1) = _
{ _
	"as", "ar", "ld", "gcc", "llc", "dlltool", "GoRC", "windres", "cxbe" _
}

declare function fbcFindBin( byval tool as integer, byref path as string ) as integer

declare function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byval tool as integer, _
		byref ln as string _
	) as integer

#macro safeKill(f)
	if( kill( f ) <> 0 ) then
	end if
#endmacro

dim shared as FBCCTX fbc

private sub fbcInit( )
	const FBC_INITFILES = 64

	fbc.backend = -1
	fbc.cputype = -1

	listInit( @fbc.modules, FBC_INITFILES, sizeof(FBCIOFILE) )
	listInit( @fbc.rcs, FBC_INITFILES\4, sizeof(FBCIOFILE) )
	strlistInit( @fbc.temps, FBC_INITFILES\4 )
	strlistInit( @fbc.objlist, FBC_INITFILES )
	strlistInit( @fbc.libfiles, FBC_INITFILES\4 )
	strsetInit( @fbc.libs, FBC_INITFILES\4 )
	strsetInit( @fbc.libpaths, FBC_INITFILES\4 )

	strsetInit(@fbc.finallibs, FBC_INITFILES\2)
	strsetInit(@fbc.finallibpaths, FBC_INITFILES\2)

	fbGlobalInit()

	fbc.objinf.lang = fbGetOption( FB_COMPOPT_LANG )
end sub

private sub fbcEnd(byval errnum as integer)
	'' Clean up temporary files
	dim as string ptr file = listGetHead(@fbc.temps)
	while (file)
		safeKill(*file)
		file = listGetNext(file)
	wend

	end errnum
end sub

private sub fbcAddTemp(byref file as string)
	strlistAppend(@fbc.temps, file)
end sub

private function fbcAddObj( byref file as string ) as string ptr
	'' .o's should be linked/archived in the order they were found on
	'' command line, so callers of this function must take care to preserve
	'' the order...
	dim as string ptr s = listNewNode( @fbc.objlist )
	*s = file
	function = s
end function

private function hCanDeleteAsm( byval stage as integer ) as integer
	if( stage = 1 ) then
		'' Stage 1 output (the FB backend output, which also happens to
		'' be the final asm for -gen gas) can be preserved by -R,
		'' and additionally for -gen gas with -RR aswell.
		function = ((not fbc.keepasm) and _
		            ((fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS) or _
		             (not fbc.keepfinalasm)))
	else
		'' Stage 2 output (the final .asm for -gen gcc) can be
		'' preserved with -RR only.
		function = (not fbc.keepfinalasm)
	end if
end function

'' Find a file in our lib/ or in the system somewhere
private function fbcFindLibFile( byval file as zstring ptr ) as string
	dim as string found

	''
	'' The Standalone build expects to have all needed files in its lib/,
	'' so it needs to do nothing but build up the path and use that.
	''
	'' Normal however wants to use the "system's" files (and only has few
	'' files in its own lib/).
	''
	'' Typically libgcc.a, libsupc++.a, crtbegin.o, crtend.o will be inside
	'' gcc's sub-directory in lib/gcc/target/version, i.e. Normal can only
	'' find them via 'gcc -print-file-name=foo' (except for hard-coding
	'' against a specific gcc target/version, but that's not a good option).
	''

	found = fbc.libpath + FB_HOST_PATHDIV + *file

#ifndef ENABLE_STANDALONE
	if( hFileExists( found ) ) then
		return found
	end if

	'' Not found in our lib/, query the target-specific gcc
	dim as string path
	fbcFindBin( FBCTOOL_GCC, path )

	if( fbIsTarget64bit( ) ) then
		path += " -m64"
	else
		path += " -m32"
	end if

	path += " -print-file-name=" + *file

	dim as integer ff = freefile( )
	if( open pipe( path, for input, as ff ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, file, -1 )
		exit function
	end if

	input #ff, found

	close ff

	if( found = hStripPath( found ) ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, file, -1 )
		exit function
	end if
#endif

	function = found
end function

private sub fbcAddDefLibPath(byref path as string)
	strsetAdd(@fbc.finallibpaths, path, TRUE)
end sub

private sub fbcAddLibPathFor( byval libname as zstring ptr )
	dim as string path
	path = hStripFilename( fbcFindLibFile( libname ) )
	path = pathStripDiv( path )
	if( len( path ) > 0 ) then
		fbcAddDefLibPath( path )
	end if
end sub

function fbcFindBin( byval tool as integer, byref path as string ) as integer
	static as integer lasttool = -1
	static as string lastpath

	function = TRUE

	'' Re-use path from last time if possible
	if( lasttool = tool ) then
		path = lastpath
		exit function
	end if

	'' a) Use the path from the corresponding environment variable if it's set
	path = environ( ucase( toolnames(tool) ) )
	if( len( path ) = 0 ) then
		'' b) Try bin/ directory
		path = fbc.binpath + toolnames(tool) + FB_HOST_EXEEXT

		#ifndef ENABLE_STANDALONE
			if( hFileExists( path ) = FALSE ) then
				'' c) Rely on PATH
				path = fbc.targetprefix + toolnames(tool) + FB_HOST_EXEEXT
				function = FALSE
			end if
		#endif
	end if

	lasttool = tool
	lastpath = path
end function

function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byval tool as integer, _
		byref ln as string _
	) as integer

	dim as integer result = any
	dim as string path

	result = fbcFindBin( tool, path )

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
		if( result ) then
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

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
private function createArgsFile _
	( _
		byref argsfile as string, _
		byref ln as string _
	) as integer

	dim as integer f = freefile()
	if (open(argsfile, for output, as #f)) then
		return FALSE
	end if

	print #f, ln

	close #f

	return TRUE
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

	dim as string ln
	ln += "--def """ + deffile + """"
	ln += " --dllname """ + hStripPath( fbc.outname ) + """"
	ln += " --output-lib """ + hStripFilename( fbc.outname ) + "lib" + dllname + ".dll.a"""

	if( fbcRunBin( "creating import library", FBCTOOL_DLLTOOL, ln ) = FALSE ) then
		exit function
	end if

	if( hCanDeleteAsm( 1 ) ) then
		fbcAddTemp( deffile )
	end if

	function = TRUE
end function

private function hFindLib( byval file as zstring ptr ) as string
	function = " """ + fbcFindLibFile( file ) + """"
end function

private function hLinkFiles( ) as integer
	dim as string ldcline, dllname, deffile

	function = FALSE

	'' Determine the output binary's name if not given via -x
	if (len(fbc.outname) = 0) then
		fbc.outname = fbc.mainname

		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			select case as const fbGetOption( FB_COMPOPT_TARGET )
			case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32, _
			     FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
				'' Note: XBox target creates an .exe first,
				'' then uses cxbe to turn it into an .xbe later
				fbc.outname += ".exe"

			end select

		case FB_OUTTYPE_DYNAMICLIB
			select case as const fbGetOption( FB_COMPOPT_TARGET )
			case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
				fbc.outname += ".dll"

			case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
			     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
			     FB_COMPTARGET_OPENBSD
				fbc.outname = hStripFilename(fbc.outname) + _
					"lib" + hStripPath(fbc.outname) + ".so"

			end select

		end select
	end if

	'' Set executable name
	ldcline = "-o " + QUOTE + fbc.outname + QUOTE

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

			'' set the entry-point
			ldcline += " -e _DllMainCRTStartup@12"
		end if

	case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			dllname = hStripPath( hStripExt( fbc.outname ) )
			ldcline += " -shared -h" + hStripPath( fbc.outname )
		else
			select case as const fbGetOption( FB_COMPOPT_TARGET )
			case FB_COMPTARGET_FREEBSD
				ldcline += " -dynamic-linker /libexec/ld-elf.so.1"
			case FB_COMPTARGET_LINUX
				ldcline += " -dynamic-linker /lib/ld-linux.so.2"
			case FB_COMPTARGET_NETBSD
				ldcline += " -dynamic-linker /usr/libexec/ld.elf_so"
			case FB_COMPTARGET_OPENBSD
				ldcline += " -dynamic-linker /usr/libexec/ld.so"
			end select
		end if

		'' Add all symbols to the dynamic symbol table
		if( (fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB) or _
		    fbGetOption( FB_COMPOPT_EXPORT ) ) then
			ldcline += " --export-dynamic"
		end if

	case FB_COMPTARGET_XBOX
		ldcline += " -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared"

	end select

	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		'' For DJGPP, the custom ldscript must always be used,
		'' to get ctors/dtors into the correct order that lets
		'' fbrt0's c/dtor be the first/last respectively.
		'' (needed until binutils' default DJGPP ldscripts are fixed)
		ldcline += " -T """ + fbc.libpath + (FB_HOST_PATHDIV + "i386go32.x""")
	else
		'' Supplementary ld script to drop the fbctinf objinfo section
		ldcline += " """ + fbc.libpath + (FB_HOST_PATHDIV + "fbextra.x""")
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

	case FB_COMPTARGET_LINUX
		'' set emulation
		ldcline += " -m elf_i386"

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

	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' Add the library search paths
	scope
		dim as TSTRSETITEM ptr i = listGetHead(@fbc.finallibpaths.list)
		while (i)
			ldcline += " -L """ + i->s + """"
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

	case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD

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

		'' All have crti.o, except OpenBSD
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += hFindLib( "crti.o" )
		end if

		ldcline += hFindLib( "crtbegin.o" )

	case FB_COMPTARGET_XBOX
		'' link with crt0.o (C runtime init)
		ldcline += hFindLib( "crt0.o" )

	end select

	if( fbc.nodeflibs = FALSE ) then
		ldcline += " """ + fbc.libpath + (FB_HOST_PATHDIV + "fbrt0.o""")
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
	ldcline += " ""-("""

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
			'' Prevent linking DLLs against their own import library
			'' (normally this shouldn't be needed though, even if
			'' the lib is given to ld, it shouldn't be used normally
			'' since the DLL will have all symbols itself already,
			'' but safe is safe, with #inclib etc.)
			if ((checkdllname = FALSE) orelse (i->s <> dllname)) then
				ldcline += " -l" + i->s
			end if
			i = listGetNext(i)
		wend
	end scope

	'' End of lib group
	ldcline += " ""-)"""

	'' crt end
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD
		ldcline += hFindLib( "crtend.o" )
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += hFindLib( "crtn.o" )
		end if

	case FB_COMPTARGET_WIN32
		ldcline += hFindLib( "crtend.o" )

	end select

	'' extra options
	ldcline += " " + fbc.extopt.ld

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
	'' When using the DOS DJGPP tools, the command line length might be
	'' limited, and with our generally long ld command lines (especially
	'' when linking fbc) the line must be passed to ld through an @file.
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		dim as string argsfile = hStripFilename(fbc.outname) + "temp.res"
		if (createArgsFile(argsfile, ldcline) = FALSE) then
			exit function
		end if
		fbcAddTemp(argsfile)
		if (fbc.verbose) then
			print "ld options in '" & argsfile & "': ", ldcline
		end if
		ldcline = "@" + argsfile
	end if
#endif

	'' invoke ld
	if( fbcRunBin( "linking", FBCTOOL_LD, ldcline ) = FALSE ) then
		exit function
	end if

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_DOS
		'' patch the exe to change the stack size
		dim as integer f = freefile()

		if (open(fbc.outname, for binary, access read write, as #f) <> 0) then
			exit function
		end if

		put #f, 533, fbGetOption(FB_COMPOPT_STACKSIZE)

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
		
		if( fbGetOption( FB_COMPOPT_DEBUG ) ) then
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

private sub hFatalInvalidOption( byref arg as string )
	errReportEx( FB_ERRMSG_INVALIDCMDOPTION, QUOTE + arg + QUOTE, -1 )
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

	dim as integer o_option_not_used_yet = (len( fbc.objfile ) = 0)

	'' No objfile name set yet (from the -o <file> option)?
	if( o_option_not_used_yet ) then
		'' Choose default *.o name based on input file name
		if( is_rc ) then
#ifdef ENABLE_GORC
			'' GoRC only accepts *.obj
			'' foo.rc -> foo.obj, so there is no collision with foo.bas' foo.o
			fbc.objfile += hStripExt( srcfile ) + ".obj"
#else
			'' windres doesn't care, so we use the default *.o
			'' foo.rc -> foo.rc.o to avoid collision with foo.bas' foo.o
			fbc.objfile += srcfile + ".o"
#endif
		else
			'' foo.bas -> foo.o
			fbc.objfile += hStripExt( srcfile ) + ".o"
		end if
	end if

	module->srcfile = srcfile
	module->objfile = fbcAddObj( fbc.objfile )

	fbc.objfile = ""

	if( o_option_not_used_yet ) then
		'' Allow overwriting by a following -o <file> later
		fbc.lastmoduleobj = module->objfile
	end if

end sub

private sub hAddBas( byref basfile as string )
	hSetIofile( listNewNode( @fbc.modules ), basfile, FALSE )
end sub

#ifndef ENABLE_STANDALONE
'' To support GNU triplets, we need to parse them, to identify which target
'' of ours it could mean. A triplet is made up of these components:
''    [arch-[vendor-]]os[-...]
private sub hParseTargetId _
	( _
		byref os as string, _
		byref arch as string _
	)

	dim as integer i = any, j = any

	i = instr( 1, os, "-" )
	if( i > 0 ) then
		arch = left( os, i - 1 )

		j = instr( i + 1, os, "-" )
		if( j > 0 ) then
			i = j
		end if

		os = right( os, len( os ) - i )
	end if

end sub
#endif

private function hParseTargetOS( byref os as string ) as integer
	if( len( os ) = 0 ) then
		return -1
	end if

#ifdef ENABLE_STANDALONE
	#macro MAYBE( s, comptarget )
		if( id = s ) then
			return comptarget
		end if
	#endmacro
#else
	#macro MAYBE( s, comptarget )
		'' Allow incomplete matches, e.g.:
		'' 'linux' matches 'linux-gnu',
		'' 'mingw' matches 'mingw32msvc', etc.
		if( left( os, len( s ) ) = s ) then
			return comptarget
		end if
	#endmacro
#endif

	'' Assuming 32bit for now; if it's 64bit, hParseTargetArch() will
	'' remap the target to the corresponding 64bit one.
	select case as const( os[0] )
	case asc( "c" )
		MAYBE( "cygwin", FB_COMPTARGET_CYGWIN )

	case asc( "d" )
		MAYBE( "darwin", FB_COMPTARGET_DARWIN )
#ifndef ENABLE_STANDALONE
		MAYBE( "djgpp", FB_COMPTARGET_DOS )
#endif
		MAYBE( "dos", FB_COMPTARGET_DOS )

	case asc( "f" )
		MAYBE( "freebsd", FB_COMPTARGET_FREEBSD )

	case asc( "l" )
		'' Checking linux64 first because it also starts with "linux",
		'' but is a different target
		MAYBE( "linux64", FB_COMPTARGET_LINUX64 )
		MAYBE( "linux", FB_COMPTARGET_LINUX )

#ifndef ENABLE_STANDALONE
	case asc( "m" )
		MAYBE( "mingw", FB_COMPTARGET_WIN32 )
		MAYBE( "msdos", FB_COMPTARGET_DOS )
#endif

	case asc( "n" )
		MAYBE( "netbsd", FB_COMPTARGET_NETBSD )

	case asc( "o" )
		MAYBE( "openbsd", FB_COMPTARGET_OPENBSD )

	case asc( "s" )
		'' TODO (not yet implemented in the compiler)
		''MAYBE( "solaris", FB_COMPTARGET_SOLARIS )

	case asc( "w" )
		MAYBE( "win32", FB_COMPTARGET_WIN32 )
		MAYBE( "win64", FB_COMPTARGET_WIN64 )
#ifndef ENABLE_STANDALONE
		MAYBE( "windows", FB_COMPTARGET_WIN32 )
#endif

	case asc( "x" )
		MAYBE( "xbox", FB_COMPTARGET_XBOX )

	end select

	function = -1
end function

private function hParseTargetArch _
	( _
		byval target as integer, _
		byref arch as string _
	) as integer

	select case( arch )
	'' 64bit architecture?
	case "x86_64", "amd64"
		'' Remap targets to their 64bit version if supported
		select case as const( target )
		case FB_COMPTARGET_WIN32
			'' This happens e.g. with x86_64-w64-mingw32, where the
			'' mingw32 looks like win32 at first, but then due to
			'' the x86_64 we know it's win64.
			target = FB_COMPTARGET_WIN64

		case FB_COMPTARGET_LINUX
			target = FB_COMPTARGET_LINUX64

		case FB_COMPTARGET_WIN64, FB_COMPTARGET_LINUX64
			'' Already 64bit? Leave as-is

		case else
			'' Others not yet supported, or impossible (dos, xbox)
			target = -1
		end select
	end select

	function = target
end function

enum
	OPT_A = 0
	OPT_ARCH
	OPT_ASM
	OPT_B
	OPT_C
	OPT_CKEEPOBJ
	OPT_D
	OPT_DLL
	OPT_DYLIB
	OPT_E
	OPT_EX
	OPT_EXX
	OPT_EXPORT
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
	OPT_O
	OPT_OPTIMIZE
	OPT_P
	OPT_PP
	OPT_PREFIX
	OPT_PROFILE
	OPT_R
	OPT_RKEEPASM
	OPT_RR
	OPT_RRKEEPASM
	OPT_S
	OPT_STATIC
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

dim shared as integer option_takes_argument(0 to (OPT__COUNT - 1)) = _
{ _
	TRUE , _ '' OPT_A
	TRUE , _ '' OPT_ARCH
	TRUE , _ '' OPT_ASM
	TRUE , _ '' OPT_B
	FALSE, _ '' OPT_C
	FALSE, _ '' OPT_CKEEPOBJ
	TRUE , _ '' OPT_D
	FALSE, _ '' OPT_DLL
	FALSE, _ '' OPT_DYLIB
	FALSE, _ '' OPT_E
	FALSE, _ '' OPT_EX
	FALSE, _ '' OPT_EXX
	FALSE, _ '' OPT_EXPORT
	FALSE, _ '' OPT_FORCELANG
	TRUE , _ '' OPT_FPMODE
	TRUE , _ '' OPT_FPU
	FALSE, _ '' OPT_G
	TRUE , _ '' OPT_GEN
	FALSE, _ '' OPT_HELP
	TRUE , _ '' OPT_I
	TRUE , _ '' OPT_INCLUDE
	TRUE , _ '' OPT_L
	TRUE , _ '' OPT_LANG
	FALSE, _ '' OPT_LIB
	TRUE , _ '' OPT_M
	TRUE , _ '' OPT_MAP
	TRUE , _ '' OPT_MAXERR
	FALSE, _ '' OPT_MT
  	FALSE, _ '' OPT_NODEFLIBS
	FALSE, _ '' OPT_NOERRLINE
	TRUE , _ '' OPT_O
	TRUE , _ '' OPT_OPTIMIZE
	TRUE , _ '' OPT_P
	FALSE, _ '' OPT_PP
	TRUE , _ '' OPT_PREFIX
	FALSE, _ '' OPT_PROFILE
	FALSE, _ '' OPT_R
	FALSE, _ '' OPT_RKEEPASM
	FALSE, _ '' OPT_RR
	FALSE, _ '' OPT_RRKEEPASM
	TRUE , _ '' OPT_S
	FALSE, _ '' OPT_STATIC
	TRUE , _ '' OPT_T
	TRUE , _ '' OPT_TARGET
	TRUE , _ '' OPT_TITLE
	FALSE, _ '' OPT_V
	TRUE , _ '' OPT_VEC
	FALSE, _ '' OPT_VERSION
	TRUE , _ '' OPT_W
	TRUE , _ '' OPT_WA
	TRUE , _ '' OPT_WC
	TRUE , _ '' OPT_WL
	TRUE , _ '' OPT_X
	TRUE   _ '' OPT_Z
}

private sub handleOpt(byval optid as integer, byref arg as string)
	select case as const (optid)
	case OPT_A
		fbcAddObj( arg )

	case OPT_ARCH
		select case( arg )
		case "386"
			fbc.cputype = FB_CPUTYPE_386
		case "486"
			fbc.cputype = FB_CPUTYPE_486
		case "586"
			fbc.cputype = FB_CPUTYPE_586
		case "686"
			fbc.cputype = FB_CPUTYPE_686
		case "athlon"
			fbc.cputype = FB_CPUTYPE_ATHLON
		case "athlon-xp"
			fbc.cputype = FB_CPUTYPE_ATHLONXP
		case "athlon-fx"
			fbc.cputype = FB_CPUTYPE_ATHLONFX
		case "k8-sse3"
			fbc.cputype = FB_CPUTYPE_ATHLONSSE3
		case "pentium-mmx"
			fbc.cputype = FB_CPUTYPE_PENTIUMMMX
		case "pentium2"
			fbc.cputype = FB_CPUTYPE_PENTIUM2
		case "pentium3"
			fbc.cputype = FB_CPUTYPE_PENTIUM3
		case "pentium4"
			fbc.cputype = FB_CPUTYPE_PENTIUM4
		case "pentium4-sse3"
			fbc.cputype = FB_CPUTYPE_PENTIUMSSE3
		case "x86-64", "x86_64", "amd64"
			fbc.cputype = FB_CPUTYPE_X86_64
		case "32"
			fbc.cputype = FB_CPUTYPE_32
		case "64"
			fbc.cputype = FB_CPUTYPE_64
		case "native"
			fbc.cputype = FB_CPUTYPE_NATIVE
		case else
			hFatalInvalidOption( arg )
		end select

	case OPT_ASM
		select case( arg )
		case "att"
			fbSetOption( FB_COMPOPT_ASMSYNTAX, FB_ASMSYNTAX_ATT )
		case "intel"
			fbSetOption( FB_COMPOPT_ASMSYNTAX, FB_ASMSYNTAX_INTEL )
		case else
			hFatalInvalidOption( arg )
		end select

	case OPT_B
		hAddBas( arg )

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

	case OPT_EX
		fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
		fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )

	case OPT_EXX
		fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
		fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
		fbSetOption( FB_COMPOPT_EXTRAERRCHECK, TRUE )

	case OPT_EXPORT
		fbSetOption( FB_COMPOPT_EXPORT, TRUE )

	case OPT_FORCELANG
		dim as integer value = fbGetLangId(strptr(arg))
		if( value = FB_LANG_INVALID ) then
			hFatalInvalidOption( arg )
		end if

		fbSetOption( FB_COMPOPT_LANG, value )
		fbSetOption( FB_COMPOPT_FORCELANG, TRUE )
		fbc.objinf.lang = value

	case OPT_FPMODE
		dim as integer value = any

		select case ucase(arg)
		case "PRECISE"
			value = FB_FPMODE_PRECISE
		case "FAST"
			value = FB_FPMODE_FAST
		case else
			hFatalInvalidOption( arg )
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
			hFatalInvalidOption( arg )
		end select

		fbSetOption( FB_COMPOPT_FPUTYPE, value )

	case OPT_G
		fbSetOption( FB_COMPOPT_DEBUG, TRUE )

	case OPT_GEN
		select case( lcase( arg ) )
		case "gas"
			fbc.backend = FB_BACKEND_GAS
		case "gcc"
			fbc.backend = FB_BACKEND_GCC
		case "llvm"
			fbc.backend = FB_BACKEND_LLVM
		case else
			hFatalInvalidOption( arg )
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
			hFatalInvalidOption( arg )
		end if

		fbSetOption( FB_COMPOPT_LANG, value )
		fbc.objinf.lang = value

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
			value = valint( arg )
			if( value <= 0 ) then
				hFatalInvalidOption( arg )
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

	case OPT_O
		'' Error if there already is an -o waiting to be assigned
		hCheckWaitingObjfile( )

		'' Assign it to the last module, if it doesn't have an
		'' -o filename yet, or store it for later otherwise.
		if( fbc.lastmoduleobj ) then
			*fbc.lastmoduleobj = arg
		else
			fbc.objfile = arg
		end if

	case OPT_OPTIMIZE
		dim as integer value = any

		if (arg = "max") then
			value = 3
		else
			value = valint(arg)
			if (value < 0) then
				value = 0
			elseif (value > 3) then
				value = 3
			end if
		end if

		fbSetOption( FB_COMPOPT_OPTIMIZELEVEL, value )

	case OPT_P
		strsetAdd(@fbc.libpaths, pathStripDiv(arg), FALSE)

	case OPT_PP
		'' -pp doesn't change the output type, but like -r we want to
		'' stop fbc very early.
		fbSetOption( FB_COMPOPT_PPONLY, TRUE )
		fbc.emitasmonly = TRUE

	case OPT_PREFIX
		fbc.prefix = pathStripDiv(arg)
		hReplaceSlash( fbc.prefix, asc( FB_HOST_PATHDIV ) )

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

	case OPT_STATIC
		fbc.staticlink = TRUE

	case OPT_T
		fbSetOption(FB_COMPOPT_STACKSIZE, valint(arg) * 1024)

	case OPT_TARGET
		'' For Standalone, the argument given to -target is used just
		'' to identify the compilation target. For Normal, it's used as
		'' a prefix for the executable names of cross-compilation tools,
		'' for example:
		''    fbc -target dos
		'' will try to use:
		''    bin/dos-ld[.exe]  (normal build)
		''    bin/dos/ld[.exe]  (standalone build)
		'' This allows fbc to work well with gcc/binutils
		'' cross-toolchains via e.g. "fbc -target i686-pc-mingw32".
		'' Normal: recognizes FB's target names and GNU triplets
		'' Standalone: FB names only
		dim as string os
		dim as integer target = any

		'' The -target option should be case-insensitive
		os = lcase( arg )

		'' Ignore it if it matches the host id; this adds backwards-
		'' compatibility with fbc 0.23
		if( os <> FB_HOST ) then
			#ifndef ENABLE_STANDALONE
				'' Handle i686-pc-mingw32 triplets
				dim as string arch
				hParseTargetId( os, arch )
			#endif

			'' Identify the target
			target = hParseTargetOS( os )

			#ifndef ENABLE_STANDALONE
				'' Maybe remap to 64bit version
				target = hParseTargetArch( target, arch )
			#endif

			'' Not recognized?
			if( target < 0 ) then
				hFatalInvalidOption( arg )
			end if

			fbSetOption( FB_COMPOPT_TARGET, target )

			#ifndef ENABLE_STANDALONE
				'' Should use the -target argument as-is when
				'' prefixing to tool file names, because of
				'' case-sensitive file systems
				fbc.targetprefix = arg + "-"
			#endif
		end if

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
			hFatalInvalidOption( arg )
		end select

		fbSetOption( FB_COMPOPT_VECTORIZE, value )

	case OPT_VERSION
		fbc.showversion = TRUE

	case OPT_W
		dim as integer value = -2

		select case (arg)
		case "all"
			value = -1

		case "param"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
						 fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_PARAMMODE )

		case "escape"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
						 fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_ESCSEQ )

		case "next"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, _
						 fbGetOption( FB_COMPOPT_PEDANTICCHK ) or FB_PDCHECK_NEXTVAR )

		case "pedantic"
			fbSetOption( FB_COMPOPT_PEDANTICCHK, FB_PDCHECK_DEFAULT )
			value = -1

		case else
			value = valint(arg)
		end select

		if( value >= -1 ) then
			fbSetOption( FB_COMPOPT_WARNINGLEVEL, value )
		end if

	case OPT_WA
		fbc.extopt.gas = " " + hReplace( arg, ",", " " ) + " "

	case OPT_WC
		fbc.extopt.gcc = " " + hReplace( arg, ",", " " ) + " "

	case OPT_WL
		fbc.extopt.ld = " " + hReplace( arg, ",", " " ) + " "

	case OPT_X
		fbc.outname = arg

	case OPT_Z
		select case( lcase( arg ) )
		case "gosub-setjmp"
			fbSetOption( FB_COMPOPT_GOSUBSETJMP, TRUE )
		case else
			hFatalInvalidOption( arg )
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
		CHECK("exx", OPT_EXX)
		CHECK("export", OPT_EXPORT)

	case asc("f")
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

	case asc("o")
		ONECHAR(OPT_O)

	case asc("O")
		ONECHAR(OPT_OPTIMIZE)

	case asc("p")
		ONECHAR(OPT_P)
		CHECK("pp", OPT_PP)
		CHECK("prefix", OPT_PREFIX)
		CHECK("profile", OPT_PROFILE)

	case asc("r")
		ONECHAR(OPT_R)
		CHECK("rr", OPT_RR)

	case asc("R")
		ONECHAR(OPT_RKEEPASM)
		CHECK("RR", OPT_RRKEEPASM)

	case asc("s")
		ONECHAR(OPT_S)
		CHECK("static", OPT_STATIC)

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

declare sub parseArgsFromFile(byref filename as string)

private sub handleArg(byref arg as string)
	'' If the previous option wants this argument as parameter,
	'' call the handler with it, now that it's known.
	'' Note: Anything is accepted, even if it starts with '-' or '@'.
	if (fbc.optid >= 0) then
		'' Complain about empty next argument
		if (len(arg) = 0) then
			hFatalInvalidOption( arg )
		end if

		handleOpt(fbc.optid, arg)
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
			hFatalInvalidOption( arg )
		end if

		'' Parse the option after the '-'
		dim as integer optid = parseOption(opt)
		if (optid < 0) then
			'' Unrecognized command line option
			hFatalInvalidOption( arg )
		end if

		'' Does this option take a parameter?
		if (option_takes_argument(optid)) then
			'' Delay handling it, until the next argument is known.
			fbc.optid = optid
		else
			'' Handle this option now
			handleOpt(optid, arg)
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
			hFatalInvalidOption( arg )
		end if

		'' Recursively read in the additional options from the file
		reclevel += 1
		parseArgsFromFile(arg)
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
				hFatalInvalidOption( arg )
			end if

			hSetIofile( @fbc.xpm, arg, TRUE )

		case else
			'' Input file without or with unknown extension
			hFatalInvalidOption( arg )

		end select
	end select
end sub

private sub parseArgsFromFile(byref filename as string)
	dim as integer f = freefile()
	if (open(filename, for input, as #f)) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, filename, -1 )
		fbcEnd(1)
	end if

	dim as string args
	dim as string arg

	while (eof(f) = FALSE)
		line input #f, args
		args = trim(args)

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
				handleArg(arg)
			end if

			args = right(args, length - i)
		loop
	wend

	close #f
end sub

private sub hParseArgs( byval argc as integer, byval argv as zstring ptr ptr )
	dim as integer cputype = any, genericcputype = any
	dim as integer switch_target = any, errmsg = any

	fbc.optid = -1

	'' Note: ignoring argv[0], assuming it's the path used to run fbc
	dim as string arg
	for i as integer = 1 to (argc - 1)
		arg = *argv[i]
		handleArg(arg)
	next

	'' Waiting for argument to an option? If the user did something like
	'' 'fbc foo.bas -o' this shows the error.
	if (fbc.optid >= 0) then
		'' Missing argument for command line option
		hFatalInvalidOption( *argv[argc - 1] )
	end if

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
				return
		end if
	end if

	'' -gen given?
	if( fbc.backend >= 0 ) then
		'' 64bit target? -gen gas not supported
		if( fbIsTarget64bit( ) ) then
			if( fbc.backend = FB_BACKEND_GAS ) then
				errReportEx( FB_ERRMSG_ASMBACKEND64, "", -1 )
				fbcEnd( 1 )
			end if
		end if

		'' Override the compiler's target-based default
		fbSetOption( FB_COMPOPT_BACKEND, fbc.backend )
	end if

	''
	'' Check the -arch option
	''
	cputype = fbc.cputype

	'' "-arch native" given? Re-map to real cputype
	if( cputype = FB_CPUTYPE_NATIVE ) then
		cputype = (fb_CpuDetect( ) shr 28)

		'' Not 386..686?
		if( (cputype < 3) or (cputype > 6) ) then
			'' Don't change the FB compiler's default - since it
			'' defaults to the host
			cputype = -1
		end if
	end if

	'' -arch given (or identified via -arch native)?
	if( cputype >= 0 ) then
		'' If target is 32bit, but -arch x86_64 was given, then switch
		'' to 64bit target, and vice-versa, but without changing the
		'' fbc.targetprefix. Instead, we will rely only on
		'' "gcc -m32/-m64" and "as --32/--64" to work.

		select case( cputype )
		case FB_CPUTYPE_X86_64, FB_CPUTYPE_64
			genericcputype = FB_CPUTYPE_64
			switch_target = (not fbIsTarget64bit( ))
			errmsg = FB_ERRMSG_64ARCHWITH32TARGET
		case else
			genericcputype = FB_CPUTYPE_32
			switch_target = fbIsTarget64bit( )
			errmsg = FB_ERRMSG_32ARCHWITH64TARGET
		end select

		if( switch_target ) then
			if( fbGetOppositeBitsTarget( ) < 0 ) then
				errReportEx( errmsg, "", -1 )
				fbcEnd( 1 )
			end if

			'' Switch target
			fbSetOption( FB_COMPOPT_TARGET, fbGetOppositeBitsTarget( ) )
		end if

		'' If a specific arch was given, overwrite the default
		if( cputype <> genericcputype ) then
			fbSetOption( FB_COMPOPT_CPUTYPE, cputype )
		end if
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
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
	     FB_COMPTARGET_OPENBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_NETBSD

	case else
		if (len(fbc.xpm.srcfile) > 0) then
			errReportEx(FB_ERRMSG_RCFILEWRONGTARGET, fbc.xpm.srcfile, -1)
			fbcEnd(1)
		end if
	end select

	'' TODO: Check whether subsystem/stacksize/xboxtitle were set and
	'' complain about it when the target doesn't allow it, or just
	'' ignore silently (that might not even be too bad for portability)?
end sub

'' After command line parsing
private sub fbcInit2( )
	dim as string targetid

	''
	'' Determine base/prefix path
	''

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
		fbc.prefix += FB_HOST_PATHDIV
	end if

	''
	'' Setup compiler paths
	''
	'' Standalone (classic FB):
	''
	''    bin/targetid/
	''    inc/
	''    lib/targetid[suffix]/
	''
	'' Normal (unix-style):
	''
	''    bin/[targetid-]
	''    include/freebasic/
	''    lib/[targetid-]freebasic[suffix]/
	''
	'' - Standalone always uses target-specific sub-directories in bin/
	''   and lib/, Normal uses target-specific names only for
	''   cross-compiling (matching the behaviour of binutils/gcc).
	''
	'' - Normal uses include/freebasic/ to hold FB includes, to stay out
	''   of the way of the C ones in include/ and to conform to Linux
	''   distro packaging standards.
	''
	'' - The paths are not terminated with [back]slashes here,
	''   except for the bin/ path. fbcFindBin() expects to only have to
	''   append the file name, for example:
	''     "prefix/bin/win32/" + "as.exe"
	''     "prefix/bin/win32-" + "as.exe"
	''
	'' - The Normal layout can use GNU triplets as targetid, while the
	''   standalone layout only uses the FB target names
	''

#ifdef ENABLE_STANDALONE
	'' Use default target name
	targetid = *fbGetTargetId( )

	fbc.binpath = fbc.prefix + "bin" + FB_HOST_PATHDIV + targetid + FB_HOST_PATHDIV
	fbc.incpath = fbc.prefix + "inc"
	fbc.libpath = fbc.prefix + "lib" + FB_HOST_PATHDIV + targetid
#else
	if( len( fbc.targetprefix ) > 0 ) then
		'' Prefix tools with the id from -target
		targetid = fbc.targetprefix
	else
		'' No -target used, using "native" tools without prefix
		targetid = ""
	end if

	dim as zstring ptr fbname = any
	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS ) then
		'' Our subdirectory in include/ and lib/ is usually called
		'' freebasic/, but on DOS that's too long... of course almost
		'' no targetid or suffix can be used either.
		fbname = @"freebas"
	else
		fbname = @"freebasic"
	end if

	fbc.binpath = fbc.prefix + "bin"     + FB_HOST_PATHDIV + targetid
	fbc.incpath = fbc.prefix + "include" + FB_HOST_PATHDIV + *fbname
	fbc.libpath = fbc.prefix + "lib"     + FB_HOST_PATHDIV + targetid + *fbname

	#ifdef ENABLE_SUFFIX
		fbc.libpath += ENABLE_SUFFIX
	#endif
#endif

	'' Tell the compiler about the default include path (added after
	'' the command line ones, so those will be searched first)
	fbAddIncludePath( fbc.incpath )

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

	ext = @".asm"

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
		byval is_fbctinf as integer _
	)

	dim as integer prevlang = any, prevouttype = any, restarts = any
	dim as string asmfile

	asmfile = hGetAsmName( module, 1 )
	if( hCanDeleteAsm( 1 ) ) then
		fbcAddTemp( asmfile )
	end if

	if( fbc.verbose ) then
		print "compiling: ", module->srcfile; " -o "; asmfile;
		if( is_main ) then
			print " (main module)";
		elseif( is_fbctinf ) then
			print " (FB compile-time info)";
		end if
		print
	end if

	restarts = 0
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
		'' init the parser
		fbInit( is_main, restarts )

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

		fbCompile( module->srcfile, asmfile, is_main )

		'' If there were any errors during parsing, just exit without
		'' doing anything else.
		if( errGetCount( ) > 0 ) then
			fbcEnd( 1 )
		end if

		'' Don't restart unless asked for
		if( fbShouldRestart( ) = FALSE ) then
			exit do
		end if

		'' Restart
		restarts += 1

		'' Shutdown the parser before restarting
		fbEnd( )
	loop

	'' (unnecessary for the empty fbctinf module, it won't add anything new)
	if( is_fbctinf = FALSE ) then
		'' Update the list of libs and paths with the ones found when parsing
		fbGetLibs( @fbc.finallibs, @fbc.finallibpaths )
	end if

	'' Shutdown the parser
	fbEnd( )

	'' Restore original options
	fbSetOption( FB_COMPOPT_OUTTYPE, prevouttype )
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
	while( module )
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

		hCompileBas( module, ismain, FALSE )

		module = listGetNext( module )
	wend

	'' Make sure to add libs from command line to final lists if no input
	'' .bas were given
	if( module = NULL ) then
		strsetCopy( @fbc.finallibs, @fbc.libs )
		strsetCopy( @fbc.finallibpaths, @fbc.libpaths )
	end if
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

	'' Clean up the temp .bas too
	if( hCanDeleteAsm( 1 ) ) then
		fbcAddTemp( fbc.xpm.srcfile )
	end if

	hCompileBas( @fbc.xpm, FALSE, FALSE )
	function = TRUE
end function

dim shared as const zstring ptr gcc_architectures(FB_CPUTYPE_386 to FB_CPUTYPE_NATIVE) = _
{ _
	@"i386", _
	@"i486", _
	@"i586", _
	@"i686", _
	@"athlon", _
	@"athlon-xp", _
	@"athlon-fx", _
	@"k8-sse3", _
	@"pentium-mmx", _
	@"pentium2", _
	@"pentium3", _
	@"pentium4", _
	@"prescott", _
	@"k8", _
	NULL, _
	NULL, _
	NULL _
}

private function hCompileStage2Module( byval module as FBCIOFILE ptr ) as integer
	dim as string ln, asmfile

	asmfile = hGetAsmName( module, 2 )
	if( hCanDeleteAsm( 2 ) ) then
		fbcAddTemp( asmfile )
	end if

	select case( fbGetOption( FB_COMPOPT_BACKEND ) )
	case FB_BACKEND_GCC
		if( fbIsTarget64bit( ) ) then
			ln += "-m64 "
		else
			ln += "-m32 "
		end if

		ln += "-S -nostdlib -nostdinc -Wall -Wno-unused-label " + _
		      "-Wno-unused-function -Wno-unused-variable "

		'' Don't warn about non-standard main() signature
		'' (we emit "ubyte **argv" instead of "char **argv")
		ln += "-Wno-main "

		'' helps finding ir-hlc bugs
		ln += "-Werror-implicit-function-declaration "

		ln += "-O" + str( fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) ) + " "

		'' Do not let gcc make assumptions about pointers; FB isn't strict about it.
		ln += "-fno-strict-aliasing "

		'' The rtlib sets its own rounding mode, don't let gcc make assumptions.
		ln += "-frounding-math "

		'' ?
		ln += "-fno-math-errno "

		'' Note: we shouldn't use some options like e.g. -ffast-math, because
		'' they cause incompatibilities with the ASM backend. For example:
		''    dim as double d = INF
		''    print d - d
		'' prints -NaN (IND) under the ASM backend because the FPU does the
		'' subtraction, however with the C backend with, gcc -ffast-math
		'' optimizes out the subtraction (even under -O0) and inserts 0 instead.

		if( fbGetOption( FB_COMPOPT_DEBUG ) ) then
			ln += "-g "
		end if

		if( fbc.cputype = FB_CPUTYPE_NATIVE ) then
			ln += "-mtune=native "
		else
			ln += "-mtune=" + *gcc_architectures(fbGetOption( FB_COMPOPT_CPUTYPE )) + " "
		end if

		if( fbGetOption( FB_COMPOPT_FPUTYPE ) = FB_FPUTYPE_SSE ) then
			ln += "-mfpmath=sse -msse2 "
		end if

		if( fbGetOption( FB_COMPOPT_ASMSYNTAX ) = FB_ASMSYNTAX_INTEL ) then
			ln += "-masm=intel "
		end if

	case FB_BACKEND_LLVM
		if( fbIsTarget64bit( ) ) then
			ln += "-march=x86-64 "
		else
			ln += "-march=x86 "
		end if

		ln += "-O" + str( fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) ) + " "

		if( fbGetOption( FB_COMPOPT_ASMSYNTAX ) = FB_ASMSYNTAX_INTEL ) then
			ln += "--x86-asm-syntax=intel "
		end if

	end select

	ln += """" + hGetAsmName( module, 1 ) + """ "
	ln += "-o """ + asmfile + """"
	ln += fbc.extopt.gcc

	select case( fbGetOption( FB_COMPOPT_BACKEND ) )
	case FB_BACKEND_GCC
		function = fbcRunBin( "compiling C", FBCTOOL_GCC, ln )
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

	if( fbIsTarget64bit( ) ) then
		ln = "--64 "
	else
		ln = "--32 "
	end if

	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		ln += "--strip-local-absolute "
	end if
	ln += """" + hGetAsmName( module, 2 ) + """ "
	ln += "-o """ + *module->objfile + """"
	ln += fbc.extopt.gas

	if( fbcRunBin( "assembling", FBCTOOL_AS, ln ) = FALSE ) then
		exit function
	end if

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

	dim as string ln = "--output-format=coff "
	ln += " """ + rc->srcfile + """"
	ln += " """ + *rc->objfile + """"

	function = fbcRunBin( "compiling rc", FBCTOOL_WINDRES, ln )
#endif

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

	'' Clean up the temp .bas too
	if( hCanDeleteAsm( 1 ) ) then
		fbcAddTemp( fbctinf.srcfile )
	end if

	hCompileBas( @fbctinf, FALSE, TRUE )
	if( fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS ) then
		hCompileStage2Module( @fbctinf )
	end if
	function = hAssembleModule( @fbctinf )
end function

private function hArchiveFiles( ) as integer
	'' Determine the output archive's name if not given via -x
	if (len(fbc.outname) = 0) then
		fbc.outname = hStripFilename(fbc.mainname) + _
		              "lib" + hStripPath(fbc.mainname) + ".a"
	end if

	'' Remove lib*.a if it already exists, because ar doesn't overwrite
	safeKill( fbc.outname )

	dim as string ln = "-rsc " + QUOTE + fbc.outname + (QUOTE + " ")

	if( fbIsCrossComp( ) = FALSE ) then
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

	'' invoke ar
	function = fbcRunBin( "archiving", FBCTOOL_AR, ln )
end function

private sub hSetDefaultLibPaths( )
	'' compiler's lib/
	fbcAddDefLibPath( fbc.libpath )

	'' and the current path
	fbcAddDefLibPath( "." )

#ifndef ENABLE_STANDALONE
	'' Add gcc's private lib directory, to find libgcc and libsupc++
	'' This is for installing into Unix-like systems, and not for
	'' standalone, which has libgcc/libsupc++ in the main lib/.
	fbcAddLibPathFor( "libgcc.a" )

	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS ) then
		'' Note: The standalone DOS FB uses the renamed 8.3 filename version: supcx
		'' But this is for installing into DJGPP, where apparently supcxx is working fine.
		fbcAddLibPathFor( "libsupcxx.a" )
	else
		fbcAddLibPathFor( "libsupc++.a" )
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

private sub hAddDefaultLibs( )
	'' select the right FB rtlib
	if (fbGetOption(FB_COMPOPT_MULTITHREADED)) then
		fbcAddDefLib("fbmt")
	else
		fbcAddDefLib("fb")
	end if

	fbcAddDefLib("gcc")

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN
		fbcAddDefLib("cygwin")
		fbcAddDefLib("kernel32")
		fbcAddDefLib("supc++")

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			fbcAddDefLib("gmon")
		end if

	case FB_COMPTARGET_DARWIN
		fbcAddDefLib("System")

	case FB_COMPTARGET_DOS
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		#ifdef ENABLE_STANDALONE
			'' Renamed lib for the standalone build, working around
			'' the long file name.
			fbcAddDefLib("supcx")
		#else
			'' When installing into DJGPP, use its lib
			fbcAddDefLib("supcxx")
		#endif

	case FB_COMPTARGET_FREEBSD
		fbcAddDefLib("pthread")
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		fbcAddDefLib("ncurses")
		fbcAddDefLib("supc++")

	case FB_COMPTARGET_LINUX
		'' Note: When linking statically, -lpthread apparently should
		'' be linked before -lc. Otherwise there can be errors due to
		'' -lpthread/-lc containing overlapping symbols (but the pthread
		'' ones should be used). This is confirmed by minimal testing,
		'' searching the web and 'gcc -pthread' behavior.
		fbcAddDefLib("pthread")
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		fbcAddDefLib("dl")
		fbcAddDefLib("ncurses")
		fbcAddDefLib("supc++")
		fbcAddDefLib("gcc_eh")

	case FB_COMPTARGET_NETBSD
		'' TODO

	case FB_COMPTARGET_OPENBSD
		fbcAddDefLib("pthread")
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		fbcAddDefLib("ncurses")
		fbcAddDefLib("supc++")

	case FB_COMPTARGET_WIN32
		fbcAddDefLib("msvcrt")
		fbcAddDefLib("kernel32")
		fbcAddDefLib("mingw32")
		fbcAddDefLib("mingwex")
		fbcAddDefLib("moldname")
		fbcAddDefLib("supc++")
		#ifndef ENABLE_TDMGCC
			'' Needed by mingw.org toolchain, but not TDM-GCC
			fbcAddDefLib("gcc_eh")
		#endif

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			fbcAddDefLib("gmon")
		end if

	case FB_COMPTARGET_XBOX
		fbcAddDefLib("fbgfx")
		fbcAddDefLib("openxdk")
		fbcAddDefLib("hal")
		fbcAddDefLib("c")
		fbcAddDefLib("usb")
		fbcAddDefLib("xboxkrnl")
		fbcAddDefLib("m")
		fbcAddDefLib("supc++")

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			fbcAddDefLib("gmon")
		end if

	end select

end sub

private sub hPrintOptions( )
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
	print "  -arch <type>     Set target architecture (default: 486)"
	print "  -asm att|intel   Set asm format (-gen gcc)"
	print "  -b <file>        Treat file as .bas input file"
	print "  -c               Compile only, do not link"
	print "  -C               Preserve temporary .o files"
	print "  -d <name>[=<val>]  Add a global #define"
	print "  -dll             Same as -dylib"
	print "  -dylib           Create a DLL (win32) or shared library (*nix/*BSD)"
	print "  -e               Enable runtime error checking"
	print "  -ex              -e plus RESUME support"
	print "  -exx             -ex plus array bounds/null-pointer checking"
	print "  -export          Export symbols for dynamic linkage"
	print "  -forcelang <name>  Override #lang statements in source code"
	print "  -fpmode fast|precise  Select floating-point math accuracy/speed"
	print "  -fpu x87|sse     Set target FPU"
	print "  -g               Add debug info"
	print "  -gen gas|gcc|llvm  Select code generation backend"
	print "  [-]-help         Show this help output"
	print "  -i <path>        Add an include file search path"
	print "  -include <file>  Pre-#include a file for each input .bas"
	print "  -l <name>        Link in a library"
	print "  -lang <name>     Select FB dialect: deprecated, fblite, qb"
	print "  -lib             Create a static library"
	print "  -m <name>        Specify main module (default if not -c: first input .bas)"
	print "  -map <file>      Save linking map to file"
	print "  -maxerr <n>      Only show <n> errors"
	print "  -mt              Use thread-safe FB runtime"
	print "  -nodeflibs       Do not include the default libraries"
	print "  -noerrline       Do not show source context in error messages"
	print "  -o <file>        Set .o file name for corresponding input .bas"
	print "  -O <value>       Optimization level (default: 0)"
	print "  -p <path>        Add a library search path"
	print "  -pp              Write out preprocessed input file (.pp.bas) only"
	print "  -prefix <path>   Set the compiler prefix path"
	print "  -profile         Enable function profiling"
	print "  -r               Write out .asm (-gen gas) or .c (-gen gcc) only"
	print "  -rr              Write out the final .asm only"
	print "  -R               Preserve the temporary .asm/.c file"
	print "  -RR              Preserve the final .asm file"
	print "  -s console|gui   Select win32 subsystem"
	print "  -static          Prefer static libraries over dynamic ones when linking"
	print "  -t <value>       Set .exe stack size in kbytes, default: 1024 (win32/dos)"
	print "  -target <name>   Set cross-compilation target"
	print "  -title <name>    Set XBE display title (xbox)"
	print "  -v               Be verbose"
	print "  -vec <n>         Automatic vectorization level (default: 0)"
	print "  [-]-version      Show compiler version"
	print "  -w all|pedantic|<n>  Set min warning level: all, pedantic or a value"
	print "  -Wa <a,b,c>      Pass options to 'as' (-gen gas or -gen llvm)"
	print "  -Wc <a,b,c>      Pass options to 'gcc' (-gen gcc) or 'llc' (-gen llvm)"
	print "  -Wl <a,b,c>      Pass options to 'ld'"
	print "  -x <file>        Set output executable/library file name"
	print "  -z gosub-setjmp  Use setjmp/longjmp to implement GOSUB"
end sub

private sub hAppendConfigInfo( byref config as string, byval info as zstring ptr )
	if( len( config ) > 0 ) then
		config += ", "
	end if
	config += *info
end sub

private sub hPrintVersion( )
	dim as string config

	print "FreeBASIC Compiler - Version " + FB_VERSION + _
		" (" + FB_BUILD_DATE + ") for " + FB_HOST
	print "Copyright (C) 2004-2013 The FreeBASIC development team."

	#ifdef ENABLE_STANDALONE
		hAppendConfigInfo( config, "standalone" )
	#endif

	#ifdef ENABLE_PREFIX
		hAppendConfigInfo( config, "prefix: '" + ENABLE_PREFIX + "'" )
	#endif

	if( len( config ) > 0 ) then
		print config
	end if
end sub

	fbcInit( )

	if( __FB_ARGC__ = 1 ) then
		hPrintOptions( )
		fbcEnd( 1 )
	end if

	hParseArgs( __FB_ARGC__, __FB_ARGV__ )

	if( fbc.showversion ) then
		hPrintVersion( )
		fbcEnd( 0 )
	end if

	'' Show help if --help was given, or if there are no input files
	fbc.showhelp or= ((listGetHead(@fbc.modules) = NULL) and _
	                  (listGetHead(@fbc.objlist) = NULL) and _
	                  (listGetHead(@fbc.libs.list) = NULL) and _
	                  (listGetHead(@fbc.libfiles) = NULL))

	if( fbc.showhelp ) then
		hPrintOptions( )
		fbcEnd( 1 )
	end if

	if( fbc.verbose ) then
		hPrintVersion( )
	end if

	fbcInit2( )

	''
	'' Compile .bas modules
	''
	hCompileModules( )

	if( hCompileXpm( ) = FALSE ) then
		fbcEnd( 1 )
	end if

	if( fbc.emitasmonly ) then
		fbcEnd( 0 )
	end if

	if( fbGetOption( FB_COMPOPT_BACKEND ) <> FB_BACKEND_GAS ) then
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
	if( fbIsCrossComp( ) = FALSE ) then
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

	if( hLinkFiles( ) = FALSE ) then
		fbcEnd( 1 )
	end if

	fbcEnd( 0 )
