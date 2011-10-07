'' main module, xbox front-end
''
'' chng: jul/2005 written [DrV]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"

'':::::
private sub _setDefaultLibPaths()

end sub

'':::::
private function _linkFiles _
	( _
	) as integer
	
	dim as string ldcline, ldpath
	dim as string cxbepath, cxbecline
	dim as string tmpexename
	dim as integer res = any
	
	function = FALSE
	
	'' set path
	ldpath = fbcFindBin("ld")
	
	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".xbe"
		end select
	end if
	
	tmpexename = fbc.outname + ".exe"
	
	ldcline = " -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared"

#ifndef DISABLE_OBJINFO
	'' Supplementary ld script to drop the fbctinf objinfo section
	ldcline += " " + QUOTE + fbc.libpath + "fbextra.x" + QUOTE
#endif
	
	if( len( fbc.mapfile ) > 0) then
		ldcline += " -Map " + fbc.mapfile
	end if
	
	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		ldcline += " --strip-all"
	end if
	
	'' set entry point
	ldcline += " -e _WinMainCRTStartup "
	
	'' set executable name
	ldcline += "-o " + QUOTE + tmpexename + QUOTE
	
	'' add library search paths
	ldcline += *fbcGetLibPathList( )
	
	'' link with crt0.o (C runtime init)
	ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE + " "
	
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
	
	
	'' init lib group
	ldcline += " -( "
	
	'' add libraries from cmm-line and found when parsing
	ldcline += *fbcGetLibList( NULL )
	
	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' rtlib initialization and termination
		ldcline += QUOTE + fbc.libpath + "fbrt0.o" + QUOTE + " "
	end if
	
	'' end lib group
	ldcline += "-) "
	
	'' extra options
	ldcline += fbc.extopt.ld
	
	'' invoke ld
	if( fbc.verbose ) then
		print "linking: ", ldcline
	end if

	if (fbcRunBin(ldpath, ldcline) = FALSE) then
		exit function
	end if
	
	'' xbe title
	if( len(fbc.xbe_title) = 0 ) then
		fbc.xbe_title = hStripExt(fbc.outname)
	end if
	
	cxbecline = "-TITLE:" + QUOTE + fbc.xbe_title + (QUOTE + " ")
	
	if( fbGetOption( FB_COMPOPT_DEBUG ) ) then
		cxbecline += "-DUMPINFO:" + QUOTE + hStripExt(fbc.outname) + (".cxbe" + QUOTE)
	end if
	
	'' output xbe filename
	cxbecline += " -OUT:" + QUOTE + fbc.outname + QUOTE
	
	'' input exe filename
	cxbecline += " " + QUOTE + tmpexename + QUOTE
	
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
			print "cxbe failed: error code " & res
		end if
		exit function
	end if
	
	'' remove .exe
	kill tmpexename
	
	function = TRUE

end function

'':::::
private function _archiveFiles(byval cmdline as zstring ptr) as integer
	return fbcRunBin(fbcFindBin("ar"), *cmdline)
end function

'':::::
private function _stripUnderscore _
	( _
		byval symbol as zstring ptr _
	) as string

	function = *(symbol + 1)

end function

'':::::
private sub _addGfxLibs _
	( _
	)

end sub


'':::::
private function _getCStdType _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

	if( ctype = FB_CSTDTYPE_SIZET ) then
		function = FB_DATATYPE_ULONG
	end if

end function


'':::::
function fbcInit_xbox( ) as integer
	
	static as FBC_VTBL vtbl = _
	( _
		@_linkFiles, _
		@_archiveFiles, _
		@_setDefaultLibPaths, _
		@_addGfxLibs, _
		@_getCStdType _
	)
	
	fbc.vtbl = vtbl

	env.target.wchar.type = FB_DATATYPE_UINT
	env.target.wchar.size = FB_INTEGERSIZE

	env.target.triplet = @ENABLE_XBOX
	env.target.define = @"__FB_XBOX__"
	env.target.entrypoint = @"XBoxStartup"
	env.target.underprefix = TRUE
	env.target.constsection = @"rdata"

    '' Default calling convention, must match the rtlib's FBCALL
    env.target.fbcall = FB_FUNCMODE_STDCALL

    '' Specify whether stdcall or EXTERN "windows" result in STDCALL (with @N),
    '' or STDCALL_MS (without @N).
    env.target.stdcall = FB_FUNCMODE_STDCALL

	return TRUE
	
end function


