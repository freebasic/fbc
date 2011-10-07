'' main module, NetBSD front-end
''
'' chng: aug/2008 written [DrV]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"

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

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		dllname = hStripPath( hStripExt( fbc.outname ) )
	end if

	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_DYNAMICLIB
			fbc.outname = hStripFilename( fbc.outname ) + "lib" + hStripPath( fbc.outname ) + ".so"
		end select
	end if

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline = "-shared --export-dynamic -h" + hStripPath( fbc.outname )
	else
		ldcline = "-dynamic-linker /usr/libexec/ld.elf_so"

		'' tell LD to add all symbols declared as EXPORT to the symbol table
		if( fbGetOption( FB_COMPOPT_EXPORT ) ) then
			ldcline += " --export-dynamic"
		end if
	end if

#ifndef DISABLE_OBJINFO
	'' Supplementary ld script to drop the fbctinf objinfo section
	ldcline += " " + QUOTE + fbc.libpath + "fbextra.x" + QUOTE
#endif

	if( len( fbc.mapfile ) > 0 ) then
		ldcline += " -Map " + fbc.mapfile
	end if

	''
	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' add library search paths
	ldcline += *fbcGetLibPathList( )

	'' crt init stuff
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += " " + QUOTE + fbcFindGccLib("gcrt0.o") + QUOTE
		else
			ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE
		end if
	end if

	ldcline += " " + QUOTE + fbcFindGccLib("crti.o") + QUOTE + " "
	ldcline += " " + QUOTE + fbcFindGccLib("crtbegin.o") + QUOTE + " "

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
		'' rtlib initialization and termination (must be included in the group or
		'' dlopen() will fail because fb_hRtExit() will be undefined)
		ldcline += QUOTE + fbc.libpath + "fbrt0.o" + QUOTE + " "
	end if

	'' end lib group
	ldcline += "-) "

	'' crt end stuff
	ldcline += QUOTE + fbcFindGccLib("crtend.o") + QUOTE
	ldcline += QUOTE + fbcFindGccLib("crtn.o") + QUOTE

   	'' extra options
   	ldcline += fbc.extopt.ld

	'' invoke ld
	return fbcRunBin("linking", fbcFindBin("ld"), ldcline)
end function

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
function fbcInit_netbsd( ) as integer

    static as FBC_VTBL vtbl = _
    ( _
		@_linkFiles, _
		@_setDefaultLibPaths, _
		@_getCStdType _
	)

	fbc.vtbl = vtbl

	env.target.wchar.type = FB_DATATYPE_UINT
	env.target.wchar.size = FB_INTEGERSIZE

	env.target.triplet = @ENABLE_NETBSD
	env.target.define = @"__FB_NETBSD__"
	env.target.entrypoint = @"main"
	env.target.underprefix = FALSE
	env.target.constsection = @"rodata"

    '' Default calling convention, must match the rtlib's FBCALL
    env.target.fbcall = FB_FUNCMODE_CDECL

    '' Specify whether stdcall or EXTERN "windows" result in STDCALL (with @N),
    '' or STDCALL_MS (without @N).
    env.target.stdcall = FB_FUNCMODE_STDCALL_MS

	return TRUE

end function
