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


'' fb - main inteface
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"

declare sub		 parserInit				( )
declare sub		 parserEnd				( )

'' globals
	dim shared infileTb( ) as FBFILE
	dim shared incpathTB( ) as zstring * FB_MAXPATHLEN+1
	dim shared incfileTB( ) as zstring * FB_MAXPATHLEN+1
	dim shared pathTB(0 to FB_MAXPATHS-1) as zstring * FB_MAXPATHLEN+1

'' const
#if defined(TARGET_WIN32) or defined(TARGET_DOS) or defined(TARGET_XBOX)
	const PATHDIV = "\\"
#else
	const PATHDIV = "/"
#endif

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' interface
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub fbAddIncPath( byval path as zstring ptr )

	if( env.incpaths < FB_MAXINCPATHS ) then
        ' test for both path dividers because a slash is also supported
        ' under Win32 and DOS using DJGPP. However, the (back)slashes
        ' will always be converted to the OS' preferred type of slash.
		select case right( *path, 1 )
        case "/","\\"
        case else
			*path += PATHDIV
		end select

		incpathTB( env.incpaths ) = *path

		env.incpaths += 1
	end if

end sub

'':::::
sub fbAddDefine( byval dname as zstring ptr, _
				 byval dtext as zstring ptr )

    symbAddDefine( dname, dtext, len( *dtext ) )

end sub

'':::::
private function hFindIncFile( byval filename as zstring ptr ) as integer static
	static as zstring * FB_MAXPATHLEN+1 fname
	dim as integer i

	fname = ucase( *filename )

	for i = 0 to env.incfiles-1
		if( incfileTB( i ) = fname ) then
			return i
		end if
	next

	function = -1

end function

'':::::
private function hAddIncFile( byval filename as zstring ptr ) as integer static
    static as zstring * FB_MAXPATHLEN+1 fname
    dim as integer i

	fname = ucase( *filename )

	if( env.incfiles >= ubound( incfileTB ) ) then
		i = ubound( incfileTB )
		redim preserve incfileTB(0 to (i + (cunsg(i) \ 2))-1)
	end if

	i = hFindIncFile( fname )
	if( i = -1 ) then
		i = env.incfiles
		incfileTB( i ) = fname
		env.incfiles += 1
	end if

	function = i

end function

'':::::
function fbGetIncFile( byval index as integer ) as zstring ptr static

	if( (index >= 0) and (index <= ubound( incfileTB )) ) then
		function = @incfileTB( index )
	else
		function = NULL
	end if

end function

'':::::
private sub hSetCtx( )

	env.scope				= 0
	env.reclevel			= 0
	env.currproc 			= NULL

	env.opt.base			= 0
	env.opt.argmode			= FB_ARGMODE_BYREF
	env.opt.explicit		= FALSE
	env.opt.procpublic		= TRUE
	env.opt.escapestr		= FALSE
	env.opt.dynamic			= FALSE

	env.compoundcnt 		= 0
	env.lastcompound		= INVALID
	env.isprocstatic		= FALSE
	env.procerrorhnd 		= NULL
	env.withvar				= NULL

	env.prntcnt				= 0
	env.prntopt				= FALSE
	env.checkarray			= TRUE
	env.ctxsym 				= NULL
	env.isexpr 				= FALSE

	''
	env.forstmt.endlabel	= NULL
	env.forstmt.cmplabel	= NULL
	env.dostmt.endlabel		= NULL
	env.dostmt.cmplabel		= NULL
	env.whilestmt.endlabel	= NULL
	env.whilestmt.cmplabel	= NULL
	env.procstmt.endlabel	= NULL
	env.procstmt.cmplabel	= NULL

	''
	env.incpaths			= 0
	env.incfiles			= 0

	fbAddIncPath( exepath( ) + *fbGetPath( FB_PATH_INC ) )

	''
	select case env.clopt.target
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
		env.target.wchar.type = FB_DATATYPE_USHORT
		env.target.wchar.size = 2
	case FB_COMPTARGET_DOS
		env.target.wchar.type = FB_DATATYPE_UBYTE
		env.target.wchar.size = 1
	case else
		env.target.wchar.type = FB_DATATYPE_UINT
		env.target.wchar.size = FB_INTEGERSIZE
	end select

	env.target.wchar.doconv = ( len( wstring ) = env.target.wchar.size )

end sub

'':::::
function fbInit( byval ismain as integer ) as integer static

	''
	function = FALSE

	''
	redim infileTb( 0 to FB_MAXINCRECLEVEL-1 )

	redim incpathTB( 0 to FB_MAXINCPATHS-1 )

	redim incfileTB( 0 to FB_INITINCFILES-1 )

	''
	hSetCtx( )

	''
	symbInit( ismain )

	hlpInit( )

	errInit( )

	astInit( )

	irInit( )

	rtlInit( )

	emitInit( )

	''
	function = TRUE

end function

'':::::
sub fbSetDefaultOptions( )

	env.clopt.debug			= FALSE
	env.clopt.cputype 		= FB_DEFAULTCPUTYPE
	env.clopt.errorcheck	= FALSE
	env.clopt.resumeerr 	= FALSE
#if defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	env.clopt.nostdcall 	= FALSE
#else
	env.clopt.nostdcall 	= TRUE
#endif
	env.clopt.nounderprefix	= FALSE
	env.clopt.outtype		= FB_OUTTYPE_EXECUTABLE
	env.clopt.warninglevel 	= 0
	env.clopt.export		= FALSE
	env.clopt.nodeflibs		= FALSE
	env.clopt.showerror		= TRUE
	env.clopt.multithreaded	= FALSE
	env.clopt.profile       = FALSE
	env.clopt.target		= FB_DEFAULTTARGET
	env.clopt.naming		= FB_COMPNAMING_DEFAULT
	env.clopt.extraerrchk	= FALSE
	env.clopt.msbitfields	= FALSE

end sub

'':::::
sub fbSetOption ( byval opt as integer, _
				  byval value as integer )

	select case as const opt
	case FB_COMPOPT_DEBUG
		env.clopt.debug = value
	case FB_COMPOPT_CPUTYPE
		env.clopt.cputype = value
	case FB_COMPOPT_ERRORCHECK
		env.clopt.errorcheck = value
	case FB_COMPOPT_NOSTDCALL
		env.clopt.nostdcall = value
	case FB_COMPOPT_NOUNDERPREFIX
		env.clopt.nounderprefix = value
	case FB_COMPOPT_OUTTYPE
		env.clopt.outtype = value
	case FB_COMPOPT_RESUMEERROR
		env.clopt.resumeerr = value
	case FB_COMPOPT_WARNINGLEVEL
		env.clopt.warninglevel = value
	case FB_COMPOPT_EXPORT
		env.clopt.export = value
	case FB_COMPOPT_NODEFLIBS
		env.clopt.nodeflibs = value
	case FB_COMPOPT_SHOWERROR
		env.clopt.showerror = value
	case FB_COMPOPT_MULTITHREADED
		env.clopt.multithreaded = value
	case FB_COMPOPT_PROFILE
		env.clopt.profile = value
	case FB_COMPOPT_TARGET
		env.clopt.target = value
	case FB_COMPOPT_NAMING
		env.clopt.naming = value
	case FB_COMPOPT_EXTRAERRCHECK
		env.clopt.extraerrchk = value
	case FB_COMPOPT_MSBITFIELDS
		env.clopt.msbitfields = value
	end select

end sub

'':::::
function fbGetOption ( byval opt as integer ) as integer

	select case as const opt
	case FB_COMPOPT_DEBUG
		function = env.clopt.debug
	case FB_COMPOPT_CPUTYPE
		function = env.clopt.cputype
	case FB_COMPOPT_ERRORCHECK
		function = env.clopt.errorcheck
	case FB_COMPOPT_NOSTDCALL
		function = env.clopt.nostdcall
	case FB_COMPOPT_NOUNDERPREFIX
		function = env.clopt.nounderprefix
	case FB_COMPOPT_OUTTYPE
		function = env.clopt.outtype
	case FB_COMPOPT_RESUMEERROR
		function = env.clopt.resumeerr
	case FB_COMPOPT_WARNINGLEVEL
		function = env.clopt.warninglevel
	case FB_COMPOPT_EXPORT
		function = env.clopt.export
	case FB_COMPOPT_NODEFLIBS
		function = env.clopt.nodeflibs
	case FB_COMPOPT_SHOWERROR
		function = env.clopt.showerror
	case FB_COMPOPT_MULTITHREADED
		function = env.clopt.multithreaded
	case FB_COMPOPT_PROFILE
		function = env.clopt.profile
	case FB_COMPOPT_TARGET
		function = env.clopt.target
	case FB_COMPOPT_NAMING
		function = env.clopt.naming
	case FB_COMPOPT_EXTRAERRCHECK
		function = env.clopt.extraerrchk
	case FB_COMPOPT_MSBITFIELDS
		function = env.clopt.msbitfields
	case else
		function = FALSE
	end select

end function

'':::::
function fbGetNaming ( ) as integer
    static as integer target = INVALID

    if( target = INVALID ) then
	    if env.clopt.naming <> FB_COMPNAMING_DEFAULT then
	    	target = env.clopt.naming
	    else
		    select case as const env.clopt.target
		    case FB_COMPTARGET_WIN32
		    	target = FB_COMPNAMING_WIN32

		    case FB_COMPTARGET_CYGWIN
		    	target = FB_COMPNAMING_CYGWIN

			case FB_COMPTARGET_LINUX
		    	target = FB_COMPNAMING_LINUX

			case FB_COMPTARGET_DOS
		        target = FB_COMPNAMING_DOS

		    case FB_COMPTARGET_XBOX
		    	target = FB_COMPNAMING_XBOX
		    end select
		end if
	end if

    function = target

end function

'':::::
sub fbSetPaths( byval target as integer ) static

	select case as const target
	case FB_COMPTARGET_WIN32
		pathTB(FB_PATH_BIN) = "\\bin\\win32\\"
		pathTB(FB_PATH_INC) = "\\inc\\"
		pathTB(FB_PATH_LIB) = "\\lib\\win32"

	case FB_COMPTARGET_CYGWIN
		pathTB(FB_PATH_BIN) = "\\bin\\cygwin\\"
		pathTB(FB_PATH_INC) = "\\inc\\"
		pathTB(FB_PATH_LIB) = "\\lib\\cygwin"

	case FB_COMPTARGET_DOS
		pathTB(FB_PATH_BIN)	= "\\bin\\dos\\"
		pathTB(FB_PATH_INC)	= "\\inc\\"
		pathTB(FB_PATH_LIB)	= "\\lib\\dos"

	case FB_COMPTARGET_LINUX
		pathTB(FB_PATH_BIN) = "\\bin\\linux\\"
		pathTB(FB_PATH_INC) = "\\inc\\"
		pathTB(FB_PATH_LIB) = "\\lib\\linux"

	case FB_COMPTARGET_XBOX
		pathTB(FB_PATH_BIN) = "\\bin\\win32\\"
		pathTB(FB_PATH_INC) = "\\inc\\"
		pathTB(FB_PATH_LIB) = "\\lib\\xbox"
	end select

#ifdef TARGET_LINUX
	hRevertSlash( pathTB(FB_PATH_BIN), FALSE )
	hRevertSlash( pathTB(FB_PATH_INC), FALSE )
	hRevertSlash( pathTB(FB_PATH_LIB), FALSE )
#endif

end sub

'':::::
function fbGetPath( byval path as integer ) as zstring ptr static

	function = @pathTB( path )

end function

'':::::
function fbGetEntryPoint( ) as string static

	select case env.clopt.target
	case FB_COMPTARGET_XBOX
		return "XBoxStartup"

	case else
		return "main"

	end select

end function

'':::::
function fbGetModuleEntry( ) as string static
    dim as string sname

   	sname = hStripPath( hStripExt( env.outf.name ) )

   	hClearName( sname )

	function = "fb_ctor__" + sname

end function

'':::::
sub fbEnd

	''
	erase incpathTB

	erase incfileTB

	erase infileTb

	''
	emitEnd( )

	rtlEnd( )

	irEnd( )

	astEnd( )

	errEnd( )

	hlpEnd( )

	symbEnd( )

end sub

'':::::
function fbPreInclude( preincTb() as string, _
				       byval preincfiles as integer _
				     ) as integer

	dim as integer i

	for i = 0 to preincfiles-1
		if( fbIncludeFile( preincTb(i), TRUE ) = FALSE ) then
			return FALSE
		end if
	next

	function = TRUE

end function

'':::::
function fbCompile( byval infname as zstring ptr, _
				    byval outfname as zstring ptr, _
				    byval ismain as integer, _
				    preincTb() as string, _
				    byval preincfiles as integer _
				  ) as integer

    dim as integer res
	dim as double tmr

	function = FALSE

	''
	env.inf.name	= *hRevertSlash( infname, FALSE )
	env.inf.incfile	= INVALID
	env.inf.ismain	= ismain

	env.outf.name	= *outfname
	env.outf.ismain = ismain

	'' open source file
	if( hFileExists( *infname ) = FALSE ) then
		hReportErrorEx( FB_ERRMSG_FILENOTFOUND, infname, -1 )
		exit function
	end if

	env.inf.num = freefile
	if( open( *infname, for binary, access read, as #env.inf.num ) <> 0 ) then
		hReportErrorEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
		exit function
	end if

	env.inf.format = hCheckFileFormat( env.inf.num )

	'' emitOpen() will make calls to lex
	lexInit( FALSE )

	''
	if( emitOpen( ) = FALSE ) then
		hReportErrorEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
		exit function
	end if

	parserInit( )

	tmr = timer( )

	res = fbPreInclude( preincTb(), preincfiles )

	if( res = TRUE ) then
		'' parse
		res = cProgram( )
	end if

	tmr = timer( ) - tmr

	parserEnd( )

	lexEnd( )

	'' save
	emitClose( tmr )

	'' close src
	if( close( #env.inf.num ) <> 0 ) then
		'' ...
	end if

	'' check if any label undefined was used
	if( res = TRUE ) then
		symbCheckLabels( )
		function = (hGetErrorCnt( ) = 0)
	else
		function = FALSE
	end if

end function

'':::::
function fbListLibs( namelist() as string, byval index as integer ) as integer
	dim i as integer

	index += symbListLibs( namelist(), index )

	if( env.clopt.multithreaded ) then
		for i = 0 to index-1
			if( namelist(i) = "fb" ) then
				namelist(i) = "fbmt"
				exit for
			end if
		next i
	end if

	function = index

end function

'':::::
sub fbAddDefaultLibs( ) static

	if( env.clopt.nodeflibs ) then
		exit sub
    end if

	symbAddLib( "fb" )

	select case as const env.clopt.target
	case FB_COMPTARGET_WIN32
		symbAddLib( "gcc" )
		symbAddLib( "mingw32" )
		symbAddLib( "moldname" )
		symbAddLib( "msvcrt" )
		symbAddLib( "kernel32" )

	case FB_COMPTARGET_CYGWIN
		symbAddLib( "gcc" )
		symbAddLib( "cygwin" )
		symbAddLib( "kernel32" )

	case FB_COMPTARGET_LINUX
		symbAddLib( "gcc" )
		symbAddLib( "c" )
		symbAddLib( "m" )
		symbAddLib( "pthread" )
		symbAddLib( "dl" )
		symbAddLib( "ncurses" )

	case FB_COMPTARGET_DOS
		symbAddLib( "c" )

	case FB_COMPTARGET_XBOX
		symbAddLib( "fbgfx" )
		symbAddLib( "SDL" )
		symbAddLib( "openxdk" )
		symbAddLib( "hal" )
		symbAddLib( "c" )
		symbAddLib( "usb" )
		symbAddLib( "xboxkrnl" )
		symbAddLib( "m" )

	end select

end sub

''::::
function fbIncludeFile( byval filename as zstring ptr, _
						byval isonce as integer ) as integer

    static as zstring * FB_MAXPATHLEN incfile
    dim as integer i, fileidx

	function = FALSE

	if( env.reclevel >= FB_MAXINCRECLEVEL ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
		exit function
	end if

	'' open include file
	if( hFileExists( filename ) = FALSE ) then

		'' try finding it at same path as env.infile
		incfile = hStripFilename( env.inf.name ) + *filename
		if( hFileExists( incfile ) = FALSE ) then

			'' try finding it at the inc paths
			for i = env.incpaths-1 to 0 step -1

				incfile = incpathTB(i) + *filename
				if( hFileExists( incfile ) ) then
					exit for
				end if

			next
		end if

	else
		incfile = *filename
	end if

	''
	hRevertSlash( incfile, FALSE )

	''
	if( hFileExists( incfile ) = FALSE ) then
		hReportErrorEx( FB_ERRMSG_FILENOTFOUND, "\"" + *filename + "\"" )

	else

		''
		if( isonce ) then
            ' We should respect the path
        	if( hFindIncFile( incfile ) <> -1 ) then
        		return TRUE
        	end if
		end if

		''
        ' We should respect the path here too
		fileidx = hAddIncFile( incfile )

		''
		infileTb(env.reclevel) = env.inf
    	env.reclevel += 1

        ' We must remember the path - otherwise we'd be unable to
        ' find header files in the same path ...
		env.inf.name 	= incfile
		env.inf.incfile = fileidx

		''
		env.inf.num = freefile
		if( open( incfile, for binary, access read, as #env.inf.num ) <> 0 ) then
			hReportErrorEx( FB_ERRMSG_FILENOTFOUND, "\"" + *filename + "\"" )
			exit function
		end if

		env.inf.format = hCheckFileFormat( env.inf.num )

		'' parse
		lexPushCtx( )

		lexInit( TRUE )

		function = cProgram( )

		lexPopCtx( )

		'' close it
		if( close( #env.inf.num ) <> 0 ) then
			'' ...
		end if

		''
		env.reclevel -= 1
		env.inf = infileTb( env.reclevel )
	end if

end function

