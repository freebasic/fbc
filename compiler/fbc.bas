'' main module, front-end
''
'' chng: sep/2004 written [v1ctor]
''		 dec/2004 linux support added [lillo]
''		 jan/2005 dos support added [DrV]

#include once "fb.bi"
#include once "fbc.bi"
#include once "hlp.bi"

declare sub fbcInit _
	( _
	)

declare sub fbcEnd _
	(  _
		byval errnum as integer _
	)

declare sub parseCmd _
	( _
	)

declare sub setDefaultOptions _
	( _
	)

declare function processOptions _
	( _
	) as integer

declare function processCompLists _
	( _
	) as integer

declare function processTargetOptions _
	( _
	) as integer

declare sub printOptions _
	( _
	)

declare sub getLibList _
	( _
	)

declare sub setLibListFromCmd _
	( _
	)

declare sub setLibList _
	( _
	)

declare sub initTarget _
	( _
	)

declare function compileFiles _
	( _
	) as integer

declare function assembleFiles _
	( _
	) as integer

declare function linkFiles _
	( _
	) as integer

declare function archiveFiles _
	( _
	) as integer

declare function compileXpm() as integer

declare function compileRcs _
	( _
	) as integer

declare sub delFiles()

declare sub setMainModule _
	( _
	)

declare sub setPaths()

declare function collectObjInfo _
	( _
	) as integer

declare sub setDefaultLibPaths()
declare sub addDefaultLibs()


''globals
	dim shared as FBCCTX fbc

	'on error goto runtime_err

	''
    fbcInit( )

    ''
    parseCmd( )

    if( listGetHead( @fbc.arglist ) = NULL ) then
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
    if( fbc.showversion = FALSE ) then
    	if( (listGetHead( @fbc.inoutlist ) = NULL) and _
    		(listGetHead( @fbc.objlist ) = NULL) and _
    		(listGetHead( @fbc.liblist ) = NULL) ) then
    		printOptions( )
    		fbcEnd( 1 )
    	end if
    end if

    ''
    if( fbc.verbose or fbc.showversion ) then
    	print "FreeBASIC Compiler - Version " + FB_VERSION + " (" + FB_BUILD_DATE + ")" + _
    		  " for " + FB_HOST + " (target:" + FB_TARGET + ")"
    	print "Copyright (C) 2004-2011 The FreeBASIC development team."

#ifdef ENABLE_PREFIX
		print "Configured with prefix " + ENABLE_PREFIX
#endif

#ifdef ENABLE_STANDALONE
		print "Configured as standalone"
#endif

#ifndef DISABLE_OBJINFO
		print "objinfo enabled ";
#ifdef ENABLE_FBBFD
		print "using FB BFD header version " & ENABLE_FBBFD
#else
		print "using C BFD wrapper"
#endif
#else
		print "objinfo disabled"
#endif

    	print
    	if( fbc.showversion ) then
    		fbcEnd( 0 )
    	end if
    end if

	setPaths()

    ''
    setMainModule( )

    '' compile
    if( compileFiles( ) = FALSE ) then
    	delFiles( )
    	fbcEnd( 1 )
    end if

	if( fbc.emitonly ) then

	else

		'' assemble
		if( assembleFiles( ) = FALSE ) then
			delFiles( )
			fbcEnd( 1 )
		end if

		if( fbc.compileonly ) then

		else
			'' set the default lib paths before scanning for other libs
			setDefaultLibPaths( )

			'' scan objects and libraries for more libraries and paths
			collectObjInfo( )

			'' link
			if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_STATICLIB ) then
				if( archiveFiles( ) = FALSE ) then
					delFiles( )
					fbcEnd( 1 )
				end if

			else
				'' Add default libs for linking, unless -nodeflibs was given
				'' Note: These aren't added into objinfo sections of objects or
				'' static libraries. Only the non-default libs are needed there.
				if (env.clopt.nodeflibs = FALSE) then
					addDefaultLibs()
				end if

				select case as const fbGetOption( FB_COMPOPT_TARGET )
				case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX
					'' Compile *.rc's, if any
					if( compileRcs( ) = FALSE ) then
						delFiles( )
						fbcEnd( 1 )
					end if

				case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
				     FB_COMPTARGET_OPENBSD, FB_COMPTARGET_DARWIN, _
				     FB_COMPTARGET_NETBSD
					'' Compile the given .xpm, if any
					if( compileXpm( ) = FALSE ) then
						delFiles( )
						fbcEnd( 1 )
					end if

				end select

				if( linkFiles( ) = FALSE ) then
					delFiles( )
					fbcEnd( 1 )
				end if
			end if
		end if
	end if

	'' del temps
	delFiles( )

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

	'' arg list
	listNew( @fbc.arglist, FBC_INITARGS, len( string ) )

	'' file and path lists
	listNew( @fbc.inoutlist, FBC_INITFILES, len( FBC_IOFILE ) )
	listNew( @fbc.objlist, FBC_INITFILES, len( string ) )
	listNew( @fbc.deflist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.preinclist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.liblist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.libpathlist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.incpathlist, FBC_INITFILES\4, len( string ) )
	listNew( @fbc.rclist, FBC_INITARGS\4, len( string ) )

	'' the final lib and search path lists passed to LD
	listNew( @fbc.ld_liblist, FBC_INITFILES\2, len( FBS_LIB ) )
	hashNew( @fbc.ld_libhash, FBC_INITFILES\2, FALSE )
	listNew( @fbc.ld_libpathlist, FBC_INITFILES\2, len( FBS_LIB ) )
	hashNew( @fbc.ld_libpathhash, FBC_INITFILES\2, FALSE )

	fbc.iof_head = NULL

	''
	setDefaultOptions( )

end sub

''':::::
private sub fbcEnd _
	(  _
		byval errnum as integer _
	)

	listFree( @fbc.arglist )

	'' file and path lists
	listFree( @fbc.inoutlist )
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

	''
	end errnum

end sub

'':::::
private sub initTarget( )

	select case as const fbGetOption( FB_COMPOPT_TARGET )
#ifdef ENABLE_WIN32
	case FB_COMPTARGET_WIN32
		fbcInit_win32( )
#endif

#ifdef ENABLE_CYGWIN
	case FB_COMPTARGET_CYGWIN
		fbcInit_cygwin( )
#endif

#ifdef ENABLE_LINUX
	case FB_COMPTARGET_LINUX
		fbcInit_linux( )
#endif

#ifdef ENABLE_DOS
	case FB_COMPTARGET_DOS
		fbcInit_dos( )
#endif

#ifdef ENABLE_XBOX
	case FB_COMPTARGET_XBOX
		fbcInit_xbox( )
#endif

#ifdef ENABLE_FREEBSD
	case FB_COMPTARGET_FREEBSD
		fbcInit_freebsd( )
#endif

#ifdef ENABLE_OPENBSD
	case FB_COMPTARGET_OPENBSD
		fbcInit_openbsd( )
#endif

#ifdef ENABLE_DARWIN
	case FB_COMPTARGET_DARWIN
		fbcInit_darwin( )
#endif

#ifdef ENABLE_NETBSD
	case FB_COMPTARGET_NETBSD
		fbcInit_netbsd( )
#endif

	case else
		print "unsupported target in " & __FILE__

	end select

	fbc.triplet = *env.target.triplet
	if( len(fbc.triplet) > 0 ) then
		fbc.triplet += "-"
	end if

end sub

'':::::
private function hGetOutFileExt as string

	select case fbGetOption( FB_COMPOPT_BACKEND )
	case FB_BACKEND_GAS
		return ".asm"

	case FB_BACKEND_GCC
		return ".c"

	end select

end function

'':::::
private function compileFiles _
	( _
	) as integer

	dim as integer i, checkmain, ismain, res, restarts
	dim as FBC_IOFILE ptr iof = any
	dim as FB_LANG prevlangid = any
	function = FALSE

	''
	select case fbGetOption( FB_COMPOPT_OUTTYPE )
	case FB_OUTTYPE_EXECUTABLE, FB_OUTTYPE_DYNAMICLIB
		checkmain = TRUE
	case else
		checkmain = fbc.mainset
	end select

	ismain = FALSE

	'' for each input file..
	iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )

		if( checkmain ) then
			ismain = fbc.mainfile = hStripPath( hStripExt( iof->inf ) )
		end if

		'' preserve orginal lang id, we may have to restore it.
		prevlangid = fbGetOption( FB_COMPOPT_LANG )

		restarts = 0

		do

			'' init the parser
			if( fbInit( ismain, restarts ) = FALSE ) then
				exit function
			end if

			'' add include paths and defines
			processCompLists( )

			'' if no output file given, assume it's the
			'' same name as input, with the .o extension
			if( len( iof->outf ) = 0 ) then
				iof->outf = hStripExt( iof->inf ) + ".o"
			end if

			'' create output asm name
			iof->asmf = hStripExt( iof->outf ) + hGetOutFileExt( )

			'' add the libs and paths passed in the cmd-line
			setLibList( )

			if( fbc.verbose ) then
				print "compiling: ", iof->inf; " -o "; iof->asmf
			end if

			if( fbCompile( iof->inf, _
						   iof->asmf, _
						   ismain, _
						   @fbc.preinclist ) = FALSE ) then

				'' Restore original lang
				fbSetOption( FB_COMPOPT_LANG, prevlangid )

				exit function
			end if

			if( fbCheckRestartCompile( ) ) then

				'' Errors? Don't bother restarting ...
				if( errGetCount( ) <> 0 ) then
					exit function
				else
					restarts += 1

					'' shutdown the parser (it will be restarted)
					fbEnd( )
				end if

			else

				'' update the list of libs and paths, with the ones found when parsing
				getLibList( )

				'' shutdown the parser
				fbEnd( )

				'' Restore original lang
				fbSetOption( FB_COMPOPT_LANG, prevlangid )

				exit do

			end if

		loop

		iof = listGetNext( iof )
	loop

	'' no default libs would be added if no inp files were given
	if( listGetHead( @fbc.inoutlist ) = NULL ) then
		setLibListFromCmd( )
	end if

	function = TRUE

end function

'':::::
private function assembleFile _
	( _
		byval assembler as zstring ptr, _
		byref cmdline as string _
	) as integer

	static as string path

	if (len(path) = 0) then
		path = fbcFindBin(*assembler)
	end if

	return fbcRunBin("assembling", path, cmdline)
end function

'':::::
private function assembleFiles_GAS _
	( _
	) as integer

	dim as string ascline

	function = FALSE

	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )

		'' gas' options --32 as we only compile for 32bit right now, and 64 bit systems will error trying to do
		'' a 64 bit compile by default
		if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
			ascline = "--32 --strip-local-absolute "
		else
			ascline = "--32 "
		end if

		ascline += QUOTE + iof->asmf + _
				   (QUOTE + " -o " + QUOTE) + _
				   iof->outf + (QUOTE) + _
                   fbc.extopt.gas

		'' invoke as
		if( assembleFile( "as", ascline ) = FALSE ) then
			exit function
		end if

    	iof = listGetNext( iof )
    loop

    function = TRUE

end function

'':::::
private function hArchToGccArch _
	( _
		byval arch as integer _
	) as string

	dim as string march

	select case as const arch
	case FB_CPUTYPE_386
		march = "i386"

	case FB_CPUTYPE_486
		march = "i486"

	case FB_CPUTYPE_586
		march = "i586"

	case FB_CPUTYPE_686
		march = "i686"

	case FB_CPUTYPE_ATHLON
		march = "athlon"

	case FB_CPUTYPE_ATHLONXP
		march = "athlon-xp"

	case FB_CPUTYPE_ATHLONFX
		march = "athlon-fx"

	case FB_CPUTYPE_ATHLONSSE3
		march = "k8-sse3"

	case FB_CPUTYPE_PENTIUMMMX
		march = "pentium-mmx"

	case FB_CPUTYPE_PENTIUM2
		march = "pentium2"

	case FB_CPUTYPE_PENTIUM3
		march = "pentium3"

	case FB_CPUTYPE_PENTIUM4
		march = "pentium4"

	case FB_CPUTYPE_PENTIUMSSE3
		march = "prescott"

	case FB_CPUTYPE_NATIVE
		march = "native"

	end select

	function = march

end function
'':::::
private function assembleFiles_GCC _
	( _
	) as integer

	dim as string ascline
	dim as string march = "-mtune=" & hArchToGccArch( fbGetOption( FB_COMPOPT_CPUTYPE ) ) & " "

	function = FALSE

	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )

    	'' gcc' options
    	ascline = "-c -nostdlib -nostdinc " & _
    			  "-Wall -Wno-unused-label -Wno-unused-function -Wno-unused-variable " & _
    			  "-finline -ffast-math -fomit-frame-pointer -fno-math-errno -fno-trapping-math -frounding-math -fno-strict-aliasing " & _
    			  "-O" & fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) & " "

    	if( fbGetOption( FB_COMPOPT_DEBUG ) ) then
			ascline += "-g "
    	end if

    	ascline += march

    	if( fbGetOption( FB_COMPOPT_FPUTYPE ) = FB_FPUTYPE_SSE ) then
    		ascline += "-mfpmath=sse -msse2 "
    	end if

		ascline += QUOTE + iof->asmf + _
				   (QUOTE + " -o " + QUOTE) + _
				   iof->outf + (QUOTE) + _
                   fbc.extopt.gcc

		'' invoke gcc
		if( assembleFile( "gcc", ascline ) = FALSE ) then
			exit function
		end if

    	iof = listGetNext( iof )
    loop

    function = TRUE

end function

'':::::
private function assembleFiles _
	( _
	) as integer

	select case fbGetOption( FB_COMPOPT_BACKEND )
	case FB_BACKEND_GAS
		return assembleFiles_GAS( )

	case FB_BACKEND_GCC
		return assembleFiles_GCC( )

	end select

end function


'':::::
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

'':::::
private function archiveFiles _
	( _
	) as integer

    dim as string arcline
    dim as integer has_infobj = FALSE

	function = FALSE

    ''
    fbc.outname = hStripFilename( fbc.outname ) + _
			fbcMakeLibFileName( hStripPath( fbc.outname ) )

    arcline = "-rsc "

    '' output library file name
    arcline += QUOTE + fbc.outname + (QUOTE + " ")

#ifndef DISABLE_OBJINFO
    '' the first object must be the info one
    if( fbIsCrossComp( ) = FALSE ) then
    	if( hAddInfoObject( ) ) then
    		arcline += QUOTE + FB_INFOSEC_OBJNAME + QUOTE + " "
    		has_infobj = TRUE
    	end if
    end if
#endif

    '' add objects from output list
	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )
    	arcline += QUOTE + iof->outf + (QUOTE + " ")

    	iof = listGetNext( iof )
    loop

    '' add objects from cmm-line
	dim as string ptr objf = listGetHead( @fbc.objlist )
	do while( objf <> NULL )
    	arcline += QUOTE + *objf + (QUOTE + " ")

    	objf = listGetNext( objf )
    loop

    if( hFileExists( fbc.outname ) ) then
    	safeKill( fbc.outname )
    end if

	'' invoke ar
	function = fbcRunBin("archiving", fbcFindBin("ar"), arcline)

    ''
    if( has_infobj ) then
    	safeKill( FB_INFOSEC_OBJNAME )
    end if

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

'':::::
private function clearDefList( byval dllfile as zstring ptr ) as integer
	dim inpf as integer, outf as integer
	dim ln as string

	function = FALSE

    if( hFileExists( *dllfile + ".def" ) = FALSE ) then
    	exit function
    end if

    inpf = freefile
    open *dllfile + ".def" for input as #inpf
    outf = freefile
    open *dllfile + ".clean.def" for output as #outf

    '''''print #outf, "LIBRARY " + hStripPath( dllfile ) + ".dll"

    do until eof( inpf )

    	line input #inpf, ln

    	if( right( ln, 4 ) =  "DATA" ) then
    		ln = left( ln, len( ln ) - 4 )
    	end if

    	print #outf, ln
    loop

    close #outf
    close #inpf

    kill( *dllfile + ".def" )
    name *dllfile + ".clean.def", *dllfile + ".def"

    function = TRUE

end function

'':::::
private function makeImpLib _
	( _
		byval dllpath as zstring ptr, _
		byval dllname as zstring ptr _
	) as integer

	dim as string dtpath, dtcline, dllfile

	function = FALSE

	'' set path
	dtpath = fbcFindBin("dlltool")

	''
	dllfile = *dllpath + *dllname

	'' output def list
	'''''if( makeDefList( dllname ) = FALSE ) then
	'''''	exit function
	'''''end if

	'' for some weird reason, LD will declare all functions exported as if they were
	'' from DATA segment, causing an exception (UPPERCASE'd symbols assumption??)
	if( clearDefList( dllfile ) = FALSE ) then
		exit function
	end if

	dtcline = "--def " + QUOTE + dllfile + ".def" + QUOTE + _
			  " --dllname " + QUOTE + *dllname + ".dll" + QUOTE + _
			  " --output-lib " + QUOTE + *dllpath + "lib" + *dllname + (".dll.a" + QUOTE)

	if (fbcRunBin("creating import library", dtpath, dtcline) = FALSE) then
		exit function
	end if

	''
	kill( dllfile + ".def" )

    function = TRUE

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

'':::::
private function linkFiles() as integer
	dim as string ldcline, dllname, resfile

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

	case FB_COMPTARGET_XBOX
		ldcline += " -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared"

	end select

	'' export all symbols declared as EXPORT
	if( (fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB) or _
	    fbGetOption( FB_COMPOPT_EXPORT ) ) then
		ldcline += " --export-dynamic"
	end if

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
			'' create the def list to use when creating the import library
			ldcline += " --output-def " + QUOTE + hStripFilename( fbc.outname ) + dllname + (".def" + QUOTE)
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

	'' add objects from output list
	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )
		ldcline += " " + QUOTE + iof->outf + QUOTE
		iof = listGetNext( iof )
	loop

	'' add objects from cmm-line
	dim as string ptr objf = listGetHead( @fbc.objlist )
	do while( objf <> NULL )
		ldcline += " " + QUOTE + *objf + QUOTE
		objf = listGetNext( objf )
	loop

	'' init lib group
	ldcline += " -("

	'' add libraries from command-line and found when parsing
	ldcline += *fbcGetLibList( dllname )

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' note: for some odd reason, this object must be included in the group when
		'' 		 linking a DLL, or LD will fail with an "undefined symbol" msg. at least
		'' 		 the order the .ctors/.dtors appeared will be preserved, so the rtlib ones
		'' 		 will be the first/last called, respectively
		'' On *nix/*BSD: must be included in the group or
		'' dlopen() will fail because fb_hRtExit() will be undefined.
		ldcline += " " + QUOTE + fbc.libpath + "fbrt0.o" + QUOTE + " "
	end if

	'' end lib group
	ldcline += " -)"

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
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
		dim as string resfile = hCreateResFile( ldcline )
		if( len( resfile ) = 0 ) then
			exit function
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
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
		if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
			'' create the import library for the dll built
			if( makeImpLib( hStripFilename( fbc.outname ), dllname ) = FALSE ) then
				exit function
			end if
		end if

	case FB_COMPTARGET_DOS
		'' patch the exe to change the stack size
		dim as integer f = freefile()

		if (open(fbc.outname, for binary, access read write, as #f) <> 0) then
			exit function
		end if

		put #f, 533, fbc.stacksize

		close #f

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
private function compileXpm() as integer
	#define STATE_OUT_STRING	0
	#define STATE_IN_STRING		1

	dim as integer fi, fo
	dim as integer outstr_count, buffer_len, state, label
	dim as ubyte ptr p
	dim as string * 4096 chunk
	dim as string iconsrc, buffer, outstr()

	function = FALSE

	'' executbles as well as dynamic libs (ldopen can fail otherwise)
	if( (fbGetOption( FB_COMPOPT_OUTTYPE ) <> FB_OUTTYPE_EXECUTABLE) and _ 
	    (fbGetOption( FB_COMPOPT_OUTTYPE ) <> FB_OUTTYPE_DYNAMICLIB) ) then
		return TRUE
	end if

	if( len( fbc.xpmfile ) = 0 ) then
		return TRUE
	else
		''
		if( hFileExists( fbc.xpmfile ) = FALSE ) then
			exit function
		end if
		iconsrc = hStripExt( hStripPath( fbc.xpmfile ) ) + ".asm"

		if( fbc.verbose ) then
			print "compiling XPM icon resource: ", fbc.xpmfile & " -o " & iconsrc
		end if

		''
		fi = freefile()
		open fbc.xpmfile for input as #fi
		line input #1, buffer
		if( ucase( buffer ) <> "/* XPM */" ) then
			close #fi
			exit function
		end if
		buffer = ""
		while eof( fi ) = FALSE
			buffer_len = seek( fi )
			get #1,, chunk
			buffer_len = seek( fi ) - buffer_len
			buffer += left( chunk, buffer_len )
		wend
		close #fi
		buffer_len = len( buffer )
		p = sadd( buffer )

		''
		do
			select case state

			case STATE_OUT_STRING
				if( *p = CHAR_QUOTE ) then
					state = STATE_IN_STRING
					outstr_count += 1
					redim preserve outstr(outstr_count) as string
					outstr(outstr_count-1) = ""
				end if

			case STATE_IN_STRING
				if( *p = CHAR_QUOTE ) then
					state = STATE_OUT_STRING
				elseif( *p = CHAR_TAB ) then
					outstr(outstr_count-1) += RSLASH + "t"
				else
					outstr(outstr_count-1) += chr(*p)
				end if

			end select
			p += 1
			buffer_len -= 1
		loop while buffer_len > 0
		if( state <> STATE_OUT_STRING ) then
			exit function
		end if

		''
		fo = freefile()
		open iconsrc for output as #fo
		print #fo, ".section .rodata"
		for label = 0 to outstr_count-1
			print #fo, "_l" + hex( label ) + ":"
			print #fo, ".string " + QUOTE + outstr( label ) + QUOTE
		next label
		print #fo, ".section .data"
		print #fo, ".align 32"
		print #fo, "_xpm_data:"
		for label = 0 to outstr_count-1
			print #fo, ".long _l" + hex( label )
		next label
		print #fo, ".align 32"
		print #fo, ".globl fb_program_icon"
		print #fo, "fb_program_icon:"
		print #fo, ".long _xpm_data"
		close #fo
	end if

	'' compile icon source file
	if (fbcRunBin("assembling", fbcFindBin("as"), _
	              iconsrc + " --32 -o " + hStripExt( iconsrc ) + ".o" ) = FALSE) then
		kill( iconsrc )
		exit function
	end if

	kill( iconsrc )

	'' add to obj list
	dim as string ptr objf = listNewNode( @fbc.objlist )
	*objf = hStripExt( iconsrc ) + ".o"

	function = TRUE
end function

'':::::
private function compileRcs() as integer
	dim as string rescmppath, rescmpcline, oldinclude

	'' Change the include env var to point to the (hopefully present)
	'' win/rc/*.h headers.
	oldinclude = trim( environ( "INCLUDE" ) )
	setenviron "INCLUDE=" + fbc.incpath + ("win" + RSLASH + "rc")

	rescmppath = fbcFindBin("GoRC")

	'' set input files (.rc's and .res') and output files (.obj's)
	dim as string ptr rcf = listGetHead( @fbc.rclist )
	do while( rcf <> NULL )

		'' windres options
		rescmpcline = "/ni /nw /o /fo " + QUOTE + hStripExt( *rcf ) + _
					  (".obj" + QUOTE + " " + QUOTE) + *rcf + QUOTE

		'' invoke
		if (fbcRunBin("compiling resource", rescmppath, rescmpcline) = FALSE) then
			exit function
		end if

		'' add to obj list
		dim as string ptr objf = listNewNode( @fbc.objlist )
		*objf = hStripExt( *rcf ) + ".obj"

		rcf = listGetNext( rcf )
	loop

	'' restore the include env var
	if( len( oldinclude ) > 0 ) then
		setenviron "INCLUDE=" + oldinclude
	end if

	return TRUE
end function

'':::::
private sub delFiles()
	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )

	do while( iof <> NULL )
		if( fbc.preserveasm = FALSE ) then
			safeKill( iof->asmf )
		end if

		if( fbc.emitonly = FALSE ) then
			if( fbc.preserveobj = FALSE ) then
				safeKill( iof->outf )
			end if
		end if

		iof = listGetNext( iof )
	loop

	select case as const fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX

	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
	     FB_COMPTARGET_OPENBSD, FB_COMPTARGET_DARWIN, _
	     FB_COMPTARGET_NETBSD
		'' delete compiled icon object
		if( len( fbc.xpmfile ) > 0 ) then
			safeKill( hStripExt( hStripPath( fbc.xpmfile ) ) + ".o" )
		end if

	end select
end sub

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
private sub setMainModule( )

	if( len( fbc.mainfile ) = 0 ) then
		dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
		dim as string ptr inf = NULL
		if( iof <> NULL ) then
			inf = @iof->inf
		end if

		if( inf <> NULL ) then
			fbc.mainfile = hStripPath( hStripExt( *inf ) )
			fbc.mainpath = hStripFilename( *inf )

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

private sub setPaths()
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
end sub

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

'':::::
private sub printInvalidOpt _
	( _
		byval arg as string ptr, _
		byval errnum as FB_ERRMSG = FB_ERRMSG_MISSINGCMDOPTION _
	)

	errReportEx( errnum, QUOTE + *arg + QUOTE, -1 )

end sub

'':::::
#macro hDelArgNode( arg )
	*arg = ""
	listDelNode( @fbc.arglist, arg )
#endmacro

'':::::
#macro hDelArgNodes( arg, nxt )
	hDelArgNode( arg )
	if( nxt <> NULL ) then
		arg = listGetNext( nxt )
		hDelArgNode( nxt )
	end if
	nxt = arg
#endmacro

'':::::
private function processTargetOptions _
	( _
	) as integer

    dim as string ptr arg = any, nxt = any

	function = FALSE

	'' for each arg..
	nxt = listGetHead( @fbc.arglist )
	do while( nxt <> NULL )

		arg = nxt
		nxt = listGetNext( nxt )

		if( len( arg[0] ) = 0 ) then
			continue do
		end if

		if( (*arg)[0] = asc( "-" ) ) then

			if( len( arg[0] ) = 1 ) then
				continue do
			end if

			if( *(strptr( arg[0] ) + 1) = "target" ) then

				if( nxt = NULL ) then
					printInvalidOpt( arg )
					return FALSE
				end if

				select case *nxt
#ifdef ENABLE_DOS
				case "dos"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_DOS )
#endif

#ifdef ENABLE_CYGWIN
				case "cygwin"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_CYGWIN )
#endif

#ifdef ENABLE_LINUX
				case "linux"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_LINUX )
#endif

#ifdef ENABLE_WIN32
				case "win32"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_WIN32 )
#endif

#ifdef ENABLE_XBOX
				case "xbox"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_XBOX )
#endif

#ifdef ENABLE_FREEBSD
				case "freebsd"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_FREEBSD )
#endif

#ifdef ENABLE_OPENBSD
				case "openbsd"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_OPENBSD )
#endif

#ifdef ENABLE_DARWIN
				case "darwin"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_DARWIN )
#endif

#ifdef ENABLE_NETBSD
				case "netbsd"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_NETBSD )
#endif

				case else
					'' TODO: Accept & parse GNU triplets, like in the makefile,
					'' to support more than the default triplets specified at
					'' compile time.
					''fbc.triplet = triplet + "-"
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					return FALSE
				end select

				hDelArgNodes( arg, nxt )
			end if

		end if

	loop

	function = TRUE

end function

'':::::
private function checkFiles _
	( _
		byval arg as string ptr _
	) as integer

	select case hGetFileExt( arg[0] )
	case "bas"
		dim as FBC_IOFILE ptr iof = listNewNode( @fbc.inoutlist )
		iof->inf = *arg

		if( fbc.iof_head = NULL ) then
			fbc.iof_head = iof
		end if

	case "a"
		dim as string ptr libf = listNewNode( @fbc.liblist )
		*libf = *arg

	case "o"
		dim as string ptr objf = listNewNode( @fbc.objlist )
		*objf = *arg

	case "rc", "res"
		'' Only for Win32 & co
		select case as const fbGetOption( FB_COMPOPT_TARGET )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX

		case else
			return FALSE

		end select

		dim as string ptr rcf = listNewNode( @fbc.rclist )
		*rcf = *arg

	case "xpm"
		'' Only for Linux & co
		select case as const fbGetOption( FB_COMPOPT_TARGET )
		case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, _
		     FB_COMPTARGET_OPENBSD, FB_COMPTARGET_DARWIN, _
		     FB_COMPTARGET_NETBSD

		case else
			return FALSE

		end select

		if( len( fbc.xpmfile ) <> 0 ) then
			return FALSE
		end if
		fbc.xpmfile = *arg

	case else
		return FALSE

	end select

	return TRUE
end function

'':::::
private function processOptions _
	( _
	) as integer

    dim as string ptr arg = any, nxt = any
    dim as integer value
    dim as FBC_OPT id

	function = FALSE

	'' for each arg..
	nxt = listGetHead( @fbc.arglist )
	do while( nxt <> NULL )

		arg = nxt
		nxt = listGetNext( nxt )

		if( len( arg[0] ) = 0 ) then
			continue do
		end if

		'' not an option?
		if( (*arg)[0] <> asc( "-" ) ) then
			'' file name?
			if( checkFiles( arg ) = FALSE ) then
				printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
				exit function
			end if

			hDelArgNode( arg )
			continue do
		end if

		'' '-' only
		if( len( arg[0] ) = 1 ) then
			continue do
		end if

		'' option..
		dim as integer del_cnt = 0

		dim as zstring ptr p = strptr(*arg) + 1

		select case as const cptr(ubyte ptr, p)[0]
		case asc("a")
			select case *p
			case "a"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as string ptr objf = listNewNode( @fbc.objlist )
				*objf = *nxt

				del_cnt = 2

			case "arch"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				select case *nxt
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
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end select

				fbSetOption( FB_COMPOPT_CPUTYPE, value )

				del_cnt = 2
			end select

		case asc("b")
			select case *p
			case "b"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as FBC_IOFILE ptr iof = listNewNode( @fbc.inoutlist )
				iof->inf = *nxt
				if( fbc.iof_head = NULL ) then
					fbc.iof_head = iof
				end if

				del_cnt = 2

			end select

		case asc("c")
			select case *p
			case "c"
				fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
				fbc.compileonly = TRUE
				fbc.emitonly = FALSE
				fbc.preserveobj = TRUE
				del_cnt = 1

			end select

		case asc("d")
			select case *p
			case "d"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as string ptr def = listNewNode( @fbc.deflist )
				*def = *nxt

				del_cnt = 2

			case "dylib", "dll"
				fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_DYNAMICLIB )
				del_cnt = 1

			end select

		case asc("e")
			select case *p
			case "e"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				del_cnt = 1

			case "ex"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
				del_cnt = 1

			case "exx"
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
				fbSetOption( FB_COMPOPT_EXTRAERRCHECK, TRUE )
				del_cnt = 1

			case "export"
				fbSetOption( FB_COMPOPT_EXPORT, TRUE )
				del_cnt = 1

			end select

		case asc("f")
			select case *p
			case "forcelang"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				value = fbGetLangId( strptr(*nxt) )

				if( value = FB_LANG_INVALID ) then
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end if

				fbSetOption( FB_COMPOPT_LANG, value )
				fbSetOptionIsExplicit( FB_COMPOPT_FORCELANG )
				fbc.objinf.lang = value

				del_cnt = 2

			case "fpu"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				select case ucase( *nxt )
				case "X87", "FPU"
					value = FB_FPUTYPE_FPU
				case "SSE"
					value = FB_FPUTYPE_SSE
				case else
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end select

				fbSetOption( FB_COMPOPT_FPUTYPE, value )

				del_cnt = 2

			case "fpmode"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				select case ucase( *nxt )
				case "PRECISE"
					value = FB_FPMODE_PRECISE
				case "FAST"
					value = FB_FPMODE_FAST
				case else
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end select

				fbSetOption( FB_COMPOPT_FPMODE, value )

				del_cnt = 2

			end select

		case asc("g")
			select case *p
			case "g"
				fbSetOption( FB_COMPOPT_DEBUG, TRUE )
				del_cnt = 1

			case "gen"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				select case lcase( *nxt )
				case "gas"
					value = FB_BACKEND_GAS
				case "gcc"
					value = FB_BACKEND_GCC
				case else
					printInvalidOpt( arg )
					exit function
				end select

				fbSetOption( FB_COMPOPT_BACKEND, value )

				del_cnt = 2

			end select

		case asc("i")
			select case *p
			case "i"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as string ptr incp = listNewNode( @fbc.incpathlist )
				*incp = *nxt

				del_cnt = 2

			case "include"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as string ptr incf = listNewNode( @fbc.preinclist )
				*incf = *nxt

				del_cnt = 2

			end select

		case asc("l")
			select case *p
			case "l"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as string ptr libf = listNewNode( @fbc.liblist )
				*libf = *nxt

				del_cnt = 2

			case "lang"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				value = fbGetLangId( strptr(*nxt) )

				if( value = FB_LANG_INVALID ) then
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end if

				fbSetOption( FB_COMPOPT_LANG, value )
				fbc.objinf.lang = value

				del_cnt = 2

			case "lib"
				fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_STATICLIB )
				del_cnt = 1

			end select

		case asc("m")
			select case *p
			case "mt"
				fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )
				fbc.objinf.mt = TRUE
				del_cnt = 1

			case "m"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.mainfile = hStripPath( *nxt )
				if( len( fbc.mainfile ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if
				fbc.mainpath = hStripFilename( *nxt )
				fbc.mainset = TRUE

				del_cnt = 2

			case "map"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.mapfile = *nxt
				if( len( fbc.mapfile ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				del_cnt = 2

			case "maxerr"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( *nxt = "inf" ) then
					value = FB_ERR_INFINITE
				else
					value = valint( *nxt )
					if( value <= 0 ) then
						value = 1
						printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					end if
				end if

				fbSetOption( FB_COMPOPT_MAXERRORS, value )

				del_cnt = 2

			end select

		case asc("n")
			select case *p
			case "noerrline"
				fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )
				del_cnt = 1

			case "nodeflibs"
				fbSetOption( FB_COMPOPT_NODEFLIBS, TRUE )
				del_cnt = 1

			end select

		case asc("o")
			select case *p
			case "o"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( fbc.iof_head = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.iof_head->outf = *nxt
				fbc.iof_head = listGetNext( fbc.iof_head )

				del_cnt = 2

			end select

		case asc("p")
			select case *p
			case "p"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( len( *nxt ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				dim as string ptr incp = listNewNode( @fbc.libpathlist )
				*incp = *nxt

				del_cnt = 2

			case "pp"
				fbSetOption( FB_COMPOPT_PPONLY, TRUE )
				fbc.compileonly = TRUE
				fbc.emitonly = TRUE
				fbc.preserveasm = FALSE
				del_cnt = 1

			case "prefix"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.prefix = *nxt

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

				del_cnt = 2

			case "profile"
				fbSetOption( FB_COMPOPT_PROFILE, TRUE )
				del_cnt = 1

			end select

		case asc("r")
			select case *p
			case "r"
				if( fbc.compileonly = FALSE )then
					fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
					fbc.emitonly = TRUE
				end if
				fbc.preserveasm = TRUE
				del_cnt = 1

			end select

		case asc("s")
			select case *p
			case "s"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.subsystem = *nxt
				if( len( fbc.subsystem ) = 0 ) then
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end if

				del_cnt = 2

			end select

		case asc("t")
			select case *p
			case "t"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.stacksize = valint( *nxt ) * 1024
				if( fbc.stacksize < FBC_MINSTACKSIZE ) then
					fbc.stacksize = FBC_MINSTACKSIZE
				end if

				del_cnt = 2

			case "title"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.xbe_title = *nxt

				del_cnt = 2

			end select

		case asc("v")
			select case *p
			case "v"
				fbc.verbose = TRUE
				del_cnt = 1

			case "vec"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				select case ucase( *nxt )
				case "NONE", "0"
					value = FB_VECTORIZE_NONE
				case "1"
					value = FB_VECTORIZE_NORMAL
				case "2"
					value = FB_VECTORIZE_INTRATREE
				case else
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end select

				fbSetOption( FB_COMPOPT_VECTORIZE, value )

				del_cnt = 2

			case "version"
				fbc.showversion = TRUE
				del_cnt = 1

			end select

		case asc("w")
			select case *p
			case "w"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				value = -2

				select case *nxt
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
					value = valint( *nxt )
				end select

				if( value >= -1 ) then
					fbSetOption( FB_COMPOPT_WARNINGLEVEL, value )
				end if

				del_cnt = 2

			end select

		case asc("x")
			select case *p
			case "x"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.outname = *nxt
				if( len( fbc.outname ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				del_cnt = 2

			end select

		case asc("z")
			select case *p
			case "z"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				value = fbGetOption( FB_COMPOPT_EXTRAOPT )

				select case lcase( *nxt )
				case "gosub-setjmp"
					value or= FB_EXTRAOPT_GOSUB_SETJMP
				case else
					printInvalidOpt( arg )
					exit function
				end select

				fbSetOption( FB_COMPOPT_EXTRAOPT, value )

				del_cnt = 2

			end select

		case asc("C")
			select case *p
			case "C"
				fbc.preserveobj = TRUE
				del_cnt = 1

			end select

		case asc("O")
			select case *p
			case "O"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				if( *nxt = "max" ) then
					value = 3
				else
					value = valint( *nxt )
					if( value < 0 ) then
						value = 0
						printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					elseif( value > 3 ) then
						value = 3
					end if
				end if

				fbSetOption( FB_COMPOPT_OPTIMIZELEVEL, value )

				del_cnt = 2

			end select

		case asc("R")
			select case *p
			case "R"
				fbc.preserveasm = TRUE
				del_cnt = 1

			end select

		case asc("W")
			select case *p
			case "Wa"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.extopt.gas = " " + hReplace( *nxt, ",", " " ) + " "

				del_cnt = 2

			case "Wl"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.extopt.ld = " " + hReplace( *nxt, ",", " " ) + " "

				del_cnt = 2

			case "Wc"
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.extopt.gcc = " " + hReplace( *nxt, ",", " " ) + " "

				del_cnt = 2

			end select
		end select

		if( del_cnt = 0 ) then
			printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
			exit function
		end if

		hDelArgNode( arg )
		if( del_cnt = 2 ) then
			arg = listGetNext( nxt )
			hDelArgNode( nxt )
			nxt = arg
		end if
	loop

	if ( fbGetOption( FB_COMPOPT_FPUTYPE ) = FB_FPUTYPE_FPU ) then
		if( fbGetOption( FB_COMPOPT_VECTORIZE ) >= FB_VECTORIZE_NORMAL ) or _
			( fbGetOption( FB_COMPOPT_FPMODE ) = FB_FPMODE_FAST ) then
				errReportEx( FB_ERRMSG_OPTIONREQUIRESSSE, "", -1 )
				exit function
		end if
	end if

	function = TRUE

end function

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
private sub parseCmdFile _
	( _
		byref optfilearg as string _
	)

	static as integer nestinglevel = 0

	'' Extract the filename; will be empty if the argument was '@' only.
	dim as string filename = right( optfilearg, len( optfilearg ) - 1 )

	if( nestinglevel > FBC_MAXCMDFILE_RECLEVEL ) then
		errReportEx( FB_ERRMSG_RECLEVELTOODEEP, "@" + filename, -1 )
		fbcEnd( 1 )
	end if

	if( hFileExists( filename ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, "@" + filename, -1 )
		fbcEnd( 1 )
	end if

	dim as integer fnum = freefile( )
	if( open( filename, for input, as #fnum ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, "@" + filename, -1 )
		fbcEnd( 1 )
	end if

	dim as string ln = ""
	dim as string arg = ""
	while( eof(fnum) = FALSE )
		line input #fnum, ln
		ln = trim(ln)

		dim as integer linepos = 0
		while( linepos < len( ln ) )
			dim as integer i = linepos

			'' Parse the first arg from the line, i.e. everything before SPACE
			'' or newline. Double-quoted strings are handled too.
			dim as integer inside_string = FALSE
			for i = linepos to len( ln ) - 1
				select case ln[i]
				case asc(" ")
					if( inside_string = FALSE ) then
						exit for
					end if

				case asc(!"\"")
					inside_string = (inside_string = FALSE)

				end select
			next

			arg = trim( mid( ln, linepos + 1, i - linepos ) )
			linepos = i + 1

			'' Not just space?
			if( len( arg ) > 0 ) then
				'' Check for @filename in such a file (recursion/nesting):
				if( arg[0] = asc("@") ) then
					nestinglevel += 1
					parseCmdFile( arg )
					nestinglevel -= 1
				else
					'' Remember normal argument for later...
					dim as string ptr node = listNewNode( @fbc.arglist )
					*node = arg
				end if
			end if
		wend
	wend

	close #fnum
end sub

'':::::
private sub parseCmd _
	( _
	)

	dim as string ptr arg = any
	dim as integer argc = any

	argc = 1
	do
		arg = listNewNode( @fbc.arglist )
		assert( arg <> NULL )

		*arg = command( argc )
		if( len( arg[0] ) = 0 ) then
			listDelNode( @fbc.arglist, arg )
			exit do
		end if

		if( (*arg)[0] = asc("@") ) then
			parseCmdFile( *arg )
			listDelNode( @fbc.arglist, arg )
		end if

		argc += 1
	loop

end sub

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

'':::::
private sub setDefaultLibPaths()

	'' compiler's /lib
	fbcAddDefLibPath( fbc.libpath )

	'' and the current path
	fbcAddDefLibPath( "./" )

	'' Add gcc's private lib directory, to find libgcc and libsupc++
	'' This is for installing into Unix-like systems, and not for
	'' standalone, which has libgcc/libsupc++ in its own lib/.
	#ifndef ENABLE_STANDALONE
		fbcAddLibPathFor("gcc")
		if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DOS) then
			'' Note: The standalone DOS FB uses the renamed 8.3 filename version: supcx
			'' But this is for installing into DJGPP, where apparently supcxx is working fine.
			fbcAddLibPathFor("supcxx")
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
#define printOption(_opt,_desc) print _opt, " "; _desc

'':::::
private sub printOptions( )
	dim as string desc

	print "Usage: fbc [options] inputlist"
	print

	printOption( "inputlist:", "*.a = library, *.o = object, *.bas = source" )
	printOption( "", "*.rc = resource script, *.res = compiled resource (win32 only)" )
	printOption( "", "*.xpm = icon resource (linux, *bsd only)" )

	print
	print "options:"

	printOption( "@<file>", "Read command-line options from a file" )
	printOption( "-a <name>", "Add an object file to linker's list" )
	printOption( "-arch <type>", "Set target architecture (default: 486)" )
	printOption( "-b <name>", "Add a source file to compilation" )
	printOption( "-c", "Compile only, do not link" )
	printOption( "-C", "Do not delete the object file(s)" )
	printOption( "-d <name=val>", "Add a preprocessor's define" )
	select case fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, FB_COMPTARGET_OPENBSD, FB_COMPTARGET_DARWIN, FB_COMPTARGET_NETBSD
		printOption( "-dll", "Same as -dylib" )
		if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_WIN32 ) then
			printOption( "-dylib", "Create a DLL, including the import library" )
		else
			printOption( "-dylib", "Create a shared library" )
		end if
	end select
	printOption( "-e", "Add error checking" )
	printOption( "-ex", "Add error checking with RESUME support" )
	printOption( "-exx", "Same as above plus array bounds and null-pointer checking" )
	printOption( "-export", "Export symbols for dynamic linkage" )
	print "-forcelang <name>"; " Select language compatibility, overriding #lang/$lang in code"
	print "-fpmode <mode>"; " Select accuracy/speed of floating-point math (FAST, PRECISE)"
	printOption( "-fpu <type>", "Select FPU (x87, sse)" )
	printOption( "-g", "Add debug info" )
	printOption( "-gen <name>", "Select the code generator (gas, gcc)" )
	printOption( "-i <name>", "Add a path to search for include files" )
	print "-include <name>"; " Include a header file on each source compiled"
	printOption( "-l <name>", "Add a library file to linker's list" )
	printOption( "-lang <name>", "Select language compatibility: deprecated, fblite, qb" )
	printOption( "-lib", "Create a static library" )
	printOption( "-m <name>", "Main file w/o ext, the entry point (def: 1st .bas on list)" )
	printOption( "-map <name>", "Save the linking map to file name" )
	printOption( "-maxerr <val>", "Only stop parsing if <val> errors occurred" )
	if( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_DOS ) then
		printOption( "-mt", "Link with thread-safe runtime library" )
	end if
	printOption( "-nodeflibs", "Do not include the default libraries" )
	printOption( "-noerrline", "Do not show source line where error occurred" )
	printOption( "-o <name>", "Set object file path/name (must be passed after the .bas file)" )
	printOption( "-O <value>", "Optimization level (default: 0)" )
	printOption( "-p <name>", "Add a path to search for libraries" )
	printOption( "-pp", "Emit the preprocessed input file only, do not compile")
	print "-prefix <path>"; " Set the compiler prefix path"
	printOption( "-profile", "Enable function profiling" )
	printOption( "-r", "Write asm only, do not compile" )
	printOption( "-R", "Do not delete the asm file(s)" )
	printOption( "-s <name>", "Set subsystem, 'gui' or 'console' (win32 only)" )
	printOption( "-t <value>", "Set stack size in kbytes, default: 1M (win32/dos only)" )

	desc = " Available (cross-)compilation targets:"
	#macro listTarget(defname, fbname)
		#ifdef ENABLE_##defname
			desc += " " & fbname
			if( len( ENABLE_##defname ) > 0 ) then
				desc += " (" & ENABLE_##defname & ")"
			end if
			#ifdef TARGET_##defname
				desc += " (default)"
			#endif
		#endif
	#endmacro
	listTarget(CYGWIN, "cygwin")
	listTarget(DARWIN, "darwin")
	listTarget(DOS, "dos")
	listTarget(FREEBSD, "freebsd")
	listTarget(LINUX, "linux")
	listTarget(NETBSD, "netbsd")
	listTarget(OPENBSD, "openbsd")
	listTarget(WIN32, "win32")
	listTarget(XBOX, "xbox")
	print "-target <name>"; desc

	printOption( "-title <name>", "Set XBE display title (xbox only)" )
	printOption( "-v", "Be verbose" )
	printOption( "-vec <val>", "Enable <val> level of automatic vectorization (def: 0)" )
	printOption( "-version", "Show compiler version" )
	printOption( "-w <value>", "Set min warning level: all, pedantic or a value" )
	printOption( "-Wa <opt>", "Pass options to GAS (separated by commas)" )
	printOption( "-Wc <opt>", "Pass options to GCC when using -gen gcc (separated by commas)" )
	printOption( "-Wl <opt>", "Pass options to LD (separated by commas)" )
	printOption( "-x <name>", "Set executable/library path/name" )

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

