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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'
'$include once: 'inc\emitdbg.bi'

'' globals
	dim shared incfiles as integer			'' can't be on ENV as it is restored on recursion
	dim shared envcopyTB( ) as FBENV
	dim shared incpathTB( ) as zstring * FB.MAXPATHLEN+1
	dim shared incfileTB( ) as zstring * FB.MAXPATHLEN+1
	dim shared pathTB(0 to FB_MAXPATHS-1) as zstring * FB.MAXPATHLEN+1


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' interface
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

deflibsdata:
data "fb"
#ifdef TARGET_WIN32
data "msvcrt"
data "kernel32"
#elseif defined(TARGET_LINUX)
data "c"
data "m"
data "pthread"
data "dl"
#elseif defined(TARGET_DOS)
data "c"
#endif
data ""

'':::::
sub fbAddIncPath( byval path as string )

#if defined(TARGET_WIN32) or defined(TARGET_DOS)
	const PATHDIV = "\\"
#else
	const PATHDIV = "/"
#endif

	if( env.incpaths < FB.MAXINCPATHS ) then
		if( right$( path, 1 ) <> PATHDIV ) then
			path += PATHDIV
		end if

		incpathTB( env.incpaths ) = path

		env.incpaths += 1
	end if

end sub

'':::::
sub fbAddDefine( byval dname as string, _
				 byval dtext as string )

    symbAddDefine( dname, dtext )

end sub

'':::::
function fbFindIncFile( byval filename as string ) as integer static
	static as zstring * FB.MAXPATHLEN+1 fname
	dim as integer i

	fname = ucase$( filename )

	for i = 0 to incfiles-1
		if( incfileTB( i ) = fname ) then
			return TRUE
		end if
	next i

	function = FALSE

end function

'':::::
sub fbAddIncFile( byval filename as string ) static
    static as zstring * FB.MAXPATHLEN+1 fname
    dim as integer i

	fname = ucase$( filename )

	if( incfiles >= ubound( incfileTB ) ) then
		i = ubound( incfileTB )
		redim preserve incfileTB(0 to (i + (i \ 2))-1)
	end if

	if( not fbFindIncFile( fname ) ) then
		incfileTB( incfiles ) = fname
		incfiles += 1
	end if

end sub

'':::::
private sub hSetCtx

	env.scope			= 0
	env.reclevel		= 0
	env.currproc 		= NULL

	env.optbase			= 0
	env.optargmode		= FB.ARGMODE.BYREF
	env.optexplicit		= FALSE
	env.optprocpublic	= TRUE
	env.optescapestr	= FALSE
	env.optdynamic		= FALSE

	env.compoundcnt 	= 0
	env.lastcompound	= INVALID
	env.isprocstatic	= FALSE
	env.procerrorhnd 	= NULL
	env.withtext		= ""

	env.prntcnt			= 0
	env.prntopt			= FALSE
	env.varcheckarray	= TRUE

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
	env.incpaths		= 0
	incfiles			= 0

#ifndef TARGET_LINUX
	fbAddIncPath( exepath( ) + *fbGetPath( FB_PATH_INC ) )
#else
	fbAddIncPath( *fbGetPath( FB_PATH_INC ) )
#endif

end sub

'':::::
function fbInit as integer static

	''
	function = FALSE

	''
	symbInit( )

	hlpInit( )

	astInit( )

	irInit( )

	rtlInit( )

	lexInit( )

	emitInit( )

	''
	redim envcopyTB( 0 to FB.MAXINCRECLEVEL-1 )

	redim incpathTB( 0 to FB.MAXINCPATHS-1 )

	redim incfileTB( 0 to FB.INITINCFILES-1 )

	''
	hSetCtx( )

	''
	function = TRUE

end function

'':::::
sub fbSetDefaultOptions

	env.clopt.debug			= FALSE
	env.clopt.cputype 		= FB.DEFAULTCPUTYPE
	env.clopt.errorcheck	= FALSE
	env.clopt.resumeerr 	= FALSE
#ifdef TARGET_WIN32
	env.clopt.nostdcall 	= FALSE
#else
	env.clopt.nostdcall 	= TRUE
#endif
	env.clopt.nounderprefix	= FALSE
	env.clopt.outtype		= FB_OUTTYPE_EXECUTABLE
	env.clopt.warninglevel 	= 0
	env.clopt.export		= TRUE
	env.clopt.nodeflibs		= FALSE
	env.clopt.showerror		= TRUE
	env.clopt.multithreaded	= FALSE
	env.clopt.profile       = FALSE
	env.clopt.target		= FB_DEFAULTTARGET

end sub

'':::::
sub fbSetOption ( byval opt as integer, _
				  byval value as integer )

	select case as const opt
	case FB.COMPOPT.DEBUG
		env.clopt.debug = value
	case FB.COMPOPT.CPUTYPE
		env.clopt.cputype = value
	case FB.COMPOPT.ERRORCHECK
		env.clopt.errorcheck = value
	case FB.COMPOPT.NOSTDCALL
		env.clopt.nostdcall = value
	case FB.COMPOPT.NOUNDERPREFIX
		env.clopt.nounderprefix = value
	case FB.COMPOPT.OUTTYPE
		env.clopt.outtype = value
	case FB.COMPOPT.RESUMEERROR
		env.clopt.resumeerr = value
	case FB.COMPOPT.WARNINGLEVEL
		env.clopt.warninglevel = value
	case FB.COMPOPT.EXPORT
		env.clopt.export = value
	case FB.COMPOPT.NODEFLIBS
		env.clopt.nodeflibs = value
	case FB.COMPOPT.SHOWERROR
		env.clopt.showerror = value
	case FB.COMPOPT.MULTITHREADED
		env.clopt.multithreaded = value
	case FB.COMPOPT.PROFILE
		env.clopt.profile = value
	case FB.COMPOPT.TARGET
		env.clopt.target = value
	end select

end sub

'':::::
function fbGetOption ( byval opt as integer ) as integer

	select case as const opt
	case FB.COMPOPT.DEBUG
		function = env.clopt.debug
	case FB.COMPOPT.CPUTYPE
		function = env.clopt.cputype
	case FB.COMPOPT.ERRORCHECK
		function = env.clopt.errorcheck
	case FB.COMPOPT.NOSTDCALL
		function = env.clopt.nostdcall
	case FB.COMPOPT.NOUNDERPREFIX
		function = env.clopt.nounderprefix
	case FB.COMPOPT.OUTTYPE
		function = env.clopt.outtype
	case FB.COMPOPT.RESUMEERROR
		function = env.clopt.resumeerr
	case FB.COMPOPT.WARNINGLEVEL
		function = env.clopt.warninglevel
	case FB.COMPOPT.EXPORT
		function = env.clopt.export
	case FB.COMPOPT.NODEFLIBS
		function = env.clopt.nodeflibs
	case FB.COMPOPT.SHOWERROR
		function = env.clopt.showerror
	case FB.COMPOPT.MULTITHREADED
		function = env.clopt.multithreaded
	case FB.COMPOPT.PROFILE
		function = env.clopt.profile
	case FB.COMPOPT.TARGET
		function = env.clopt.target
	case else
		function = FALSE
	end select

end function

'':::::
sub fbSetPaths( byval target as integer ) static

	select case target
	case FB_COMPTARGET_WIN32
		pathTB(FB_PATH_BIN) = "\\bin\\win32\\"
		pathTB(FB_PATH_INC) = "\\inc\\"
		pathTB(FB_PATH_LIB) = "\\lib\\win32"
	case FB_COMPTARGET_DOS
		pathTB(FB_PATH_BIN)	= "\\bin\\dos\\"
		pathTB(FB_PATH_INC)	= "\\inc\\"
		pathTB(FB_PATH_LIB)	= "\\lib\\dos"
	case FB_COMPTARGET_LINUX
#ifdef TARGET_WIN32
		pathTB(FB_PATH_BIN) = "\\bin\\linux\\"
		pathTB(FB_PATH_INC) = "\\inc\\"
		pathTB(FB_PATH_LIB) = "\\lib\\linux"
#else
		pathTB(FB_PATH_BIN)	= "/usr/share/freebasic/bin/"
		pathTB(FB_PATH_INC)	= "/usr/share/freebasic/inc/"
		pathTB(FB_PATH_LIB)	= "/usr/share/freebasic/lib"
#endif
	end select

end sub

'':::::
function fbGetPath( byval path as integer ) as zstring ptr static

	function = @pathTB( path )

end function

'':::::
sub fbEnd

	''
	erase incpathTB

	erase incfileTB

	erase envcopyTB

	''
	emitEnd( )

	lexEnd( )

	rtlEnd( )

	irEnd( )

	astEnd( )

	hlpEnd( )

	symbEnd( )

end sub

'':::::
function fbCompile ( byval infname as string, _
				     byval outfname as string ) as integer
    dim res as integer, l as FBSYMBOL ptr
	dim tmr as double

	function = FALSE

	''
	env.infile	= infname
	env.outfile	= outfname

	'' open source file
	if( not hFileExists( infname ) ) then
		hReportErrorEx( FB.ERRMSG.FILENOTFOUND, infname, -1 )
		exit function
	end if

	env.inf = freefile
	if( open( infname, for binary, access read, as #env.inf ) <> 0 ) then
		hReportErrorEx( FB.ERRMSG.FILEACCESSERROR, infname, -1 )
		exit function
	end if

	''
	if( not emitOpen( ) ) then
		hReportErrorEx( FB.ERRMSG.FILEACCESSERROR, infname, -1 )
		exit function
	end if

	'' parse
	tmr = timer

	parser4Init( )
	res = cProgram
	parser4End( )

	tmr = timer - tmr

	irFlush( )

	'' save
	emitClose( tmr )

	'' close src
	if( close( #env.inf ) <> 0 ) then
		'' ...
	end if

	'' check if any label undefined was used
	if( res = TRUE ) then
		l = symbCheckLabels
		if( l <> NULL ) then
			hReportErrorEx( FB.ERRMSG.UNDEFINEDLABEL, symbGetOrgName( l ), -1 )
			function = FALSE
		else
			function = TRUE
		end if
	else
		function = FALSE
	end if

end function

'':::::
function fbListLibs( namelist() as string, byval index as integer ) as integer
	dim i as integer

	function = symbListLibs( namelist(), index )

	if( env.clopt.multithreaded ) then
		for i = 0 to index-1
			if( namelist(i) = "fb" ) then
				namelist(i) = "fbmt"
				exit for
			end if
		next i
	end if

end function

'':::::
sub fbAddDefaultLibs( ) static
    dim lname as string

	if( env.clopt.nodeflibs ) then
		exit sub
    end if

	restore deflibsdata

	do
		read lname
		if( len( lname ) = 0 ) then
			exit do
		end if

		symbAddLib( lname )
	loop

end sub

''::::
function fbIncludeFile( byval filename as string, _
						byval isonce as integer ) as integer

    static as zstring * FB.MAXPATHLEN incfile
    dim as integer i

	function = FALSE

	if( env.reclevel >= FB.MAXINCRECLEVEL ) then
		hReportError( FB.ERRMSG.RECLEVELTOODEPTH )
		exit function
	end if

	'' open include file
	if( not hFileExists( filename ) ) then

		'' try finding it at the inc paths
		for i = env.incpaths-1 to 0 step -1

			incfile = incpathTB(i) + filename
			if( hFileExists( incfile ) ) then
				exit for
			end if

		next i

	else
		incfile = filename
	end if

	''
	if( not hFileExists( incfile ) ) then
		hReportErrorEx( FB.ERRMSG.FILENOTFOUND, "\"" + filename + "\"" )

	else

		''
		if( isonce ) then
        	if( fbFindIncFile( filename ) ) then
        		return TRUE
        	end if
		end if

		''
		fbAddIncFile( filename )

		''
		envcopyTB(env.reclevel) = env
		lexSaveCtx( env.reclevel )
    	env.reclevel += 1

		env.infile = filename

		''
		lexInit( )

		''
		env.inf = freefile
		if( open( incfile, for binary, access read, as #env.inf ) <> 0 ) then
			hReportErrorEx( FB.ERRMSG.FILENOTFOUND, "\"" + filename + "\"" )
			exit function
		end if

		''
		if( env.clopt.debug ) then
			irFlush( )
			edbgIncludeBegin( incfile )
		end if

		'' parse
		function = cProgram( )

		''
		if( env.clopt.debug ) then
			irFlush( )
			edbgIncludeEnd( )
		end if

		'' close it
		if( close( #env.inf ) <> 0 ) then
			'' ...
		end if

		''
		lexRestoreCtx( env.reclevel-1 )
		env = envcopyTB(env.reclevel-1)
	end if

end function

