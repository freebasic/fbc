'' main module, front-end
''
'' chng: sep/2004 written [v1ctor]
''		 dec/2004 linux support added [lillo]
''		 jan/2005 dos support added [DrV]

#include once "fb.bi"
#include once "fbc.bi"
#include once "hlp.bi"

declare sub setDefaultOptions( )

declare function fbcMakeLibFileName(byref libname as string) as string

declare function fbcRunBin _
	( _
		byval action as zstring ptr, _
		byref tool as string, _
		byref ln as string _
	) as integer

declare function fbcFindBin(byval filename as zstring ptr) as string

declare function fbcGetLibPathList _
	( _
	) as zstring ptr

declare function fbcGetLibList _
	( _
		byval dllname as zstring ptr _
	) as zstring ptr

#define fbcAddDefLibPath( path ) _
	fbAddLibPathEx( @fbc.ld_libpathlist, _
					@fbc.ld_libpathhash, _
					path, _
					TRUE )

#macro safeKill(f)
	if( kill( f ) <> 0 ) then
	end if
#endmacro

dim shared as FBCCTX fbc

private sub fbcInit( )
	hashInit( )

	'' file and path lists
	listNew( @fbc.modules, FBC_INITFILES, sizeof(FBCMODULE) )
	listNew( @fbc.temps, FBC_INITARGS\4, len( string ) )
	listNew( @fbc.objlist, FBC_INITFILES, len( string ) )
	listNew( @fbc.deflist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.preinclist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.liblist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.libpathlist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.incpathlist, FBC_INITFILES\4, len( string ) )

	'' the final lib and search path lists passed to LD
	listNew( @fbc.ld_liblist, FBC_INITFILES\2, len( FBS_LIB ) )
	hashNew( @fbc.ld_libhash, FBC_INITFILES\2, FALSE )
	listNew( @fbc.ld_libpathlist, FBC_INITFILES\2, len( FBS_LIB ) )
	hashNew( @fbc.ld_libpathhash, FBC_INITFILES\2, FALSE )

	setDefaultOptions( )
end sub

private sub fbcEnd(byval errnum as integer)
	'' Clean up temporary files
	dim as string ptr file = listGetHead(@fbc.temps)
	while (file)
		safeKill(*file)
		file = listGetNext(file)
	wend

	'' file and path lists
	listFree( @fbc.modules )
	listFree( @fbc.temps )
	listFree( @fbc.objlist )
	listFree( @fbc.deflist )
	listFree( @fbc.preinclist )
	listFree( @fbc.liblist )
	listFree( @fbc.libpathlist )
	listFree( @fbc.incpathlist )

	'' the final lib and search path lists passed to LD
	listFree( @fbc.ld_liblist )
	hashFree( @fbc.ld_libhash )
	listFree( @fbc.ld_libpathlist )
	hashFree( @fbc.ld_libpathhash )

	hashEnd( )

	end errnum
end sub

private sub fbcAddTemp(byref file as string)
	dim as string ptr temp = listNewNode(@fbc.temps)
	*temp = file
end sub

private sub fbcAddObj(byref file as string)
	dim as string ptr obj = listNewNode(@fbc.objlist)
	*obj = file
end sub

private function hAddInfoObject as integer

    if( hFileExists( FB_INFOSEC_OBJNAME ) ) then
    	safeKill( FB_INFOSEC_OBJNAME )
    end if

#ifndef DISABLE_OBJINFO
    if( fbObjInfoWriteObj( @fbc.ld_liblist, @fbc.ld_libpathlist ) ) then
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
	fbc.outname = hStripFilename(fbc.outname) + _
	              fbcMakeLibFileName(hStripPath(fbc.outname))

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
	found = fbc.libpath + file

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

function fbcMakeLibFileName(byref libname as string) as string
	return "lib" + libname + ".a"
end function

sub fbcAddLibPathFor(byref libname as string)
	dim as string path = hStripFilename(fbcFindGccLib(fbcMakeLibFileName(libname)))
	if (len(path)) then
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
	path = fbc.binpath
	path += fbc.triplet
	path += *filename
	path += FB_HOST_EXEEXT

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
private function hCreateResFile( byval cline as zstring ptr ) as string
	dim as integer f
	dim as string resfile

	resfile = fbc.mainpath + "temp.res"

	f = freefile( )
	if( open( resfile, for output, as #f ) <> 0 ) then
		return ""
	end if

	print #f, *cline

	close #f

	function = resfile

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

	kill(deffile)

	return TRUE
end function

'':::::
private function linkFiles() as integer
	dim as string ldcline, dllname, deffile, resfile

	function = FALSE

	'' set executable name
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
		ldcline += " -T " + QUOTE + fbc.libpath + "i386go32.x" + QUOTE

#ifndef DISABLE_OBJINFO
	else
		'' Supplementary ld script to drop the fbctinf objinfo section
		ldcline += " " + QUOTE + fbc.libpath + "fbextra.x" + QUOTE
#endif

	end if

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
		'' stack size
		ldcline += " --stack " + str( fbc.stacksize ) + "," + str( fbc.stacksize )

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
			ldcline += " --output-def " + QUOTE + deffile + QUOTE
		end if

	case FB_COMPTARGET_LINUX
		'' set emulation
		ldcline += " -m elf_i386"

	case FB_COMPTARGET_XBOX
		'' set entry point
		ldcline += " -e _WinMainCRTStartup"

	end select

	if( len( fbc.mapfile ) > 0) then
		ldcline += " -Map " + fbc.mapfile
	end if

	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' add the library search paths
	ldcline += *fbcGetLibPathList( )

	'' crt begin objects
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE
		else
			'' TODO
			ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE
			'' additional support for gmon
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				ldcline += " " + QUOTE + fbcFindGccLib("gcrt0.o") + QUOTE
			end if
		end if

	case FB_COMPTARGET_WIN32
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			ldcline += " " + QUOTE + fbcFindGccLib("dllcrt2.o") + QUOTE
		else
			ldcline += " " + QUOTE + fbcFindGccLib("crt2.o") + QUOTE
			'' additional support for gmon
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				ldcline += " " + QUOTE + fbcFindGccLib("gcrt2.o") + QUOTE
			end if
		end if

		ldcline += " " + QUOTE + fbcFindGccLib("crtbegin.o") + QUOTE

	case FB_COMPTARGET_DOS
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += " " + QUOTE + fbcFindGccLib("gcrt0.o") + QUOTE
		else
			ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE
		end if

	case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD

		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
			if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD
					ldcline += " " + QUOTE + fbcFindGccLib("gcrt0.o") + QUOTE
				case else
					ldcline += " " + QUOTE + fbcFindGccLib("gcrt1.o") + QUOTE
				end select
			else
				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_OPENBSD, FB_COMPTARGET_NETBSD
					ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE
				case else
					ldcline += " " + QUOTE + fbcFindGccLib("crt1.o") + QUOTE
				end select
			end if
		end if

		'' All have crti.o, except OpenBSD
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += " " + QUOTE + fbcFindGccLib("crti.o") + QUOTE
		end if

		ldcline += " " + QUOTE + fbcFindGccLib("crtbegin.o") + QUOTE

	case FB_COMPTARGET_XBOX
		'' link with crt0.o (C runtime init)
		ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE

	end select

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		ldcline += " " + QUOTE + fbc.libpath + "fbrt0.o" + QUOTE + " "
	end if

	dim as string ptr objfile = listGetHead(@fbc.objlist)
	while (objfile)
		ldcline += " """ + *objfile + """"
		objfile = listGetNext(objfile)
	wend

	'' init lib group
	ldcline += " ""-("""

	'' add libraries from command-line and found when parsing
	ldcline += *fbcGetLibList( dllname )

	'' end lib group
	ldcline += " ""-)"""

	'' crt end
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_FREEBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD
		ldcline += " " + QUOTE + fbcFindGccLib("crtend.o") + QUOTE
		if (fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_OPENBSD) then
			ldcline += " " + QUOTE + fbcFindGccLib("crtn.o") + QUOTE
		end if

	case FB_COMPTARGET_WIN32
		ldcline += " " + QUOTE + fbcFindGccLib("crtend.o") + QUOTE

	end select

	'' extra options
	ldcline += " " + fbc.extopt.ld

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
	'' When using the DOS DJGPP tools, the command line length might be
	'' limited, and with our generally long ld command lines (especially
	'' when linking fbc) the line must be passed to ld through an @file.
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		dim as string resfile = hCreateResFile( ldcline )
		if( len( resfile ) = 0 ) then
			exit function
		end if
		if (fbc.verbose) then
			print "ld options in '" & resfile & "': ", ldcline
		end if
		ldcline = "@" + resfile
	end if
#endif

	'' invoke ld
	if (fbcRunBin("linking", fbcFindBin("ld"), ldcline) = FALSE) then
		exit function
	end if

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		kill( resfile )
	end if
#endif

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_DOS
		'' patch the exe to change the stack size
		dim as integer f = freefile()

		if (open(fbc.outname, for binary, access read write, as #f) <> 0) then
			exit function
		end if

		put #f, 533, fbc.stacksize

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

	'' let the symbol module do the hard work for us
	fbAddLibEx( @fbc.ld_liblist, @fbc.ld_libhash, libName, FALSE )

end sub

'':::::
private sub objinf_addPathCb _
	( _
		byval pathName as zstring ptr, _
		byval objName as zstring ptr _
	)

	fbAddLibPathEx( @fbc.ld_libpathlist, @fbc.ld_libpathhash, pathName, FALSE )

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
		dim as TLIST ptr libpathlist = @fbc.ld_libpathlist

		'' for each library found (must be done after processing all objects)
		dim as FBS_LIB ptr lib_ = listGetHead( @fbc.ld_liblist )
		do while( lib_ <> NULL )
	    	if( lib_->isdefault = FALSE ) then
	    		fbObjInfoReadLib( *lib_->name, _
	    					 	  @objinf_addLibCb, _
	    					 	  @objinf_addPathCb, _
	    					 	  @objinf_addOption, _
	    					 	  libpathlist )
			end if

			lib_ = listGetNext( lib_ )
		loop
	end scope

	function = TRUE
#else
	function = FALSE
#endif

end function

'':::::
private sub setDefaultOptions( )

	fbSetDefaultOptions( )

	fbc.emitonly    = FALSE
	fbc.compileonly = FALSE
	fbc.preserveasm	= FALSE
	fbc.preserveobj	= FALSE
	fbc.verbose     = FALSE
	fbc.stacksize	= FBC_DEFSTACKSIZE

	fbc.mainfile	= ""
	fbc.mainpath	= ""
    fbc.mapfile     = ""
	fbc.mainset     = FALSE
	fbc.outname     = ""

	fbc.extopt.gas	= ""
	fbc.extopt.ld	= ""

	fbc.objinf.lang = fbGetOption( FB_COMPOPT_LANG )
	fbc.objinf.mt   = FALSE

end sub

private sub fbcErrorInvalidOption(byref arg as string)
	errReportEx( FB_ERRMSG_INVALIDCMDOPTION, QUOTE + arg + QUOTE, -1 )
end sub

private sub addModule(byref srcfile as string, byval typ as integer)
	dim as FBCMODULE ptr m = listNewNode(@fbc.modules)
	m->type = typ
	m->srcfile = srcfile

	if (fbc.nextmodule = NULL) then
		fbc.nextmodule = m
	end if
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
		addModule(arg, FBCMODULE_BAS)

	case OPT_C
		fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
		fbc.compileonly = TRUE
		fbc.emitonly = FALSE
		fbc.preserveobj = TRUE

	case OPT_CKEEPOBJ
		fbc.preserveobj = TRUE

	case OPT_D
		dim as string ptr def = listNewNode( @fbc.deflist )
		*def = arg

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
		fbSetOptionIsExplicit( FB_COMPOPT_FORCELANG )
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
		dim as string ptr incp = listNewNode( @fbc.incpathlist )
		*incp = arg

	case OPT_INCLUDE
		dim as string ptr incf = listNewNode( @fbc.preinclist )
		*incf = arg

	case OPT_L
		dim as string ptr libf = listNewNode( @fbc.liblist )
		*libf = arg

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
		fbc.mainfile = hStripPath( arg )
		fbc.mainpath = hStripFilename( arg )
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
		fbSetOption( FB_COMPOPT_NODEFLIBS, TRUE )

	case OPT_NOERRLINE
		fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )

	case OPT_O
		if (fbc.nextmodule = NULL) then
			fbcErrorInvalidOption(arg)
			return
		end if

		fbc.nextmodule->objfile = arg
		fbc.nextmodule = listGetNext(fbc.nextmodule)

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
		dim as string ptr incp = listNewNode( @fbc.libpathlist )
		*incp = arg

	case OPT_PP
		fbSetOption( FB_COMPOPT_PPONLY, TRUE )
		fbc.compileonly = TRUE
		fbc.emitonly = TRUE
		fbc.preserveasm = FALSE

	case OPT_PREFIX
		fbc.prefix = arg

		'' Trim trailing slash
		if( right( fbc.prefix, 1 )  = "/" ) then
			fbc.prefix = left( fbc.prefix, len( fbc.prefix ) - 1 )
		end if

		#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
			'' On Windows/DOS, also trim trailing backslash
			'' (additionally to the forward slash check)
			if( right( fbc.prefix, 1 ) = RSLASH ) then
				fbc.prefix = left( fbc.prefix, len( fbc.prefix ) - 1 )
			end if
		#endif

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

	case OPT_T
		fbc.stacksize = valint(arg) * 1024
		if( fbc.stacksize < FBC_MINSTACKSIZE ) then
			fbc.stacksize = FBC_MINSTACKSIZE
		end if

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
			addModule(arg, FBCMODULE_BAS)

		case "o"
			fbcAddObj(arg)

		case "a"
			dim as string ptr libf = listNewNode( @fbc.liblist )
			*libf = arg

		case "rc", "res"
			addModule(arg, FBCMODULE_RC)

		case "xpm"
			static as integer count = 0

			'' Can have only one .xpm, or the fb_program_icon
			'' symbol will be duplicated
			if (count >= 1) then
				fbcErrorInvalidOption(arg)
				fbcEnd(1)
			end if

			count += 1
			addModule(arg, FBCMODULE_XPM)

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
	fbc.nextmodule = NULL

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

	'' TODO: Check whether subsystem/stacksize/xboxtitle were set and
	'' complain about it when the target doesn't allow it, or just
	'' ignore silently (that might not even be too bad for portability)?
end sub

'' After command line parsing
private sub fbcInit2()
	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
		env.target.size_t_type = FB_DATATYPE_UINT
		env.target.wchar.type = FB_DATATYPE_USHORT
		env.target.wchar.size = 2
		env.target.underprefix = TRUE

	case FB_COMPTARGET_DOS
		env.target.size_t_type = FB_DATATYPE_ULONG
		env.target.wchar.type = FB_DATATYPE_UBYTE
		env.target.wchar.size = 1
		env.target.underprefix = TRUE

	case FB_COMPTARGET_XBOX
		env.target.size_t_type = FB_DATATYPE_ULONG
		env.target.wchar.type = FB_DATATYPE_UINT
		env.target.wchar.size = FB_INTEGERSIZE
		env.target.underprefix = TRUE

	case else
		env.target.size_t_type = FB_DATATYPE_UINT
		env.target.wchar.type = FB_DATATYPE_UINT
		env.target.wchar.size = FB_INTEGERSIZE
		env.target.underprefix = FALSE

	end select

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
		env.target.fbcall = FB_FUNCMODE_STDCALL
		env.target.stdcall = FB_FUNCMODE_STDCALL

	case else
		env.target.fbcall = FB_FUNCMODE_CDECL
		env.target.stdcall = FB_FUNCMODE_STDCALL_MS

	end select

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

	fbc.binpath = fbc.prefix + "bin" + FB_HOST_PATHDIV
	fbc.incpath = fbc.prefix
	fbc.libpath = fbc.prefix

	#ifdef ENABLE_STANDALONE
		'' [triplet-]lib[-suffix]/
		fbc.incpath += fbc.triplet + "include"
		fbc.libpath += fbc.triplet + "lib"
	#else
		'' lib/[triplet-]freebasic[-suffix]/
		fbc.incpath += "include" + FB_HOST_PATHDIV + fbc.triplet
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

	fbc.incpath += FB_SUFFIX + FB_HOST_PATHDIV
	fbc.libpath += FB_SUFFIX + FB_HOST_PATHDIV

	hRevertSlash( fbc.binpath, FALSE, asc(FB_HOST_PATHDIV) )
	hRevertSlash( fbc.incpath, FALSE, asc(FB_HOST_PATHDIV) )
	hRevertSlash( fbc.libpath, FALSE, asc(FB_HOST_PATHDIV) )

	''
	'' Determine the main module
	''
	if( len( fbc.mainfile ) = 0 ) then
		dim as FBCMODULE ptr m = listGetHead( @fbc.modules )
		if( m ) then
			fbc.mainfile = hStripPath( hStripExt( m->srcfile ) )
			fbc.mainpath = hStripFilename( m->srcfile )
		else
			dim as string ptr objf = listGetHead( @fbc.objlist )
			if( objf <> NULL ) then
				fbc.mainfile = hStripPath( hStripExt( *objf ) )
				fbc.mainpath = hStripFilename( *objf )
			else
				fbc.mainfile = "undefined"
				fbc.mainpath = ""
			end if
		end if
	end if

	'' if no executable name was defined, use the main module name
	if( len( fbc.outname ) = 0 ) then
		fbc.outname = fbc.mainpath + fbc.mainfile

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
				fbc.outname = hStripFilename( fbc.outname ) + "lib" + hStripPath( fbc.outname ) + ".so"

			end select

		end select
	end if
end sub

'':::::
private function processCompLists _
	( _
	) as integer

    dim as integer p
    dim as string dname, dtext

	function = FALSE

    '' add inc files
	dim as string ptr incp = listGetHead( @fbc.incpathlist )
	do while( incp <> NULL )
    	fbAddIncPath( *incp )
    	incp = listGetNext( incp )
    loop

    '' add defines
	dim as string ptr def = listGetHead( @fbc.deflist )
	do while( def <> NULL )

    	p = instr( *def, "=" )
    	if( p = 0 ) then
    		p = len( *def ) + 1
    	end if

    	dname = left( *def, p-1 )

		if( p < len( *def ) ) then
			dtext = mid( *def, p+1 )
		else
			dtext = "1"
    	end if

    	fbAddDefine( dname, dtext )

    	def = listGetNext( def )
    loop

    function = FALSE

end function

'':::::
private sub getLibList _
	( _
	)

	'' update libs
	fbListLibs( @fbc.ld_liblist, _
				@fbc.ld_libhash, _
				TRUE )

	'' update paths
	fbListLibPaths( @fbc.ld_libpathlist, _
					@fbc.ld_libpathhash, _
					TRUE )

end sub

'':::::
private sub setLibList _
	( _
	)

	dim as string ptr n = any

	'' add libs
	n = listGetHead( @fbc.liblist )
	do while( n <> NULL )
		fbAddLib( *n )
		n = listGetNext( n )
	loop

	'' add lib paths
	n = listGetHead( @fbc.libpathlist )
	do while( n <> NULL )
		fbAddLibPath( *n )
		n = listGetNext( n )
	loop

end sub

'':::::
private sub setLibListFromCmd _
	( _
	)

	dim as string ptr n = any

	'' add libs
	n = listGetHead( @fbc.liblist )
	do while( n <> NULL )
		fbAddLibEx( @fbc.ld_liblist, _
					@fbc.ld_libhash, _
					*n, _
					FALSE )
		n = listGetNext( n )
	loop

	'' add lib paths
	n = listGetHead( @fbc.libpathlist )
	do while( n <> NULL )
		fbAddLibPathEx( @fbc.ld_libpathlist, _
						@fbc.ld_libpathhash, _
						*n, _
						FALSE )
		n = listGetNext( n )
	loop

end sub

private function compileBas _
	( _
		byval module as FBCMODULE ptr, _
		byval ismain as integer _
	) as integer

	function = FALSE

	if (fbGetOption(FB_COMPOPT_BACKEND) = FB_BACKEND_GCC) then
		module->asmfile &= ".c"
	else
		module->asmfile &= ".asm"
	end if

	if (fbc.preserveasm = FALSE) then
		fbcAddTemp(module->asmfile)
	end if

	if (fbc.verbose) then
		print "compiling: ", module->srcfile; " -o "; module->asmfile
	end if

	'' preserve orginal lang id, we may have to restore it.
	dim as FB_LANG prevlangid = fbGetOption(FB_COMPOPT_LANG)

	dim as integer restarts = 0

	do
		'' init the parser
		if (fbInit(ismain, restarts) = FALSE) then
			exit function
		end if

		'' add include paths and defines
		processCompLists()

		'' add the libs and paths passed in the cmd-line
		setLibList()

		if (fbCompile(module->srcfile, module->asmfile, ismain, @fbc.preinclist) = FALSE) then
			'' Restore original lang
			fbSetOption(FB_COMPOPT_LANG, prevlangid)
			exit function
		end if

		if (fbCheckRestartCompile() = FALSE) then
			exit do
		end if

		'' Errors? Don't bother restarting ...
		if (errGetCount() > 0) then
			exit function
		end if

		'' Restart
		restarts += 1
		fbEnd()
	loop

	'' update the list of libs and paths, with the ones found when parsing
	getLibList( )

	'' shutdown the parser
	fbEnd( )

	'' Restore original lang
	fbSetOption( FB_COMPOPT_LANG, prevlangid )

	function = TRUE
end function

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

private function compileXpm(byval module as FBCMODULE ptr) as integer
	'' Turn the .xpm icon resource into a .bas file, then compile that
	'' using the normal fb compilation process.

	'' The embedded .xpm is only useful for the X11 gfxlib
	select case as const (fbGetOption(FB_COMPOPT_TARGET))
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
	     FB_COMPTARGET_OPENBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_NETBSD

	case else
		errReportEx(FB_ERRMSG_RCFILEWRONGTARGET, module->srcfile, -1)
		return FALSE
	end select

	dim as string xpmfile = module->srcfile

	'' Change this xpm module into a bas module, then compile and assemble
	'' it (almost) like any other bas module. The temporary .bas file name
	'' is based on the -o <name> given for the .xpm. compileBas() will
	'' complete the module->asmfile name, and use the given module->objile
	'' too.
	module->type = FBCMODULE_BAS
	module->srcfile = module->asmfile & ".bas"

	if( fbc.verbose ) then
		print "compiling resource: ", xpmfile & " -o " & module->srcfile
	end if

	dim as string code
	parseXpm(xpmfile, code)

	dim as integer fo = freefile()
	if (open(module->srcfile, for output, as #fo)) then
		return FALSE
	end if
	print #fo, code;
	close #fo

	'' Clean up the temp .bas too
	if (fbc.preserveasm = FALSE) then
		fbcAddTemp(module->srcfile)
	end if

	function = compileBas(module, FALSE)
end function

private function compileModules() as integer
	dim as integer saw_bas = FALSE
	dim as integer ismain = FALSE
	dim as integer checkmain = any

	function = FALSE

	select case fbGetOption( FB_COMPOPT_OUTTYPE )
	case FB_OUTTYPE_EXECUTABLE, FB_OUTTYPE_DYNAMICLIB
		checkmain = TRUE
	case else
		checkmain = fbc.mainset
	end select

	dim as FBCMODULE ptr module = listGetHead(@fbc.modules)
	while (module)
		'' The base file name for temporary file(s) created for this
		'' module (bas: .asm/.c, .xpm: .bas) is based on the -o <file>
		'' for this module, if given, and defaults to the same base
		'' name as the input file. Later during assembling, the *.o
		'' names are based on this too.
		if (len(module->objfile) > 0) then
			module->asmfile = module->objfile
		else
			module->asmfile = module->srcfile
		end if

		module->asmfile = hStripExt(module->asmfile)

		select case (module->type)
		case FBCMODULE_BAS
			saw_bas = TRUE
			if( checkmain ) then
				ismain = (fbc.mainfile = hStripPath(hStripExt(module->srcfile)))
			end if

			if (compileBas(module, ismain) = FALSE) then
				exit function
			end if

		case FBCMODULE_XPM
			if (compileXpm(module) = FALSE) then
				exit function
			end if

		case FBCMODULE_RC
			'' Note: rc never uses the asmfile itself, except to
			'' determine the .o name, so extension doesn't matter
			'' but it should still have one, otherwise further
			'' hStripExt()'s might strip off the wrong thing of
			'' the file name...
			module->asmfile &= ".asm"

		end select

		module = listGetNext(module)
	wend

	'' Make sure to add libs if no input .bas were given
	if (saw_bas = FALSE) then
		setLibListFromCmd()
	end if

	return TRUE
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

private function assembleBas(byval module as FBCMODULE ptr) as integer
	static as string assembler

	function = FALSE

	'' *.o name based on *.asm name unless given via -o <file>
	if (len(module->objfile) = 0) then
		module->objfile = hStripExt(module->asmfile) & ".o"
	end if

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

	ln += """" + module->asmfile + """ "
	ln += "-o """ + module->objfile + """"

	if (fbGetOption(FB_COMPOPT_BACKEND) = FB_BACKEND_GCC) then
		ln += fbc.extopt.gcc
	else
		ln += fbc.extopt.gas
	end if

	return fbcRunBin("assembling", assembler, ln)
end function

private function assembleRc(byval module as FBCMODULE ptr) as integer
	'' Resource scripts are only allowed for win32 & co
	select case as const (fbGetOption(FB_COMPOPT_TARGET))
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX

	case else
		errReportEx(FB_ERRMSG_RCFILEWRONGTARGET, module->srcfile, -1)
		return FALSE
	end select

#if defined(ENABLE_STANDALONE) and defined(__FB_WIN32__)
	'' Using GoRC for the classical native win32 standalone build
	'' Note: GoRC /fo doesn't accept anything except *.obj, not even *.o,
	'' so we need to make it *.obj and then rename it afterwards.

	'' *.obj name based on *.asm name unless given via -o <file>
	dim as integer need_rename = FALSE
	if (len(module->objfile) = 0) then
		module->objfile = hStripExt(module->asmfile) & ".obj"
	else
		if (hGetFileExt(module->objfile) <> "obj") then
			need_rename = TRUE
			module->objfile &= ".obj"
		end if
	end if

	'' Change the include env var to point to the (hopefully present)
	'' win/rc/*.h headers.
	dim as string oldinclude = trim(environ("INCLUDE"))
	setenviron "INCLUDE=" + fbc.incpath + ("win" + RSLASH + "rc")

	dim as string ln = "/ni /nw /o "
	ln &= "/fo """ & module->objfile & """"
	ln &= " """ & module->srcfile & """"

	if (fbcRunBin("compiling resource", fbcFindBin("GoRC"), ln) = FALSE) then
		return FALSE
	end if

	'' restore the include env var
	if (len(oldinclude) > 0) then
		setenviron "INCLUDE=" + oldinclude
	end if

	if (need_rename) then
		dim as string badname = module->objfile
		module->objfile = hStripExt(module->objfile)
		'' Rename back so it will be found by ld/the user
		function = (name(badname, module->objfile) = 0)
	else
		function = TRUE
	end if
#else
	'' Using binutils' windres for all other setups (e.g. cross-compiling
	'' linux -> win32)
	'' Note: windres uses gcc -E to preprocess the .rc by default,
	'' and that's not 100% compatible to GoRC (e.g. backslashes in
	'' paths/filenames are seen as escape sequences by gcc, but not GoRC)
	if (len(module->objfile) = 0) then
		module->objfile = hStripExt(module->asmfile) & ".obj"
	end if

	dim as string ln = "--output-format=coff "
	ln &= " """ & module->srcfile & """"
	ln &= " """ & module->objfile & """"

	function = fbcRunBin("compiling resource", fbcFindBin("windres"), ln)
#endif
end function

private function assembleModules() as integer
	function = FALSE

	'' Note: If there was an .xpm module, it was changed to .bas by now
	dim as FBCMODULE ptr module = listGetHead(@fbc.modules)
	while (module)
		if (module->type = FBCMODULE_RC) then
			if (assembleRc(module) = FALSE) then
				exit function
			end if
		else
			if (assembleBas(module) = FALSE) then
				exit function
			end if
		end if

		fbcAddObj(module->objfile)
		if (fbc.preserveobj = FALSE) then
			fbcAddTemp(module->objfile)
		end if

		module = listGetNext(module)
	wend

	function = TRUE
end function

private sub setDefaultLibPaths()

	'' compiler's lib/
	fbcAddDefLibPath( fbc.libpath )

	'' and the current path
	fbcAddDefLibPath( "./" )

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

'':::::
private sub addDefaultLibs()
	'' note: list of FBS_LIB
	dim as TLIST ptr dstlist = @fbc.ld_liblist
	dim as THASH ptr dsthash = @fbc.ld_libhash

	#macro hAddLib( libname )
		symbAddLibEx( dstlist, dsthash, libname, TRUE )
	#endmacro

	'' select the right FB rtlib
	if( env.clopt.multithreaded ) then
		hAddLib( "fbmt" )
	else
		hAddLib( "fb" )
	end if

	hAddLib( "gcc" )

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_CYGWIN
		hAddLib( "cygwin" )
		hAddLib( "kernel32" )
		hAddLib( "supc++" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			hAddLib( "gmon" )
		end if

	case FB_COMPTARGET_DARWIN
		hAddLib( "System" )

	case FB_COMPTARGET_DOS
		hAddLib( "c" )
		hAddLib( "m" )
		#ifdef ENABLE_STANDALONE
			'' Renamed lib for the standalone build, working around
			'' the long file name.
			hAddLib( "supcx" )
		#else
			'' When installing into DJGPP, use its lib
			hAddLib( "supcxx" )
		#endif

	case FB_COMPTARGET_FREEBSD
		hAddLib( "c" )
		hAddLib( "m" )
		hAddLib( "pthread" )
		hAddLib( "ncurses" )
		hAddLib( "supc++" )

	case FB_COMPTARGET_LINUX
		hAddLib( "c" )
		hAddLib( "m" )
		hAddLib( "pthread" )
		hAddLib( "dl" )
		hAddLib( "ncurses" )
		hAddLib( "supc++" )
		hAddLib( "gcc_eh" )

	case FB_COMPTARGET_NETBSD
		'' TODO

	case FB_COMPTARGET_OPENBSD
		hAddLib( "c" )
		hAddLib( "m" )
		hAddLib( "pthread" )
		hAddLib( "ncurses" )
		hAddLib( "supc++" )

	case FB_COMPTARGET_WIN32
		hAddLib( "msvcrt" )
		hAddLib( "kernel32" )
		hAddLib( "mingw32" )
		hAddLib( "mingwex" )
		hAddLib( "moldname" )
		hAddLib( "supc++" )
		hAddLib( "gcc_eh" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			hAddLib( "gmon" )
		end if

	case FB_COMPTARGET_XBOX
		hAddLib( "fbgfx" )
		hAddLib( "openxdk" )
		hAddLib( "hal" )
		hAddLib( "c" )
		hAddLib( "usb" )
		hAddLib( "xboxkrnl" )
		hAddLib( "m" )
		hAddLib( "supc++" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			hAddLib( "gmon" )
		end if

	end select

end sub

'':::::
private sub printOptions( )
	const FBC_HELP = _
	!"usage: fbc [options] <input files>\n"                                + _
	!"input files:\n"                                                      + _
	!"  *.a = static library, *.o = object file, *.bas = source\n"         + _
	!"  *.rc = resource script, *res = compiled resource (win32)\n"        + _
	!"  *.xpm = icon resource (*nix/*bsd)\n"                               + _
	!"options:\n"                                                          + _
	!"  @<file>          Read more command line arguments from a file\n"   + _
	!"  -a <file>        Treat file as *.o/*.a input file\n"               + _
	!"  -arch <type>     Set target architecture (default: 486)\n"         + _
	!"  -b <file>        Treat file as *.bas input file\n"                 + _
	!"  -c               Compile only, do not link\n"                      + _
	!"  -C               Preserve generated *.o files\n"                   + _
	!"  -d <name>[=<val>]  Add a global #define\n"                         + _
	!"  -dll             Same as -dylib\n"                                 + _
	!"  -dylib           Create a DLL (win32) or shared library (*nix/*BSD)\n" + _
	!"  -e               Enable runtime error checking\n"                  + _
	!"  -ex              -e plus RESUME support\n"                         + _
	!"  -exx             -ex plus array bounds/null-pointer checking\n"    + _
	!"  -export          Export symbols for dynamic linkage\n"             + _
	!"  -forcelang <name>  Override #lang statements in source code\n"     + _
	!"  -fpmode fast|precise  Select floating-point math accuracy/speed\n" + _
	!"  -fpu x87|sse     Set target FPU\n"                                 + _
	!"  -g               Add debug info\n"                                 + _
	!"  -gen gas|gcc     Select code generation backend\n"                 + _
	!"  -i <path>        Add an include file search path\n"                + _
	!"  -include <file>  Pre-#include a file for each input *.bas\n"       + _
	!"  -l <name>        Link in a library\n"                              + _
	!"  -lang <name>     Select FB dialect: deprecated, fblite, qb\n"      + _
	!"  -lib             Create a static library\n"                        + _
	!"  -m <name>        Set main module (default: first input *.bas)\n"   + _
	!"  -map <file>      Save linking map to file\n"                       + _
	!"  -maxerr <n>      Only show <n> errors\n"                           + _
	!"  -mt              Use thread-safe FB runtime\n"                     + _
	!"  -nodeflibs       Do not include the default libraries\n"           + _
	!"  -noerrline       Do not show source context in error messages\n"   + _
	!"  -o <file>        Set *.o file name for corresponding input *.bas\n" + _
	!"  -O <value>       Optimization level (default: 0)\n"                + _
	!"  -p <name>        Add a library search path\n"                      + _
	!"  -pp              Write out preprocessed input file (*.pp.bas) only\n" + _
	!"  -prefix <path>   Set the compiler prefix path\n"                   + _
	!"  -profile         Enable function profiling\n"                      + _
	!"  -r               Write out *.asm/*.c only, do not compile\n"       + _
	!"  -R               Preserve generated *.asm/*.c files\n"             + _
	!"  -s console|gui   Select win32 subsystem\n"                         + _
	!"  -t <value>       Set *.exe stack size in kbytes, default: 1024 (win32/dos)\n" + _
	!"  -target <name>   Set cross-compilation target\n"                  + _
	!"  -title <name>    Set XBE display title (xbox)\n"                   + _
	!"  -v               Be verbose\n"                                     + _
	!"  -vec <n>         Automatic vectorization level (default: 0)\n"     + _
	!"  -version         Show compiler version\n"                          + _
	!"  -w all|pedantic|<n>  Set min warning level: all, pedantic or a value\n" + _
	!"  -Wa <a,b,c>      Pass options to GAS\n"                            + _
	!"  -Wc <a,b,c>      Pass options to GCC (with -gen gcc)\n"            + _
	!"  -Wl <a,b,c>      Pass options to LD\n"                             + _
	!"  -x <file>        Set output executable/library file name\n"        + _
	 "  -z gosub-setjmp  Use setjmp/longjmp to implement GOSUB"

	print FBC_HELP
end sub

private sub printVersion()
	dim as string s

	s += !"FreeBASIC Compiler - Version " + FB_VERSION + _
		" (" + FB_BUILD_DATE + ")" + _
		" for " + FB_HOST + " (target:" + FB_TARGET + !")\n"
	s += !"Copyright (C) 2004-2011 The FreeBASIC development team.\n"

	#ifdef ENABLE_STANDALONE
		s += "standalone, "
	#endif

	#ifdef ENABLE_PREFIX
		s += "prefix: '" + ENABLE_PREFIX + "', "
	#endif

	s += "objinfo: "
	#ifndef DISABLE_OBJINFO
		s += "enabled ("
		#ifdef ENABLE_FBBFD
			s += "FB header " & ENABLE_FBBFD
		#else
			s += "C wrapper"
		#endif
		s += "), "
	#else
		s += "disabled, "
	#endif

	'' Trim ', ' at the end
	s = left(s, len(s) - 2)

	print s
end sub

'':::::
function fbcGetLibList _
	( _
		byval dllname as zstring ptr _
	) as zstring ptr

	static as string list

    list = ""

	dim as FBS_LIB ptr libf = listGetHead( @fbc.ld_liblist )

    '' add libraries from cmm-line and found when parsing
    if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		do while( libf <> NULL )
   			'' check if the lib isn't the dll's import library itself
   	        if( *libf->name <> *dllname ) then
				list += " -l" + *libf->name
			end if

			libf = listGetNext( libf )
		loop
    else
		do while( libf <> NULL )
			list += " -l" + *libf->name
			libf = listGetNext( libf )
		loop
	end if

    function = strptr( list )

end function

'':::::
function fbcGetLibPathList _
	( _
	) as zstring ptr

	static as string list

    list = ""

	dim as FBS_LIB ptr libp = listGetHead( @fbc.ld_libpathlist )
	do while( libp <> NULL )
		if( right( *libp->name, 1 ) = FB_HOST_PATHDIV ) then
    		list += " -L " + QUOTE + left( *libp->name, len(*libp->name) - 1 ) + QUOTE
		else
    		list += " -L " + QUOTE + *libp->name + QUOTE
		end if
    	libp = listGetNext( libp )
    loop

    function = strptr( list )

end function


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
	    (listGetHead(@fbc.liblist) = NULL)) then
		printOptions()
		fbcEnd( 1 )
	end if

	if (fbc.verbose) then
		printVersion()
	end if

	fbcInit2()

	'' Compile
	if (compileModules() = FALSE) then
		fbcEnd( 1 )
	end if

	if (fbc.emitonly) then
		fbcEnd( 0 )
	end if

	'' Assemble
	if (assembleModules() = FALSE) then
		fbcEnd( 1 )
	end if

	if (fbc.compileonly) then
		fbcEnd( 0 )
	end if

	'' set the default lib paths before scanning for other libs
	setDefaultLibPaths()

	'' scan objects and libraries for more libraries and paths
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
	if (env.clopt.nodeflibs = FALSE) then
		addDefaultLibs()
	end if

	if( linkFiles( ) = FALSE ) then
		fbcEnd( 1 )
	end if

	fbcEnd( 0 )
