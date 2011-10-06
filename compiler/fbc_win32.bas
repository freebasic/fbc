'' main module, Windows front-end
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"
#include once "list.bi"

declare function makeImpLib _
	( _
		byval dllpath as zstring ptr, _
		byval dllname as zstring ptr _
	) as integer

'':::::
private sub _setDefaultLibPaths()
	#ifndef ENABLE_STANDALONE
		'' To allow installing into MinGW
		fbcAddLibPathFor("gcc")
		fbcAddLibPathFor("supc++")
	#endif
end sub

/'
'':::::
private function hSplitPathEnv _
	( _
		pathTb() as string _
	) as integer

    dim as string path
    dim as integer pi, pe, lgt, paths, i

	path = trim( environ( "PATH" ) )

	paths = 8
	redim pathTb(0 to paths-1)

	pi = 0
	do
		pe = instr( pi+1, path, ";" )
		if( pe = 0 ) then
			if( pi = 0 ) then
				pathTb(0) = path
				i = 1
			end if
			exit do
		end if

		lgt = (pe - pi) - 1
		if( lgt > 0 ) then
			if( i >= paths ) then
				paths += 8
				redim preserve pathTb(0 to paths-1)
			end if

			pathTb(i) = mid( path, pi+1, lgt )

			i += 1
		end if

		pi = pe
	loop

	function = i

end function

'':::::
function hFindDllPath _
	( _
		byval dllname as zstring ptr _
	) as zstring ptr

	static as integer paths = 0
	static as string pathTb()
	dim as integer i, c

	if( paths = 0 ) then
		paths = hSplitPathEnv( pathTb() )

		'' add last slash
		for i = 0 to paths-1
			c = pathTb(i)[len(pathTb(i))-1]
			if( c <> asc( RSLASH ) ) then
				if( c <> asc( "/" ) ) then
					pathTb(i) += "/"
				end if
			end if
		next
	end if

	for i = 0 to paths-1
		if( hFileExists( pathTb(i) + *dllname ) ) then
			return strptr( pathTb(i) )
		end if
	next

	function = NULL

end function
'/

'':::::
private function _linkFiles _
	( _
	) as integer

	dim as string ldpath, ldcline, dllname
	dim as integer res = any

	function = FALSE

	'' set path
	ldpath = fbcFindBin("ld")
	if( len( ldpath ) = 0 ) then
		exit function
	end if

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
	'' supplementary ld script to drop the fbctinf objinfo section
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

	'' add the library search paths
	ldcline += *fbcGetLibPathList( )

	'' crt entry
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline += " " + QUOTE + fbcFindGccLib("dllcrt2.o") + QUOTE + " "
	else
		ldcline += " " + QUOTE + fbcFindGccLib("crt2.o") + QUOTE + " "

		'' additional support for gmon
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += QUOTE + fbcFindGccLib("gcrt2.o") + QUOTE + " "
		end if

	end if

	ldcline += "" + QUOTE + libdir + fbcFindGccLib("crtbegin.o") + QUOTE + " "

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

	'' group
	ldcline += " -( " + *fbcGetLibList( dllname )

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' note: for some odd reason, this object must be included in the group when
		'' 		 linking a DLL, or LD will fail with an "undefined symbol" msg. at least
		'' 		 the order the .ctors/.dtors appeared will be preserved, so the rtlib ones
		'' 		 will be the first/last called, respectively
		ldcline += QUOTE + fbc.libpath + "fbrt0.o" + QUOTE + " "
	end if

	ldcline += "-) "

	'' crt end stuff
	ldcline += QUOTE + fbcFindGccLib("crtend.o") + QUOTE

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		'' create the def list to use when creating the import library
		ldcline += " --output-def " + _
		           QUOTE + hStripFilename( fbc.outname ) + dllname + (".def" + QUOTE)
	end if

   	'' extra options
   	ldcline += fbc.extopt.ld

	'' invoke ld
	if( fbc.verbose ) then
		print "linking: ", ldcline
	end if

	res = exec( ldpath, ldcline )
	if( res <> 0 ) then
		if( fbc.verbose ) then
			print "linking failed: error code " & res
		end if
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
	dim arcpath as string

	arcpath = fbcFindBin("ar")
	if( len( arcpath ) = 0 ) then
		return FALSE
	end if

    if( exec( arcpath, *cmdline ) <> 0 ) then
		return FALSE
    end if

	return TRUE

end function

#if 0
'':::::
private function makeDefList( dllname as string ) as integer
	dim pxpath as string
	dim pxcline as string

	function = FALSE

	pxpath = fbcFindBin("pexports")
	if( len( pxpath ) = 0 ) then
		exit function
	end if

	pxcline = "-o " + dllname + ".dll >" + dllname + ".def"

	'' can't use EXEC coz redirection is needed, damn..
	'''''if( exec( pxpath, pxcline ) <> 0 ) then
	'''''	exit function
	'''''end if

	shell pxpath + " " + pxcline

	function = TRUE

end function
#endif

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
	dim as integer res = any

	function = FALSE

	'' set path
	dtpath = fbcFindBin("dlltool")
	if( len(dtpath) = 0 ) then
		exit function
	end if

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

	dtcline = "--def " + QUOTE + dllfile + (".def" + QUOTE + _
			  " --dllname " + QUOTE) + *dllname + (".dll" + QUOTE + _
			  " --output-lib " + QUOTE) + *dllpath + "lib" + *dllname + (".dll.a" + QUOTE)

    if( fbc.verbose ) then
    	print "dlltool: ", dtcline
    end if

	res = exec( dtpath, dtcline )
    if( res <> 0 ) then
		if( fbc.verbose ) then
			print "dlltool failed: error code " & res
		end if
		exit function
    end if

	''
	kill( dllfile + ".def" )

    function = TRUE

end function


'':::::
private sub _getDefaultLibs _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr _
	)

#macro hAddLib( libname )
	symbAddLibEx( dstlist, dsthash, libname, TRUE )
#endmacro

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

end sub


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
function fbcInit_win32( ) as integer

	static as FBC_VTBL vtbl = _
	( _
		@_linkFiles, _
		@_archiveFiles, _
		@_setDefaultLibPaths, _
		@_getDefaultLibs, _
		@_addGfxLibs, _
		@_getCStdType _
	)

	fbc.vtbl = vtbl

	env.target.wchar.type = FB_DATATYPE_USHORT
	env.target.wchar.size = 2

	env.target.triplet = @ENABLE_WIN32
	env.target.define = @"__FB_WIN32__"
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
