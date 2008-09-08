''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


'' main module, xbox front-end
''
'' chng: jul/2005 written [DrV]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"


''
'' globals
''
	dim shared rclist as TLIST
	
	dim shared xbe_title as string

'':::::
private sub _setDefaultLibPaths

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
	ldpath = fbFindBinFile( "ld" )
	if( len( ldpath ) = 0 ) then
		exit function
	end if
	
	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".xbe"
		end select
	end if
	
	tmpexename = fbc.outname + ".exe"
	
	'' set script file
	ldcline = "-T " + QUOTE + fbGetPath( FB_PATH_SCRIPT ) + ("i386pe.x" + QUOTE + _
		" -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared")
	
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
	
	dim as string libdir = fbGetPath( FB_PATH_LIB )
	
	'' link with crt0.o (C runtime init)
	ldcline += " " + QUOTE + libdir + ("crt0.o" + QUOTE + " ")
	
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
		ldcline += QUOTE + libdir + ("fbrt0.o" + QUOTE + " ")
	end if
	
	'' end lib group
	ldcline += "-) "
	
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
	
	'' xbe title
	if( len(xbe_title) = 0 ) then
		xbe_title = hStripExt(fbc.outname)
	end if
	
	cxbecline = "-TITLE:" + QUOTE + xbe_title + (QUOTE + " ")
	
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

	cxbepath = fbFindBinFile( "cxbe" )
	if( len( cxbepath ) = 0 ) then
		exit function
	end if
	
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
private function _archiveFiles _
	( _
		byval cmdline as zstring ptr _
	) as integer
	
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
private function _compileResFiles _
	( _
	) as integer
	
	dim as string rescmppath, rescmpcline, oldinclude
	dim as integer res = any
	
	function = FALSE
	
	'' change the include env var
	oldinclude = trim( environ( "INCLUDE" ) )
	setenviron "INCLUDE=" + fbGetPath( FB_PATH_INC ) + ("win" + RSLASH + "rc")
	
	''
	rescmppath = fbFindBinFile( "GoRC" )
	if( len( rescmppath ) = 0 ) then
		exit function
	end if
	
	'' set input files (.rc's and .res') and output files (.obj's)
	dim as string ptr rcf = listGetHead( @rclist )
	do while( rcf <> NULL )
		
		'' windres options
		rescmpcline = "/ni /nw /o /fo " + QUOTE + hStripExt( *rcf ) + _
					  (".obj" + QUOTE + " " + QUOTE) + *rcf + QUOTE
		
		'' invoke
		if( fbc.verbose ) then
			print "compiling resource: ", rescmpcline
		end if

		res = exec( rescmppath, rescmpcline ) 
		if( res <> 0 ) then
			if( fbc.verbose ) then
				print "compiling resource failed: error code " & res
			end if
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
	
	function = TRUE

end function

'':::::
private function _delFiles as integer

	function = TRUE

end function

'':::::
private function _listFiles( byval argv as zstring ptr ) as integer
	
	select case hGetFileExt( argv )
	case "rc", "res"
		dim as string ptr rcf = listNewNode( @rclist )
		*rcf = *argv
		
		return TRUE
		
	case else
		return FALSE
	end select
	
end function

'':::::
private function _processOptions _
	( _
		byval opt as string ptr, _
		byval argv as string ptr _
	) as integer
	
	select case mid( *opt, 2 )
	case "s"
		if( argv = NULL ) then
			return FALSE
		end if
		
		fbc.subsystem = *argv
		if( len( fbc.subsystem ) = 0 ) then
			return FALSE
		end if
		return TRUE
		
	case "t"
		if( argv = NULL ) then
			return FALSE
		end if
		
		fbc.stacksize = valint( *argv ) * 1024
		if( fbc.stacksize < FBC_MINSTACKSIZE ) then
			fbc.stacksize = FBC_MINSTACKSIZE
		end if
		return TRUE
		
	case "title"
		xbe_title = *argv
		return TRUE
		
	case else
		
		return FALSE
		
	end select

end function


'':::::
private function _stripUnderscore _
	( _
		byval symbol as zstring ptr _
	) as string

	function = *(symbol + 1)

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
function fbcInit_xbox( ) as integer
	
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
	
	''
	listNew( @rclist, FBC_INITARGS\4, len( string ) )

	env.target.wchar.type = FB_DATATYPE_UINT
	env.target.wchar.size = FB_INTEGERSIZE

	env.target.targetdir = @"xbox"
	env.target.define = @"__FB_XBOX__"
	env.target.entrypoint = @"XBoxStartup"
	env.target.underprefix = TRUE
	env.target.constsection = @"rdata"
	env.target.allowstdcall = FALSE

	return TRUE
	
end function


