''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\fbc.bi"
#include once "inc\hlp.bi"

enum GCC_LIB
	CRT1_O
	CRTBEGIN_O
	CRTEND_O
	CRTI_O
	CRTN_O
	GCRT1_O
	LIBGCC_A
	LIBSUPC_A
	GCC_LIBS
end enum


''
'' globals
''
	dim shared xpmfile as string


'':::::
private sub _setDefaultLibPaths _
	( _
	)

	'' only query gcc if this is not a cross compile
	if( fbIsCrossComp() = FALSE ) then
		dim as string file_loc
		dim as integer i = any

		'' add the paths required by gcc libs and object files
		for i = 0 to GCC_LIBS - 1

			file_loc = fbFindGccLib( i )

			if( len( file_loc ) <> 0 ) then
				fbSetGccLib( i, file_loc )
				fbcAddDefLibPath( hStripFilename( file_loc ) )
			end if
		next

	else
		dim as integer i = any
		for i = 0 to GCC_LIBS - 1
			fbSetGccLib( i, fbFindGccLib( i ) )
		next
	endif


end sub

'':::::
private function _linkFiles _
	( _
	) as integer

	dim as string ldpath, ldcline, dllname

	function = FALSE

	'' set path
	ldpath = fbFindBinFile( "ld" )
	if( len( ldpath ) = 0 ) then
		exit function
	end if

	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		dllname = hStripPath( hStripExt( fbc.outname ) )
	end if
	
	'' add extension
	if( fbc.outaddext ) then
		select case fbGetOption( FB_COMPOPT_OUTTYPE )
		case FB_OUTTYPE_DYNAMICLIB
			fbc.outname = hStripFilename( fbc.outname ) + "lib" + hStripPath( fbc.outname ) + ".so"
		end select
	end if

	''
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
#ifdef TARGET_LINUX
		ldcline = "-dynamic-linker /lib/ld-linux.so.2"
#endif
	end if

	''
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB ) then
		ldcline = "-shared --export-dynamic -h" + hStripPath( fbc.outname )

	else
		'' tell LD to add all symbols declared as EXPORT to the symbol table
		if( fbGetOption( FB_COMPOPT_EXPORT ) ) then
			ldcline += " --export-dynamic"
		end if
	end if

#ifdef STANDALONE
	'' set script file
	ldcline += (" -T " + QUOTE) + fbGetPath( FB_PATH_SCRIPT ) + ("elf_i386.x" + QUOTE)
#endif

	'' set emulation
	ldcline += " -m elf_i386" 

	if( len( fbc.mapfile ) > 0) then
		ldcline += " -Map " + fbc.mapfile
	end if

	''
	if( fbGetOption( FB_COMPOPT_DEBUG ) = FALSE ) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) = FALSE ) then
			ldcline += " -s"
		end if
	end if

	'' add library search paths
	ldcline += *fbcGetLibPathList( )

	'' crt init stuff
	if( fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_EXECUTABLE) then
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			ldcline += " " + QUOTE + fbGetGccLib( GCRT1_O ) + QUOTE
		else
			ldcline += " " + QUOTE + fbGetGccLib( CRT1_O ) + QUOTE
		end if
	end if

	ldcline += " " + QUOTE + fbGetGccLib( CRTI_O ) + QUOTE
	ldcline += " " + QUOTE + fbGetGccLib( CRTBEGIN_O ) + QUOTE + " "

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
	ldcline += *fbcGetLibList( dllname )

	if( fbGetOption( FB_COMPOPT_NODEFLIBS ) = FALSE ) then
		'' rtlib initialization and termination (must be included in the group or
		'' dlopen() will fail because fb_hRtExit() will be undefined)
		ldcline += QUOTE + fbGetPath( FB_PATH_LIB ) + "fbrt0.o" + QUOTE + " "
	end if

	'' end lib group
	ldcline += "-) "

	'' crt end stuff
	ldcline += QUOTE + fbGetGccLib( CRTEND_O ) + QUOTE + " "
	ldcline += QUOTE + fbGetGccLib( CRTN_O ) + QUOTE + " " 

   	'' extra options
   	ldcline += fbc.extopt.ld

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

#define STATE_OUT_STRING	0
#define STATE_IN_STRING		1

'':::::
private function _compileResFiles _
	( _
	) as integer

	dim as integer fi, fo
	dim as integer outstr_count, buffer_len, state, label
	dim as ubyte ptr p
	dim as string * 4096 chunk
	dim as string aspath, iconsrc, buffer, outstr()

	function = FALSE
    
    '' executbles as well as dynamic libs (ldopen can fail otherwise)
	if( (fbGetOption( FB_COMPOPT_OUTTYPE ) <> FB_OUTTYPE_EXECUTABLE) and _ 
	    (fbGetOption( FB_COMPOPT_OUTTYPE ) <> FB_OUTTYPE_DYNAMICLIB) ) then
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
		if( ucase( buffer ) <> "/* XPM */" ) then
			close #fi
			exit function
		end if
		buffer = ""
		while eof( fi ) = FALSE
			buffer_len = seek( fi )
			get #1,, chunk
			buffer_len = seek( fi ) - buffer_len
			buffer += left( chunk, buffer_len )
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
					outstr(outstr_count-1) += RSLASH + "t"
				else
					outstr(outstr_count-1) += chr(*p)
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
			print #fo, "_l" + hex( label ) + ":"
			print #fo, ".string " + QUOTE + outstr( label ) + QUOTE
		next label
		print #fo, ".section .data"
		print #fo, ".align 32"
		print #fo, "_xpm_data:"
		for label = 0 to outstr_count-1
			print #fo, ".long _l" + hex( label )
		next label
		print #fo, ".align 32"
		print #fo, ".globl fb_program_icon"
		print #fo, "fb_program_icon:"
		print #fo, ".long _xpm_data"
		close #fo
	end if

	'' compile icon source file
	aspath = fbFindBinFile( "as" )
	if( len( aspath ) = 0 ) then
		exit function
	end if

	if( exec( aspath, iconsrc + " --32 -o " + hStripExt( iconsrc ) + ".o" ) ) then
		kill( iconsrc )
		exit function
	end if

	kill( iconsrc )

	'' add to obj list
	dim as string ptr objf = listNewNode( @fbc.objlist )
	*objf = hStripExt( iconsrc ) + ".o"

	function = TRUE

end function

'':::::
private function _delFiles as integer

	'' delete compiled icon object
	if( len( xpmfile ) = 0 ) then
		safeKill( "$$fb_icon$$.o" )
	else
		safeKill( hStripExt( hStripPath( xpmfile ) ) + ".o" )
	end if

	function = TRUE

end function

'':::::
private function _listFiles( byval argv as zstring ptr ) as integer

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
private function _processOptions _
	( _
		byval opt as string ptr, _
		byval argv as string ptr _
	) as integer

	function = FALSE

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
	hAddLib( "pthread" )
	hAddLib( "dl" )
	hAddLib( "ncurses" )
	hAddLib( "supc++" )
	hAddLib( "gcc_eh" )

end sub


'':::::
private sub _addGfxLibs _
	( _
	)

#ifdef __FB_LINUX__
	symbAddLibPath( "/usr/X11R6/lib" )
#endif

	symbAddLib( "X11" )
	symbAddLib( "Xext" )
	symbAddLib( "Xpm" )
	symbAddLib( "Xrandr" )
	symbAddLib( "Xrender" )

end sub


'':::::
private function _getCStdType _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

	if( ctype = FB_CSTDTYPE_SIZET ) then
		function = FB_DATATYPE_UINT
	end if

end function


'':::::
function fbcInit_linux( ) as integer

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
	xpmfile = ""

	fbAddGccLib( @"crt1.o", CRT1_O )
	fbAddGccLib( @"crtbegin.o", CRTBEGIN_O )
	fbAddGccLib( @"crtend.o", CRTEND_O )
	fbAddGccLib( @"crti.o", CRTI_O )
	fbAddGccLib( @"crtn.o", CRTN_O )
	fbAddGccLib( @"gcrt1.o", GCRT1_O )
	fbAddGccLib( @"libgcc.a", LIBGCC_A )
	fbAddGccLib( @"libsupc++.a", LIBSUPC_A )

	env.target.wchar.type = FB_DATATYPE_UINT
	env.target.wchar.size = FB_INTEGERSIZE

	env.target.targetdir = @"linux"
	env.target.define = @"__FB_LINUX__"
	env.target.entrypoint = @"main"
	env.target.underprefix = FALSE
	env.target.constsection = @"rodata"

    '' Default calling convention, must match the rtlib's FBCALL
    env.target.fbcall = FB_FUNCMODE_CDECL

    '' Specify whether stdcall or EXTERN "windows" result in STDCALL (with @N),
    '' or STDCALL_MS (without @N).
    env.target.stdcall = FB_FUNCMODE_STDCALL_MS

	return TRUE

end function
