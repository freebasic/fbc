''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"

declare function _linkFiles 			( ) as integer
declare function _archiveFiles			( byval cmdline as zstring ptr ) as integer
declare function _compileResFiles 		( ) as integer
declare function _delFiles 				( ) as integer
declare function _listFiles				( byval argv as zstring ptr ) as integer
declare function _processOptions		( byval opt as string ptr, _
						 				  byval argv as string ptr ) as integer

'':::::
function fbcInit_dos( ) as integer

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

'':::::
private function _linkFiles as integer
	dim as string ldcline, ldpath, libdir
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
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		end select
	end if

    '' set script file
    select case fbGetOption( FB_COMPOPT_OUTTYPE )
	case FB_OUTTYPE_EXECUTABLE
		ldcline = " -T " + QUOTE + exepath( ) + *fbGetPath( FB_PATH_BIN ) + _
				  ("i386go32.x" + QUOTE)
	case else
		ldcline = ""
	end select

    if( len( fbc.mapfile ) > 0) then
        ldcline += " -Map " + fbc.mapfile
    end if

	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

    '' default lib path
	libdir = exepath( ) + *fbGetPath( FB_PATH_LIB )

    ldcline += " -L " + QUOTE + libdir + QUOTE
    '' and the current path to libs search list
    ldcline += " -L " + QUOTE + "./" + QUOTE

    '' add additional user-specified library search paths
	dim as string ptr libp = listGetHead( @fbc.libpathlist )
	do while( libp <> NULL )
    	ldcline += " -L " + QUOTE + *libp + QUOTE
    	libp = listGetNext( libp )
    loop

	'' link with crt0.o (C runtime init) or gcrt0.o for gmon profiling
	if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
		ldcline += " " + QUOTE + exepath( ) + *fbGetPath( FB_PATH_LIB ) + _
				   (RSLASH + "gcrt0.o" + QUOTE + " ")
	else
		ldcline += " " + QUOTE + exepath( ) + *fbGetPath( FB_PATH_LIB ) + _
				   (RSLASH + "crt0.o" + QUOTE + " ")
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
	dim as string ptr libf = listGetHead( @fbc.liblist )
	do while( libf <> NULL )
		ldcline += "-l" + *libf + " "
		libf = listGetNext( libf )
	loop

	'' rtlib initialization and termination
	'' must be included in the group
	'' previously was libfb_ctor.o
	ldcline += QUOTE + libdir + ("/fbrt0.o" + QUOTE + " " )

    '' end lib group
    ldcline += "-) "

   	'' extra options
   	ldcline += fbc.extopt.ld

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

	arcpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ar.exe"

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

