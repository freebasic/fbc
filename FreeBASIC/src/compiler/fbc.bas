''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"

#ifdef USE_FB_BFD_HEADER
#include "bfd.bi"
#endif

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

declare function compileResFiles _
	( _
	) as integer

declare function delFiles _
	( _
	) as integer

declare sub setMainModule _
	( _
	)

declare sub setCompOptions _
	( _
	)

declare function collectObjInfo _
	( _
	) as integer

declare sub setDefaultLibPaths _
	( _
	)

declare sub getDefaultLibs _
	( _
	)


''globals
	dim shared as FBCCTX fbc

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
		( FBC_OPT_NOUNDERSCORE	, @"nounderscore"), _
		( FBC_OPT_UNDERSCORE	, @"underscore"  ), _
		( FBC_OPT_SHOWSUSPERR	, @"showsusperr" ), _
		( FBC_OPT_ARCH			, @"arch"        ), _
		( FBC_OPT_FPU			, @"fpu"         ), _
		( FBC_OPT_VECTORIZE		, @"vec"         ), _
		( FBC_OPT_FPMODE		, @"fpmode"      ), _
		( FBC_OPT_DEBUG			, @"g"           ), _
		( FBC_OPT_COMPILEONLY	, @"c"           ), _
		( FBC_OPT_EMITONLY		, @"r"           ), _
		( FBC_OPT_SHAREDLIB		, @"dylib"       ), _
		( FBC_OPT_SHAREDLIB		, @"dll"         ), _
		( FBC_OPT_STATICLIB		, @"lib"         ), _
		( FBC_OPT_PRESERVEOBJ	, @"C"           ), _
		( FBC_OPT_PRESERVEASM 	, @"R"           ), _
		( FBC_OPT_PPONLY		, @"pp"          ), _
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
		( FBC_OPT_FORCELANG		, @"forcelang"   ), _
		( FBC_OPT_WA			, @"Wa"     	 ), _
		( FBC_OPT_WL			, @"Wl"     	 ), _
		( FBC_OPT_WC			, @"Wc"     	 ), _
		( FBC_OPT_GEN			, @"gen"		 ), _
		( FBC_OPT_PREFIX		, @"prefix"      ), _
		( FBC_OPT_OPTIMIZE		, @"O"      	 ), _
		( FBC_OPT_EXTRAOPT		, @"z"			 ) _
	}

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
    setCompOptions( )

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

#ifndef STANDALONE
		print "Configured with prefix " + FB_ARCH_PREFIX
#else
		print "Configured as standalone"
#endif

#ifdef DISABLE_OBJINFO
		print "objinfo disabled"
#else
		print "objinfo enabled ";
#ifdef USE_FB_BFD_HEADER
		print "using FB BFD header version " & __BFD_VER__
#else
		print "using C BFD wrapper"
#endif
#endif

    	print
    	if( fbc.showversion ) then
    		fbcEnd( 0 )
    	end if
    end if

    ''
    fbSetPaths( )

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
				'' only add the default libraries to the LD cmd-line, and not to the
				'' objects and static libraries, for speed/size reasons
				getDefaultLibs( )

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

	'' create the cmd-line options hash
	hashNew( @fbc.opthash, 32, FALSE )

	for i = 0 to FBC_OPTS-1
		hashAdd( @fbc.opthash, _
				 optionTb(i).name, _
				 cast( any ptr, optionTb(i).id ), _
				 INVALID )
	next

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

    '' free the cmd-line options hash
	hashFree( @fbc.opthash )

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

#if defined(TARGET_FREEBSD) or defined(CROSSCOMP_FREEBSD)
	case FB_COMPTARGET_FREEBSD
		fbcInit_freebsd( )
#endif

#if defined(TARGET_OPENBSD) or defined(CROSSCOMP_OPENBSD)
	case FB_COMPTARGET_OPENBSD
		fbcInit_openbsd( )
#endif

#if defined(TARGET_DARWIN) or defined(CROSSCOMP_DARWIN)
	case FB_COMPTARGET_DARWIN
		fbcInit_darwin( )
#endif

#if defined(TARGET_NETBSD) or defined(CROSSCOMP_NETBSD)
	case FB_COMPTARGET_NETBSD
		fbcInit_netbsd( )
#endif

	case else
		print "unsupported target in " & __FILE__

	end select

end sub

'':::::
private sub setCompOptions( )

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
private function assembleFile_GAS _
	( _
		byref cmdline as string _
	) as integer

	static as string path
	static as integer has_path = FALSE
	static as integer res

    if( has_path = FALSE ) then
    	has_path = TRUE

		path = fbFindBinFile( "as" )
		if( len( path ) = 0 ) then
			return FALSE
		end if

    end if

    if( fbc.verbose ) then
    	print "assembling: ", path + " " + cmdline
    end if

	res = exec( path, cmdline )
	if( res <> 0 ) then
		if( fbc.verbose ) then
			print "assembling failed: returned error code " & res
		end if
	end if

	function = (res = 0)


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
		if( assembleFile_GAS( ascline ) = FALSE ) then
			exit function
		end if

    	iof = listGetNext( iof )
    loop

    function = TRUE

end function

'':::::
private function assembleFile_GCC _
	( _
		byref cmdline as string _
	) as integer

	static as string path
	static as integer has_path = FALSE
	static as integer res

	if( has_path = FALSE ) then
		has_path = TRUE

		path = fbFindBinFile( "gcc" )
		if( len( path ) = 0 ) then
			return FALSE
		end if

	end if

	if( fbc.verbose ) then
		print "assembling: ", path + " " + cmdline
	end if

	res = exec( path, cmdline )
	if( res <> 0 ) then
		if( fbc.verbose ) then
			print "assembling failed: returned error code " & res
		end if
	end if

	function = (res = 0)


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
		if( assembleFile_GCC( ascline ) = FALSE ) then
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

#ifdef DISABLE_OBJINFO
	function = FALSE

#else '' DISABLE_OBJINFO

    if( fbObjInfoWriteObj( @fbc.ld_liblist, @fbc.ld_libpathlist ) ) then
    	function = TRUE

    '' and error occurred or there's no need for an info object, delete it
    else
		if( hFileExists( FB_INFOSEC_OBJNAME ) ) then
    		safeKill( FB_INFOSEC_OBJNAME )
    	end if

    	function = FALSE
    end if

#endif '' DISABLE_OBJINFO

end function

'':::::
private function archiveFiles _
	( _
	) as integer

    dim as string arcline
    dim as integer has_infobj = FALSE

	function = FALSE

    ''
    fbc.outname = hStripFilename( fbc.outname ) + "lib" + _
				  hStripPath( fbc.outname ) + ".a"

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
#endif '' DISABLE_OBJINFO

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

    '' invoke ar
    if( fbc.verbose ) then
       print "archiving: ", arcline
    end if

    if( hFileExists( fbc.outname ) ) then
    	safeKill( fbc.outname )
    end if

    fbc.vtbl.archiveFiles( arcline )

    ''
    if( has_infobj ) then
    	safeKill( FB_INFOSEC_OBJNAME )
    end if

    function = TRUE

end function

'':::::
private function linkFiles as integer

	function = fbc.vtbl.linkFiles( )

end function

'':::::
private function compileResFiles as integer

	function = fbc.vtbl.compileResFiles( )

end function

'':::::
private function delFiles as integer

    function = FALSE

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

    function = fbc.vtbl.delFiles( )

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

#ifdef DISABLE_OBJINFO
	function = FALSE

#else '' DISABLE_OBJINFO

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

#endif '' DISABLE_OBJINFO

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
		fbc.outaddext = TRUE
	end if

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
	fbc.outaddext   = FALSE

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
#if defined(TARGET_DOS) or defined(CROSSCOMP_DOS)
				case "dos"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_DOS )
#endif

#if defined(TARGET_CYGWIN) or defined(CROSSCOMP_CYGWIN)
				case "cygwin"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_CYGWIN )
#endif

#if defined(TARGET_LINUX) or defined(CROSSCOMP_LINUX)
				case "linux"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_LINUX )
#endif

#if defined(TARGET_WIN32) or defined(CROSSCOMP_WIN32)
				case "win32"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_WIN32 )
#endif

#if defined(TARGET_XBOX) or defined(CROSSCOMP_XBOX)
				case "xbox"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_XBOX )
#endif

#if defined(TARGET_FREEBSD) or defined(CROSSCOMP_FREEBSD)
				case "freebsd"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_FREEBSD )
#endif

#if defined(TARGET_OPENBSD) or defined(CROSSCOMP_OPENBSD)
				case "openbsd"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_OPENBSD )
#endif

#if defined(TARGET_DARWIN) or defined(CROSSCOMP_DARWIN)
				case "darwin"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_DARWIN )
#endif

#if defined(TARGET_NETBSD) or defined(CROSSCOMP_NETBSD)
				case "netbsd"
					fbSetOption( FB_COMPOPT_TARGET, FB_COMPTARGET_NETBSD )
#endif

				case else
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

	function = FALSE

	select case hGetFileExt( arg[0] )
	case "bas"
		dim as FBC_IOFILE ptr iof = listNewNode( @fbc.inoutlist )
		iof->inf = *arg

		if( fbc.iof_head = NULL ) then
			fbc.iof_head = iof
		end if

		hDelArgNode( arg )

	case "a"
		dim as string ptr libf = listNewNode( @fbc.liblist )
		*libf = *arg

		hDelArgNode( arg )

	case "o"
		dim as string ptr objf = listNewNode( @fbc.objlist )
		*objf = *arg

		hDelArgNode( arg )

	case else
		if( fbc.vtbl.listFiles( arg[0] ) = FALSE ) then
			return FALSE
		end if

		hDelArgNode( arg )

	end select

	function = TRUE

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

		'' option..
		else
			dim as integer del_cnt = 1

			if( len( arg[0] ) = 1 ) then
				continue do
			end if

			id = cast( FBC_OPT, hashLookUp( @fbc.opthash, _
											strptr( arg[0] ) + 1 ) )

			'' not found?
			if( id = 0 ) then
				'' target-dependent options?
				if( fbc.vtbl.processOptions( arg, nxt ) = FALSE ) then
					printInvalidOpt( arg, FB_ERRMSG_INVALIDCMDOPTION )
					exit function
				end if

				hDelArgNodes( arg, nxt )
				continue do
			end if

			select case as const id
			case FBC_OPT_E
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )

			case FBC_OPT_EX
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )

			case FBC_OPT_EXX
				fbSetOption( FB_COMPOPT_ERRORCHECK, TRUE )
				fbSetOption( FB_COMPOPT_RESUMEERROR, TRUE )
				fbSetOption( FB_COMPOPT_EXTRAERRCHECK, TRUE )

			case FBC_OPT_MT
				fbSetOption( FB_COMPOPT_MULTITHREADED, TRUE )
				fbc.objinf.mt = TRUE

			case FBC_OPT_PROFILE
				fbSetOption( FB_COMPOPT_PROFILE, TRUE )

			case FBC_OPT_NOERRLINE
				fbSetOption( FB_COMPOPT_SHOWERROR, FALSE )

			case FBC_OPT_NODEFLIBS
				fbSetOption( FB_COMPOPT_NODEFLIBS, TRUE )

			case FBC_OPT_EXPORT
				fbSetOption( FB_COMPOPT_EXPORT, TRUE )

			case FBC_OPT_SHOWSUSPERR
				fbSetOption( FB_COMPOPT_SHOWSUSPERRORS, FALSE )

			case FBC_OPT_ARCH
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

				del_cnt += 1

			case FBC_OPT_FPU
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

				del_cnt += 1

			case FBC_OPT_FPMODE
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

				del_cnt += 1

			case FBC_OPT_VECTORIZE
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

				del_cnt += 1

			case FBC_OPT_DEBUG
				fbSetOption( FB_COMPOPT_DEBUG, TRUE )

			case FBC_OPT_COMPILEONLY
				fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
				fbc.compileonly = TRUE
				fbc.emitonly = FALSE
				fbc.preserveobj = TRUE

			case FBC_OPT_EMITONLY
				if( fbc.compileonly = FALSE )then
					fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_OBJECT )
					fbc.emitonly = TRUE
				end if
				fbc.preserveasm = TRUE

			case FBC_OPT_PRESERVEOBJ
				fbc.preserveobj = TRUE

			case FBC_OPT_PRESERVEASM
				fbc.preserveasm = TRUE

			case FBC_OPT_PPONLY
				fbSetOption( FB_COMPOPT_PPONLY, TRUE )
				fbc.compileonly = TRUE
				fbc.emitonly = TRUE
				fbc.preserveasm = FALSE

			case FBC_OPT_SHAREDLIB
				fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_DYNAMICLIB )

			case FBC_OPT_STATICLIB
				fbSetOption( FB_COMPOPT_OUTTYPE, FB_OUTTYPE_STATICLIB )

			case FBC_OPT_VERBOSE
				fbc.verbose = TRUE

			case FBC_OPT_VERSION
				fbc.showversion = TRUE

			case FBC_OPT_OUTPUTNAME
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.outname = *nxt
				if( len( fbc.outname ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				del_cnt += 1

			case FBC_OPT_MAINMODULE
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

				del_cnt += 1

			case FBC_OPT_MAPFILE
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.mapfile = *nxt
				if( len( fbc.mapfile ) = 0 ) then
					printInvalidOpt( arg )
					exit function
				end if

				del_cnt += 1

			case FBC_OPT_MAXERRORS
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

				del_cnt += 1

			case FBC_OPT_WARNLEVEL
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

				del_cnt += 1

			case FBC_OPT_LIBPATH
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

				del_cnt += 1

			case FBC_OPT_INCPATH
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

				del_cnt += 1

			case FBC_OPT_DEFINE
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

				del_cnt += 1

			'' source files
			case FBC_OPT_INPFILE
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

				del_cnt += 1

			case FBC_OPT_OUTFILE
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

				del_cnt += 1

			case FBC_OPT_OBJFILE
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

				del_cnt += 1

			case FBC_OPT_LIBFILE
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

				del_cnt += 1

			'' pre-include files
			case FBC_OPT_INCLUDE
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

				del_cnt += 1

			case FBC_OPT_LANG, FBC_OPT_FORCELANG
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
				if( id = FBC_OPT_FORCELANG ) then
					fbSetOptionIsExplicit( FB_COMPOPT_FORCELANG )
				end if
				fbc.objinf.lang = value

				del_cnt += 1

			case FBC_OPT_GEN
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

				del_cnt += 1

			case FBC_OPT_OPTIMIZE
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

				del_cnt += 1

			case FBC_OPT_WA
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.extopt.gas = " " + hReplace( *nxt, ",", " " ) + " "

				del_cnt += 1

			case FBC_OPT_WL
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.extopt.ld = " " + hReplace( *nxt, ",", " " ) + " "

				del_cnt += 1

			case FBC_OPT_WC
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbc.extopt.gcc = " " + hReplace( *nxt, ",", " " ) + " "

				del_cnt += 1

			case FBC_OPT_PREFIX
				if( nxt = NULL ) then
					printInvalidOpt( arg )
					exit function
				end if

				fbSetPrefix( *nxt )

				del_cnt += 1

			case FBC_OPT_EXTRAOPT
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

				del_cnt += 1
			end select

			hDelArgNode( arg )
			if( del_cnt > 1 ) then
				arg = listGetNext( nxt )
				hDelArgNode( nxt )
				nxt = arg
			end if
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
private sub setDefaultLibPaths

	'' compiler's /lib
	fbcAddDefLibPath( fbGetPath( FB_PATH_LIB ) )

    '' and the current path
	fbcAddDefLibPath( "./" )

	'' platform dependent paths
	fbc.vtbl.setDefaultLibPaths( )

end sub

'':::::
private sub getDefaultLibs

    fbGetDefaultLibs( @fbc.ld_liblist, @fbc.ld_libhash )

end sub

'':::::
#define printOption(_opt,_desc) print _opt, " "; _desc

'':::::
private sub printOptions( )
	dim as string desc

	print "Usage: fbc [options] inputlist"
	print

	printOption( "inputlist:", "*.a = library, *.o = object, *.bas = source" )
	select case fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
		printOption( "", "*.rc = resource script, *.res = compiled resource" )
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD, FB_COMPTARGET_OPENBSD
		printOption( "", "*.xpm = icon resource" )
	end select

#if defined(CROSSCOMP_WIN32) or _
	defined(CROSSCOMP_CYGWIN) or _
	defined(CROSSCOMP_DOS) or _
	defined(CROSSCOMP_LINUX) or _
	defined(CROSSCOMP_XBOX) or _
	defined(CROSSCOMP_FREEBSD) or _
	defined(CROSSCOMP_OPENBSD) or _
	defined(CROSSCOMP_DARWIN) or _
	defined(CROSSCOMP_NETBSD)

	print
	print "invoke as 'fbc -target PLATFORM' alone to show options for cross compilation to that platform"

#endif

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
	select case fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
		printOption( "-s <name>", "Set subsystem (gui, console)" )
	end select
	select case fbGetOption( FB_COMPOPT_TARGET )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_DOS
		printOption( "-t <value>", "Set stack size in kbytes (default: 1M)" )
	end select

#if defined(CROSSCOMP_WIN32) or _
	defined(CROSSCOMP_CYGWIN) or _
	defined(CROSSCOMP_DOS) or _
	defined(CROSSCOMP_LINUX) or _
	defined(CROSSCOMP_XBOX) or _
	defined(CROSSCOMP_FREEBSD) or _
	defined(CROSSCOMP_OPENBSD) or _
	defined(CROSSCOMP_DARWIN) or _
	defined(CROSSCOMP_NETBSD)

	' note: alphabetical order

	desc = " Cross-compile to:"
 #ifdef CROSSCOMP_CYGWIN
	desc += " cygwin"
 #endif
 #ifdef CROSSCOMP_DARWIN
	desc += " darwin"
 #endif
 #ifdef CROSSCOMP_DOS
	desc += " dos"
 #endif
  #ifdef CROSSCOMP_FREEBSD
	desc += " freebsd"
 #endif
 #ifdef CROSSCOMP_LINUX
	desc += " linux"
 #endif
 #ifdef CROSSCOMP_NETBSD
	desc += " netbsd"
 #endif
 #ifdef CROSSCOMP_OPENBSD
	desc += " openbsd"
 #endif
 #ifdef CROSSCOMP_WIN32
	desc += " win32"
 #endif
 #ifdef CROSSCOMP_XBOX
	desc += " xbox"
 #endif

	print "-target <name>"; desc
#endif

	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_XBOX ) then
		printOption( "-title <name>", "Set XBE display title" )
	end if
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
				list += "-l" + *libf->name + " "
			end if

			libf = listGetNext( libf )
		loop
    else
		do while( libf <> NULL )
			list += "-l" + *libf->name + " "
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

