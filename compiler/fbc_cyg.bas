'' main module, Windows front-end
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"

declare function makeImpLib _
	( _
		byval dllpath as zstring ptr, _
		byval dllname as zstring ptr _
	) as integer

'':::::
private sub _setDefaultLibPaths()
	#ifndef ENABLE_STANDALONE
		fbcAddLibPathFor("gcc")
		fbcAddLibPathFor("supc++")
	#endif
end sub

'':::::
private function _linkFiles _
	( _
	) as integer

	dim as string ldcline, dllname

	function = FALSE

	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		case FB_OUTTYPE_DYNAMICLIB
			fbc.outname += ".dll"
		end select
	end if

	'' set default subsystem mode
	if( len( fbc.subsystem ) = 0 ) then
		fbc.subsystem = "console"
	else
		if( fbc.subsystem = "gui" ) then
			fbc.subsystem = "windows"
		end if
	end if

	ldcline = " -subsystem " + fbc.subsystem

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		''
		dllname = hStripPath( hStripExt( fbc.outname ) )

		'' create a dll
		ldcline += " --dll --enable-stdcall-fixup"

		'' export all symbols declared as EXPORT
		ldcline += " --export-dynamic"

		'' set the entry-point
		ldcline += " -e _DllMainCRTStartup@12"
	else
		'' tell LD to add all symbols declared as EXPORT to the symbol table
		if( fbGetOption( FB_COMPOPT_EXPORT ) ) then
			ldcline += " --export-dynamic"
		end if
	end if

#ifndef DISABLE_OBJINFO
	'' Supplementary ld script to drop the fbctinf objinfo section
	ldcline += " " + QUOTE + fbc.libpath + "fbextra.x" + QUOTE
#endif

	if( len( fbc.mapfile ) > 0) then
		ldcline += " -Map " + fbc.mapfile
	end if

	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' stack size
	ldcline += " --stack " + str( fbc.stacksize ) + "," + str( fbc.stacksize )

	'' add library paths
	ldcline += *fbcGetLibPathList( )

	'' crt entry
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE + " "
	else
		'' FIXME
		ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE + " "

		'' additional support for gmon
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += QUOTE + fbcFindGccLib("gcrt0.o") + QUOTE + " "
		end if

	end if

	'' add objects from output list
	dim as FBC_IOFILE ptr iof = listGetHead( @fbc.inoutlist )
	do while( iof <> NULL )
		ldcline += QUOTE + iof->outf + (QUOTE + " ")
		iof = listGetNext( iof )
	loop

	'' add objects from cmm-line
	dim as string ptr objf = listGetHead( @fbc.objlist )
	do while( objf <> NULL )
		ldcline += QUOTE + *objf + (QUOTE + " ")
		objf = listGetNext( objf )
	loop

	'' set executable name
	ldcline += "-o " + QUOTE + fbc.outname + QUOTE

	'' init lib group
	ldcline += " -( "

	'' add libraries from cmm-line and found when parsing
	ldcline += *fbcGetLibList( dllname )

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' rtlib initialization and termination
		ldcline += QUOTE + fbc.libpath + ("fbrt0.o" + QUOTE + " ")
	end if

	'' end lib group
	ldcline += "-) "

	'' crt end
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		'' create the def list to use when creating the import library
		ldcline += " --output-def " + QUOTE + hStripFilename( fbc.outname ) + dllname + (".def" + QUOTE)
	end if

	'' extra options
	ldcline += fbc.extopt.ld

	'' invoke ld
	if (fbcRunBin("linking", fbcFindBin("ld"), ldcline) = FALSE) then
		exit function
	end if

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		'' create the import library for the dll built
		if( makeImpLib( hStripFilename( fbc.outname ), dllname ) = FALSE ) then
			exit function
		end if
	end if

	function = TRUE

end function

'':::::
private function _archiveFiles( byval cmdline as zstring ptr ) as integer
	return fbcRunBin("archiving", fbcFindBin("ar"), *cmdline)
end function

'':::::
function clearDefList( byval dllfile as zstring ptr ) as integer
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

'':::::
private sub _addGfxLibs _
	( _
	)

	symbAddLib( "user32" )
	symbAddLib( "gdi32" )
	symbAddLib( "winmm" )

end sub


'':::::
private function _getCStdType _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

	if( ctype = FB_CSTDTYPE_SIZET ) then
		function = FB_DATATYPE_UINT
	end if

end function


'':::::
function fbcInit_cygwin( ) as integer

	static as FBC_VTBL vtbl = _
	( _
		@_linkFiles, _
		@_archiveFiles, _
		@_setDefaultLibPaths, _
		@_addGfxLibs, _
		@_getCStdType _
	)

	fbc.vtbl = vtbl

	env.target.wchar.type = FB_DATATYPE_USHORT
	env.target.wchar.size = 2

	env.target.triplet = @ENABLE_CYGWIN
	env.target.define = @"__FB_CYGWIN__"
	env.target.entrypoint = @"main"
	env.target.underprefix = TRUE
	env.target.constsection = @"rdata"

    '' Default calling convention, must match the rtlib's FBCALL
    env.target.fbcall = FB_FUNCMODE_STDCALL

    '' Specify whether stdcall or EXTERN "windows" result in STDCALL (with @N),
    '' or STDCALL_MS (without @N).
    env.target.stdcall = FB_FUNCMODE_STDCALL

	return TRUE

end function
