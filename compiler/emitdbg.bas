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

'$include:'inc\fb.bi'
'$include:'inc\fbint.bi'
'$include:'inc\lex.bi'
'$include:'inc\emit.bi'
'$include:'inc\emitdbg.bi'

const STABS = ".stabs "
const STABD = ".stabd "
const STABN = ".stabn "

type EDBGCTX
	asmf			as integer

	mainopened		as integer
	mainclosed		as integer
	maininitlabel	as FBSYMBOL ptr
	mainoffs		as integer
	procinitline 	as integer
end type

declare sub 		edgbhCloseMain				( )

'' globals
	dim shared QUOTE as string
	dim shared ctx as EDBGCTX


stabstdef:
data "integer:t1=1"
data "single:t2=2"
data "double:t3=3"
data "void:t4=4"

const STABS_TYPEDEFS = 4

'':::::
function hRevertSlash( s as string ) as string 'static
    dim c as string, i as integer
    dim res as string

	res = ""

	for i = 1 to len( s )

		c = mid$( s, i, 1 )
		if( asc( c ) = CHAR_RSLASH ) then
			res = res + chr$( CHAR_SLASH )
		else
			res = res + lcase$( c )
		end if

	next i

	hRevertSlash = res

end function

'':::::
sub edbgHeader( byval asmf as integer, filename as string )
    dim i as integer
    dim s as string

	if( not env.clopt.debug ) then exit sub

	''
	ctx.asmf = asmf

	QUOTE = chr$( CHAR_QUOTE )

	'' source file
    s = QUOTE + hRevertSlash( filename ) + QUOTE
    hWriteStr asmf, TRUE, ".file " + s
    if( instr( s, "/" ) = 0 ) then
    	hWriteStr asmf, TRUE, STABS + QUOTE + hRevertSlash( curdir$ + "/" ) + QUOTE + ",100,0,0,__stabini"
    end if
    hWriteStr asmf, TRUE, STABS + s + ",100,0,0,__stabini"

	'' type defs
	hWriteStr asmf, FALSE, ".section .text"
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
	hWriteStr asmf, TRUE, STABS + QUOTE + EMIT_MAINPROC + QUOTE + ",42,0,1," + EMIT_MAINPROC

end sub

'':::::
sub edbgFooter

	if( not env.clopt.debug ) then exit sub

	hWriteStr ctx.asmf, FALSE, ""
	hWriteStr ctx.asmf, FALSE, ".section .text"

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
    hWriteStr ctx.asmf, FALSE, ltrim$( str$( ctx.procinitline ) )
    seek #ctx.asmf, currpos

    ''
    exitlabel = symbAddLabel( hMakeTmpStr )

    lname = symbGetLabelName( exitlabel )
    emitLABEL lname, FALSE

    edbgProcEnd NULL, ctx.maininitlabel, exitlabel

	'''''symbDelLabel exitlabel

	ctx.mainclosed = TRUE

end sub

'':::::
sub edbgLine( byval lnum as integer, lname as string )
    dim procname as string

	if( not env.clopt.debug ) then exit sub

	if( not ctx.mainopened ) then
		edbgProcBegin NULL, FALSE, lnum
		ctx.mainopened = TRUE
		ctx.mainclosed = FALSE
	end if

	if( env.currproc <> NULL ) then
		procname = symbGetProcName( env.currproc )
	else
		procname = EMIT_MAINPROC
	end if

	hWriteStr ctx.asmf, TRUE, STABN + "68,0," + ltrim$( str$( lnum ) ) + "," + lname + "-" + procname

end sub

'':::::
sub edbgProcBegin ( byval proc as FBSYMBOL ptr, byval ispublic as integer, byval lnum as integer )
    dim realname as string, procname as string, prochar as string

	if( not env.clopt.debug ) then exit sub

	if( proc <> NULL ) then
		if( ctx.mainopened and not ctx.mainclosed ) then
			edgbhCloseMain
		end if

		realname = symbGetName( proc )
		procname = symbGetProcName( proc )
	else
		realname = EMIT_MAINPROC
		procname = EMIT_MAINPROC
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
sub edbgProcEnd ( byval proc as FBSYMBOL ptr, byval initlabel as FBSYMBOL ptr, byval exitlabel as FBSYMBOL ptr )
    dim procname as string, ininame as string, endname as string, lname as string
    dim iniline as integer, endline as integer

	if( not env.clopt.debug ) then exit sub

	if( proc <> NULL ) then
		procname = symbGetProcName( proc )
		iniline = ctx.procinitline
		endline = lexLineNum
	else
		procname = EMIT_MAINPROC
		iniline = 0
		endline = 0
	end if

	ininame	 = symbGetLabelName( initlabel )
	endname	 = symbGetLabelName( exitlabel )


	hWriteStr ctx.asmf, TRUE, STABN + "192,0," + ltrim$( str$( iniline ) ) + "," + ininame + "-" + procname
	hWriteStr ctx.asmf, TRUE, STABN + "224,0," + ltrim$( str$( endline ) ) + "," + endname + "-" + procname

	lname = hMakeTmpStr
	emitLABEL lname, FALSE
	hWriteStr ctx.asmf, TRUE, STABS + QUOTE+QUOTE + ",36,0,0," + lname + "-" + procname

end sub
