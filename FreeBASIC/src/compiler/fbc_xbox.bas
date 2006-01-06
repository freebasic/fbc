''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

defint a-z
option explicit
option private
option escape

#include once "inc\fb.bi"
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"

declare function _linkFiles 			( ) as integer
declare function _archiveFiles			( byval cmdline as zstring ptr ) as integer
declare function _compileResFiles 		( ) as integer
declare function _delFiles 				( ) as integer
declare function _listFiles				( byval argv as zstring ptr ) as integer
declare function _processOptions		( byval opt as zstring ptr, _
						 				  byval argv as zstring ptr ) as integer

''
'' globals
''
	dim shared rclist (0 to FB_MAXARGS-1) as string
	dim shared rcs as integer

	dim shared xbe_title as string


'':::::
public function fbcInit_xbox( ) as integer

	''
	fbc.processOptions 	= @_processOptions
	fbc.listFiles 		= @_listFiles
	fbc.compileResFiles = @_compileResFiles
	fbc.linkFiles 		= @_linkFiles
	fbc.archiveFiles 	= @_archiveFiles
	fbc.delFiles 		= @_delFiles

	''
	rcs = 0

	return TRUE

end function

'':::::
function _linkFiles as integer
	dim as integer i
	dim as string ldcline, ldpath, libname
	dim as string cxbepath, cxbecline

	function = FALSE

    '' set path
	ldpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ld.exe"

    if( hFileExists( ldpath ) = FALSE ) then
		hReportErrorEx( FB_ERRMSG_EXEMISSING, ldpath, -1 )
		exit function
    end if

	'' add extension
	if( fbc.outaddext ) then
		select case fbc.outtype
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		end select
	end if

	'' set script file and subsystem
	ldcline = "-T \"" + exepath( ) + *fbGetPath( FB_PATH_BIN ) + "i386pe.x\" -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared"

    if( len( fbc.mapfile ) > 0) then
        ldcline += " -Map " + fbc.mapfile
    end if

	if( fbc.debug = FALSE ) then
		ldcline += " --strip-all"
	end if

	'' set entry point
	ldcline += " -e _WinMainCRTStartup "

    '' add objects from output list
    for i = 0 to fbc.inps-1
    	ldcline += QUOTE + fbc.outlist(i) + "\" "
    next i

    '' add objects from cmm-line
    for i = 0 to fbc.objs-1
    	ldcline += QUOTE + fbc.objlist(i) + "\" "
    next i

    '' set executable name
    ldcline += "-o \"" + fbc.outname + QUOTE

    '' default lib path
    ldcline += " -L \"" + exepath( ) + *fbGetPath( FB_PATH_LIB ) + QUOTE
    '' and the current path to libs search list
    ldcline += " -L \"./\""

    '' add additional user-specified library search paths
    for i = 0 to fbc.pths-1
    	ldcline += " -L \"" + fbc.pthlist(i) + QUOTE
    next i

    '' init lib group
    ldcline += " -( "

    '' add libraries from cmm-line and found when parsing
    for i = 0 to fbc.libs-1
    	libname = fbc.liblist(i)

    	if( len( libname ) > 0 ) then
    		ldcline += "-l" + libname + " "
    	end if
    next i

    '' end lib group
    ldcline += "-) "

    '' invoke ld
    if( fbc.verbose ) then
    	print "linking: ", ldcline
    end if

    if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
    end if

    '' xbe title
    if len(xbe_title) = 0 then xbe_title = hStripExt(fbc.outname)
    cxbecline = "-TITLE:\"" + xbe_title + "\" "

    if fbc.debug then
    	cxbecline += "-DUMPINFO:\"" + hStripExt(fbc.outname) + ".cxbe\""
    end if

    '' output xbe filename
    cxbecline += " -OUT:\"" + hStripExt(fbc.outname) + ".xbe\" "

    '' input exe filename
    cxbecline += "\"" + fbc.outname + "\""

    '' don't echo cxbe output
    if fbc.verbose = FALSE then
    	cxbecline += " >nul"
    end if

    '' invoke cxbe (exe -> xbe)
    if (fbc.verbose) then
    	print "cxbe: ", cxbecline
    end if

    cxbepath = exepath() + *fbGetPath(FB_PATH_BIN) + "cxbe.exe"

    if( hFileExists( cxbepath ) = FALSE ) then
		hReportErrorEx( FB_ERRMSG_EXEMISSING, cxbepath, -1 )
		exit function
    end if

    '' have to use shell instead of exec in order to use >nul
    if shell(cxbepath + " " + cxbecline) <> 0 then
    	exit function
    end if

    '' remove .exe
    kill fbc.outname

    function = TRUE

end function

'':::::
function _archiveFiles( byval cmdline as zstring ptr ) as integer
	dim arcpath as string

	arcpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ar.exe"

    if( exec( arcpath, *cmdline ) <> 0 ) then
		return FALSE
    end if

	return TRUE

end function

'':::::
function _compileResFiles as integer
	dim i as integer, f as integer
	dim rescmppath as string, rescmpcline as string
	dim oldinclude as string

	function = FALSE

	'' change the include env var
	oldinclude = trim$( environ$( "INCLUDE" ) )
	setenviron "INCLUDE=" + exepath( ) + *fbGetPath( FB_PATH_INC ) + "win\\rc"

	''
	rescmppath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "GoRC.exe"

	'' set input files (.rc's and .res') and output files (.obj's)
	for i = 0 to rcs-1

		'' windres options
		rescmpcline = "/ni /nw /o /fo \"" + hStripExt(rclist(i)) + ".obj\" " + rclist(i)

		'' invoke
		if( fbc.verbose ) then
			print "compiling resource: ", rescmpcline
		end if

		if( exec( rescmppath, rescmpcline ) <> 0 ) then
			exit function
		end if

		'' add to obj list
		fbc.objlist(fbc.objs) = hStripExt(rclist(i)) + ".obj"
		fbc.objs += 1
	next i

	'' restore the include env var
	if( len( oldinclude ) > 0 ) then
		setenviron "INCLUDE=" + oldinclude
	end if

	function = TRUE

end function

'':::::
function _delFiles as integer

	function = TRUE

end function

'':::::
function _listFiles( byval argv as zstring ptr ) as integer

	select case hGetFileExt( argv )
	case "rc", "res"
		rclist(rcs) = *argv
		rcs += 1
		return TRUE

	case else
		return FALSE
	end select

end function

'':::::
function _processOptions( byval opt as zstring ptr, _
						  byval argv as zstring ptr ) as integer

    select case mid( *opt, 2 )
	case "s"
		fbc.subsystem = *argv
		if( len( fbc.subsystem ) = 0 ) then
			return FALSE
		end if
		return TRUE

	case "t"
		fbc.stacksize = valint( *argv ) * 1024
		if( fbc.stacksize < FB_MINSTACKSIZE ) then
			fbc.stacksize = FB_MINSTACKSIZE
		end if
		return TRUE

	case "title"
		xbe_title = *argv
		return TRUE

	case else

		return FALSE

	end select

end function


