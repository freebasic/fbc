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

'' globals
	dim shared infileTb( ) as FBFILE
	dim shared incpathTB( ) as zstring * FB_MAXPATHLEN+1
	dim shared incfileTB( ) as zstring * FB_MAXPATHLEN+1
	dim shared pathTB(0 to FB_MAXPATHS-1) as zstring * FB_MAXPATHLEN+1

'' const
#if defined(TARGET_WIN32) or defined(TARGET_DOS)
	const PATHDIV = "\\"
#else
	const PATHDIV = "/"
#endif


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

	if( env.incpaths < FB_MAXINCPATHS ) then
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

    symbAddDefine( dname, dtext, len( dtext ) )

end sub

'':::::
function fbFindIncFile( byval filename as string ) as integer static
	static as zstring * FB_MAXPATHLEN+1 fname
	dim as integer i

	fname = ucase$( filename )

	for i = 0 to env.incfiles-1
		if( incfileTB( i ) = fname ) then
			return TRUE
		end if
	next i

	function = FALSE

end function

'':::::
sub fbAddIncFile( byval filename as string ) static
    static as zstring * FB_MAXPATHLEN+1 fname
    dim as integer i

	fname = ucase$( filename )

	if( env.incfiles >= ubound( incfileTB ) ) then
		i = ubound( incfileTB )
		redim preserve incfileTB(0 to (i + (i \ 2))-1)
	end if

	if( not fbFindIncFile( fname ) ) then
		incfileTB( env.incfiles ) = fname
		env.incfiles += 1
	end if

end sub

'':::::
private sub hSetCtx

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
	env.withtext			= ""

	env.prntcnt				= 0
	env.prntopt				= FALSE
	env.varcheckarray		= TRUE

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
	redim infileTb( 0 to FB_MAXINCRECLEVEL-1 )

	redim incpathTB( 0 to FB_MAXINCPATHS-1 )

	redim incfileTB( 0 to FB_INITINCFILES-1 )

	''
	hSetCtx( )

	''
	function = TRUE

end function

'':::::
sub fbSetDefaultOptions

	env.clopt.debug			= FALSE
	env.clopt.cputype 		= FB_DEFAULTCPUTYPE
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
	env.clopt.naming		= FB_COMPNAMING_DEFAULT

end sub

public function fbGetNaming ( ) as integer
    dim naming_type as integer
    naming_type = fbGetOption(FB_COMPOPT_NAMING)
    if naming_type = FB_COMPNAMING_DEFAULT then
        select case fbGetOption(FB_COMPOPT_TARGET)
        case FB_COMPTARGET_WIN32
            naming_type = FB_COMPNAMING_WIN32

		case FB_COMPTARGET_LINUX
            naming_type = FB_COMPNAMING_LINUX

		case FB_COMPTARGET_DOS
            naming_type = FB_COMPNAMING_DOS

        case else
            print "Internal compiler error (1)"
            end 1

        end select
    end if
    return naming_type
end function

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

	erase infileTb

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
	env.inf.name	= infname
	env.outf.name	= outfname

	'' open source file
	if( not hFileExists( infname ) ) then
		hReportErrorEx( FB_ERRMSG_FILENOTFOUND, infname, -1 )
		exit function
	end if

	env.inf.num = freefile
	if( open( infname, for binary, access read, as #env.inf.num ) <> 0 ) then
		hReportErrorEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
		exit function
	end if

	''
	if( not emitOpen( ) ) then
		hReportErrorEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
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
	if( close( #env.inf.num ) <> 0 ) then
		'' ...
	end if

	'' check if any label undefined was used
	if( res = TRUE ) then
		l = symbCheckLabels
		if( l <> NULL ) then
			hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, symbGetOrgName( l ), -1 )
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

    static as zstring * FB_MAXPATHLEN incfile
    dim as integer i

	function = FALSE

	if( env.reclevel >= FB_MAXINCRECLEVEL ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
		exit function
	end if

	'' open include file
	if( not hFileExists( filename ) ) then

		'' try finding it at same path as env.infile
		incfile = hStripFilename( env.inf.name ) + PATHDIV + hStripPath( filename )
		if( not hFileExists( incfile ) ) then

			'' try finding it at the inc paths
			for i = env.incpaths-1 to 0 step -1

				incfile = incpathTB(i) + filename
				if( hFileExists( incfile ) ) then
					exit for
				end if

			next i
		end if

	else
		incfile = filename
	end if

	''
	if( not hFileExists( incfile ) ) then
		hReportErrorEx( FB_ERRMSG_FILENOTFOUND, "\"" + filename + "\"" )

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
		infileTb(env.reclevel) = env.inf
		lexSaveCtx( env.reclevel )
    	env.reclevel += 1

		env.inf.name = filename

		''
		lexInit( )

		''
		env.inf.num = freefile
		if( open( incfile, for binary, access read, as #env.inf.num ) <> 0 ) then
			hReportErrorEx( FB_ERRMSG_FILENOTFOUND, "\"" + filename + "\"" )
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
		if( close( #env.inf.num ) <> 0 ) then
			'' ...
		end if

		''
		env.reclevel -= 1
		lexRestoreCtx( env.reclevel )
		env.inf = infileTb( env.reclevel )
	end if

end function

