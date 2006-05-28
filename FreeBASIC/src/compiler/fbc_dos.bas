''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' main module, DOS front-end
''
'' chng: jan/2005 written [DrV]

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

'':::::
public function fbcInit_dos( ) as integer

	''
	fbc.processOptions 	= @_processOptions
	fbc.listFiles 		= @_listFiles
	fbc.compileResFiles = @_compileResFiles
	fbc.linkFiles 		= @_linkFiles
	fbc.archiveFiles 	= @_archiveFiles
	fbc.delFiles 		= @_delFiles

	return TRUE

end function

'':::::
function hCreateResFile( byval cline as zstring ptr ) as string
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

'':::::
function _linkFiles as integer
	dim as integer i, f
	dim as string ldcline, ldpath
#ifndef TARGET_DOS
	dim as string resfile
#endif

	function = FALSE

	'' set path
	ldpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ld.exe"

    if( hFileExists( ldpath ) = FALSE ) then
		errReportEx( FB_ERRMSG_EXEMISSING, ldpath, -1 )
		exit function
    end if

	'' add extension
	if( fbc.outaddext ) then
		select case fbc.outtype
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		end select
	end if

    '' set script file
    select case fbc.outtype
	case FB_OUTTYPE_EXECUTABLE
		ldcline = " -T \"" + exepath( ) + *fbGetPath( FB_PATH_BIN ) + "i386go32.x\""
	case else
		ldcline = ""
	end select

    if( len( fbc.mapfile ) > 0) then
        ldcline += " -Map " + fbc.mapfile
    end if

	if( fbc.debug = FALSE ) then
		ldcline += " -s"
	end if

    '' default lib path
    ldcline += " -L \"" + exepath( ) + *fbGetPath( FB_PATH_LIB ) + QUOTE
    '' and the current path to libs search list
    ldcline += " -L \"./\""

    '' add additional user-specified library search paths
    for i = 0 to fbc.pths-1
    	ldcline += " -L \"" + fbc.pthlist(i) + QUOTE
    next

	'' link with crt0.o (C runtime init)
	ldcline += " \"" + exepath( ) + *fbGetPath( FB_PATH_LIB ) + "\\crt0.o\" "

    '' add objects from output list
    for i = 0 to fbc.inps-1
    	ldcline += QUOTE + fbc.outlist(i) + "\" "
    next

    '' add objects from cmm-line
    for i = 0 to fbc.objs-1
    	ldcline += QUOTE + fbc.objlist(i) + "\" "
    next

    '' set executable name
    ldcline += "-o \"" + fbc.outname + QUOTE

    '' init lib group
    ldcline += " -( "

    '' add libraries from cmm-line and found when parsing
    for i = 0 to fbc.libs-1
		if fbc.outtype = FB_OUTTYPE_EXECUTABLE then
			ldcline += "-l" + fbc.liblist(i) + " "
		end if
    next

    '' end lib group
    ldcline += "-) "

    '' invoke ld
    if( fbc.verbose ) then
    	print "linking: ", ldpath + " " + ldcline
    end if

#ifndef TARGET_DOS
    resfile = hCreateResFile( ldcline )
    ldcline = "@" + resfile
#endif

    if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
    end if

#ifndef TARGET_DOS
	kill( resfile )
#endif

	if fbc.stacksize < FB_MINSTACKSIZE then
		fbc.stacksize = FB_MINSTACKSIZE
	end if

	f = freefile()

	if (open(fbc.outname, for binary, access read write, as #f) <> 0) then
		exit function
	end if

	put #f, 533, fbc.stacksize

	close #f

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

	function = TRUE

end function

'':::::
function _delFiles as integer

	function = TRUE

end function

'':::::
function _listFiles( byval argv as zstring ptr ) as integer

	function = FALSE

end function

'':::::
function _processOptions( byval opt as zstring ptr, _
						  byval argv as zstring ptr ) as integer

	select case mid( *opt, 2 )
	case "t"
		fbc.stacksize = valint( *argv ) * 1024
		if( fbc.stacksize < FB_MINSTACKSIZE ) then
			fbc.stacksize = FB_MINSTACKSIZE
		end if
		return TRUE

	case else
		return FALSE

	end select

end function

