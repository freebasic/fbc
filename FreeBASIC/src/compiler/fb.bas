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

declare function cConstExprValue			( littext as string ) as integer

'' globals
	dim shared incfiles as integer			'' can't be on ENV as it is restored on recursion

	dim shared envcopyTB( ) as FBENV
	dim shared incpathTB( ) as string
	dim shared incfileTB( ) as string


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
#elseif defined(TARGET_DOS)
data "c"
data "gcc"
#endif
data ""

'':::::
sub fbAddIncPath( path as string )

	if( env.incpaths < FB.MAXINCPATHS ) then
		incpathTB( env.incpaths ) = path

#ifdef TARGET_WIN32
const PATHDIV = "\\"
#elseif TARGET_DOS
const PATHDIV = "\\"
#else
const PATHDIV = "/"
#endif
		if( right$( path, 1 ) <> PATHDIV ) then
			incpathTB( env.incpaths ) = incpathTB( env.incpaths ) + PATHDIV
		end if

		env.incpaths = env.incpaths + 1
	end if

end sub

'':::::
sub fbAddDefine( dname as string, dtext as string )

    symbAddDefine( dname, dtext )

end sub

'':::::
function fbFindIncFile( filename as string ) as integer
	dim i as integer
	dim fname as string

	fbFindIncFile = FALSE

	fname = ucase$( filename )

	for i = 0 to incfiles-1
		if( incfileTB( i ) = fname ) then
			fbFindIncFile = TRUE
			exit function
		end if
	next i

end function

'':::::
sub fbAddIncFile( filename as string )
    dim fname as string

	fname = ucase$( filename )

	if( incfiles < FB.MAXINCFILES ) then
		if( not fbFindIncFile( fname ) ) then
			incfileTB( incfiles ) = fname
			incfiles = incfiles + 1
		end if
	end if

end sub

'':::::
private sub hSetCtx

	env.scope			= 0
	env.reclevel		= 0
	env.currproc 		= NULL

	env.dbglname 		= ""
	env.dbglnum 		= 0
	env.dbgpos 			= 0

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
	env.withtextidx		= INVALID

	env.prntcnt			= 0
	env.prntopt			= FALSE

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
	fbAddIncPath exepath$ + FB.INCPATH
#else
	fbAddIncPath FB.INCPATH
#endif

end sub

'':::::
function fbInit as integer static

	''
	fbInit = FALSE

	''
	strpInit

	symbInit

	hlpInit

	astInit

	irInit

	rtlInit

	lexInit

	emitInit

	''
	redim envcopyTB( 0 to FB.MAXINCRECLEVEL-1 ) as FBENV

	redim incpathTB( 0 to FB.MAXINCPATHS-1 ) as string

	redim incfileTB( 0 to FB.MAXINCFILES-1 ) as string

	''
	hSetCtx

	''
	fbInit = TRUE

end function

'':::::
sub fbSetDefaultOptions

	env.clopt.debug			= FALSE
	env.clopt.cputype 		= FB.DEFAULTCPUTYPE
	env.clopt.errorcheck	= FALSE
	env.clopt.resumeerr 	= FALSE
	env.clopt.nostdcall 	= FALSE
	env.clopt.nounderprefix	= FALSE
	env.clopt.outtype		= FB_OUTTYPE_EXECUTABLE
	env.clopt.warninglevel 	= 0
	env.clopt.export		= TRUE
	env.clopt.nodeflibs		= FALSE
	env.clopt.showerror		= TRUE

end sub

'':::::
sub fbSetOption ( byval opt as integer, byval value as integer )

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
	end select

end sub

'':::::
function fbGetOption ( byval opt as integer ) as integer
    dim res as integer

	res = FALSE

	select case as const opt
	case FB.COMPOPT.DEBUG
		res = env.clopt.debug
	case FB.COMPOPT.CPUTYPE
		res = env.clopt.cputype
	case FB.COMPOPT.ERRORCHECK
		res = env.clopt.errorcheck
	case FB.COMPOPT.NOSTDCALL
		res = env.clopt.nostdcall
	case FB.COMPOPT.NOUNDERPREFIX
		res = env.clopt.nounderprefix
	case FB.COMPOPT.OUTTYPE
		res = env.clopt.outtype
	case FB.COMPOPT.RESUMEERROR
		res = env.clopt.resumeerr
	case FB.COMPOPT.WARNINGLEVEL
		res = env.clopt.warninglevel
	case FB.COMPOPT.EXPORT
		res = env.clopt.export
	case FB.COMPOPT.NODEFLIBS
		res = env.clopt.nodeflibs
	case FB.COMPOPT.SHOWERROR
		res = env.clopt.showerror
	end select

	fbGetOption = res

end function

'':::::
sub fbEnd

	''
	erase incpathTB

	erase incfileTB

	erase envcopyTB

	''
	emitEnd

	lexEnd

	rtlEnd

	irEnd

	astEnd

	hlpEnd

	symbEnd

	strpEnd

end sub

'':::::
function fbCompile ( infname as string, outfname as string )
    dim res as integer, l as FBSYMBOL ptr
	dim tmr as double

	fbCompile = FALSE

	''
	env.infile	= infname
	env.outfile	= outfname

	'' open source file
	if( not hFileExists( infname ) ) then
		hReportErrorEx FB.ERRMSG.FILENOTFOUND, infname, -1
		exit function
	end if

	env.inf = freefile
	open infname for binary access read as #env.inf

	''
	if( not emitOpen ) then
		hReportErrorEx FB.ERRMSG.FILEACCESSERROR, infname, -1
		exit function
	end if

	'' parse
	tmr = timer

	parser4Init
	res = cProgram
	parser4End

	tmr = timer - tmr

	irFlush

	'' save
	emitClose tmr

	'' close src
	close #env.inf

	'' check if any label undefined was used
	if( res = TRUE ) then
		l = symbCheckLabels
		if( l <> NULL ) then
			hReportErrorEx FB.ERRMSG.UNDEFINEDLABEL, symbGetOrgName( l ), -1
			res = FALSE
		else
			res = TRUE
		end if
	end if

	fbCompile = res

end function

'':::::
function fbListLibs( namelist() as string, byval index as integer ) as integer

	fbListLibs = symbListLibs( namelist(), index )

end function

'':::::
sub fbAddDefaultLibs
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

		symbAddLib lname
	loop

end sub

''::::
function fbIncludeFile( filename as string, byval isonce as integer ) as integer
    dim incfile as string
    dim i as integer

	fbIncludeFile = FALSE

	if( env.reclevel >= FB.MAXINCRECLEVEL ) then
		hReportError FB.ERRMSG.RECLEVELTOODEPTH
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
		hReportErrorEx FB.ERRMSG.FILENOTFOUND, "\"" + incfile + "\""

	else

		''
		if( isonce ) then
        	if( fbFindIncFile( filename ) ) then
        		fbIncludeFile = TRUE
        		exit function
        	end if
		end if

		''
		fbAddIncFile filename

		''
		envcopyTB(env.reclevel) = env
		lexSaveCtx env.reclevel
    	env.reclevel	= env.reclevel + 1

		env.infile		= filename

		''
		lexInit

		''
		env.inf = freefile
		open incfile for binary access read as #env.inf

		'' parse
		fbIncludeFile = cProgram

		'' close it
		close #env.inf

		''
		lexRestoreCtx env.reclevel-1
		env = envcopyTB(env.reclevel-1)
	end if

end function

