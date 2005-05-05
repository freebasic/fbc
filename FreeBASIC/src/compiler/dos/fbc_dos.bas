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


'' main module, DOS front-end
''
'' chng: jan/2005 written [DrV]

defint a-z
option explicit
option private
option escape

'$include once: 'inc\fb.bi'
'$include once: 'inc\fbc.bi'
'$include once: 'inc\hlp.bi'

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

	return TRUE

end function

'':::::
function _linkFiles as integer
	dim i as integer
	dim ldcline as string
	dim ldpath as string
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

    '' set script file
    select case fbc.outtype
	case FB_OUTTYPE_EXECUTABLE
		ldcline = "-T \"" + exepath( ) + *fbGetPath( FB_PATH_BIN ) + "i386go32.x\""
	end select

	if( not fbc.debug ) then
		ldcline += " -s"
	end if

	'' set entry point
    '' default crt entry point 'start' calls 'main' which calls the fb entry point
    ldcline += " "

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

	'' link with crt0.o and crt1.o (C runtime init)
	ldcline += QUOTE + exepath( ) + *fbGetPath( FB_PATH_LIB ) + "/crt0.o\" "
	'''''ldcline = ldcline + QUOTE + exepath( ) + *fbGetPath( FB_PATH_LIB ) + "/crt1.o\" "

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
		if fbc.outtype = FB_OUTTYPE_EXECUTABLE then
			ldcline += "-l" + fbc.liblist(i) + " "
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

	'' delete temporary files
	kill( mainobj )

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

	function = TRUE

end function

'':::::
function _delFiles as integer

	function = TRUE

end function

'':::::
function _listFiles( byval argv as string ) as integer

	function = FALSE

end function

'':::::
function _processOptions( byval opt as string, _
						  byval argv as string ) as integer


	function = FALSE

end function

'':::::
function _processCompOptions( byval argv as string ) as integer

	function = FALSE

end function

'':::::
function _setCompOptions( ) as integer

	function = TRUE

end function

'':::::
function makeMain ( byval main_obj as string ) as integer
    '' ugly hack for DOS/DJGPP to let libc's init routine set up protected mode etc.
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
    print #f, ".globl _main"
    print #f, "_main:"

	if fbc.outtype = FB_OUTTYPE_EXECUTABLE then

		'' save argc and argv in rtlib vars
		print #f, "movl 8(%esp), %eax"
		print #f, "movl %eax, (_fb_argv)"

		print #f, "movl 4(%esp), %eax"
		print #f, "movl %eax, (_fb_argc)"

		'' jump to real entry point ( will ret to crt startup code )
		print #f, "jmp " + fbc.entrypoint

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

