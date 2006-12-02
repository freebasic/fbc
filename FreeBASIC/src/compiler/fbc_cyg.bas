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


'' main module, Windows front-end
''
'' chng: sep/2004 written [v1ctor]


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

declare function makeImpLib 			( byval dllpath as zstring ptr, _
										  byval dllname as zstring ptr ) as integer

''
'' globals
''
	dim shared rclist (0 to FB_MAXARGS-1) as string
	dim shared rcs as integer


'':::::
function fbcInit_cygwin( ) as integer

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
private function _linkFiles as integer
	dim as integer i
	dim as string ldpath, libdir, ldcline, libname, dllname

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

	'' set script file and subsystem
	ldcline = "-T " + QUOTE + exepath( ) + *fbGetPath( FB_PATH_BIN ) + ("i386pe.x" + QUOTE + " -subsystem ") + fbc.subsystem

    if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		''
		dllname = hStripPath( hStripExt( fbc.outname ) )

		'' create a dll
		ldcline += " --dll --enable-stdcall-fixup"

		'' add aliases for functions without @nn
		if( fbGetOption( FB_COMPOPT_NOSTDCALL ) ) then
	   		ldcline += " --add-stdcall-alias"
    	end if

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

    if( len( fbc.mapfile ) > 0) then
        ldcline += " -Map " + fbc.mapfile
    end if

	if( fbc.debug = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) <> FB_PROFILE_OPT_GMON ) then
			ldcline += " -s"
		end if
	end if

	'' stack size
	ldcline += " --stack " + str( fbc.stacksize ) + "," + str( fbc.stacksize )

    '' default lib path
    libdir = exepath( ) + *fbGetPath( FB_PATH_LIB )

    ldcline += " -L " + QUOTE + libdir + QUOTE
    '' and the current path to libs search list
    ldcline += " -L " + QUOTE + "./" + QUOTE

    '' add additional user-specified library search paths
    for i = 0 to fbc.pths-1
    	ldcline += " -L " + QUOTE + fbc.pthlist(i) + QUOTE
    next i

	'' crt entry
	if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline += " " + QUOTE + libdir + (RSLASH + "crt0.o" + QUOTE + " ")
	else
        '' FIXME
		ldcline += " " + QUOTE + libdir + (RSLASH + "crt0.o" + QUOTE + " ")

		'' additional support for gmon
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FB_PROFILE_OPT_GMON ) then
			ldcline += QUOTE + libdir + (RSLASH + "gcrt0.o" + QUOTE + " ")
		end if

	end if

    '' add objects from output list
    for i = 0 to fbc.inps-1
    	ldcline += QUOTE + fbc.outlist(i) + (QUOTE + " ")
    next i

    '' add objects from cmm-line
    for i = 0 to fbc.objs-1
    	ldcline += QUOTE + fbc.objlist(i) + (QUOTE + " ")
    next i

    '' set executable name
    ldcline += "-o " + QUOTE + fbc.outname + QUOTE

    '' init lib group
    ldcline += " -( "

    '' add libraries from cmm-line and found when parsing
    for i = 0 to fbc.libs-1
    	libname = fbc.liblist(i)
    	if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
    		'' check if the lib isn't the dll's import library itself
            if( libname = dllname ) then
            	libname = ""
            end if
    	end if

    	if( len( libname ) > 0 ) then
    		ldcline += "-l" + libname + " "
    	end if
    next i

	'' rtlib initialization and termination
	''       previously was: libfb_ctor.o
    if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline += QUOTE + libdir + ("/fbrt0.o" + QUOTE )
	else
		select case fbGetOption( FB_COMPOPT_PROFILE )
		case FB_PROFILE_OPT_CALLS
			ldcline += QUOTE + libdir + ("/fbrt0p.o" + QUOTE )
		case FB_PROFILE_OPT_GMON
			ldcline += "-lgmon " + QUOTE + libdir + ("/fbrt0.o" + QUOTE )
		case else
			ldcline += QUOTE + libdir + ("/fbrt0.o" + QUOTE )
		end select
	end if

    '' end lib group
    ldcline += " -) "

	'' crt end
    if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
        '' create the def list to use when creating the import library
        ldcline += " --output-def " + QUOTE + hStripFilename( fbc.outname ) + dllname + (".def" + QUOTE)
	end if

   	'' extra options
   	ldcline += fbc.extopt.ld

    '' invoke ld
    if( fbc.verbose ) then
    	print "linking: ", ldcline
    end if

    if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
    end if

    if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
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

	arcpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ar.exe"

    if( exec( arcpath, *cmdline ) <> 0 ) then
		return FALSE
    end if

	return TRUE

end function

'':::::
private function _compileResFiles as integer
	dim i as integer, f as integer
	dim rescmppath as string, rescmpcline as string
	dim oldinclude as string

	function = FALSE

	'' change the include env var
	oldinclude = trim( environ( "INCLUDE" ) )
	setenviron "INCLUDE=" + exepath( ) + *fbGetPath( FB_PATH_INC ) + "win" + RSLASH + "rc"

	''
	rescmppath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "GoRC.exe"

	'' set input files (.rc's and .res') and output files (.obj's)
	for i = 0 to rcs-1

		'' windres options
		rescmpcline = "/ni /nw /o /fo " + QUOTE + hStripExt(rclist(i)) + (".obj" + QUOTE + " ") + rclist(i)

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
private function _delFiles as integer

	function = TRUE

end function

'':::::
private function _listFiles _
	( _
		byval argv as zstring ptr _
	) as integer

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
private function _processOptions _
	( _
		byval opt as zstring ptr, _
		byval argv as zstring ptr _
	) as integer

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

	case else
		return FALSE

	end select

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
	dtpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "dlltool.exe"

    if( hFileExists( dtpath ) = FALSE ) then
		errReportEx( FB_ERRMSG_EXEMISSING, dtpath, -1 )
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

	dtcline = "--def " + QUOTE + dllfile + ".def" + QUOTE + _
			  " --dllname " + QUOTE + *dllname + ".dll" + QUOTE + _
			  " --output-lib " + QUOTE + *dllpath + "lib" + *dllname + (".dll.a" + QUOTE)

    if( fbc.verbose ) then
    	print "dlltool: ", dtcline
    end if

    if( exec( dtpath, dtcline ) <> 0 ) then
		exit function
    end if

	''
	kill( dllfile + ".def" )

    function = TRUE

end function


