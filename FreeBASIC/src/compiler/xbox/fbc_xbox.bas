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
declare function _archiveFiles			( byval cmdline as string ) as integer
declare function _compileResFiles 		( ) as integer
declare function _delFiles 				( ) as integer
declare function _listFiles				( byval argv as string ) as integer
declare function _processOptions		( byval opt as string, _
						 				  byval argv as string ) as integer
declare function _processCompOptions	( byval argv as string ) as integer
declare function _setCompOptions		( ) as integer

declare function makeMain				( byval o_file as string ) as integer

''
'' globals
''
	dim shared rclist (0 to FB_MAXARGS-1) as string
	dim shared rcs as integer
	
	dim shared xbe_title as string


'':::::
public function fbcInit( ) as integer

	''
	fbc.processOptions 	= @_processOptions
	fbc.listFiles 		= @_listFiles
	fbc.processCompOptions = @_processCompOptions
	fbc.setCompOptions 	= @_setCompOptions
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
	dim i as integer
	dim ldcline as string
	dim ldpath as string
	dim libname as string, dllname as string
	dim cxbepath as string
	dim cxbecline as string
	dim mainobj as string

	function = FALSE

	'' if no executable name was defined, assume it's the same as the first source file
	if( len( fbc.outname ) = 0 ) then

		SETUP_OUTNAME()

		select case fbc.outtype
		case FB_OUTTYPE_EXECUTABLE
			fbc.outname += ".exe"
		end select

	end if

    '' if entry point was not defined, assume it's at the first source file
	if( len( fbc.entrypoint ) = 0 ) then
		select case fbc.outtype
		case FB_OUTTYPE_EXECUTABLE

			SETUP_ENTRYPOINT()
			
		end select
	end if

	hClearName( fbc.entrypoint )

	'' set script file and subsystem
	ldcline = "-T \"" + exepath( ) + *fbGetPath( FB_PATH_BIN ) + "i386pe.x\" -nostdlib --file-alignment 0x20 --section-alignment 0x20 -shared"
	
	if( not fbc.debug ) then
		ldcline += " --strip-all"
	end if

	'' stack size
	''ldcline += " --stack " + str$( fbc.stacksize ) + "," + str$( fbc.stacksize )
	
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
    
    '' add entry point wrapper
	mainobj = hStripExt(fbc.outname) + ".~~~"
	if not makeMain(mainobj) then
		print "makemain failed"
		exit function
	end if
	ldcline += QUOTE + mainobj + "\" "    

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

	ldpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ld.exe"

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
    if not fbc.verbose then
    	cxbecline += " >nul"
    end if
    
    '' invoke cxbe (exe -> xbe)
    if (fbc.verbose) then
    	print "cxbe: ", cxbecline
    end if
    
    cxbepath = exepath() + *fbGetPath(FB_PATH_BIN) + "cxbe.exe"
    
    '' have to use shell instead of exec in order to use >nul
    if shell(cxbepath + " " + cxbecline) <> 0 then
    	exit function
    end if
    
    '' remove .exe and .~~~
    kill fbc.outname
    kill mainobj
	
    function = TRUE

end function

'':::::
function _archiveFiles( byval cmdline as string ) as integer
	dim arcpath as string

	arcpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ar.exe"

    if( exec( arcpath, cmdline ) <> 0 ) then
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
function _listFiles( byval argv as string ) as integer

	select case hGetFileExt( argv )
	case "rc", "res"
		rclist(rcs) = argv
		rcs += 1
		return TRUE

	case else
		return FALSE
	end select

end function

'':::::
function _processOptions( byval opt as string, _
						  byval argv as string ) as integer

    select case mid$( opt, 2 )
	case "s"
		fbc.subsystem = argv
		if( len( fbc.subsystem ) = 0 ) then
			return FALSE
		end if
		return TRUE

	case "t"
		fbc.stacksize = valint( argv ) * 1024
		if( fbc.stacksize < FB_MINSTACKSIZE ) then
			fbc.stacksize = FB_MINSTACKSIZE
		end if
		return TRUE

	case "target"
		select case argv
		case "win32"
			fbc.target = FB_COMPTARGET_WIN32
		case "linux"
			fbc.target = FB_COMPTARGET_LINUX
		case "dos"
			fbc.target = FB_COMPTARGET_DOS
		case "xbox"
			fbc.target = FB_COMPTARGET_XBOX
		case else
			return FALSE
		end select
		return TRUE

	case "naming"
		select case argv
		case "win32"
			fbc.naming = FB_COMPNAMING_WIN32
		case "linux"
			fbc.naming = FB_COMPNAMING_LINUX
		case "dos"
			fbc.naming = FB_COMPNAMING_DOS
		case "xbox"
			fbc.naming = FB_COMPNAMING_XBOX
		case else
			return FALSE
		end select
		return TRUE
	case "title"
		xbe_title = argv
		return TRUE

	case else

		return FALSE

	end select

end function

'':::::
function _processCompOptions( byval argv as string ) as integer

	select case mid$( argv, 2 )
	case "nostdcall"
		fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )
		return TRUE

	case "stdcall"
		fbSetOption( FB_COMPOPT_NOSTDCALL, FALSE )
		return TRUE

	case "nounderscore"
		fbSetOption( FB_COMPOPT_NOUNDERPREFIX, TRUE )
		return TRUE

	case "underscore"
		fbSetOption( FB_COMPOPT_NOUNDERPREFIX, FALSE )
		return TRUE

	case else
		return FALSE

	end select

end function

'':::::
function _setCompOptions( ) as integer

	select case fbc.target
	case FB_COMPTARGET_LINUX
		fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )
		fbSetOption( FB_COMPOPT_NOUNDERPREFIX, TRUE )
	case FB_COMPTARGET_DOS
		fbSetOption( FB_COMPOPT_NOSTDCALL, TRUE )
	end select

	function = TRUE

end function


'':::::
function makeMain ( byval main_obj as string ) as integer
    dim asm_file as string
    dim f as integer
    dim aspath as string, ascline as string
	
    function = FALSE
	
    aspath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "as.exe"
	
    f = freefile()
    if f = 0 then exit function
	
    asm_file = hStripExt(main_obj) + ".s~~"
	
    open asm_file for output as #f
	
    print #f, ".section .text"
    print #f, ".globl _XBoxStartup2"
    print #f, "_XBoxStartup2:"
	
	if fbc.outtype = FB_OUTTYPE_EXECUTABLE then
		'' call real entry point
		print #f, "call " + fbc.entrypoint
	end if
	
    close #f
    
    ascline = "--strip-local-absolute \"" + asm_file + "\" -o \"" + main_obj + QUOTE
	
    '' invoke as
    if (fbc.verbose) then
        print "assembling: ", ascline
    end if
	
    if (exec(aspath, ascline) <> 0) then
        exit function
    end if
	
    kill( asm_file )
	
    function = TRUE
	
end function
