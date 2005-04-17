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


'' debug emiter (stabs format) for GNU assembler (GAS)
''
'' chng: nov/2004 written [v1ctor]

defint a-z
option explicit
option escape

'$include once:'inc\fb.bi'
'$include once:'inc\fbint.bi'
'$include once:'inc\lex.bi'
'$include once:'inc\emit.bi'
'$include once:'inc\emitdbg.bi'

const STABS = ".stabs "
const STABD = ".stabd "
const STABN = ".stabn "
const QUOTE = "\""

type EDBGCTX
	asmf			as integer
	modulename		as string
	entryname		as string

	mainopened		as integer
	mainclosed		as integer
	maininitlabel	as FBSYMBOL ptr
	mainoffs		as integer

	procinitline 	as integer
end type

declare sub 		edgbhCloseMain				( )

'' globals
	dim shared ctx as EDBGCTX


stabstdef:
data "integer:t1=1"
data "single:t2=2"
data "double:t3=3"
data "void:t4=4"

const STABS_TYPEDEFS = 4

'':::::
function hRevertSlash( byval s as string ) as string 'static
    dim c as string, i as integer
    dim res as string

	res = ""

	for i = 1 to len( s )

		c = mid$( s, i, 1 )
		if( asc( c ) = CHAR_RSLASH ) then
			res += chr$( CHAR_SLASH )
		else
			res += lcase$( c )
		end if

	next i

	hRevertSlash = res

end function

'':::::
sub edbgHeader( byval asmf as integer, _
				byval filename as string, _
				byval modulename as string, _
				byval entryname as string )
    dim i as integer
    dim s as string

	if( not env.clopt.debug ) then exit sub

	''
	ctx.asmf = asmf
	ctx.entryname = entryname
	ctx.modulename = modulename

	'' source file
    s = QUOTE + hRevertSlash( filename ) + QUOTE
    hWriteStr asmf, TRUE, ".file " + s
    if( instr( s, "/" ) = 0 ) then
    	hWriteStr asmf, TRUE, STABS + QUOTE + hRevertSlash( curdir$ + "/" ) + QUOTE + ",100,0,0,__stabini"
    end if
    hWriteStr asmf, TRUE, STABS + s + ",100,0,0,__stabini"

	'' type defs
	emitSECTION EMIT.SECTYPE.CODE
	hWriteStr asmf, FALSE, "__stabini:"

	hWriteStr asmf, TRUE, STABD + "68,0,    "
#ifdef TARGET_WIN32
	ctx.mainoffs = seek( asmf ) - (4+2)
#else
	'' under Unix newline is NL only so we need to adjust the position by 1, not 2
	ctx.mainoffs = seek( asmf ) - (4+1)
#endif

	restore stabstdef
	for i = 0 to STABS_TYPEDEFS-1
		read s
		hWriteStr asmf, TRUE, STABS + QUOTE + s + QUOTE + ",128,0,0,0"
	next i

	hWriteStr asmf, FALSE, ""
	hWriteStr asmf, TRUE, STABS + QUOTE + modulename + QUOTE + ",42,0,1," + entryname

end sub

'':::::
sub edbgFooter

	if( not env.clopt.debug ) then exit sub

	emitSECTION EMIT.SECTYPE.CODE

	if( ctx.mainopened and not ctx.mainclosed ) then
		edgbhCloseMain
	end if

	hWriteStr ctx.asmf, TRUE, STABS + QUOTE + QUOTE + ",100,0,0,__stabend"
	hWriteStr ctx.asmf, FALSE, "__stabend:"

end sub

'':::::
sub edbgMain( byval initlabel as FBSYMBOL ptr )

	if( not env.clopt.debug ) then exit sub

	ctx.mainclosed = FALSE
	ctx.maininitlabel = initlabel

end sub

'':::::
sub edgbhCloseMain
    dim exitlabel as FBSYMBOL ptr, currpos as integer
    dim lname as string

    ''
    currpos = seek( ctx.asmf )
    seek #ctx.asmf, ctx.mainoffs
    hWriteStr ctx.asmf, FALSE, str$( ctx.procinitline )
    seek #ctx.asmf, currpos

    ''
    exitlabel = symbAddLabel( hMakeTmpStr )

    lname = symbGetName( exitlabel )
    emitLABEL lname

    edbgProcEnd NULL, ctx.maininitlabel, exitlabel

	'''''symbDelLabel exitlabel

	ctx.mainclosed = TRUE

end sub

'':::::
sub edbgLine( byval lnum as integer, _
			  byval lname as string )
    dim procname as string

	if( not env.clopt.debug ) then exit sub

	if( not ctx.mainopened ) then
		edbgProcBegin NULL, FALSE, lnum
		ctx.mainopened = TRUE
		ctx.mainclosed = FALSE
	end if

	if( env.currproc <> NULL ) then
		procname = symbGetName( env.currproc )
	else
		procname = ctx.entryname
	end if

	hWriteStr ctx.asmf, TRUE, STABN + "68,0," + ltrim$( str$( lnum ) ) + "," + lname + "-" + procname

end sub

'':::::
sub edbgProcBegin ( byval proc as FBSYMBOL ptr, _
					byval ispublic as integer, _
					byval lnum as integer )
    dim realname as string, procname as string, prochar as string

	if( not env.clopt.debug ) then exit sub

	if( proc <> NULL ) then
		if( ctx.mainopened and not ctx.mainclosed ) then
			edgbhCloseMain
		end if

		realname = symbGetOrgName( proc )
		procname = symbGetName( proc )
	else
		realname = ctx.modulename
		procname = ctx.entryname
	end if

	if( ispublic ) then
		prochar = "F"
	else
		prochar = "f"
	end if

	if( lnum = -1 ) then
		ctx.procinitline = lexLineNum
	else
		ctx.procinitline = lnum
	end if

	hWriteStr ctx.asmf, TRUE, STABS + QUOTE + realname + ":" + prochar + "4" + QUOTE + ",36,0," + ltrim$( str$( ctx.procinitline ) ) + "," + procname

end sub

'':::::
sub edbgProcEnd ( byval proc as FBSYMBOL ptr, _
				  byval initlabel as FBSYMBOL ptr, _
				  byval exitlabel as FBSYMBOL ptr )
    dim procname as string, ininame as string, endname as string, lname as string
    dim iniline as integer, endline as integer

	if( not env.clopt.debug ) then exit sub

	iniline = ctx.procinitline
	endline = lexLineNum

	if( proc <> NULL ) then
		procname = symbGetName( proc )
	else
		procname = ctx.entryname
		endline -= 1
	end if

	ininame	 = symbGetName( initlabel )
	endname	 = symbGetName( exitlabel )

	hWriteStr ctx.asmf, TRUE, STABN + "192,0," + str$( iniline ) + "," + ininame + "-" + procname
	hWriteStr ctx.asmf, TRUE, STABN + "224,0," + str$( endline ) + "," + endname + "-" + procname

	lname = hMakeTmpStr
	emitLABEL lname
	hWriteStr ctx.asmf, TRUE, STABS + QUOTE+QUOTE + ",36,0,0," + lname + "-" + procname

end sub
