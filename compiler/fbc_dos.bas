'' main module, DOS front-end
''
'' chng: jan/2005 written [DrV]


#include once "fb.bi"
#include once "fbint.bi"
#include once "fbc.bi"
#include once "hlp.bi"

'':::::
private sub _setDefaultLibPaths

end sub

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

	dim as string ldcline = "", ldpath
#ifdef __FB_WIN32__
	dim as string resfile
#endif

	function = FALSE

	'' set path
	ldpath = fbFindBinFile( "ld" )
	if( len( ldpath ) = 0 ) then
		exit function
	end if

	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		end select
	end if

#ifndef DISABLE_OBJINFO
	select case fbGetOption( FB_COMPOPT_OUTTYPE )
	case FB_OUTTYPE_EXECUTABLE
		'' supplementary ld script to drop the fbctinf objinfo section
		ldcline += QUOTE + fbGetPath( FB_PATH_LIB ) + "fbextra.x" + QUOTE
	end select
#endif

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

	dim as string libdir = fbGetPath( FB_PATH_LIB )
	
	'' link with crt0.o (C runtime init) or gcrt0.o for gmon profiling
	if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
		ldcline += " " + QUOTE + libdir + "gcrt0.o" + QUOTE + " "
	else
		ldcline += " " + QUOTE + libdir + "crt0.o" + QUOTE + " "
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
		ldcline += QUOTE + libdir + ("fbrt0.o" + QUOTE + " ")
	end if

	'' end lib group
	ldcline += "-) "

	'' extra options
	ldcline += fbc.extopt.ld

	'' invoke ld
	if( fbc.verbose ) then
		print "linking: ", ldpath + " " + ldcline
	end if

#ifdef __FB_WIN32__
	resfile = hCreateResFile( ldcline )
	if( len( resfile ) = 0 ) then
		exit function
	end if
	ldcline = "@" + resfile
#endif

	if( exec( ldpath, ldcline ) <> 0 ) then
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
private function _archiveFiles( byval cmdline as zstring ptr ) as integer
	dim arcpath as string

	arcpath = fbFindBinFile( "ar" )
	if( len( arcpath ) = 0 ) then
		return FALSE
	end if

	if( exec( arcpath, *cmdline ) <> 0 ) then
		return FALSE
	end if

	return TRUE

end function

'':::::
private function _compileResFiles as integer

	function = TRUE

end function

'':::::
private function _delFiles as integer

	function = TRUE

end function

'':::::
private function _listFiles( byval argv as zstring ptr ) as integer

	function = FALSE

end function

'':::::
private function _processOptions _
	( _
		byval opt as string ptr, _
		byval argv as string ptr _
	) as integer

	select case mid( *opt, 2 )
	case "t"
		if( argv = NULL ) then
			return FALSE
		end if

		fbc.stacksize = valint( *argv ) * 1024
		if( fbc.stacksize < FBC_MINSTACKSIZE ) then
			fbc.stacksize = FBC_MINSTACKSIZE
		end if
		return TRUE

	case else
		return FALSE

	end select

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

	hAddLib( "c" )
	hAddLib( "m" )
	hAddLib( "supcx" )

end sub


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
function fbcInit_dos( ) as integer

	static as FBC_VTBL vtbl = _
	( _
		@_processOptions, _
		@_listFiles, _
		@_compileResFiles, _
		@_linkFiles, _
		@_archiveFiles, _
		@_delFiles, _
		@_setDefaultLibPaths, _
		@_getDefaultLibs, _
		@_addGfxLibs, _
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
	env.target.allowstdcall = FALSE

	return TRUE

end function
