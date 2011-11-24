'' main module, front-end
''
'' chng: sep/2004 written [v1ctor]
''		 dec/2004 linux support added [lillo]
''		 jan/2005 dos support added [DrV]

#include once "fb.bi"
#include once "hlp.bi"
#include once "hash.bi"
#include once "list.bi"

type FBC_EXTOPT
	gas			as zstring * 128
	ld			as zstring * 128
	gcc			as zstring * 128
end type

type FBCIOFILE
	as string srcfile '' input file
	as string objfile '' output .o file
end type

type FBC_OBJINF
	lang		as FB_LANG
	mt			as integer
end type

type FBCCTX
	'' For command line parsing
	optid				as integer       '' Current option
	lastiofile			as FBCIOFILE ptr '' Input file that receives the next -o filename
	objfile				as string '' -o filename waiting for next input file

	emitonly			as integer
	compileonly			as integer
	preserveasm			as integer
	preserveobj			as integer
	verbose				as integer
	showversion			as integer

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
	mainname			as zstring * FB_MAXNAMELEN+1
	mainset				as integer
	mapfile				as zstring * FB_MAXNAMELEN+1
	subsystem			as zstring * FB_MAXNAMELEN+1
	extopt				as FBC_EXTOPT
	prefix				as zstring * FB_MAXPATHLEN+1  '' Prefix path, either the default exepath() or hard-coded $prefix, or from -prefix
	triplet 			as zstring * FB_MAXNAMELEN+1  '' GNU triplet to prefix in front of cross-compiling tool names
	xbe_title 			as zstring * FB_MAXNAMELEN+1  '' For the '-title <title>' xbox option
	nodeflibs			as integer
	staticlink			as integer

	'' Compiler paths
	binpath				as zstring * FB_MAXPATHLEN+1
	incpath				as zstring * FB_MAXPATHLEN+1
	libpath				as zstring * FB_MAXPATHLEN+1

	objinf				as FBC_OBJINF
end type

declare function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byref tool as string, _
		byref ln as string _
	) as integer

declare function fbcFindBin(byval filename as zstring ptr) as string

#macro safeKill(f)
	if( kill( f ) <> 0 ) then
	end if
#endmacro

dim shared as FBCCTX fbc

private sub fbcInit( )
	const FBC_INITFILES = 64

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

	fbc.emitonly    = FALSE
	fbc.compileonly = FALSE
	fbc.preserveasm	= FALSE
	fbc.preserveobj	= FALSE
	fbc.verbose     = FALSE

	fbc.mainname	= ""
	fbc.mainset     = FALSE
	fbc.mapfile     = ""
	fbc.outname     = ""

	fbc.extopt.gas	= ""
	fbc.extopt.ld	= ""

	fbc.objinf.lang = fbGetOption( FB_COMPOPT_LANG )
	fbc.objinf.mt   = FALSE
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

private sub fbcAddObj(byref file as string)
	strlistAppend(@fbc.objlist, file)
end sub

private function hAddInfoObject as integer

    if( hFileExists( FB_INFOSEC_OBJNAME ) ) then
    	safeKill( FB_INFOSEC_OBJNAME )
    end if

#ifndef DISABLE_OBJINFO
    if( fbObjInfoWriteObj( @fbc.finallibs.list, @fbc.finallibpaths.list ) ) then
    	function = TRUE

    '' and error occurred or there's no need for an info object, delete it
    else
		if( hFileExists( FB_INFOSEC_OBJNAME ) ) then
    		safeKill( FB_INFOSEC_OBJNAME )
    	end if

    	function = FALSE
    end if
#else
	function = FALSE
#endif

end function

private function archiveFiles() as integer
	'' Determine the output archive's name if not given via -x
	if (len(fbc.outname) = 0) then
		fbc.outname = hStripFilename(fbc.mainname) + _
		              "lib" + hStripPath(fbc.mainname) + ".a"
	end if

	'' Remove lib*.a if it already exists, because ar doesn't overwrite
	safeKill( fbc.outname )

	dim as string ln = "-rsc " + QUOTE + fbc.outname + (QUOTE + " ")

#ifndef DISABLE_OBJINFO
	'' the first object must be the info one
	if( fbIsCrossComp( ) = FALSE ) then
		if( hAddInfoObject( ) ) then
			ln += QUOTE + FB_INFOSEC_OBJNAME + QUOTE + " "
			fbcAddTemp(FB_INFOSEC_OBJNAME)
		end if
	end if
#endif

	dim as string ptr objfile = listGetHead(@fbc.objlist)
	while (objfile)
		ln += QUOTE + *objfile + (QUOTE + " ")
		objfile = listGetNext(objfile)
	wend

	'' invoke ar
	return fbcRunBin("archiving", fbcFindBin("ar"), ln)
end function

function fbcFindGccLib(byref file as string) as string
	dim as string found

	'' Files in our lib/ directory have precedence, and are in fact
	'' required for standalone builds.
	found = fbc.libpath + FB_HOST_PATHDIV + file

#ifndef ENABLE_STANDALONE
	if( hFileExists( found ) ) then
		return found
	end if

	'' Normally libgcc.a, libsupc++.a, crtbegin.o, crtend.o will be inside
	'' gcc's sub-directory in lib/gcc/target/version, i.e. we can only
	'' find them via 'gcc -print-file-name=foo' (or by hard-coding against
	'' a specific gcc target/version).
	'' The normal build needs to ask gcc to find out where those files are,
	'' while the standalone build is supposed to be standalone and have
	'' everything in its own lib/ directory.
	''
	'' (Note: If we're cross-compiling, the cross-gcc will be queried,
	'' not the host gcc.)

	dim as integer ff = any

	function = ""

	dim as string path = fbcFindBin("gcc")

	path += " -m32 -print-file-name=" + file

	ff = freefile()
	if( open pipe( path, for input, as ff ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, file, -1 )
		exit function
	end if

	input #ff, found

	close ff

	dim as string fileonly = hStripPath( found )

	if( found = fileonly ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, file, -1 )
		exit function
	end if
#endif

	function = found

end function

private sub fbcAddDefLibPath(byref path as string)
	strsetAdd(@fbc.finallibpaths, path, TRUE)
end sub

sub fbcAddLibPathFor(byref libname as string)
	dim as string path = _
		pathStripDiv(hStripFilename( _
			fbcFindGccLib("lib" + libname + ".a")))
	if (len(path) > 0) then
		fbcAddDefLibPath(path)
	end if
end sub

function fbcFindBin(byval filename as zstring ptr) as string
	'' Check for an environment variable.
	'' (e.g. fbcFindBin("ld") will check the LD environment variable)
	dim as string path = environ(ucase(*filename))
	if (len(path) > 0) then
		'' The environment variable is set, this should be it.
		'' If this path doesn't work, then why did someone set the
		'' variable that way?
		return path
	end if

	'' Build the path to the program in our bin/ directory
	path = fbc.binpath + FB_HOST_PATHDIV
	path += fbc.triplet + *filename + FB_HOST_EXEEXT

#ifdef __FB_UNIX__
	'' On *nix/*BSD, check whether the program exists in bin/, and fallback
	'' to the system default otherwise, i.e. tools installed in the same
	'' location are preferred, but not required.
	if (hFileExists(path)) then
		return path
	end if

	'' Use the system default, it works with exec() on these systems.
	return fbc.triplet + *filename + FB_HOST_EXEEXT
#else
	'' The programs must be reachable via relative or absolute path,
	'' otherwise the CreateProcess() in exec() will fail.
	return path
#endif
end function

function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byref tool as string, _
		byref ln as string _
	) as integer

	'' Note: We have to use exec(). shell() would require special care
	'' with shell syntax (we'd have to quote escape chars in filenames
	'' and such), and it's slower too.

	if (fbc.verbose) then
		print *action & ": ", tool & " " & ln
	end if

	dim as integer result = exec(tool, ln)
	if (result = 0) then
		return TRUE
	end if

	'' A rather vague assumption on exec() return value:
	''    -1 should be "not found"
	if (result < 0) then
		errReportEx(FB_ERRMSG_EXEMISSING, tool, -1, FB_ERRMSGOPT_ADDCOLON or FB_ERRMSGOPT_ADDQUOTES)
	else
		'' Report bad exit codes only in verbose mode; normally the
		'' program should already have shown an error message, and the
		'' exit code is only interesting for debugging purposes.
		if (fbc.verbose) then
			print *action & " failed: '" & tool & "' terminated with exit code " & result
		end if
	end if

	return FALSE
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

private function makeImpLib(byref dllname as string, byref deffile as string) as integer
	'' for some weird reason, LD will declare all functions exported as if they were
	'' from DATA segment, causing an exception (UPPERCASE'd symbols assumption??)
	if (clearDefList(deffile) = FALSE) then
		return FALSE
	end if

	dim as string ln
	ln += "--def " + QUOTE + deffile + QUOTE
	ln += " --dllname " + QUOTE + hStripPath(fbc.outname) + QUOTE
	ln += " --output-lib " + QUOTE + hStripFilename(fbc.outname) + "lib" + dllname + (".dll.a" + QUOTE)

	if (fbcRunBin("creating import library", fbcFindBin("dlltool"), ln) = FALSE) then
		return FALSE
	end if

	if (fbc.preserveasm = FALSE) then
		fbcAddTemp(deffile)
	end if

	return TRUE
end function

'':::::
private function linkFiles() as integer
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

		'' export all symbols declared as EXPORT
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

#ifndef DISABLE_OBJINFO
	else
		'' Supplementary ld script to drop the fbctinf objinfo section
		ldcline += " """ + fbc.libpath + (FB_HOST_PATHDIV + "fbextra.x""")
#endif

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
			ldcline += " """ + fbcFindGccLib("crt0.o") + """"
		else
			'' TODO
			ldcline += " """ + fbcFindGccLib("crt0.o") + """"
			'' additional support for gmon
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				ldcline += " """ + fbcFindGccLib("gcrt0.o") + """"
			end if
		end if

	case FB_COMPTARGET_WIN32
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			ldcline += " """ + fbcFindGccLib("dllcrt2.o") + """"
		else
			ldcline += " """ + fbcFindGccLib("crt2.o") + """"
			'' additional support for gmon
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				ldcline += " """ + fbcFindGccLib("gcrt2.o") + """"
			end if
		end if

		ldcline += " """ + fbcFindGccLib("crtbegin.o") + """"

	case FB_COMPTARGET_DOS
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += " """ + fbcFindGccLib("gcrt0.o") + """"
		else
			ldcline += " """ + fbcFindGccLib("crt0.o") + """"
		end if

	case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD
					ldcline += " """ + fbcFindGccLib("gcrt0.o") + """"
				case else
					ldcline += " """ + fbcFindGccLib("gcrt1.o") + """"
				end select
			else
				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD
					ldcline += " """ + fbcFindGccLib("crt0.o") + """"
				case else
					ldcline += " """ + fbcFindGccLib("crt1.o") + """"
				end select
			end if
		end if

		'' All have crti.o, except OpenBSD
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += " """ + fbcFindGccLib("crti.o") + """"
		end if

		ldcline += " """ + fbcFindGccLib("crtbegin.o") + """"

	case FB_COMPTARGET_XBOX
		'' link with crt0.o (C runtime init)
		ldcline += " """ + fbcFindGccLib("crt0.o") + """"

	end select

	if (fbc.nodeflibs = FALSE) then
		ldcline += " """ + fbc.libpath + (FB_HOST_PATHDIV + "fbrt0.o""")
	end if

	scope
		dim as string ptr objfile = listGetHead(@fbc.objlist)
		while (objfile)
			ldcline += " """ + *objfile + """"
			objfile = listGetNext(objfile)
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
		ldcline += " """ + fbcFindGccLib("crtend.o") + """"
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += " " + QUOTE + fbcFindGccLib("crtn.o") + QUOTE
		end if

	case FB_COMPTARGET_WIN32
		ldcline += " """ + fbcFindGccLib("crtend.o") + """"

	end select

	'' extra options
	ldcline += " " + fbc.extopt.ld

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
	'' When using the DOS DJGPP tools, the command line length might be
	'' limited, and with our generally long ld command lines (especially
	'' when linking fbc) the line must be passed to ld through an @file.
	dim as string argsfile
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		argsfile = hStripFilename(fbc.outname) + "temp.res"
		if (createArgsFile(argsfile, ldcline) = FALSE) then
			exit function
		end if
		if (fbc.verbose) then
			print "ld options in '" & argsfile & "': ", ldcline
		end if
		ldcline = "@" + argsfile
	end if
#endif

	'' invoke ld
	if (fbcRunBin("linking", fbcFindBin("ld"), ldcline) = FALSE) then
		exit function
	end if

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		kill(argsfile)
	end if
#endif

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

		cxbepath = fbcFindBin("cxbe")

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

'':::::
private sub objinf_addLibCb _
	( _
		byval libName as zstring ptr, _
		byval objName as zstring ptr _
	)

	strsetAdd(@fbc.finallibs, *libName, FALSE)

end sub

'':::::
private sub objinf_addPathCb _
	( _
		byval pathName as zstring ptr, _
		byval objName as zstring ptr _
	)

	strsetAdd(@fbc.finallibpaths, *pathName, FALSE)

end sub

'':::::
private sub objinf_addOption _
	( _
		byval opt as FB_COMPOPT, _
		byval value as zstring ptr, _
		byval objName as zstring ptr _
	)

#macro hReportErr( num )
	errReportWarnEx( num, objName, -1 )
#endmacro

	select case opt
	case FB_COMPOPT_MULTITHREADED
		if( fbc.objinf.mt = FALSE ) then
			hReportErr( FB_WARNINGMSG_MIXINGMTMODES )

			fbc.objinf.mt = TRUE
			fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )
		end if

	case FB_COMPOPT_LANG
		dim as FB_LANG id = any

		id = fbGetLangId( value )

		'' bad objinfo value?
		if( id = FB_LANG_INVALID ) then
			id = FB_LANG_FB
		end if

		if( id <> fbc.objinf.lang ) then
			hReportErr( FB_WARNINGMSG_MIXINGLANGMODES )

			fbc.objinf.lang = id
			fbSetOption( FB_COMPOPT_LANG, id )
		end if
	end select

end sub

'':::::
private function collectObjInfo _
	( _
	) as integer

	'' cross-compiling? BFD can't be used..
	if( fbIsCrossComp( ) ) then
		return FALSE
    end if

#ifndef DISABLE_OBJINFO
	scope
		'' for each object passed in the cmd-line
		dim as string ptr obj = listGetHead( @fbc.objlist )
		do while( obj <> NULL )
			fbObjInfoReadObj( *obj, _
							  @objinf_addLibCb, _
							  @objinf_addPathCb, _
							  @objinf_addOption )
			obj = listGetNext( obj )
		loop
	end scope

	scope
		'' for each library found (must be done after processing all objects)
		dim as TSTRSETITEM ptr i = listGetHead(@fbc.finallibs.list)
		while (i)
			'' Not default?
			if (i->userdata = FALSE) then
				fbObjInfoReadLib(i->s, @objinf_addLibCb, _
				                       @objinf_addPathCb, _
				                       @objinf_addOption, _
				                       @fbc.finallibpaths.list)
			end if
			i = listGetNext(i)
		wend
	end scope

	function = TRUE
#else
	function = FALSE
#endif

end function

private sub fbcErrorInvalidOption(byref arg as string)
	errReportEx( FB_ERRMSG_INVALIDCMDOPTION, QUOTE + arg + QUOTE, -1 )
end sub

private sub checkWaitingObjfile()
	if (len(fbc.objfile) > 0) then
		errReportEx( FB_ERRMSG_OBJFILEWITHOUTINPUTFILE, "-o " & fbc.objfile, -1 )
		fbc.objfile = ""
	end if
end sub

private sub setIofile(byval iofile as FBCIOFILE ptr, byref file as string)
	iofile->srcfile = file
	fbc.lastiofile = iofile

	'' Got a waiting -o <file>? This module takes it.
	if (len(fbc.objfile) > 0) then
		iofile->objfile = fbc.objfile
		fbc.objfile = ""
	end if
end sub

private sub addBas(byref basfile as string)
	setIofile(listNewNode(@fbc.modules), basfile)
end sub

'' -target <triplet> parser
private function parseTargetTriplet(byref triplet as string) as integer
	'' To support the system triplets, we need to parse them,
	'' to identify which target of ours it could mean (much like in the
	'' FB makefile when cross-compiling FB).

	'' Split the triplet into its components
	''    [arch-][vendor-]os[-...]

	'' Cut off up to two leading components to get to the OS
	dim as string os = triplet
	for i as integer = 0 to 1
		dim as integer j = instr(1, os, "-")
		if (j = 0) then
			exit for
		end if
		os = right(os, len(os) - j)
	next

	if (len(os) = 0) then
		return -1
	end if

	#macro MAYBE(target, comptarget)
		'' Allow incomplete matches, e.g.:
		'' 'linux' matches 'linux-gnu',
		'' 'mingw' matches 'mingw32msvc', etc.
		if (left(os, len(target)) = target) then
			return comptarget
		end if
	#endmacro

	select case as const (os[0])
	case asc("c")
		MAYBE("cygwin", FB_COMPTARGET_CYGWIN)

	case asc("d")
		MAYBE("darwin", FB_COMPTARGET_DARWIN)
		MAYBE("djgpp", FB_COMPTARGET_DOS)
		MAYBE("dos", FB_COMPTARGET_DOS)

	case asc("f")
		MAYBE("freebsd", FB_COMPTARGET_FREEBSD)

	case asc("l")
		MAYBE("linux", FB_COMPTARGET_LINUX)

	case asc("m")
		MAYBE("mingw", FB_COMPTARGET_WIN32)
		MAYBE("msdos", FB_COMPTARGET_DOS)

	case asc("n")
		MAYBE("netbsd", FB_COMPTARGET_NETBSD)

	case asc("o")
		MAYBE("openbsd", FB_COMPTARGET_OPENBSD)

	case asc("s")
		'' TODO (not yet implemented in the compiler)
		''MAYBE("solaris", FB_COMPTARGET_SOLARIS)

	case asc("w")
		MAYBE("win32", FB_COMPTARGET_WIN32)
		MAYBE("windows", FB_COMPTARGET_WIN32)

	case asc("x")
		MAYBE("xbox", FB_COMPTARGET_XBOX)

	end select

	return -1
end function

enum
	OPT_A = 0
	OPT_ARCH
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
		fbcAddObj(arg)

	case OPT_ARCH
		dim as integer value = any

		select case (arg)
		case "386"
			value = FB_CPUTYPE_386
		case "486"
			value = FB_CPUTYPE_486
		case "586"
			value = FB_CPUTYPE_586
		case "686"
			value = FB_CPUTYPE_686
		case "athlon"
			value = FB_CPUTYPE_ATHLON
		case "athlon-xp"
			value = FB_CPUTYPE_ATHLONXP
		case "athlon-fx"
			value = FB_CPUTYPE_ATHLONFX
		case "k8-sse3"
			value = FB_CPUTYPE_ATHLONSSE3
		case "pentium-mmx"
			value = FB_CPUTYPE_PENTIUMMMX
		case "pentium2"
			value = FB_CPUTYPE_PENTIUM2
		case "pentium3"
			value = FB_CPUTYPE_PENTIUM3
		case "pentium4"
			value = FB_CPUTYPE_PENTIUM4
		case "pentium4-sse3"
			value = FB_CPUTYPE_PENTIUMSSE3
		case "native"
			value = FB_CPUTYPE_NATIVE
		case else
			fbcErrorInvalidOption(arg)
			return
		end select

		fbSetOption( FB_COMPOPT_CPUTYPE, value )

	case OPT_B
		addBas(arg)

	case OPT_C
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
		fbc.compileonly = TRUE
		fbc.emitonly = FALSE
		fbc.preserveobj = TRUE

	case OPT_CKEEPOBJ
		fbc.preserveobj = TRUE

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
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
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
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
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
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
		end select

		fbSetOption( FB_COMPOPT_FPUTYPE, value )

	case OPT_G
		fbSetOption( FB_COMPOPT_DEBUG, TRUE )

	case OPT_GEN
		dim as integer value = any

		select case (lcase(arg))
		case "gas"
			value = FB_BACKEND_GAS
		case "gcc"
			value = FB_BACKEND_GCC
		case else
			fbcErrorInvalidOption(arg)
			return
		end select

		fbSetOption( FB_COMPOPT_BACKEND, value )

	case OPT_I
		fbAddIncludePath(pathStripDiv(arg))

	case OPT_INCLUDE
		fbAddPreInclude(arg)

	case OPT_L
		strsetAdd(@fbc.libs, arg, FALSE)

	case OPT_LANG
		dim as integer value = fbGetLangId( strptr(arg) )
		if( value = FB_LANG_INVALID ) then
			fbcErrorInvalidOption(arg)
			return
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
				value = 1
				fbcErrorInvalidOption(arg)
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
		checkWaitingObjfile()

		'' Assign it to the last module, if it doesn't have an -o filename yet,
		'' or store it for later otherwise.
		if (fbc.lastiofile andalso (len(fbc.lastiofile->objfile) = 0)) then
			fbc.lastiofile->objfile = arg
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
				fbcErrorInvalidOption(arg)
			elseif (value > 3) then
				value = 3
			end if
		end if

		fbSetOption( FB_COMPOPT_OPTIMIZELEVEL, value )

	case OPT_P
		strsetAdd(@fbc.libpaths, pathStripDiv(arg), FALSE)

	case OPT_PP
		fbSetOption( FB_COMPOPT_PPONLY, TRUE )
		fbc.compileonly = TRUE
		fbc.emitonly = TRUE
		fbc.preserveasm = FALSE

	case OPT_PREFIX
		fbc.prefix = pathStripDiv(arg)

	case OPT_PROFILE
		fbSetOption( FB_COMPOPT_PROFILE, TRUE )

	case OPT_R
		if( fbc.compileonly = FALSE )then
			fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
			fbc.emitonly = TRUE
		end if
		fbc.preserveasm = TRUE

	case OPT_RKEEPASM
		fbc.preserveasm = TRUE

	case OPT_S
		fbc.subsystem = arg

	case OPT_STATIC
		fbc.staticlink = TRUE

	case OPT_T
		fbSetOption(FB_COMPOPT_STACKSIZE, valint(arg) * 1024)

	case OPT_TARGET
		'' The argument given to -target is what will be prepended to
		'' the executable names of cross-tools, for example:
		''    fbc -target dos
		'' will try to use:
		''    bin/dos-ld[.exe]
		''
		'' It allows fbc to work together with cross-gcc/binutils
		'' using system triplets:
		''    fbc -target i686-pc-mingw32
		'' looks for:
		''    bin/i686-pc-mingw32-ld[.exe]
		fbc.triplet = arg + "-"

		'' Identify the target
		dim as integer comptarget = parseTargetTriplet(arg)
		if (comptarget < 0) then
			fbcErrorInvalidOption(arg)
			return
		end if

		fbSetOption( FB_COMPOPT_TARGET, comptarget )

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
			fbcErrorInvalidOption(arg)
			return
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
		dim as integer value = fbGetOption( FB_COMPOPT_EXTRAOPT )

		select case (lcase(arg))
		case "gosub-setjmp"
			value or= FB_EXTRAOPT_GOSUB_SETJMP
		case else
			fbcErrorInvalidOption(arg)
			return
		end select

		fbSetOption( FB_COMPOPT_EXTRAOPT, value )

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

	case asc("R")
		ONECHAR(OPT_RKEEPASM)

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
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
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
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
		end if

		'' Parse the option after the '-'
		dim as integer optid = parseOption(opt)
		if (optid < 0) then
			'' Unrecognized command line option
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
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
			fbcErrorInvalidOption(arg)
			fbcEnd(1)
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
			addBas(arg)

		case "o"
			fbcAddObj(arg)

		case "a"
			strlistAppend(@fbc.libfiles, arg)

		case "rc", "res"
			setIofile(listNewNode(@fbc.rcs), arg)

		case "xpm"
			'' Can have only one .xpm, or the fb_program_icon
			'' symbol will be duplicated
			if (len(fbc.xpm.srcfile) > 0) then
				fbcErrorInvalidOption(arg)
				fbcEnd(1)
			end if

			setIofile(@fbc.xpm, arg)

		case else
			'' Input file without or with unknown extension
			fbcErrorInvalidOption(arg)
			fbcEnd(1)

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

private sub parseArgs(byval argc as integer, byval argv as zstring ptr ptr)
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
		fbcErrorInvalidOption(*argv[argc - 1])
		fbcEnd(1)
	end if

	'' In case there was an '-o <file>', but no corresponding input file,
	'' this will report the error.
	checkWaitingObjfile()

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
private sub fbcInit2()
	'' Setup/calculate the paths to bin/ (needed when invoking helper
	'' tools), include/ (needed when searching headers), and lib/ (needed
	'' to find libraries when linking).
	'' (See the makefile for some directory layout info)

	'' Not already set from -prefix command line option?
	if (len(fbc.prefix) = 0) then
		'' Then default to exepath() or the hard-coded prefix.
		'' Normally fbc is relocatable, i.e. no fixed prefix is
		'' compiled in, but there still is ENABLE_PREFIX to do just
		'' that if desired.
		#ifdef ENABLE_PREFIX
			fbc.prefix = ENABLE_PREFIX
		#else
			fbc.prefix = exepath()
			#ifndef ENABLE_STANDALONE
				'' Non-standalone fbc is in prefix/bin,
				'' it can add '..' to get to prefix.
				fbc.prefix += FB_HOST_PATHDIV + ".."
			#endif
		#endif
	end if

	fbc.prefix += FB_HOST_PATHDIV

	fbc.binpath = fbc.prefix + "bin"
	fbc.incpath = fbc.prefix
	fbc.libpath = fbc.prefix

	#ifdef ENABLE_STANDALONE
		'' include/
		'' [triplet-]lib[-suffix]/
		fbc.incpath += "include"
		fbc.libpath += fbc.triplet + "lib"
	#else
		'' include/freebasic/
		'' lib/[triplet-]freebasic[-suffix]/
		fbc.incpath += "include" + FB_HOST_PATHDIV
		fbc.libpath += "lib"     + FB_HOST_PATHDIV + fbc.triplet
		#ifdef __FB_DOS__
			'' Our subdirectory in include/ and lib/ is usually called
			'' freebasic/, but on DOS that's too long... of course almost
			'' no target triplet or suffix can be used either.
			'' (Note: When changing, update the makefile too)
			fbc.incpath += "freebas"
			fbc.libpath += "freebas"
		#else
			fbc.incpath += "freebasic"
			fbc.libpath += "freebasic"
		#endif
	#endif

	fbc.libpath += FB_SUFFIX

	hRevertSlash( fbc.binpath, FALSE, asc(FB_HOST_PATHDIV) )
	hRevertSlash( fbc.incpath, FALSE, asc(FB_HOST_PATHDIV) )
	hRevertSlash( fbc.libpath, FALSE, asc(FB_HOST_PATHDIV) )

	'' Tell the compiler about the default include path (it's added after
	'' the command line ones, so those will be searched first)
	fbAddIncludePath(fbc.incpath)

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
				fbc.mainname = "undefined"
			end if
		end if
		fbc.mainname = hStripExt(fbc.mainname)
	end if
end sub

'' Generate the .asm/.c file name for the given .bas module
private function getModuleAsmName(byval module as FBCIOFILE ptr) as string
	'' Based on the objfile name so it's also affected by -o
	dim as string asmfile = hStripExt(module->objfile)
	if (fbGetOption(FB_COMPOPT_BACKEND) = FB_BACKEND_GCC) then
		asmfile &= ".c"
	else
		asmfile &= ".asm"
	end if
	function = asmfile
end function

private sub compileBas(byval module as FBCIOFILE ptr, byval ismain as integer)
	'' *.o name based on input file name unless given via -o <file>
	if (len(module->objfile) = 0) then
		module->objfile = hStripExt(module->srcfile) & ".o"
	end if

	dim as string asmfile = getModuleAsmName(module)
	if (fbc.preserveasm = FALSE) then
		fbcAddTemp(asmfile)
	end if

	if (fbc.verbose) then
		print "compiling: ", module->srcfile; " -o "; asmfile;
		if (ismain) then
			print " (main module)";
		end if
		print
	end if

	'' preserve orginal lang id, we may have to restore it.
	dim as FB_LANG prevlangid = fbGetOption(FB_COMPOPT_LANG)

	dim as integer restarts = 0

	do
		'' init the parser
		fbInit(ismain, restarts)

		'' add the libs and paths passed in the cmd-line, so the
		'' compiler can add them to the module's objinfo section
		fbSetLibs(@fbc.libs, @fbc.libpaths)

		fbCompile(module->srcfile, asmfile, ismain)

		'' If there were any errors during parsing, just exit without
		'' doing anything else.
		if (errGetCount() > 0) then
			fbcEnd(1)
		end if

		'' Don't restart unless asked for
		if (fbShouldRestart() = FALSE) then
			exit do
		end if

		'' Restart
		restarts += 1

		'' Shutdown the parser before restarting
		fbEnd()
	loop

	'' Update the list of libs and paths, with the ones found when parsing
	fbGetLibs(@fbc.finallibs, @fbc.finallibpaths)

	'' Shutdown the parser
	fbEnd()

	'' Restore original lang
	fbSetOption( FB_COMPOPT_LANG, prevlangid )
end sub

private sub compileModules()
	dim as integer ismain = FALSE
	dim as integer checkmain = any

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

	dim as string mainfile
	if (checkmain) then
		'' Note: This causes the path given with -m to be ignored in
		'' the ismain check below. This is good because -m is easier
		'' to use that way (e.g. fbc ../../main.bas -m main), and bad
		'' because then modules with the same name but in different
		'' directories will both be seen as the main one.
		mainfile = hStripPath(fbc.mainname)
	end if

	dim as FBCIOFILE ptr module = listGetHead(@fbc.modules)
	while (module)
		if (checkmain) then
			ismain = (mainfile = hStripPath(hStripExt(module->srcfile)))
			'' Note: checking continues for all modules, because
			'' "the" main module could be passed multiple times,
			'' and it makes sense to always treat it the same,
			'' so that <fbc 1.bas 1.bas -c> generates the same 1.o
			'' twice and <fbc 1.bas 1.bas> causes a duplicated
			'' definition of main().
			/'checkmain = not ismain'/
		end if

		compileBas(module, ismain)

		module = listGetNext(module)
	wend

	'' Make sure to add libs from command line to final lists if no input
	'' .bas were given
	if (module = NULL) then
		strsetCopy(@fbc.finallibs, @fbc.libs)
		strsetCopy(@fbc.finallibpaths, @fbc.libpaths)
	end if
end sub

private function parseXpm _
	( _
		byref xpmfile as string, _
		byref code as string _
	) as integer

	code += !"\ndim shared as zstring ptr "
	code += "fb_program_icon_data"
	code += !"(0 to ...) = _\n{ _\n"

	dim as integer f = freefile()
	if (open(xpmfile, for input, as #f)) then
		return FALSE
	end if

	dim as string ln

	'' Check for the header line
	line input #f, ln
	if (ucase(ln) <> "/* XPM */") then
		'' Invalid XPM header
		return FALSE
	end if

	'' Check for lines containing strings (color and pixel lines)
	'' Other lines (declaration line, empty lines, C comments, ...) aren't
	'' explicitely handled, but should automatically be ignored, as long as
	'' they don't contain strings.
	dim as integer saw_rows = FALSE
	while (eof(f) = FALSE)
		line input #f, ln

		'' Strip everything in front of the first '"'
		ln = right(ln, len(ln) - (instr(ln, """") - 1))

		'' Strip everything behind the second '"'
		ln = left(ln, instr(2, ln, """"))

		'' Got something left?
		if (len(ln) > 0) then
			'' Add an entry to the array, in a new line,
			'' separated by a comma, if it's not the first one.
			if (saw_rows) then
				code += !", _\n"
			end if
			code += !"\t@" + ln
			saw_rows = TRUE
		end if
	wend

	if (saw_rows = FALSE) then
		'' No image data found
		return FALSE
	end if

	close #f

	'' Line break after the last entry
	code += !" _ \n"

	code += !"}\n\n"

	'' Symbol for the gfxlib
	code += !"extern as zstring ptr ptr fb_program_icon alias ""fb_program_icon""\n"
	code += "dim shared as zstring ptr ptr fb_program_icon = " & _
					!"@fb_program_icon_data(0)\n"

	return TRUE
end function

private function compileXpm() as integer
	if (len(fbc.xpm.srcfile) = 0) then
		return TRUE
	end if

	'' Turn the .xpm icon resource into a .bas file, then compile that
	'' using the normal fb compilation process.
	dim as string xpmfile = fbc.xpm.srcfile

	'' *.bas name based on input file name or -o <file>
	'' Note: When naming after the input file, append .bas instead of
	'' replacing the extension, to avoid overwriting an existing .bas.
	if (len(fbc.xpm.objfile) > 0) then
		fbc.xpm.srcfile = hStripExt(fbc.xpm.objfile)
	end if
	fbc.xpm.srcfile &= ".bas"

	if (fbc.verbose) then
		print "compiling xpm: ", xpmfile & " -o " & fbc.xpm.srcfile
	end if

	dim as string code
	parseXpm(xpmfile, code)

	dim as integer fo = freefile()
	if (open(fbc.xpm.srcfile, for output, as #fo)) then
		return FALSE
	end if
	print #fo, code;
	close #fo

	'' Clean up the temp .bas too
	if (fbc.preserveasm = FALSE) then
		fbcAddTemp(fbc.xpm.srcfile)
	end if

	compileBas(@fbc.xpm, FALSE)
	function = TRUE
end function

dim shared as zstring ptr gcc_architectures(0 to (FB_CPUTYPECOUNT - 1)) = _
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
	@"native" _
}

private function assembleBas(byval module as FBCIOFILE ptr) as integer
	static as string assembler

	function = FALSE

	if (len(assembler) = 0) then
		if (fbGetOption(FB_COMPOPT_BACKEND) = FB_BACKEND_GCC) then
			assembler = "gcc"
		else
			assembler = "as"
		end if
		assembler = fbcFindBin(assembler)
	end if

	dim as string ln

	if (fbGetOption(FB_COMPOPT_BACKEND) = FB_BACKEND_GCC) then
		ln += "-c -nostdlib -nostdinc " & _
		      "-Wall -Wno-unused-label -Wno-unused-function -Wno-unused-variable " & _
		      "-finline -ffast-math -fomit-frame-pointer -fno-math-errno -fno-trapping-math -frounding-math -fno-strict-aliasing " & _
		      "-O" & fbGetOption(FB_COMPOPT_OPTIMIZELEVEL) & " "

		if (fbGetOption(FB_COMPOPT_DEBUG)) then
			ln += "-g "
		end if

		ln += "-mtune=" & *gcc_architectures(fbGetOption(FB_COMPOPT_CPUTYPE)) & " "

		if (fbGetOption(FB_COMPOPT_FPUTYPE) = FB_FPUTYPE_SSE) then
			ln += "-mfpmath=sse -msse2 "
		end if
	else
		'' --32 because we only compile for 32bit right now
		ln = "--32 "

		if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
			ln += "--strip-local-absolute "
		end if
	end if

	ln += """" + getModuleAsmName(module) + """ "
	ln += "-o """ + module->objfile + """"

	if (fbGetOption(FB_COMPOPT_BACKEND) = FB_BACKEND_GCC) then
		ln += fbc.extopt.gcc
	else
		ln += fbc.extopt.gas
	end if

	if (fbcRunBin("assembling", assembler, ln) = FALSE) then
		return FALSE
	end if

	fbcAddObj(module->objfile)
	if (fbc.preserveobj = FALSE) then
		fbcAddTemp(module->objfile)
	end if

	return TRUE
end function

private function assembleModules() as integer
	dim as FBCIOFILE ptr module = listGetHead(@fbc.modules)
	while (module)
		if (assembleBas(module) = FALSE) then
			return FALSE
		end if
		module = listGetNext(module)
	wend
	return TRUE
end function

private function assembleXpm() as integer
	if (len(fbc.xpm.srcfile) = 0) then
		function = TRUE
	else
		function = assembleBas(@fbc.xpm)
	end if
end function

private function assembleRc(byval rc as FBCIOFILE ptr) as integer
#if defined(ENABLE_STANDALONE) and defined(__FB_WIN32__)
	'' Using GoRC for the classical native win32 standalone build
	'' Note: GoRC /fo doesn't accept anything except *.obj, not even *.o,
	'' so we need to make it *.obj and then rename it afterwards.

	'' *.obj name based on input file name unless given via -o <file>
	dim as integer need_rename = FALSE
	if (len(rc->objfile) = 0) then
		'' Note: no need to worry about overwriting; nothing else uses
		'' the .obj extension.
		rc->objfile = hStripExt(rc->srcfile) & ".obj"
	else
		if (hGetFileExt(rc->objfile) <> "obj") then
			need_rename = TRUE
			rc->objfile &= ".obj"
		end if
	end if

	'' Change the include env var to point to the (hopefully present)
	'' win/rc/*.h headers.
	dim as string oldinclude = trim(environ("INCLUDE"))
	setenviron "INCLUDE=" + fbc.incpath + _
				(FB_HOST_PATHDIV + "win" + FB_HOST_PATHDIV + "rc")

	dim as string ln = "/ni /nw /o "
	ln &= "/fo """ & rc->objfile & """"
	ln &= " """ & rc->srcfile & """"

	if (fbcRunBin("compiling rc", fbcFindBin("GoRC"), ln) = FALSE) then
		return FALSE
	end if

	'' restore the include env var
	if (len(oldinclude) > 0) then
		setenviron "INCLUDE=" + oldinclude
	end if

	if (need_rename) then
		dim as string badname = rc->objfile
		rc->objfile = hStripExt(rc->objfile)
		'' Rename back so it will be found by ld/the user
		function = (name(badname, rc->objfile) = 0)
	else
		function = TRUE
	end if
#else
	'' Using binutils' windres for all other setups (e.g. cross-compiling
	'' linux -> win32)
	'' Note: windres uses gcc -E to preprocess the .rc by default,
	'' and that's not 100% compatible to GoRC (e.g. backslashes in
	'' paths/filenames are seen as escape sequences by gcc, but not GoRC)

	'' *.o name based on input file name unless given via -o <file>
	if (len(rc->objfile) = 0) then
		'' Note: Appending instead of replacing, to avoid overwriting
		'' an existing object file.
		rc->objfile = rc->srcfile & ".o"
	end if

	dim as string ln = "--output-format=coff "
	ln &= " """ & rc->srcfile & """"
	ln &= " """ & rc->objfile & """"

	function = fbcRunBin("compiling rc", fbcFindBin("windres"), ln)
#endif

	fbcAddObj(rc->objfile)
	if (fbc.preserveobj = FALSE) then
		fbcAddTemp(rc->objfile)
	end if
end function

private function assembleRcs() as integer
	'' Compile .rc/.res files
	dim as FBCIOFILE ptr rc = listGetHead(@fbc.rcs)
	while (rc)
		if (assembleRc(rc) = FALSE) then
			exit function
		end if
		rc = listGetNext(rc)
	wend
	function = TRUE
end function

private sub setDefaultLibPaths()

	'' compiler's lib/
	fbcAddDefLibPath(fbc.libpath)

	'' and the current path
	fbcAddDefLibPath(".")

#ifndef ENABLE_STANDALONE
	'' Add gcc's private lib directory, to find libgcc and libsupc++
	'' This is for installing into Unix-like systems, and not for
	'' standalone, which has libgcc/libsupc++ in its own lib/.
	fbcAddLibPathFor("gcc")

	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		'' Note: The standalone DOS FB uses the renamed 8.3 filename version: supcx
		'' But this is for installing into DJGPP, where apparently supcxx is working fine.
		fbcAddLibPathFor("supcxx")

		'' Help out the DJGPP linker. It doesn't seem to add
		'' the main DJGPP lib path by default like on other
		'' systems.
		'' Note: Shouldn't look for libc here -- we're supposed
		'' to have the fixed version of it in our lib/freebas/.
		fbcAddLibPathFor("m")
	else
		fbcAddLibPathFor("supc++")
	end if
#endif

end sub

private sub fbcAddDefLib(byval libname as zstring ptr)
	strsetAdd(@fbc.finallibs, *libname, TRUE)
end sub

'':::::
private sub addDefaultLibs()
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
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		fbcAddDefLib("pthread")
		fbcAddDefLib("ncurses")
		fbcAddDefLib("supc++")

	case FB_COMPTARGET_LINUX
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		fbcAddDefLib("pthread")
		fbcAddDefLib("dl")
		fbcAddDefLib("ncurses")
		fbcAddDefLib("supc++")
		fbcAddDefLib("gcc_eh")

	case FB_COMPTARGET_NETBSD
		'' TODO

	case FB_COMPTARGET_OPENBSD
		fbcAddDefLib("c")
		fbcAddDefLib("m")
		fbcAddDefLib("pthread")
		fbcAddDefLib("ncurses")
		fbcAddDefLib("supc++")

	case FB_COMPTARGET_WIN32
		fbcAddDefLib("msvcrt")
		fbcAddDefLib("kernel32")
		fbcAddDefLib("mingw32")
		fbcAddDefLib("mingwex")
		fbcAddDefLib("moldname")
		fbcAddDefLib("supc++")
		fbcAddDefLib("gcc_eh")

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

'':::::
private sub printOptions( )
	'' Note: must print each line separately to let the rtlib print the
	'' proper line endings even if redirected to file/pipe, hard-coding \n
	'' here isn't enough for DOS/Windows.

	print "usage: fbc [options] <input files>"
	print "input files:"
	print "  *.a = static library, *.o = object file, *.bas = source"
	print "  *.rc = resource script, *res = compiled resource (win32)"
	print "  *.xpm = icon resource (*nix/*bsd)"
	print "options:"
	print "  @<file>          Read more command line arguments from a file"
	print "  -a <file>        Treat file as .o/.a input file"
	print "  -arch <type>     Set target architecture (default: 486)"
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
	print "  -gen gas|gcc     Select code generation backend"
	print "  -i <path>        Add an include file search path"
	print "  -include <file>  Pre-#include a file for each input .bas"
	print "  -l <name>        Link in a library"
	print "  -lang <name>     Select FB dialect: deprecated, fblite, qb"
	print "  -lib             Create a static library"
	print "  -m <name>        Set main module (default if not -c: first input .bas)"
	print "  -map <file>      Save linking map to file"
	print "  -maxerr <n>      Only show <n> errors"
	print "  -mt              Use thread-safe FB runtime"
	print "  -nodeflibs       Do not include the default libraries"
	print "  -noerrline       Do not show source context in error messages"
	print "  -o <file>        Set .o file name for corresponding input .bas"
	print "  -O <value>       Optimization level (default: 0)"
	print "  -p <name>        Add a library search path"
	print "  -pp              Write out preprocessed input file (.pp.bas) only"
	print "  -prefix <path>   Set the compiler prefix path"
	print "  -profile         Enable function profiling"
	print "  -r               Like -c, but write out .asm/.c only, do not assemble"
	print "  -R               Preserve temporary non-.o files (.asm/.c etc.)"
	print "  -s console|gui   Select win32 subsystem"
	print "  -t <value>       Set .exe stack size in kbytes, default: 1024 (win32/dos)"
	print "  -target <name>   Set cross-compilation target"
	print "  -title <name>    Set XBE display title (xbox)"
	print "  -v               Be verbose"
	print "  -vec <n>         Automatic vectorization level (default: 0)"
	print "  -version         Show compiler version"
	print "  -w all|pedantic|<n>  Set min warning level: all, pedantic or a value"
	print "  -Wa <a,b,c>      Pass options to GAS"
	print "  -Wc <a,b,c>      Pass options to GCC (with -gen gcc)"
	print "  -Wl <a,b,c>      Pass options to LD"
	print "  -x <file>        Set output executable/library file name"
	print "  -z gosub-setjmp  Use setjmp/longjmp to implement GOSUB"
end sub

private sub printVersion()
	print "FreeBASIC Compiler - Version " + FB_VERSION + _
		" (" + FB_BUILD_DATE + ") for " + FB_HOST
	print "Copyright (C) 2004-2011 The FreeBASIC development team."

	dim as string config
	#ifdef ENABLE_STANDALONE
		config += "standalone, "
	#endif

	#ifdef ENABLE_PREFIX
		config += "prefix: '" + ENABLE_PREFIX + "', "
	#endif

	config += "objinfo: "
	#ifndef DISABLE_OBJINFO
		config += "enabled ("
		#ifdef ENABLE_FBBFD
			config += "FB header " & ENABLE_FBBFD
		#else
			config += "C wrapper"
		#endif
		config += "), "
	#else
		config += "disabled, "
	#endif

	'' Trim ', ' at the end
	config = left(config, len(config) - 2)

	print config
end sub

	fbcInit()

	if (__FB_ARGC__ = 1) then
		printOptions( )
		fbcEnd( 1 )
	end if

	parseArgs(__FB_ARGC__, __FB_ARGV__)

	if (fbc.showversion) then
		printVersion()
		fbcEnd( 0 )
	end if

	if( (listGetHead(@fbc.modules) = NULL) and _
	    (listGetHead(@fbc.objlist) = NULL) and _
	    (listGetHead(@fbc.libs.list) = NULL)) then
		printOptions()
		fbcEnd( 1 )
	end if

	if (fbc.verbose) then
		printVersion()
	end if

	fbcInit2()

	'' Compile into temporary files

	compileModules()

	if (compileXpm() = FALSE) then
		fbcEnd(1)
	end if

	if (fbc.emitonly) then
		fbcEnd( 0 )
	end if

	'' Generate objects

	if (assembleModules() = FALSE) then
		fbcEnd( 1 )
	end if

	if (assembleRcs() = FALSE) then
		fbcEnd(1)
	end if

	if (assembleXpm() = FALSE) then
		fbcEnd(1)
	end if

	if (fbc.compileonly) then
		fbcEnd( 0 )
	end if

	'' Set the default lib paths before scanning for other libs
	setDefaultLibPaths()

	'' Scan objects and libraries for more libraries and paths,
	'' before adding the default libs, which don't need to be searched,
	'' because they don't contain objinfo anyways.
	collectObjInfo()

	if (fbGetOption(FB_COMPOPT_OUTTYPE) = FB_OUTTYPE_STATICLIB) then
		if (archiveFiles() = FALSE) then
			fbcEnd( 1 )
		end if
		fbcEnd( 0 )
	end if

	'' Link

	'' Add default libs for linking, unless -nodeflibs was given
	'' Note: These aren't added into objinfo sections of objects or
	'' static libraries. Only the non-default libs are needed there.
	if (fbc.nodeflibs = FALSE) then
		addDefaultLibs()
	end if

	if( linkFiles( ) = FALSE ) then
		fbcEnd( 1 )
	end if

	fbcEnd( 0 )
