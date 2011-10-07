'' main module, DOS front-end
''
'' chng: jan/2005 written [DrV]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"

#ifdef __FB_WIN32__
'':::::
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
private function _linkFiles _
	( _
	) as integer

	dim as string ldcline = ""
#ifdef __FB_WIN32__
	dim as string resfile
#endif

	function = FALSE

	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		end select
	end if

	'' The custom ldscript must always be used, to get ctors/dtors into
	'' the correct order that lets fbrt0's ctor be the first and fbrt0's
	'' dtor the last one called. (needed until DJGPP's default ldscripts
	'' are fixed)
	ldcline += " -T " + QUOTE + fbc.libpath + "i386go32.x" + QUOTE

	if( len( fbc.mapfile ) > 0) then
		ldcline += " -Map " + fbc.mapfile
	end if

	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' add library search paths
	ldcline += *fbcGetLibPathList( )

	'' link with crt0.o (C runtime init) or gcrt0.o for gmon profiling
	if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
		ldcline += " " + QUOTE + fbcFindGccLib("gcrt0.o") + QUOTE + " "
	else
		ldcline += " " + QUOTE + fbcFindGccLib("crt0.o") + QUOTE + " "
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
	ldcline += *fbcGetLibList( NULL )

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' rtlib initialization and termination, must be included in the group
		ldcline += QUOTE + fbc.libpath + "fbrt0.o" + QUOTE + " "
	end if

	'' end lib group
	ldcline += "-) "

	'' extra options
	ldcline += fbc.extopt.ld

	'' invoke ld

#ifdef __FB_WIN32__
	resfile = hCreateResFile( ldcline )
	if( len( resfile ) = 0 ) then
		exit function
	end if
	ldcline = "@" + resfile
#endif

	if (fbcRunBin("linking", fbcFindBin("ld"), ldcline) = FALSE) then
		exit function
	end if

#ifdef __FB_WIN32__
	kill( resfile )
#endif

	'' patch the exe to change the stack size
	if fbc.stacksize < FBC_MINSTACKSIZE then
		fbc.stacksize = FBC_MINSTACKSIZE
	end if

	dim as integer f = freefile()

	if (open(fbc.outname, for binary, access read write, as #f) <> 0) then
		exit function
	end if

	put #f, 533, fbc.stacksize

	close #f

	function = TRUE

end function

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
function fbcInit_dos( ) as integer

	static as FBC_VTBL vtbl = _
	( _
		@_linkFiles, _
		@_getCStdType _
	)

	fbc.vtbl = vtbl

	env.target.wchar.type = FB_DATATYPE_UBYTE
	env.target.wchar.size = 1

	env.target.triplet = @ENABLE_DOS
	env.target.define = @"__FB_DOS__"
	env.target.entrypoint = @"main"
	env.target.underprefix = TRUE
	env.target.constsection = @"rdata"

    '' Default calling convention, must match the rtlib's FBCALL
    env.target.fbcall = FB_FUNCMODE_CDECL

    '' Specify whether stdcall or EXTERN "windows" result in STDCALL (with @N),
    '' or STDCALL_MS (without @N).
    env.target.stdcall = FB_FUNCMODE_STDCALL_MS

	return TRUE

end function
