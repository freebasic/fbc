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


'' main module, Linux front-end
''
'' chng: dec/2004 written [lillo]

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
	dim shared xpmfile as string

'':::::
public function fbcInit_linux( ) as integer

	''
	fbc.processOptions 	= @_processOptions
	fbc.listFiles 		= @_listFiles
	fbc.compileResFiles = @_compileResFiles
	fbc.linkFiles 		= @_linkFiles
	fbc.archiveFiles 	= @_archiveFiles
	fbc.delFiles 		= @_delFiles

	''
	xpmfile = ""

	return TRUE

end function

'':::::
function _linkFiles as integer
	dim as integer i
	dim as string ldpath, ldcline, libdir, bindir, libname, dllname

	function = FALSE

	'' set path
	bindir = exepath( ) + *fbGetPath( FB_PATH_BIN )
#ifdef TARGET_LINUX
	ldpath = bindir + "ld"
#else
	ldpath = bindir + "ld.exe"
#endif

    if( hFileExists( ldpath ) = FALSE ) then
		errReportEx( FB_ERRMSG_EXEMISSING, ldpath, -1 )
		exit function
    end if

	if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		dllname = hStripPath( hStripExt( fbc.outname ) )
	end if

	'' add extension
	if( fbc.outaddext ) then
		select case fbc.outtype
		case FB_OUTTYPE_DYNAMICLIB
			fbc.outname = hStripFilename( fbc.outname ) + "lib" + hStripPath( fbc.outname ) + ".so"
		end select
	end if

	''
	if( fbc.outtype = FB_OUTTYPE_EXECUTABLE) then
#ifdef TARGET_LINUX
		ldcline = "-dynamic-linker /lib/ld-linux.so.2"
#endif
	end if

    ''
    if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline = "-shared --export-dynamic -h" + hStripPath( fbc.outname )

    else
    	'' tell LD to add all symbols declared as EXPORT to the symbol table
    	if( fbGetOption( FB_COMPOPT_EXPORT ) ) then
    		ldcline += " --export-dynamic"
    	end if
    end if

	'' set script file
	ldcline += " -T \"" + bindir + "elf_i386.x\""

    if( len( fbc.mapfile ) > 0) then
        ldcline += " -Map " + fbc.mapfile
    end if

	''
	if( fbc.debug = FALSE ) then
		ldcline += " -s"
	end if

    '' default lib path
	libdir = exepath( ) + *fbGetPath( FB_PATH_LIB )
	ldcline += " -L \"" + libdir + QUOTE

    '' and the current path to libs search list
    ldcline += " -L \"./\""

    '' add additional user-specified library search paths
    for i = 0 to fbc.pths-1
    	ldcline += " -L \"" + fbc.pthlist(i) + QUOTE
    next i

	'' crt init stuff
	if( fbc.outtype = FB_OUTTYPE_EXECUTABLE) then
		ldcline += " \"" + libdir + "/crt1.o\""
	end if
	ldcline += " \"" + libdir + "/crti.o\""
	ldcline += " \"" + libdir + "/crtbegin.o\" "

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

	'' init lib group
    ldcline += " -( "

    '' add libraries from cmm-line and found when parsing
   	for i = 0 to fbc.libs-1
		libname = fbc.liblist(i)

    	if( fbc.outtype = FB_OUTTYPE_DYNAMICLIB ) then
   			'' check if the lib isn't the dll's import library itself
   	        if( libname = dllname ) then
   	        	continue for
   	        end if
   		end if
	
		ldcline += "-l" + libname + " "
	next

    '' end lib group
    ldcline += "-) "

	'' crt end stuff
	ldcline += " \"" + libdir + "/crtend.o\""
	ldcline += " \"" + libdir + "/crtn.o\""

    '' invoke ld
    if( fbc.verbose ) then
    	print "linking: ", ldcline
    end if

    if( exec( ldpath, ldcline ) <> 0 ) then
		exit function
    end if

    function = TRUE

end function

'':::::
function _archiveFiles( byval cmdline as zstring ptr ) as integer
	dim arcpath as string

#ifdef TARGET_LINUX
	arcpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ar"
#else
	arcpath = exepath( ) + *fbGetPath( FB_PATH_BIN ) + "ar.exe"
#endif

    if( exec( arcpath, *cmdline ) <> 0 ) then
		return FALSE
    end if

	return TRUE

end function

#define STATE_OUT_STRING	0
#define STATE_IN_STRING		1
#define CHAR_TAB			9
#define CHAR_QUOTE			34

'':::::
function _compileResFiles as integer
	dim fi as integer, fo as integer
	dim iconsrc as string
	dim buffer as string, chunk as string * 4096
	dim outstr_count as integer
	dim buffer_len as integer, p as ubyte ptr
	dim state as integer, label as integer
	redim outstr(0) as string

	function = FALSE

	if( fbc.outtype <> FB_OUTTYPE_EXECUTABLE ) then
		return TRUE
	end if

	if( len( xpmfile ) = 0 ) then

		'' no icon supplied, provide a NULL symbol
		iconsrc = "$$fb_icon$$.asm"
		fo = freefile()
		open iconsrc for output as #fo
		print #fo, ".data"
		print #fo, ".align 32"
		print #fo, ".globl fb_program_icon"
		print #fo, "fb_program_icon:"
		print #fo, ".long 0"
		close #fo

	else
		'' invoke
		if( fbc.verbose ) then
			print "compiling XPM icon resource: ", xpmfile
		end if

		''
		if( hFileExists( xpmfile ) = FALSE ) then
			exit function
		end if
		iconsrc = hStripExt( hStripPath( xpmfile ) ) + ".asm"

		''
		fi = freefile()
		open xpmfile for input as #fi
		line input #1, buffer
		if( ucase$( buffer ) <> "/* XPM */" ) then
			close #fi
			exit function
		end if
		buffer = ""
		while eof( fi ) = FALSE
			buffer_len = seek( fi )
			get #1,, chunk
			buffer_len = seek( fi ) - buffer_len
			buffer += left$( chunk, buffer_len )
		wend
		close #fi
		buffer_len = len( buffer )
		p = sadd( buffer )

		''
		do
			select case state

			case STATE_OUT_STRING
				if( *p = CHAR_QUOTE ) then
					state = STATE_IN_STRING
					outstr_count += 1
					redim preserve outstr(outstr_count) as string
					outstr(outstr_count-1) = ""
				end if

			case STATE_IN_STRING
				if( *p = CHAR_QUOTE ) then
					state = STATE_OUT_STRING
				elseif( *p = CHAR_TAB ) then
					outstr(outstr_count-1) += "\\t"
				else
					outstr(outstr_count-1) += chr$(*p)
				end if

			end select
			p += 1
			buffer_len -= 1
		loop while buffer_len > 0
		if( state <> STATE_OUT_STRING ) then
			exit function
		end if

		''
		fo = freefile()
		open iconsrc for output as #fo
		print #fo, ".section .rodata"
		for label = 0 to outstr_count-1
			print #fo, "_l" + hex$( label ) + ":"
			print #fo, ".string \"" + outstr( label ) + "\""
		next label
		print #fo, ".section .data"
		print #fo, ".align 32"
		print #fo, "_xpm_data:"
		for label = 0 to outstr_count-1
			print #fo, ".long _l" + hex$( label )
		next label
		print #fo, ".align 32"
		print #fo, ".globl fb_program_icon"
		print #fo, "fb_program_icon:"
		print #fo, ".long _xpm_data"
		close #fo
	end if

	'' compile icon source file
#ifdef TARGET_LINUX
	if( exec( exepath( ) + *fbGetPath( FB_PATH_BIN ) + "as", iconsrc + " -o " + hStripExt( iconsrc ) + ".o" ) ) then
#else
	if( exec( exepath( ) + *fbGetPath( FB_PATH_BIN ) + "as.exe", iconsrc + " -o " + hStripExt( iconsrc ) + ".o" ) ) then
#endif
		kill( iconsrc )
		exit function
	end if

	kill( iconsrc )

	'' add to obj list
	fbc.objlist(fbc.objs) = hStripExt( iconsrc ) + ".o"
	fbc.objs += 1

	function = TRUE

end function

'':::::
function _delFiles as integer

	'' delete compiled icon object
	if( len( xpmfile ) = 0 ) then
		safeKill( "$$fb_icon$$.o" )
	else
		safeKill( hStripExt( hStripPath( xpmfile ) ) + ".o" )
	end if

	function = TRUE

end function

'':::::
function _listFiles( byval argv as zstring ptr ) as integer

	if( hGetFileExt( argv ) = "xpm" ) then
		if( len( xpmfile ) <> 0 ) then
			return FALSE
		end if

		xpmfile = *argv
		return TRUE

	else
		return FALSE
	end if

end function

'':::::
function _processOptions( byval opt as zstring ptr, _
						  byval argv as zstring ptr ) as integer


	function = FALSE

end function


