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


'' symbol table module
''
'' chng: sep/2004 written [v1ctor]

option explicit

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\hash.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'

type SYMBLIST
	nodes			as integer
	fhead			as integer
	head			as integer
	tail			as integer
end type

type SYMBCTX
	inited			as integer

	sym				as SYMBLIST
	locsym			as SYMBLIST
	elm				as SYMBLIST
	vdim			as SYMBLIST
	arg				as SYMBLIST
	lib				as SYMBLIST

	lastlbl			as integer
end type


declare function 	hCreateName		( symbol as string, byval typ as integer ) as string
declare function 	hCreateNameEx	( symbol as string, byval typ as integer, byval preservecase as integer, _
								      byval addunderscore as integer, byval clearname as integer ) as string

declare function 	hCalcDiff		( byval dimensions as integer, dTB() as FBARRAYDIM, byval lgt as integer ) as long

declare function 	hCalcElements2	( byval dimensions as integer, dTB() as FBARRAYDIM ) as long


''globals
	dim shared ctx as SYMBCTX

	redim shared symbolTB( 0 ) as FBSYMBOL, symbhashTB( 0 ) as HASHTB

	redim shared locsymbolTB( 0 ) as FBLOCSYMBOL, locsymbhashTB( 0 ) as HASHTB

	redim shared keywordTB( 0 ) as FBKEYWORD, keyhashTB( 0 ) as HASHTB

	redim shared typelmTB( 0 ) as FBTYPELEMENT

	redim shared dimTB( 0 ) as FBVARDIM

	redim shared argTB( 0 ) as FBPROCARG

	redim shared libTB( 0 ) as FBLIBRARY, libhashTB( 0 ) as HASHTB


'' keywords: name, id (token), class
keyworddata:
data "AND"		, FB.TK.AND			, FB.TKCLASS.OPERATOR
data "OR"		, FB.TK.OR			, FB.TKCLASS.OPERATOR
data "XOR"		, FB.TK.XOR			, FB.TKCLASS.OPERATOR
data "EQV"		, FB.TK.EQV			, FB.TKCLASS.OPERATOR
data "IMP"		, FB.TK.IMP			, FB.TKCLASS.OPERATOR
data "NOT"		, FB.TK.NOT			, FB.TKCLASS.OPERATOR
data "REM"		, FB.TK.REM			, FB.TKCLASS.KEYWORD
data "DIM"		, FB.TK.DIM			, FB.TKCLASS.KEYWORD
data "STATIC"	, FB.TK.STATIC		, FB.TKCLASS.KEYWORD
data "SHARED"	, FB.TK.SHARED		, FB.TKCLASS.KEYWORD
data "INTEGER"	, FB.TK.INTEGER		, FB.TKCLASS.KEYWORD
data "LONG"		, FB.TK.LONG		, FB.TKCLASS.KEYWORD
data "SINGLE"	, FB.TK.SINGLE		, FB.TKCLASS.KEYWORD
data "DOUBLE"	, FB.TK.DOUBLE		, FB.TKCLASS.KEYWORD
data "STRING"	, FB.TK.STRING		, FB.TKCLASS.KEYWORD
data "CALL"		, FB.TK.CALL		, FB.TKCLASS.KEYWORD
data "CALLS"	, FB.TK.CALLS		, FB.TKCLASS.KEYWORD
data "BYVAL"	, FB.TK.BYVAL		, FB.TKCLASS.KEYWORD
data "SEG"		, FB.TK.SEG			, FB.TKCLASS.KEYWORD
data "INCLUDE"	, FB.TK.INCLUDE		, FB.TKCLASS.KEYWORD
data "DYNAMIC"	, FB.TK.DYNAMIC		, FB.TKCLASS.KEYWORD
data "AS"		, FB.TK.AS			, FB.TKCLASS.KEYWORD
data "DECLARE"	, FB.TK.DECLARE		, FB.TKCLASS.KEYWORD
data "GOTO"		, FB.TK.GOTO		, FB.TKCLASS.KEYWORD
data "GOSUB"	, FB.TK.GOSUB		, FB.TKCLASS.KEYWORD
data "DEFINT"	, FB.TK.DEFINT		, FB.TKCLASS.KEYWORD
data "DEFLNG"	, FB.TK.DEFLNG		, FB.TKCLASS.KEYWORD
data "DEFSNG"	, FB.TK.DEFSNG		, FB.TKCLASS.KEYWORD
data "DEFDBL"	, FB.TK.DEFDBL		, FB.TKCLASS.KEYWORD
data "DEFSTR"	, FB.TK.DEFSTR		, FB.TKCLASS.KEYWORD
data "CONST"	, FB.TK.CONST		, FB.TKCLASS.KEYWORD
data "FOR"		, FB.TK.FOR			, FB.TKCLASS.KEYWORD
data "STEP"		, FB.TK.STEP		, FB.TKCLASS.KEYWORD
data "NEXT"		, FB.TK.NEXT		, FB.TKCLASS.KEYWORD
data "TO"		, FB.TK.TO			, FB.TKCLASS.KEYWORD
data "MOD"		, FB.TK.MOD			, FB.TKCLASS.KEYWORD
data "TYPE"		, FB.TK.TYPE		, FB.TKCLASS.KEYWORD
data "END"		, FB.TK.END			, FB.TKCLASS.KEYWORD
data "SUB"		, FB.TK.SUB			, FB.TKCLASS.KEYWORD
data "FUNCTION"	, FB.TK.FUNCTION	, FB.TKCLASS.KEYWORD
data "CDECL"	, FB.TK.CDECL		, FB.TKCLASS.KEYWORD
data "STDCALL"	, FB.TK.STDCALL		, FB.TKCLASS.KEYWORD
data "ALIAS"	, FB.TK.ALIAS		, FB.TKCLASS.KEYWORD
data "LIB"		, FB.TK.LIB			, FB.TKCLASS.KEYWORD
data "LET"		, FB.TK.LET			, FB.TKCLASS.KEYWORD
data "BYTE"		, FB.TK.BYTE		, FB.TKCLASS.KEYWORD
data "UBYTE"	, FB.TK.UBYTE		, FB.TKCLASS.KEYWORD
data "SHORT"	, FB.TK.SHORT		, FB.TKCLASS.KEYWORD
data "USHORT"	, FB.TK.USHORT		, FB.TKCLASS.KEYWORD
data "UINTEGER"	, FB.TK.UINT		, FB.TKCLASS.KEYWORD
data "DEFBYTE"	, FB.TK.DEFBYTE		, FB.TKCLASS.KEYWORD
data "DEFUBYTE"	, FB.TK.DEFUBYTE	, FB.TKCLASS.KEYWORD
data "DEFSHORT"	, FB.TK.DEFSHORT	, FB.TKCLASS.KEYWORD
data "DEFUSHORT", FB.TK.DEFUSHORT	, FB.TKCLASS.KEYWORD
data "DEFUINT"	, FB.TK.DEFUINT		, FB.TKCLASS.KEYWORD
data "EXIT"		, FB.TK.EXIT		, FB.TKCLASS.KEYWORD
data "DO"		, FB.TK.DO			, FB.TKCLASS.KEYWORD
data "LOOP"		, FB.TK.LOOP		, FB.TKCLASS.KEYWORD
data "RETURN"	, FB.TK.RETURN		, FB.TKCLASS.KEYWORD
data "ANY"		, FB.TK.ANY			, FB.TKCLASS.KEYWORD
data "PTR"		, FB.TK.PTR			, FB.TKCLASS.KEYWORD
data "POINTER"	, FB.TK.POINTER		, FB.TKCLASS.KEYWORD
data "VARPTR"	, FB.TK.VARPTR		, FB.TKCLASS.KEYWORD
data "SHL"		, FB.TK.SHL			, FB.TKCLASS.OPERATOR
data "SHR"		, FB.TK.SHR			, FB.TKCLASS.OPERATOR
data "WHILE"	, FB.TK.WHILE		, FB.TKCLASS.KEYWORD
data "UNTIL"	, FB.TK.UNTIL		, FB.TKCLASS.KEYWORD
data "WEND"		, FB.TK.WEND		, FB.TKCLASS.KEYWORD
data "CONTINUE"	, FB.TK.CONTINUE	, FB.TKCLASS.KEYWORD
data "CINT"		, FB.TK.CINT		, FB.TKCLASS.KEYWORD
data "CLNG"		, FB.TK.CLNG		, FB.TKCLASS.KEYWORD
data "CSNG"		, FB.TK.CSNG		, FB.TKCLASS.KEYWORD
data "CDBL"		, FB.TK.CDBL		, FB.TKCLASS.KEYWORD
data "CBYTE"	, FB.TK.CBYTE		, FB.TKCLASS.KEYWORD
data "CSHORT"	, FB.TK.CSHORT		, FB.TKCLASS.KEYWORD
data "CSIGN"	, FB.TK.CSIGN		, FB.TKCLASS.KEYWORD
data "CUNSG"	, FB.TK.CUNSG		, FB.TKCLASS.KEYWORD
data "IF"		, FB.TK.IF			, FB.TKCLASS.KEYWORD
data "THEN"		, FB.TK.THEN		, FB.TKCLASS.KEYWORD
data "ELSE"		, FB.TK.ELSE		, FB.TKCLASS.KEYWORD
data "ELSEIF"	, FB.TK.ELSEIF		, FB.TKCLASS.KEYWORD
data "SELECT"	, FB.TK.SELECT		, FB.TKCLASS.KEYWORD
data "CASE"		, FB.TK.CASE		, FB.TKCLASS.KEYWORD
data "IS"		, FB.TK.IS			, FB.TKCLASS.KEYWORD
data "UNSIGNED"	, FB.TK.UNSIGNED	, FB.TKCLASS.KEYWORD
data "REDIM"	, FB.TK.REDIM		, FB.TKCLASS.KEYWORD
data "ERASE"	, FB.TK.ERASE		, FB.TKCLASS.KEYWORD
data "LBOUND"	, FB.TK.LBOUND		, FB.TKCLASS.KEYWORD
data "UBOUND"	, FB.TK.UBOUND		, FB.TKCLASS.KEYWORD
data "UNION"	, FB.TK.UNION		, FB.TKCLASS.KEYWORD
data "PUBLIC"	, FB.TK.PUBLIC		, FB.TKCLASS.KEYWORD
data "PRIVATE"	, FB.TK.PRIVATE		, FB.TKCLASS.KEYWORD
data "STR"		, FB.TK.STR			, FB.TKCLASS.KEYWORD
data "INSTR"	, FB.TK.INSTR		, FB.TKCLASS.KEYWORD
data "MID"		, FB.TK.MID			, FB.TKCLASS.KEYWORD
data "BYREF"	, FB.TK.BYREF		, FB.TKCLASS.KEYWORD
data "OPTION"	, FB.TK.OPTION		, FB.TKCLASS.KEYWORD
data "BASE"		, FB.TK.BASE		, FB.TKCLASS.KEYWORD
data "EXPLICIT"	, FB.TK.EXPLICIT	, FB.TKCLASS.KEYWORD
data "PASCAL"	, FB.TK.PASCAL		, FB.TKCLASS.KEYWORD
data "PROCPTR"	, FB.TK.PROCPTR		, FB.TKCLASS.KEYWORD
data "SADD"		, FB.TK.SADD		, FB.TKCLASS.KEYWORD
data "RESTORE"	, FB.TK.RESTORE		, FB.TKCLASS.KEYWORD
data "READ"		, FB.TK.READ		, FB.TKCLASS.KEYWORD
data "DATA"		, FB.TK.DATA		, FB.TKCLASS.KEYWORD
data "ABS"		, FB.TK.ABS			, FB.TKCLASS.KEYWORD
data "SGN"		, FB.TK.SGN			, FB.TKCLASS.KEYWORD
data "FIX"		, FB.TK.FIX			, FB.TKCLASS.KEYWORD
data "PRINT"	, FB.TK.PRINT		, FB.TKCLASS.KEYWORD
data "USING"	, FB.TK.USING		, FB.TKCLASS.KEYWORD
data "LEN"		, FB.TK.LEN			, FB.TKCLASS.KEYWORD
data "PEEK"		, FB.TK.PEEK		, FB.TKCLASS.KEYWORD
data "PEEKS"	, FB.TK.PEEKS		, FB.TKCLASS.KEYWORD
data "PEEKI"	, FB.TK.PEEKI		, FB.TKCLASS.KEYWORD
data "POKE"		, FB.TK.POKE		, FB.TKCLASS.KEYWORD
data "POKES"	, FB.TK.POKES		, FB.TKCLASS.KEYWORD
data "POKEI"	, FB.TK.POKEI		, FB.TKCLASS.KEYWORD
data "SWAP"		, FB.TK.SWAP		, FB.TKCLASS.KEYWORD
data "COMMON"	, FB.TK.COMMON		, FB.TKCLASS.KEYWORD
data "OPEN"		, FB.TK.OPEN		, FB.TKCLASS.KEYWORD
data "CLOSE"	, FB.TK.CLOSE		, FB.TKCLASS.KEYWORD
data "SEEK"		, FB.TK.SEEK		, FB.TKCLASS.KEYWORD
data "PUT"		, FB.TK.PUT			, FB.TKCLASS.KEYWORD
data "GET"		, FB.TK.GET			, FB.TKCLASS.KEYWORD
data "ACCESS"	, FB.TK.ACCESS		, FB.TKCLASS.KEYWORD
data "WRITE"	, FB.TK.WRITE		, FB.TKCLASS.KEYWORD
data "LOCK"		, FB.TK.LOCK		, FB.TKCLASS.KEYWORD
data "INPUT"	, FB.TK.INPUT		, FB.TKCLASS.KEYWORD
data "OUTPUT"	, FB.TK.OUTPUT		, FB.TKCLASS.KEYWORD
data "BINARY"	, FB.TK.BINARY		, FB.TKCLASS.KEYWORD
data "RANDOM"	, FB.TK.RANDOM		, FB.TKCLASS.KEYWORD
data "APPEND"	, FB.TK.APPEND		, FB.TKCLASS.KEYWORD
data "PRESERVE"	, FB.TK.PRESERVE	, FB.TKCLASS.KEYWORD
data "ON"		, FB.TK.ON			, FB.TKCLASS.KEYWORD
data "ERROR"	, FB.TK.ERROR		, FB.TKCLASS.KEYWORD
data "ENUM"		, FB.TK.ENUM		, FB.TKCLASS.KEYWORD
data "INCLIB"	, FB.TK.INCLIB		, FB.TKCLASS.KEYWORD
data "ASM"		, FB.TK.ASM			, FB.TKCLASS.KEYWORD
data "SPC"		, FB.TK.SPC			, FB.TKCLASS.KEYWORD
data "TAB"		, FB.TK.TAB			, FB.TKCLASS.KEYWORD
data "LINE"		, FB.TK.LINE		, FB.TKCLASS.KEYWORD
data "VIEW"		, FB.TK.VIEW		, FB.TKCLASS.KEYWORD
data "UNLOCK"	, FB.TK.UNLOCK		, FB.TKCLASS.KEYWORD
data "FIELD"	, FB.TK.FIELD		, FB.TKCLASS.KEYWORD
data "LOCAL"	, FB.TK.LOCAL		, FB.TKCLASS.KEYWORD
data "ERR"		, FB.TK.ERR			, FB.TKCLASS.KEYWORD

const FB.MAXKEYWORDS 		= 146

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' linked-lists
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbReallocSymbolTB( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.sym.nodes
	ub = ctx.sym.nodes + (nodes - 1)

	redim preserve symbolTB( 0 to ub ) as FBSYMBOL

	for i = lb to ub
		symbolTB(i).prv  = i-1
		symbolTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		symbolTB(lb).prv = INVALID
	end if

	symbolTB(ub).nxt = INVALID

	''
	ctx.sym.nodes = ctx.sym.nodes + nodes
	ctx.sym.fhead = lb

end sub

'':::::
function symbNewSymbolNode as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.sym.fhead = INVALID ) Then
		symbReallocSymbolTB ctx.sym.nodes \ 2
	end if

	'' take from free list
	n = ctx.sym.fhead
	ctx.sym.fhead = symbolTB(n).nxt

	'' add to used list
	t = ctx.sym.tail
	ctx.sym.tail = n
	if( t <> INVALID ) then
		symbolTB(t).nxt = n
	else
		ctx.sym.head = n
	end If

	symbolTB(n).prv	= t
	symbolTB(n).nxt	= INVALID

	''
	symbNewSymbolNode = n

end function

'':::::
sub symbDelSymbolNode( byval n as integer ) static
	Dim pn as integer, nn as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' remove from used list
	pn = symbolTB(n).prv
	nn = symbolTB(n).nxt
	if( pn <> INVALID ) then
		symbolTB(pn).nxt = nn
	else
		ctx.sym.head = nn
	end If

	if( nn <> INVALID ) then
		symbolTB(nn).prv = pn
	else
		ctx.sym.tail = pn
	end If

	'' add to free list
	symbolTB(n).nxt = ctx.sym.fhead
	ctx.sym.fhead = n

end sub


'':::::
sub symbReallocLocSymbolTB( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.locsym.nodes
	ub = ctx.locsym.nodes + (nodes - 1)

	redim preserve locsymbolTB( 0 to ub ) as FBLOCSYMBOL

	for i = lb to ub
		locsymbolTB(i).prv  = i-1
		locsymbolTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		locsymbolTB(lb).prv = INVALID
	end if

	locsymbolTB(ub).nxt = INVALID

	''
	ctx.locsym.nodes = ctx.locsym.nodes + nodes
	ctx.locsym.fhead = lb

end sub

'':::::
function symbNewLocSymbolNode as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.locsym.fhead = INVALID ) Then
		symbReallocLocSymbolTB ctx.locsym.nodes \ 2
	end if

	'' take from free list
	n = ctx.locsym.fhead
	ctx.locsym.fhead = locsymbolTB(n).nxt

	'' add to used list
	t = ctx.locsym.tail
	ctx.locsym.tail = n
	if( t <> INVALID ) then
		locsymbolTB(t).nxt = n
	else
		ctx.locsym.head = n
	end If

	locsymbolTB(n).prv	= t
	locsymbolTB(n).nxt	= INVALID

	''
	symbNewLocSymbolNode = n

end function

'':::::
sub symbDelLocSymbolNode( byval n as integer ) static
	Dim pn as integer, nn as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' remove from used list
	pn = locsymbolTB(n).prv
	nn = locsymbolTB(n).nxt
	if( pn <> INVALID ) then
		locsymbolTB(pn).nxt = nn
	else
		ctx.locsym.head = nn
	end If

	if( nn <> INVALID ) then
		locsymbolTB(nn).prv = pn
	else
		ctx.locsym.tail = pn
	end If

	'' add to free list
	locsymbolTB(n).nxt = ctx.locsym.fhead
	ctx.locsym.fhead = n

end sub


'':::::
sub symbReallocArgTB( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.arg.nodes
	ub = ctx.arg.nodes + (nodes - 1)

	redim preserve argTB( 0 to ub ) as FBPROCARG

	for i = lb to ub
		argTB(i).prv  = i-1
		argTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		argTB(lb).prv = INVALID
	end if

	argTB(ub).nxt = INVALID

	''
	ctx.arg.nodes = ctx.arg.nodes + nodes
	ctx.arg.fhead = lb

end sub

'':::::
function symbNewArgNode as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.arg.fhead = INVALID ) Then
		symbReallocArgTB ctx.arg.nodes \ 2
	end if

	'' take from free list
	n = ctx.arg.fhead
	ctx.arg.fhead = argTB(n).nxt

	'' add to used list
	t = ctx.arg.tail
	ctx.arg.tail = n
	if( t <> INVALID ) then
		argTB(t).nxt = n
	else
		ctx.arg.head = n
	end If

	argTB(n).prv	= t
	argTB(n).nxt	= INVALID

	''
	symbNewArgNode = n

end function


'':::::
sub symbReallocElmTB( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.elm.nodes
	ub = ctx.elm.nodes + (nodes - 1)

	redim preserve typelmTB( 0 to ub ) as FBTYPELEMENT

	for i = lb to ub
		typelmTB(i).prv  = i-1
		typelmTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		typelmTB(lb).prv = INVALID
	end if

	typelmTB(ub).nxt = INVALID

	''
	ctx.elm.nodes = ctx.elm.nodes + nodes
	ctx.elm.fhead = lb

end sub

'':::::
function symbNewElmNode as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.elm.fhead = INVALID ) Then
		symbReallocElmTB ctx.elm.nodes \ 2
	end if

	'' take from free list
	n = ctx.elm.fhead
	ctx.elm.fhead = typelmTB(n).nxt

	'' add to used list
	t = ctx.elm.tail
	ctx.elm.tail = n
	if( t <> INVALID ) then
		typelmTB(t).nxt = n
	else
		ctx.elm.head = n
	end If

	typelmTB(n).prv	= t
	typelmTB(n).nxt	= INVALID

	''
	symbNewElmNode = n

end function


'':::::
sub symbReallocLibTB( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.lib.nodes
	ub = ctx.lib.nodes + (nodes - 1)

	redim preserve libTB( 0 to ub ) as FBLIBRARY

	for i = lb to ub
		libTB(i).prv  = i-1
		libTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		libTB(lb).prv = INVALID
	end if

	libTB(ub).nxt = INVALID

	''
	ctx.lib.nodes = ctx.lib.nodes + nodes
	ctx.lib.fhead = lb

end sub

'':::::
function symbNewLibNode as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.lib.fhead = INVALID ) Then
		symbReallocLibTB ctx.lib.nodes \ 2
	end if

	'' take from free list
	n = ctx.lib.fhead
	ctx.lib.fhead = libTB(n).nxt

	'' add to used list
	t = ctx.lib.tail
	ctx.lib.tail = n
	if( t <> INVALID ) then
		libTB(t).nxt = n
	else
		ctx.lib.head = n
	end If

	libTB(n).prv	= t
	libTB(n).nxt	= INVALID

	''
	symbNewLibNode = n

end function


'':::::
sub symbReallocDimTB( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.vdim.nodes
	ub = ctx.vdim.nodes + (nodes - 1)

	redim preserve dimTB( 0 to ub ) as FBVARDIM

	for i = lb to ub
		dimTB(i).prv  = i-1
		dimTB(i).nxt  = i+1
	next i

	if( lb = 0 ) then
		dimTB(lb).prv = INVALID
	end if

	dimTB(ub).nxt = INVALID

	''
	ctx.vdim.nodes = ctx.vdim.nodes + nodes
	ctx.vdim.fhead = lb

end sub

'':::::
function symbNewDimNode as integer static
	dim n as integer, t as integer

	'' realloc node list if it's full
	if( ctx.vdim.fhead = INVALID ) Then
		symbReallocDimTB ctx.vdim.nodes \ 2
	end if

	'' take from free list
	n = ctx.vdim.fhead
	ctx.vdim.fhead = dimTB(n).nxt

	'' add to used list
	t = ctx.vdim.tail
	ctx.vdim.tail = n
	if( t <> INVALID ) then
		dimTB(t).nxt = n
	else
		ctx.vdim.head = n
	end If

	dimTB(n).prv	= t
	dimTB(n).nxt	= INVALID

	''
	symbNewDimNode = n

end function

'':::::
sub symbDelDimNode( byval n as integer ) static
	Dim pn as integer, nn as integer

	if( n = INVALID ) then
		exit sub
	end if

	'' remove from used list
	pn = dimTB(n).prv
	nn = dimTB(n).nxt
	if( pn <> INVALID ) then
		dimTB(pn).nxt = nn
	else
		ctx.vdim.head = nn
	end If

	if( nn <> INVALID ) then
		dimTB(nn).prv = pn
	else
		ctx.vdim.tail = pn
	end If

	'' add to free list
	dimTB(n).nxt = ctx.vdim.fhead
	ctx.vdim.fhead = n

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init/end
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbInitSymbols static

	'' global/module-level
	ctx.sym.nodes 	= 0
	ctx.sym.head	= INVALID
	ctx.sym.tail	= INVALID

	symbReallocSymbolTB FB.INITSYMBOLNODES

	hashNew symbhashTB(), FB.INITSYMBOLNODES

	'' local vars
	ctx.locsym.nodes 	= 0
	ctx.locsym.head		= INVALID
	ctx.locsym.tail		= INVALID

	symbReallocLocSymbolTB FB.INITLOCSYMBOLNODES

	hashNew locsymbhashTB(), FB.INITLOCSYMBOLNODES

end sub

'':::::
sub symbInitArgs static

	ctx.arg.nodes 	= 0
	ctx.arg.head	= INVALID
	ctx.arg.tail	= INVALID

	symbReallocArgTB FB.INITARGNODES

end sub

'':::::
sub symbInitElms static

	ctx.elm.nodes 	= 0
	ctx.elm.head	= INVALID
	ctx.elm.tail	= INVALID

	symbReallocElmTB FB.INITELEMENTNODES

end sub

'':::::
sub symbInitDims static

	ctx.vdim.nodes 	= 0
	ctx.vdim.head	= INVALID
	ctx.vdim.tail	= INVALID

	symbReallocDimTB FB.INITDIMNODES

end sub

'':::::
sub symbInitLibs static

	ctx.lib.nodes 	= 0
	ctx.lib.head	= INVALID
	ctx.lib.tail	= INVALID

	symbReallocLibTB FB.INITLIBNODES

    hashNew libhashTB(), FB.INITLIBNODES

end sub

'':::::
sub symbInit
	dim i as integer, sname as string

	''
	if( ctx.inited ) then
		exit sub
	end if


	''
	hashInit

	''
	'' keywords
	redim keywordTB( 0 to FB.MAXKEYWORDS-1 ) as FBKEYWORD

    hashNew keyhashTB(), FB.MAXKEYWORDS

	restore keyworddata
	for i = 0 to FB.MAXKEYWORDS-1
    	read sname
    	keywordTB(i).nameidx = strpAdd( sname )
    	read keywordTB(i).id
    	read keywordTB(i).class
    	hashAdd sname, i, keywordTB(i).nameidx, keyhashTB(), FB.MAXKEYWORDS
    next i

	''
	'' vars, arrays, procs & consts
	''
	symbInitSymbols

	''
	'' proc args tb
	''
	symbInitArgs

    ''
    '' type elements
    ''
    symbInitElms

	''
	'' arrays dim tb
	''
	symbInitDims

	''
	'' libraries
	''
	symbInitLibs

    ''
    ctx.inited 	= TRUE

end sub

'':::::
sub symbEnd

    if( not ctx.inited ) then
    	exit sub
    end if

    ''
    hashFree keyhashTB(), FB.MAXKEYWORDS

	hashFree libhashTB(), FB.INITLIBNODES

	hashFree locsymbhashTB(), FB.INITLOCSYMBOLNODES

    hashFree symbhashTB(), FB.INITSYMBOLNODES

	''
	erase libTB

	erase typelmTB

	erase argTB

	erase dimTB

	erase keywordTB

	erase locsymbolTB

	erase symbolTB

	''
	ctx.inited = FALSE

end sub

'':::::
sub hStrReplace( src as string, oldchar as string, newchar as string ) static
    dim p as integer

	p = 0
	do while( p <= len( src ) )
		p = instr( p+1, src, oldchar )
		if( p = 0 ) then exit do
		mid$( src, p, 1 ) = newchar
	loop

end sub

'':::::
function hCreateNameEx( symbol as string, byval typ as integer, _
						byval preservecase as integer, _
						byval addunderscore as integer, byval clearname as integer ) as string static
    dim nm as string

	if( addunderscore ) then
		nm = "_"
	else
		nm = ""
	end if

	nm = nm + symbol

	if( not preservecase ) then
		nm = ucase$( nm )
	end if

    if( clearname ) then
    	hClearName nm
    end if

    if( (typ <> INVALID) and (typ < 128) ) then
    	nm = nm + "_" + chr$( 97 + typ )
    end if

	hCreateNameEx = nm

end function

'':::::
function hCreateName( symbol as string, byval typ as integer ) as string static

	hCreateName = hCreateNameEx( symbol, typ, FALSE, TRUE, TRUE )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetLastLabel as integer static

	symbGetLastLabel = ctx.lastlbl

end function

'':::::
sub symbSetLastLabel( byval l as integer ) static

	ctx.lastlbl = l

end sub


'':::::
function hNewSymbol( symbol as string, aliasname as string, byval class as integer, byval isglobal as integer ) as integer static
    dim l as integer, s as integer

    hNewSymbol = INVALID

    '' symbol already exists?
    if( isglobal ) then
    	s = hashLookup( symbol, symbhashTB(), FB.INITSYMBOLNODES )
    else
    	s = hashLookup( symbol, locsymbhashTB(), FB.INITLOCSYMBOLNODES )
    end if

    if( s <> INVALID ) then
    	exit function
    end if

    s = symbNewSymbolNode
    if( s = INVALID ) then
    	exit function
    end if

    ''
    symbolTB(s).class		= class
    symbolTB(s).typ			= INVALID
    symbolTB(s).subtype		= INVALID
	symbolTB(s).alloctype	= 0

    symbolTB(s).nameidx	= strpAdd( symbol )
    if( len( aliasname ) > 0 ) then
    	symbolTB(s).aliasidx = strpAdd( aliasname )
    else
    	symbolTB(s).aliasidx= INVALID
    end if

    symbolTB(s).initialized = FALSE
    symbolTB(s).inittextidx	= INVALID

	'' add node to local symbol table for fast deletion later
	if( not isglobal ) then
		l = symbNewLocSymbolNode
		locsymbolTB(l).s = s
	end if

    ''
    hNewSymbol = s

end function

'':::::
function hCreateArrayDesc( byval s as integer, byval dimensions as integer) as integer static
    dim sname as string, aname as string, d as integer
    dim lgt as integer, isshared as integer, isstatic as integer

	hCreateArrayDesc = INVALID

	isshared = (symbolTB(s).alloctype and FB.ALLOCTYPE.SHARED) > 0
	isstatic = (symbolTB(s).alloctype and FB.ALLOCTYPE.STATIC) > 0

	sname = hMakeTmpStr

	if( (env.scope = 0) or (isshared) or (isstatic) ) then
		aname = ""
	else
		lgt = FB.ARRAYDESCSIZE + dimensions * (4+4)
		aname = emitAllocLocal( lgt )
	end if

	d = hNewSymbol( sname, aname, FB.SYMBCLASS.VAR, (env.scope = 0) or isshared )
    if( d = INVALID ) then
    	exit function
    end if

	''
	symbolTB(d).scope	= env.scope
	if( isshared ) then
		symbolTB(d).alloctype= FB.ALLOCTYPE.SHARED
	elseif( isstatic ) then
		symbolTB(d).alloctype= FB.ALLOCTYPE.STATIC
	else
		symbolTB(d).alloctype= 0
	end if
	symbolTB(d).typ		= FB.SYMBTYPE.USERDEF
	symbolTB(d).subtype	= FB.DESCTYPE.ARRAY
	symbolTB(d).lgt		= 0
	symbolTB(d).v.dif	= 0
	symbolTB(d).v.dims	= 0
	symbolTB(d).v.desc	= INVALID

	''
	hCreateArrayDesc = d

end function

'':::::
function hCreateStringDesc( byval s as integer ) as integer static
    dim sname as string, d as integer

	hCreateStringDesc = INVALID

	sname = hMakeTmpStr

	d = hNewSymbol( sname, "", FB.SYMBCLASS.VAR, TRUE )
    if( d = INVALID ) then
    	exit function
    end if

	''
	symbolTB(d).scope	= 0
	symbolTB(d).alloctype= FB.ALLOCTYPE.SHARED

	symbolTB(d).typ		= FB.SYMBTYPE.STRING 'FB.SYMBTYPE.USERDEF
	symbolTB(d).subtype	= FB.DESCTYPE.STR
	symbolTB(d).lgt		= 0
	symbolTB(d).v.dif	= 0
	symbolTB(d).v.dims	= 0
	symbolTB(d).v.desc	= INVALID

	''
	hCreateStringDesc = d

end function

'':::::
function hNewDim( head as integer, tail as integer, byval lower as long, byval upper as long ) as integer static
    dim i as integer, d as integer, n as integer

    hNewDim = INVALID

    d = symbNewDimNode
    if( d = INVALID ) then
    	exit function
    end if

    dimTB(d).lower	= lower
    dimTB(d).upper	= upper

	n = tail
	dimTB(d).r = INVALID
	tail = d
	if( n <> INVALID ) then
		dimTB(n).r = d
	else
		head = d
	end if

    hNewDim = d

end function

'':::::
sub hSetupVar( byval s as integer, sname as string, aname as string, _
			   byval typ as integer, byval subtype as integer, _
			   byval lgt as integer, byval dimensions as integer, dTB() as FBARRAYDIM, _
			   byval alloctype as integer ) static

    dim i as integer, res as integer
    dim isshared as integer, isstatic as integer, isdynamic as integer

    isshared  = (alloctype and FB.ALLOCTYPE.SHARED) > 0
    isstatic  = (alloctype and FB.ALLOCTYPE.STATIC) > 0
    isdynamic = (alloctype and FB.ALLOCTYPE.DYNAMIC) > 0

	''
	symbolTB(s).scope	= env.scope
	symbolTB(s).alloctype= alloctype

	symbolTB(s).typ		= typ
	symbolTB(s).subtype	= subtype
	symbolTB(s).lgt		= lgt

	'' array fields
	symbolTB(s).v.dimhead = INVALID
	symbolTB(s).v.dimtail =	INVALID

	symbolTB(s).v.dif	= hCalcDiff( dimensions, dTB(), symbolTB(s).lgt )
	symbolTB(s).v.dims	= dimensions
	if( dimensions > 0 ) then
		for i = 0 to dimensions-1
			if( hNewDim( symbolTB(s).v.dimhead, symbolTB(s).v.dimtail, dTB(i).lower, dTB(i).upper ) = INVALID ) then
			end if
		next i
	end if

	if( dimensions <> 0 ) then
		symbolTB(s).v.desc = hCreateArrayDesc( s, dimensions )
	else
		symbolTB(s).v.desc = INVALID
	end if

	'' add to hash tables (local or global)
	if( (isshared) or (env.scope = 0) ) then
		hashAdd sname, s, symbolTB(s).nameidx, symbhashTB(), FB.INITSYMBOLNODES
	else
		hashAdd sname, s, symbolTB(s).nameidx, locsymbhashTB(), FB.INITLOCSYMBOLNODES

		'' hack! add only the alias name to global table, DelLocalSymbols will do the rest
		if( isstatic ) then
			hashAdd aname, s, symbolTB(s).aliasidx, symbhashTB(), FB.INITSYMBOLNODES
		end if
	end if

end sub

'':::::
function symbAddVarEx( symbol as string, aliasname as string, byval typ as integer, byval subtype as integer, _
					   byval lgt as integer, byval dimensions as integer, dTB() as FBARRAYDIM, _
				       byval alloctype as integer, _
				       byval addsuffix as integer, byval preservecase as integer, _
				       byval clearname as integer ) as integer 'static

    dim s as integer, sname as string, aname as string
    dim elms as long, stype as integer, arglen as integer
    dim isshared as integer, isstatic as integer, isarg as integer, islocal as integer

    symbAddVarEx = INVALID

    ''
    isshared = (alloctype and FB.ALLOCTYPE.SHARED) > 0
    isstatic = (alloctype and FB.ALLOCTYPE.STATIC) > 0
    isarg    = (alloctype and (FB.ALLOCTYPE.ARGUMENTBYDESC or _
    						  FB.ALLOCTYPE.ARGUMENTBYVAL or _
    						  FB.ALLOCTYPE.ARGUMENTBYREF)) > 0
	islocal  = FALSE

    ''
    if( lgt <= 0 ) then
		if( typ = INVALID ) then
			stype = hGetDefType( symbol )
		else
			stype = typ
		end if
    	lgt	= symbCalcLen( stype, subtype )
    end if

    ''
    if( addsuffix ) then
    	sname = hCreateNameEx( symbol, typ, preservecase, TRUE, clearname )
    else
    	sname = hCreateNameEx( symbol, INVALID, preservecase, TRUE, clearname )
    end if

	'' create an alias name (the real one that will be emited)
	if( len( aliasname ) > 0 ) then
		aname = aliasname
	else
		if( (not isshared) and (isstatic) ) then
			aname = hMakeTmpStr
		else
			if( (isshared) or (env.scope = 0) ) then
				aname = ""
			else
				if( not isarg ) then
					elms = hCalcElements2( dimensions, dTB() )
					aname = emitAllocLocal( lgt * elms )
					islocal = TRUE
				else
        			if( alloctype = FB.ALLOCTYPE.ARGUMENTBYVAL ) then
        				arglen = lgt
        			else
        				arglen = FB.POINTERSIZE
        			end if
					aname = emitAllocArg( arglen )
				end if
			end if
		end if
	end if

	''
	s = hNewSymbol( sname, aname, FB.SYMBCLASS.VAR, (isshared) or (env.scope = 0) )

	if( s = INVALID ) then
		'' remove a local or arg or else emit will reserve unused space for it..
		if( islocal ) then
			emitFreeLocal lgt * elms
		elseif( isarg ) then
			emitFreeArg arglen
		end if
		exit function
	end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( symbol )
	end if

	hSetupVar s, sname, aname, typ, subtype, lgt, dimensions, dTB(), alloctype

	symbAddVarEx = s

end function

'':::::
function symbAddVar( symbol as string, byval typ as integer, byval subtype as integer, _
				     byval dimensions as integer, dTB() as FBARRAYDIM, _
				     byval alloctype as integer ) as integer static

    symbAddVar = symbAddVarEx( symbol, "", typ, subtype, _
    						   0, dimensions, dTB(), _
    						   alloctype, _
    						   TRUE, FALSE, TRUE )
end function

'':::::
function symbAddTempVar( byval typ as integer ) as integer static
	dim sname as string, s as integer, alloctype as integer
    dim dTB(0) as FBARRAYDIM

	sname = hMakeTmpStr

	alloctype = FB.ALLOCTYPE.TEMP
	if( (env.scope > 0) and (env.isprocstatic) ) then
		alloctype = alloctype or FB.ALLOCTYPE.STATIC
	end if
	s = symbAddVar( sname, typ, INVALID, 0, dTB(), alloctype )

	symbAddTempVar = s
	if( s = INVALID ) then
		exit function
	end if

end function

'':::::
function hAllocFloatConst( sname as string, byval typ as integer ) as integer static
	dim s as integer, ofs as integer, dTB(0) as FBARRAYDIM
    dim cname as string, aname as string
    dim elm as integer, typesymbol as integer
    dim p as integer

	hAllocFloatConst = INVALID

	cname = "_fc_" + sname

	aname = hMakeTmpStr

	s = symbAddVarEx( cname, aname, typ, INVALID, 0, 0, dTB(), FB.ALLOCTYPE.SHARED, TRUE, FALSE, FALSE )
	if( s = INVALID ) then
		hAllocFloatConst = symbLookupVarEx( cname, typ, ofs, elm, typesymbol, TRUE, FALSE, FALSE )
		exit function
	end if

	symbolTB(s).initialized = TRUE

	p = instr( sname, "D" )
	if( p <> 0 ) then
		mid$( sname, p, 1 ) = "E"
	end if
	symbolTB(s).inittextidx	= strpAdd( sname )

	hAllocFloatConst = s

end function

'':::::
function hAllocStringConst( sname as string ) as integer static
	dim s as integer, ofs as integer, dTB(0) as FBARRAYDIM
    dim cname as string, aname as string
    dim elm as integer, typesymbol as integer

	hAllocStringConst = INVALID

	cname = "_sc_" + sname

	aname = hMakeTmpStr

	s = symbAddVarEx( cname, aname, FB.SYMBTYPE.FIXSTR, INVALID, len( sname ) + 1, 0, dTB(), FB.ALLOCTYPE.SHARED, FALSE, TRUE, FALSE )
	if( s = INVALID ) then
		s = symbLookupVarEx( cname, FB.SYMBTYPE.FIXSTR, ofs, elm, typesymbol, FALSE, TRUE, FALSE )
		hAllocStringConst = s 'symbolTB(s).v.desc
		exit function
	end if

	symbolTB(s).initialized = TRUE
	symbolTB(s).inittextidx	= strpAdd( sname )

	'' can't fake a descriptor as the literal string passed to user procs can be modified/reused
	'symbolTB(s).v.desc = hCreateStringDesc( s )

	hAllocStringConst = s 'symbolTB(s).v.desc

end function

'':::::
function symbAddConst( id as string, byval typ as integer, text as string ) as integer static
    dim i as integer, c as integer
    dim cname as string

    symbAddConst = FALSE

    cname = hCreateName( id, INVALID )

    c = hNewSymbol( cname, "", FB.SYMBCLASS.CONST, env.scope = 0 )

	if( c = INVALID ) then
		exit function
	end if

	symbolTB(c).scope   	= env.scope
	symbolTB(c).typ 		= typ
	symbolTB(c).lgt			= len( text )
	symbolTB(c).c.textidx 	= strpAdd( text )

	''
	if( env.scope > 0 ) then
		hashAdd cname, c, symbolTB(c).nameidx, locsymbhashTB(), FB.INITLOCSYMBOLNODES
	else
		hashAdd cname, c, symbolTB(c).nameidx, symbhashTB(), FB.INITSYMBOLNODES
		symbolTB(c).alloctype = FB.ALLOCTYPE.SHARED
	end if

	symbAddConst = TRUE

end function

'':::::
function symbAddLabelEx( label as string, byval declaring as integer ) as integer static
    dim i as integer, l as integer
    dim lname as string

    symbAddLabelEx = INVALID

    lname = hCreateNameEx( label, INVALID, FALSE, TRUE, TRUE )

    if( env.scope > 0 ) then
    	lname = "L" + lname
    end if

    '' check if label already exists
    if( env.scope = 0 ) then
    	l = hashLookup( lname, symbhashTB(), FB.INITSYMBOLNODES )
    else
    	l = hashLookup( lname, locsymbhashTB(), FB.INITLOCSYMBOLNODES )
    end if

    if( l <> INVALID ) then
    	if( symbolTB(l).class <> FB.SYMBCLASS.LABEL ) then
    		exit function
    	end if

    	if( declaring ) then
    		if( symbolTB(l).l.declared ) then
    			exit function
    		else
    			symbolTB(l).l.declared = TRUE
    			symbAddLabelEx = l
    			exit function
    		end if

    	else
    		symbAddLabelEx = l
    		exit function
    	end if
    end if

	'' add the new label
    l = hNewSymbol( lname, "", FB.SYMBCLASS.LABEL, env.scope = 0 )
    if( l = INVALID ) then
    	exit function
    end if

	symbolTB(l).l.declared 	= declaring
	symbolTB(l).scope    	= env.scope

	if( env.scope = 0 ) then
		hashAdd lname, l, symbolTB(l).nameidx, symbhashTB(), FB.INITSYMBOLNODES
	else
		hashAdd lname, l, symbolTB(l).nameidx, locsymbhashTB(), FB.INITLOCSYMBOLNODES
	end if

	symbAddLabelEx = l

end function

'':::::
function symbAddLabel( label as string ) as integer static

	symbAddLabel = symbAddLabelEx( label, TRUE )

end function


'':::::
function symbAddUDT( id as string, byval isunion as integer, byval align as integer ) as integer static
    dim i as integer, t as integer
    dim tname as string

    symbAddUDT = INVALID

    tname = hCreateName( id, FB.SYMBTYPE.USERDEF )

    t = hNewSymbol( tname, "", FB.SYMBCLASS.UDT, env.scope = 0 )

	if( t = INVALID ) then
		exit function
	end if

	symbolTB(t).scope   	= env.scope
	symbolTB(t).lgt			= 0
	symbolTB(t).u.isunion	= isunion
	symbolTB(t).u.elements	= 0
	symbolTB(t).u.head 		= INVALID
	symbolTB(t).u.tail 		= INVALID
	symbolTB(t).u.ofs		= 0
	symbolTB(t).u.align		= align
	symbolTB(t).u.innerlgt	= 0

	if( env.scope > 0 ) then
		hashAdd tname, t, symbolTB(t).nameidx, locsymbhashTB(), FB.INITLOCSYMBOLNODES
	else
		hashAdd tname, t, symbolTB(t).nameidx, symbhashTB(), FB.INITSYMBOLNODES
		symbolTB(t).alloctype = FB.ALLOCTYPE.SHARED
	end if

	symbAddUDT = t

end function

'':::::
function hCalcALign( byval lgt as integer, byval ofs as integer, byval align as integer ) as integer
    dim pad as integer

	hCalcALign = 0

	if( align <= 1 ) then
		exit function
	end if

	select case lgt
	case 1, 2, 4, 8
		pad = lgt - 1
	case else
		pad = align - 1
		lgt = align
	end select

	if( pad > 0 ) then
		hCalcALign = (lgt - (ofs and pad)) mod lgt
	end if

end function


'':::::
function hNewUDTElement( t as integer, ename as string, _
						 byval dimensions as integer, dTB() as FBARRAYDIM, _
						 byval typ as integer, byval subtype as integer, byval lgt as integer, _
						 byval isinnerunion as integer ) as integer static
    dim i as integer, e as integer, n as integer, d as integer
    dim align as integer

    hNewUDTElement = INVALID

    '' check if element already exists in the current struct
    i = symbolTB(t).u.head
    do while( i <> INVALID )

    	if( strpGet( typelmTB(i).nameidx ) = ename ) then
    		exit function
    	end if

    	i = typelmTB(i).r
    loop

    e = symbNewElmNode
    if( e = INVALID ) then
    	exit function
    end if

    typelmTB(e).typ		= typ
    typelmTB(e).subtype	= subtype
	if( lgt <= 0 ) then
		lgt	= symbCalcLen( typ, subtype )
	end if

	align = hCalcALign( lgt, symbolTB(t).u.ofs, symbolTB(t).u.align )
	if( align > 0 ) then
		symbolTB(t).u.ofs = symbolTB(t).u.ofs + align
	end if

	typelmTB(e).ofs		= symbolTB(t).u.ofs
	typelmTB(e).lgt		= lgt
	typelmTB(e).dif		= hCalcDiff( dimensions, dTB(), typelmTB(e).lgt )
    typelmTB(e).parent	= t
    typelmTB(e).nameidx	= strpAdd( ename )

	n = symbolTB(t).u.tail
	typelmTB(e).l = n
	typelmTB(e).r = INVALID
	symbolTB(t).u.tail = e
	if( n <> INVALID ) then
		typelmTB(n).r = e
	else
		symbolTB(t).u.head = e
	end if

    symbolTB(t).u.elements	= symbolTB(t).u.elements + 1

	'' array fields
	typelmTB(e).dimhead = INVALID
	typelmTB(e).dimtail = INVALID

	typelmTB(e).dims	= dimensions
	if( dimensions > 0 ) then
		for i = 0 to dimensions-1
			if( hNewDim( typelmTB(e).dimhead, typelmTB(e).dimtail, dTB(i).lower, dTB(i).upper ) = INVALID ) then
			end if
		next i
	end if

	lgt = lgt * hCalcElements2( dimensions, dTB() )

	if( not symbolTB(t).u.isunion ) then
		if( not isinnerunion ) then
			symbolTB(t).u.ofs = symbolTB(t).u.ofs + lgt
			symbolTB(t).lgt = symbolTB(t).u.ofs
		else
			if( lgt > symbolTB(t).u.innerlgt ) then
				symbolTB(t).u.innerlgt = lgt
			end if
		end if

	else
		symbolTB(t).u.ofs = 0
		if( lgt > symbolTB(t).lgt ) then
			symbolTB(t).lgt = lgt
		end if
	end if


    hNewUDTElement = e

end function

'':::::
function symbAddUDTElement( byval t as integer, id as string, _
							 byval dimensions as integer, dTB() as FBARRAYDIM, _
							 byval typ as integer, byval subtype as integer, byval lgt as integer, _
							 byval isinnerunion as integer ) as integer static

    dim ename as string

    ename = hCreateName( id, INVALID )

	symbAddUDTElement = hNewUDTElement( t, ename, dimensions, dTB(), typ, subtype, lgt, isinnerunion )

end function

'':::::
sub symbRoundUDTSize( byval t as integer ) static
    dim round as integer, align as integer

	align = symbolTB(t).u.align

	if( align <= 1 ) then
		exit sub
	end if

	round = (align - (symbolTB(t).lgt and (align-1))) and (align-1)

	if( round > 0 ) then
		symbolTB(t).lgt = symbolTB(t).lgt + round
	end if

end sub

'':::::
sub symbRecalcUDTSize( byval t as integer ) static
    dim lgt as integer

	lgt = symbolTB(t).u.innerlgt
	if( lgt > 0 ) then
		symbolTB(t).u.ofs = symbolTB(t).u.ofs + lgt
		symbolTB(t).lgt = symbolTB(t).u.ofs
		symbolTB(t).u.innerlgt = 0
	end if

end sub


'':::::
function symbAddEnum( id as string ) as integer static
    dim i as integer, e as integer
    dim ename as string

    symbAddEnum = INVALID

    ename = hCreateName( id, FB.SYMBTYPE.USERDEF )

    e = hNewSymbol( ename, "", FB.SYMBCLASS.ENUM, env.scope = 0 )

	if( e = INVALID ) then
		exit function
	end if

	symbolTB(e).scope   	= env.scope

	if( env.scope > 0 ) then
		hashAdd ename, e, symbolTB(e).nameidx, locsymbhashTB(), FB.INITLOCSYMBOLNODES
	else
		hashAdd ename, e, symbolTB(e).nameidx, symbhashTB(), FB.INITSYMBOLNODES
	end if

	symbAddEnum = e

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' procs
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbAddLib( libname as string ) as integer static
    dim i as integer, l as integer

    symbAddLib = INVALID

    '' check if not already declared
    l = hashLookup( libname, libhashTB(), FB.INITLIBNODES )
    if( l <> INVALID ) then
    	symbAddLib = l
    	exit function
    end if

    l = symbNewLibNode
	if( l = INVALID ) then
		exit function
	end if

	''
	libTB(l).nameidx = strpAdd( libname )

	hashAdd libname, l, libTB(l).nameidx, libhashTB(), FB.INITLIBNODES

	symbAddLib = l

end function

'':::::
function hCalcProcArgsLen( byval args as integer, argv() as FBPROCARG ) as integer
	dim i as integer, lgt as integer

	lgt	= 0
	for i = 0 to args-1
		if( argv(i).mode = FB.ARGMODE.BYVAL ) then
			lgt	= lgt + ((argv(i).lgt + 3) and not 3)	'' hack! x86 pmode assumption
		else
			lgt	= lgt + FB.POINTERSIZE
		end if
	next i

	hCalcProcArgsLen = lgt

end function

'':::::
function hCreateAliasName( symbol as string, byval argslen as integer, _
						   byval toupper as integer, byval addat as integer ) as string static
    dim nm as string

	nm = "_" + symbol

	if( toupper ) then
		nm = ucase$( nm )
	end if

	if( addat ) then
		nm = nm + "@" + ltrim$( str$( argslen ) )
	end if

	hCreateAliasName = nm

end function

'':::::
function hNewArg( byval f as integer, arg as FBPROCARG ) as integer static
    dim i as integer, a as integer, n as integer

    hNewArg = INVALID

    a = symbNewArgNode
    if( a = INVALID ) then
    	exit function
    end if

    argTB(a).nameidx	= arg.nameidx
	argTB(a).typ		= arg.typ
	argTB(a).subtype	= arg.subtype
	argTB(a).lgt		= arg.lgt
	argTB(a).mode		= arg.mode
	argTB(a).suffix		= arg.suffix
	argTB(a).optional	= arg.optional
	argTB(a).defvalue	= arg.defvalue

	n = symbolTB(f).p.argtail
	argTB(a).l = n
	argTB(a).r = INVALID
	symbolTB(f).p.argtail = a
	if( n <> INVALID ) then
		argTB(n).r = a
	else
		symbolTB(f).p.arghead = a
	end if

    hNewArg = a

end function

'':::::
sub hSetupProc( byval f as integer, sname as string, aliasname as string, libname as string, _
				byval typ as integer, byval mode as integer, byval lgt as integer, _
			    byval args as integer, argv() as FBPROCARG, byval declaring as integer ) static

    dim i as integer

	symbolTB(f).scope	= env.scope
	symbolTB(f).alloctype= FB.ALLOCTYPE.SHARED

	symbolTB(f).typ		= typ
	symbolTB(f).lgt		= lgt

	symbolTB(f).p.isdeclared = declaring
	symbolTB(f).p.mode	= mode

	symbolTB(f).p.arghead = INVALID
	symbolTB(f).p.argtail = INVALID
	symbolTB(f).p.args	= args
	for i = 0 to args-1
		if( hNewArg( f, argv(i) ) = INVALID ) then
		end if
	next i

	if( len( aliasname ) > 0 ) then
		symbolTB(f).aliasidx = strpAdd( aliasname )
	else
		symbolTB(f).aliasidx = INVALID
	end if

	if( len( libname ) > 0 ) then
		symbolTB(f).p.lib = symbAddLib( libname )
	else
		symbolTB(f).p.lib = INVALID
	end if

	hashAdd sname, f, symbolTB(f).nameidx, symbhashTB(), FB.INITSYMBOLNODES

end sub

'':::::
function symbAddProc( id as string, aliasname as string, libname as string, byval typ as integer, _
                      byval mode as integer, byval args as integer, argv() as FBPROCARG, _
                      byval declaring as integer ) as integer static

    dim f as integer, sname as string, aname as string, lgt as integer
    dim toupper as integer

    symbAddProc = INVALID

    sname = hCreateName( id, INVALID )

	f = hNewSymbol( sname, "", FB.SYMBCLASS.PROC, TRUE )

	if( f = INVALID ) then
		exit function
	end if

	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    lgt = hCalcProcArgsLen( args, argv() )

    if( len( aliasname ) = 0 ) then
    	aname = id
    	toupper = TRUE
    else
    	aname = aliasname
    	toupper = FALSE
    end if

    if( len( libname ) > 0 ) then
    	toupper = FALSE
    end if

    if( instr( aname, "@" ) = 0 ) then
    	aname = hCreateAliasName( aname, lgt, toupper, (mode = FB.FUNCMODE.STDCALL) )
    end if

	hSetupProc f, sname, aname, libname, typ, mode, lgt, args, argv(), declaring

	symbAddProc = f

end function

'':::::
function symbCalcArgsLen( byval f as integer, byval args as integer ) as integer static
    dim lgt as integer

	'' use symbGetLen() with normal procs, this is only for C var-len progs
	lgt = symbolTB(f).lgt
	if( args > symbolTB(f).p.args ) then
		lgt = lgt + ((args - symbolTB(f).p.args) * FB.INTEGERSIZE)
	end if

	symbCalcArgsLen = lgt

end function

'':::::
function symbAddProcResult( byval f as integer ) as integer static
	dim rname as string, typ as integer
	dim dTB(0) as FBARRAYDIM

	rname = strpGet( symbolTB(f).aliasidx )

	typ = symbolTB(f).typ

	symbAddProcResult = symbAddVarEx( rname, "", typ, symbolTB(f).subtype, 0, _
			 			              0, dTB(), 0, TRUE, FALSE, TRUE )

end function


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookups
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetUDTElmOffset( elm as integer, typesymbol as integer, typ as integer, id as string ) as integer
	dim e as integer, ename as string
	dim p as integer, ofs as integer, o as integer

	symbGetUDTElmOffset = INVALID

    p = instr( 1, id, "." )
    if( p = 0 ) then
    	p = len( id ) + 1
    end if

    ename = hCreateName( left$( id, p-1 ), INVALID )

	elm = INVALID
	ofs = INVALID

	e = symbolTB(typesymbol).u.head
	do while( e <> INVALID )

        if( strpGet( typelmTB(e).nameidx ) = ename ) then

        	elm = e
        	ofs = typelmTB(e).ofs
        	typ = typelmTB(e).typ

        	if( (typ = FB.SYMBTYPE.USERDEF) or (typ = FB.SYMBTYPE.POINTER + FB.SYMBTYPE.USERDEF) ) then
                typesymbol = typelmTB(e).subtype

    			if( p >= len( id ) ) then
    				exit do
    			end if

    			o = symbGetUDTElmOffset( elm, typesymbol, typ, mid$( id, p+1 ) )
    			if( o = INVALID ) then
    				exit function
    			end if
    			ofs = ofs + o

    		else
    			if( p < len( id ) ) then
    				exit function
    			end if
    		end if

        	exit do
        end if

		e = typelmTB(e).r
    loop

    symbGetUDTElmOffset = ofs

end function

'':::::
function hLookupVar( vname as string ) as integer static
    dim s as integer

	hLookupVar = INVALID

	'' first check the local symbols if current scope > 0
	if( env.scope > 0 ) then
		s = hashLookup( vname, locsymbhashTB(), FB.INITLOCSYMBOLNODES )
		if( s <> INVALID ) then
			if( symbolTB(s).class = FB.SYMBCLASS.VAR ) then
				hLookupVar = s
			end if
			exit function
		end if
	else
		s = INVALID
	end if

	'' check globals (and shared if current scope > 0)
	if( s = INVALID ) then
		s = hashLookup( vname, symbhashTB(), FB.INITSYMBOLNODES )
		if( s <> INVALID ) then
			if( symbolTB(s).class = FB.SYMBCLASS.VAR ) then
				if( (env.scope = 0) or ((symbolTB(s).alloctype and FB.ALLOCTYPE.SHARED) > 0) ) then
					hLookupVar = s
				end if
			end if
			exit function
		end if
	end if

end function

'':::::
function symbLookupVarEx( symbol as string, typ as integer, ofs as integer, _
						  elm as integer, typesymbol as integer, _
					      byval addsuffix as integer, byval preservecase as integer, _
					      byval clearname as integer ) as integer static
    dim vname as string
    dim s as integer, p as integer

    symbLookupVarEx = INVALID

    ofs 		= 0
    elm	        = INVALID
    typesymbol 	= INVALID

    if( addsuffix ) then
    	vname = hCreateNameEx( symbol, typ, preservecase, TRUE, clearname )
    else
    	vname = hCreateNameEx( symbol, INVALID, preservecase, TRUE, clearname )
    end if

	s = hLookupVar( vname )
	if( s <> INVALID ) then
		typesymbol = symbolTB(s).subtype
		symbLookupVarEx = s
		exit function
	end if

	''
	'' check if it's an UDT field
	''
	p = instr( 1, symbol, "." )
	if( p <= 1 ) then
		exit function
	end if

	vname = hCreateNameEx( left$( symbol, p-1 ), INVALID, preservecase, TRUE, clearname )

    s = hLookupVar( vname )
	if( s = INVALID ) then
		exit function
	end if

	if( symbolTB(s).class <> FB.SYMBCLASS.VAR ) then
		exit function
	end if

	typ = symbolTB(s).typ
	if( (typ <> FB.SYMBTYPE.USERDEF) and (typ <> FB.SYMBTYPE.POINTER + FB.SYMBTYPE.USERDEF) ) then
		exit function
	end if

    typesymbol = symbolTB(s).subtype
    ofs = symbGetUDTElmOffset( elm, typesymbol, typ, mid$( symbol, p+1 ) )
    if( ofs = INVALID ) then
    	exit function
    end if

    symbLookupVarEx = s

end function

'':::::
function symbLookupVar( symbol as string, typ as integer, ofs as integer, elm as integer, typesymbol as integer ) as integer static

	symbLookupVar = symbLookupVarEx( symbol, typ, ofs, elm, typesymbol, TRUE, FALSE, TRUE )

end function

'':::::
function symbLookupProc( id as string ) as integer static
    dim pname as string
    dim s as integer

	symbLookupProc = INVALID

	pname = hCreateName( id, INVALID )

	s = hashLookup( pname, symbhashTB(), FB.INITSYMBOLNODES )

	if( s = INVALID ) then
		exit function
	end if

	if( symbolTB(s).class = FB.SYMBCLASS.PROC ) then
		symbLookupProc = s
	end if

end function

'':::::
function symbLookupFunctionResult( byval f as integer ) as integer static
	dim rname as string
	dim typ as integer

	rname = strpGet( symbolTB(f).aliasidx )

	typ   = symbolTB(f).typ

	rname = hCreateName( rname, typ )

	symbLookupFunctionResult = hashLookup( rname, locsymbhashTB(), FB.INITLOCSYMBOLNODES )

end function

'':::::
function symbLookupConst( constname as string, byval typ as integer ) as integer static
    dim cname as string
    dim s as integer

	symbLookupConst = INVALID

    cname = hCreateName( constname, INVALID )

	'' first check the local symbols if current scope > 0
	if( env.scope > 0 ) then
		s = hashLookup( cname, locsymbhashTB(), FB.INITLOCSYMBOLNODES)
    else
    	s = INVALID
    end if

    '' and then the globals
    if( s = INVALID ) then
    	s = hashLookup( cname, symbhashTB(), FB.INITSYMBOLNODES )
    end if

	if( s = INVALID ) then
		exit function
	end if

	if( symbolTB(s).class = FB.SYMBCLASS.CONST ) then
		symbLookupConst = s
	end if

end function

'':::::
function symbLookupUDT( typename as string, lgt as integer ) as integer static
    dim tname as string
    dim t as integer

    symbLookupUDT = INVALID

    tname = hCreateName( typename, FB.SYMBTYPE.USERDEF )

	'' first check the local symbols if current scope > 0
	if( env.scope > 0 ) then
    	t = hashLookup( tname, locsymbhashTB(), FB.INITLOCSYMBOLNODES )
    else
    	t = INVALID
    end if

    '' and then the globals
    if( t = INVALID ) then
    	t = hashLookup( tname, symbhashTB(), FB.INITSYMBOLNODES )
    end if

	if( t = INVALID ) then
		exit function
	end if

	if( symbolTB(t).class = FB.SYMBCLASS.UDT ) then
		lgt = symbolTB(t).lgt
		symbLookupUDT = t
	end if

end function

'':::::
function symbLookupEnum( id as string ) as integer static
    dim ename as string
    dim e as integer

    symbLookupEnum = INVALID

    ename = hCreateName( id, FB.SYMBTYPE.USERDEF )

	'' first check the local symbols if current scope > 0
	if( env.scope > 0 ) then
    	e = hashLookup( ename, locsymbhashTB(), FB.INITLOCSYMBOLNODES )
    else
    	e = INVALID
    end if

    '' and then the globals
    if( e = INVALID ) then
    	e = hashLookup( ename, symbhashTB(), FB.INITSYMBOLNODES )
    end if

	if( e = INVALID ) then
		exit function
	end if

	if( symbolTB(e).class = FB.SYMBCLASS.ENUM ) then
		symbLookupEnum = e
	end if

end function

'':::::
function symbLookupLabel( label as string ) as integer static
    dim l as integer, lname as string

    symbLookupLabel = INVALID

    lname = hCreateName( label, INVALID )

	'' first check the local symbols if current scope > 0
	if( env.scope > 0 ) then
    	l = hashLookup( lname, locsymbhashTB(), FB.INITLOCSYMBOLNODES )
    else
    	l = INVALID
    end if

    '' and then the globals
    if( l = INVALID ) then
    	l = hashLookup( lname, symbhashTB(), FB.INITSYMBOLNODES )
    end if

	if( l = INVALID ) then
		exit function
	end if

	if( symbolTB(l).class = FB.SYMBCLASS.LABEL ) then
		symbLookupLabel = l
	end if

end function

'':::::
function symbLookupKeyword( keyword as string, class as integer, typ as integer ) as integer static
    dim i as integer, id as integer
    dim kname as string

	id = FB.TK.ID
	class = FB.TKCLASS.IDENTIFIER

	kname = ucase$( keyword )
	if( typ <> INVALID ) then
		'kname = kname + "_" + chr$( typ )
	end if

	i = hashLookup( kname, keyhashTB(), FB.MAXKEYWORDS )
	if( i <> INVALID ) then
		id = keywordTB(i).id
		class = keywordTB(i).class
	end if

	symbLookupKeyword = id

end function

'':::::
function symbIsProc( id as string ) as integer

	if( symbLookupProc( id ) <> INVALID ) then
		symbIsProc = TRUE
	else
		symbIsProc = FALSE
	end if

end function

'':::::
'function symbIsConst( constname as string ) as integer
'
'	if( symbLookupConst( constname ) <> INVALID ) then
'		symbIsConst = TRUE
'	else
'		symbIsConst = FALSE
'	end if
'
'end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' helpers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcLen( byval typ as integer, byval subtype as integer ) as integer static
    dim lgt as integer

	lgt = 0

	select case typ
	case FB.SYMBTYPE.BYTE, FB.SYMBTYPE.UBYTE
		lgt = 1

	case FB.SYMBTYPE.SHORT, FB.SYMBTYPE.USHORT
		lgt = 2

	case FB.SYMBTYPE.INTEGER, FB.SYMBTYPE.LONG, FB.SYMBTYPE.UINT
		lgt = FB.INTEGERSIZE

	case FB.SYMBTYPE.SINGLE
		lgt = 4

	case FB.SYMBTYPE.DOUBLE
    	lgt = 8

	case FB.SYMBTYPE.FIXSTR
		lgt = 0									'' 0-len literal-strings

	case FB.SYMBTYPE.STRING
		lgt = FB.STRSTRUCTSIZE

	case FB.SYMBTYPE.USERDEF
		lgt = symbolTB(subtype).lgt

	case is >= FB.SYMBTYPE.POINTER
		lgt = FB.POINTERSIZE
	end select

	symbCalcLen = lgt

end function

'':::::
function hCalcDiff( byval dimensions as integer, dTB() as FBARRAYDIM, byval lgt as integer ) as long
    dim d as integer, diff as long, elms as long

	diff = 0
	for d = 0 to (dimensions-1)-1
		elms = (dTB(d+1).upper-dTB(d+1).lower)+1
		diff = diff + (-dTB(d).lower * elms)
	next d

	if( dimensions > 0 ) then
		diff = diff + -dTB(dimensions-1).lower
	end if

	diff = diff * lgt

	hCalcDiff = diff

end function

'':::::
function hCalcElements( byval s as integer ) as long static
    dim e as long, i as integer, d as long

	e = 1
	i = symbolTB(s).v.dimhead
	do while( i <> INVALID )
		d = (dimTB(i).upper - dimTB(i).lower) + 1
		e = e * d
		i = dimTB(i).r
	loop

	hCalcElements = e

end function

'':::::
function hCalcElements2( byval dimensions as integer, dTB() as FBARRAYDIM ) as long static
    dim e as long, i as integer, d as long

	e = 1
	for i = 0 to dimensions-1
		d = (dTB(i).upper - dTB(i).lower) + 1
		e = e * d
	next i

	hCalcElements2 = e

end function

'':::::
function hStyp2Dtype( byval typ as integer ) as integer static

	hStyp2Dtype = typ						'' hack! assuming SYMBTYPE = DATATYPE

end function

'':::::
function hDtype2Stype( byval dtype as integer ) as integer static

	hDtype2Stype = dtype					'' hack! assuming DATATYPE = SYMBTYPE

end function

'':::::
function hIsStrFixed( byval dtype as integer ) as integer static

    hIsStrFixed = (dtype = IR.DATATYPE.FIXSTR)

end function

'':::::
function hIsString( byval dtype as integer ) as integer static

   	hIsString = (dtype = IR.DATATYPE.STRING) or (dtype = IR.DATATYPE.FIXSTR)

end function

'':::::
function symbIsString( byval s as integer ) as integer static
    dim dtype as integer

    dtype = hStyp2Dtype( symbolTB(s).typ )

    symbIsString = hIsString( dtype )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' getters for symbol properties
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetLen( byval s as integer ) as integer static

	symbGetLen = symbolTB(s).lgt

end function

'':::::
function symbGetUDTElmLen( byval t as integer ) as integer static

	symbGetUDTElmLen = typelmTB(t).lgt

end function

'':::::
function symbGetFirstNode as integer static

	symbGetFirstNode = ctx.sym.head

end function

'':::::
function symbGetNextNode( byval n as integer ) as integer static

	if( n <> INVALID ) then
		symbGetNextNode = symbolTB(n).nxt
	else
		symbGetNextNode = INVALID
	end if

end function

'':::::
function symbGetType( byval s as integer ) as integer static

	symbGetType = symbolTB(s).typ

end function

'':::::
function symbGetSubType( byval s as integer ) as integer static

	symbGetSubType = symbolTB(s).subtype

end function

'':::::
function symbGetUDTElmSubType( byval t as integer ) as integer static

    symbGetUDTElmSubType = typelmTB(t).subtype

end function

'':::::
function symbGetClass( byval s as integer ) as integer static

	symbGetClass = symbolTB(s).class

end function

'':::::
function symbGetAllocType( byval s as integer ) as integer static

	symbGetAllocType = symbolTB(s).alloctype

end function

'':::::
function symbGetInitialized( byval s as integer ) as integer static

	symbGetInitialized = symbolTB(s).initialized

end function

'':::::
function symbGetVarIsDynamic( byval s as integer ) as integer static

	symbGetVarIsDynamic = (symbolTB(s).alloctype and (FB.ALLOCTYPE.DYNAMIC or FB.ALLOCTYPE.ARGUMENTBYDESC)) > 0

end function

'':::::
function symbIsArray( byval s as integer ) as integer static

	if( (symbolTB(s).alloctype and (FB.ALLOCTYPE.DYNAMIC or FB.ALLOCTYPE.ARGUMENTBYDESC)) > 0 ) then
		symbIsArray = TRUE
	else
		symbIsArray = symbolTB(s).v.dims > 0
	end if

end function

'':::::
function symbGetVarDiff( byval s as integer ) as long static

	symbGetVarDiff = symbolTB(s).v.dif

end function

'':::::
function symbGetUDTElmDiff( byval t as integer ) as long static

	symbGetUDTElmDiff = typelmTB(t).dif

end function

'':::::
function symbGetVarDimensions( byval s as integer ) as integer static

	symbGetVarDimensions = symbolTB(s).v.dims

end function

'':::::
sub symbSetVarDimensions( byval s as integer, byval dims as integer ) static

	symbolTB(s).v.dims = dims

end sub


'':::::
function symbGetUDTElmDimensions( byval t as integer ) as integer static

	symbGetUDTElmDimensions = typelmTB(t).dims

end function

'':::::
function symbGetUDTElmName( byval t as integer ) as string static

	symbGetUDTElmName = strpGet( typelmTB(t).nameidx )

end function

'':::::
function symbGetVarDescriptor( byval s as integer ) as integer static

	symbGetVarDescriptor = symbolTB(s).v.desc

end function

'':::::
function symbGetProcArgs( byval f as integer ) as integer static

	symbGetProcArgs = symbolTB(f).p.args

end function

'':::::
sub symbGetVarDims( byval s as integer, byval d as integer, lb as long, ub as long ) static

    lb = dimTB(d).lower
    ub = dimTB(d).upper

end sub

'':::::
sub symbGetUDTElmDims( byval t as integer, byval d as integer, lb as long, ub as long ) static

    lb = dimTB(d).lower
    ub = dimTB(d).upper

end sub

'':::::
function symbGetFirstVarDim( byval s as integer ) as integer static

	symbGetFirstVarDim = symbolTB(s).v.dimhead

end function

'':::::
function symbGetFirstUDTElmDim( byval t as integer ) as integer static

	symbGetFirstUDTElmDim = typelmTB(t).dimhead

end function

'':::::
function symbGetNextVarDim( byval s as integer, byval d as integer ) as integer static

	if( d <> INVALID ) then
		symbGetNextVarDim = dimTB(d).r
	else
		symbGetNextVarDim = INVALID
	end if

end function

'':::::
function symbGetNextUDTElmDim( byval t as integer, byval d as integer ) as integer static

	if( d <> INVALID ) then
		symbGetNextUDTElmDim = dimTB(d).r
	else
		symbGetNextUDTElmDim = INVALID
	end if

end function

'':::::
function symbGetFuncMode( byval f as integer ) as integer static

	symbGetFuncMode = symbolTB(f).p.mode

end function

'':::::
function symbGetFuncDataType( byval f as integer ) as integer static
	dim typ as integer

	typ = symbolTB(f).typ
	'if( typ = FB.SYMBTYPE.USERDEF ) then typ = symbolTB(f).subtype

	symbGetFuncDataType = hStyp2Dtype( typ )
end function

'':::::
function symbGetProcLib( byval p as integer ) as string static
    dim l as integer

	l = symbolTB(p).p.lib
	if( l <> INVALID ) then
		symbGetProcLib = strpGet( libTB(l).nameidx )
	else
	    symbGetProcLib = ""
	end if

end function

'':::::
function symbGetName( byval s as integer ) as string static

	symbGetName = strpGet( symbolTB(s).nameidx )

end function

'':::::
function symbGetAlias( byval s as integer ) as string static

	symbGetAlias = strpGet( symbolTB(s).aliasidx )

end function

'':::::
function symbGetVarName( byval s as integer ) as string static

	if( symbolTB(s).aliasidx <> INVALID ) then
		symbGetVarName = strpGet( symbolTB(s).aliasidx )
	else
		symbGetVarName = strpGet( symbolTB(s).nameidx )
	end if

end function

'':::::
function symbGetVarDscName( byval s as integer ) as string static
	dim d as integer

	d = symbolTB(s).v.desc
	if( d <> INVALID ) then
		symbGetVarDscName = strpGet( symbolTB(d).nameidx )
	else
		symbGetVarDscName = ""
	end if

end function

'':::::
function symbGetVarDesc( byval s as integer ) as integer static

	symbGetVarDesc = symbolTB(s).v.desc

end function

'':::::
function symbGetVarText( byval s as integer ) as string static

	symbGetVarText = strpGet( symbolTB(s).inittextidx )

end function

'':::::
function symbGetConstName( byval c as integer ) as string static

	if( symbolTB(c).aliasidx <> INVALID ) then
		symbGetConstName = strpGet( symbolTB(c).aliasidx )
	else
		symbGetConstName = strpGet( symbolTB(c).nameidx )
	end if

end function

'':::::
function symbGetConstText( byval c as integer ) as string static

	symbGetConstText = strpGet( symbolTB(c).c.textidx )

end function

'':::::
function symbGetLabelIsDeclared( byval l as integer ) as integer static

	symbGetLabelIsDeclared = symbolTB(l).l.declared

end function

'':::::
function symbGetProcName( byval p as integer ) as string static

	if( symbolTB(p).aliasidx <> INVALID ) then
		symbGetProcName = strpGet( symbolTB(p).aliasidx )
	else
		symbGetProcName = strpGet( symbolTB(p).nameidx )
	end if

end function

'':::::
function symbGetProcIsDeclared( byval f as integer ) as integer static

	symbGetProcIsDeclared = symbolTB(f).p.isdeclared

end function

'':::::
function symbGetProcFirstArg( byval f as integer ) as integer static

	if( symbolTB(f).p.mode = FB.FUNCMODE.PASCAL ) then
		symbGetProcFirstArg = symbolTB(f).p.arghead
	else
		symbGetProcFirstArg = symbolTB(f).p.argtail
	end if

end function

'':::::
function symbGetProcLastArg( byval f as integer ) as integer static

	if( symbolTB(f).p.mode = FB.FUNCMODE.PASCAL ) then
		symbGetProcLastArg = symbolTB(f).p.argtail
	else
		symbGetProcLastArg = symbolTB(f).p.arghead
	end if

end function

'':::::
function symbGetProcTailArg( byval f as integer ) as integer static

	symbGetProcTailArg = symbolTB(f).p.argtail

end function

'':::::
function symbGetProcPrevArg( byval f as integer, byval a as integer ) as integer static

	if( symbolTB(f).p.mode = FB.FUNCMODE.PASCAL ) then
		symbGetProcPrevArg = argTB(a).l
	else
		symbGetProcPrevArg = argTB(a).r
	end if

end function

'':::::
function symbGetProcNextArg( byval f as integer, byval a as integer ) as integer static

	if( symbolTB(f).p.mode = FB.FUNCMODE.PASCAL ) then
		symbGetProcNextArg = argTB(a).r
	else
		symbGetProcNextArg = argTB(a).l
	end if

end function

'':::::
function symbGetArgDataType( byval f as integer, byval a as integer ) as integer static
	dim typ as integer

	symbGetArgDataType = INVALID

	if( a = INVALID ) then
		exit function
	end if

	typ = argTB(a).typ
    if( typ <> INVALID ) then
		symbGetArgDataType = hStyp2Dtype( typ )
		exit function
	end if

	if( symbolTB(f).p.mode <> FB.FUNCMODE.CDECL ) then
		exit function
	end if

	'' it's really a "..." arg, so, it's always an integer
	symbGetArgDataType = hStyp2Dtype( FB.SYMBTYPE.INTEGER )

end function

'':::::
function symbGetArgMode( byval f as integer, byval a as integer ) as integer static
	dim mode as integer

	symbGetArgMode = INVALID

	if( a = INVALID ) then
		exit function
	end if

	mode = argTB(a).mode
	if( mode <> INVALID ) then
		symbGetArgMode = mode
		exit function
	end if

	if( symbolTB(f).p.mode <> FB.FUNCMODE.CDECL ) then
		exit function
	end if

	'' it's really a "..." arg, so, it's always passed by value
	symbGetArgMode = FB.ARGMODE.BYVAL

end function

'':::::
function symbGetArgName( byval f as integer, byval a as integer ) as string static

	symbGetArgName = strpGet( argTB(a).nameidx )

end function

'':::::
function symbGetArgType( byval f as integer, byval a as integer ) as integer static

	if( a <> INVALID ) then
		symbGetArgType = argTB(a).typ
	else
		symbGetArgType = INVALID
	end if

end function

'':::::
sub symbSetArgType( byval f as integer, byval a as integer, byval typ as integer ) static

	if( a <> INVALID ) then
		argTB(a).typ = typ
	end if

end sub

'':::::
sub symbSetArgSubType( byval f as integer, byval a as integer, byval subtype as integer ) static

	if( a <> INVALID ) then
		argTB(a).subtype = subtype
	end if

end sub

'':::::
sub symbSetArgName( byval f as integer, byval a as integer, byval nameidx as integer ) static

	if( a <> INVALID ) then
		strpDel argTB(a).nameidx
		argTB(a).nameidx = nameidx
	end if

end sub

'':::::
function symbGetArgSubtype( byval f as integer, byval a as integer ) as integer static

	if( a <> INVALID ) then
		symbGetArgSubtype = argTB(a).subtype
	else
		symbGetArgSubtype = INVALID
	end if

end function

'':::::
function symbGetArgSuffix( byval f as integer, byval a as integer ) as integer static

	if( a <> INVALID ) then
		symbGetArgSuffix = argTB(a).suffix
	else
		symbGetArgSuffix = INVALID
	end if

end function

'':::::
function symbGetArgsLen( byval f as integer ) as integer static

	symbGetArgsLen = symbolTB(f).lgt

end function

'':::::
function symbGetArgOptional( byval f as integer, byval a as integer ) as integer static

	if( a <> INVALID ) then
		symbGetArgOptional = argTB(a).optional
	else
		symbGetArgOptional = FALSE
	end if

end function

'':::::
function symbGetArgDefvalue( byval f as integer, byval a as integer ) as double static

	if( a <> INVALID ) then
		symbGetArgDefvalue = argTB(a).defvalue
	else
		symbGetArgDefvalue = 0.0
	end if

end function

'':::::
function symbGetLabelName( byval l as integer ) as string static
	symbGetLabelName = strpGet( symbolTB(l).nameidx )
end function

'':::::
function symbGetLabelScope( byval l as integer ) as integer static
	symbGetLabelScope = symbolTB(l).scope
end function


'':::::
function hFindLib( libname as string, namelist() as string ) as integer
    dim i as integer

	hFindLib = INVALID

	for i = 0 to ubound( namelist ) - 1

		if( len( namelist(i) ) = 0 ) then
			exit function
		end if

		if( namelist(i) = libname ) then
			hFindLib = i
			exit function
		end if
	next i

end function

'':::::
function symbListLibs( namelist() as string, byval index as integer ) as integer static
    dim cnt as integer, i as integer
    dim libname as string

	cnt = index
	i = ctx.lib.head
	do while( i <> INVALID )

		libname = strpGet( libTB(i).nameidx )
		if( hFindLib( libname, namelist() ) = INVALID ) then
			namelist(cnt) = libname
			cnt = cnt + 1
		end if

		i = libTB(i).nxt
	loop

	symbListLibs = cnt - index

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbDelLabel( byval l as integer ) static
    dim lname as string

    if( l = INVALID ) then
    	exit sub
    end if

    lname = strpGet( symbolTB(l).nameidx )

    if( symbolTB(l).scope > 0 ) then
    	hashDel lname, locsymbhashTB(), FB.INITLOCSYMBOLNODES
    else
    	hashDel lname, symbhashTB(), FB.INITSYMBOLNODES
    end if

    strpDel symbolTB(l).nameidx

    symbDelSymbolNode l

end sub

'':::::
sub hDelVarDims( byval s as integer ) static
    dim nn as integer, n as integer

    n = symbolTB(s).v.dimhead
    do while( n <> INVALID )
    	nn = dimTB(n).r

    	symbDelDimNode n

    	n = nn
    loop

    symbolTB(s).v.dimhead = INVALID
    symbolTB(s).v.dimtail = INVALID
    symbolTB(s).v.dims	  = 0

end sub

'':::::
sub symbDelVar( byval s as integer )
    dim sname as string, freeup as integer

    if( s = INVALID ) then
    	exit sub
    end if

	freeup = TRUE

	sname = strpGet( symbolTB(s).nameidx )

	'' local?
	if( symbolTB(s).scope > 0 ) then
		hashDel sname, locsymbhashTB(), FB.INITLOCSYMBOLNODES

    	if( (symbolTB(s).alloctype and FB.ALLOCTYPE.STATIC) = 0 ) then
			strpDel symbolTB(s).nameidx
			strpDel symbolTB(s).aliasidx
    	else
    		freeup = FALSE
    		'' check if it's not a static array descriptor
    		if( (symbolTB(s).typ <> FB.SYMBTYPE.USERDEF) or (symbolTB(s).subtype <> FB.DESCTYPE.ARRAY) ) then
    			strpDel symbolTB(s).nameidx
    			symbolTB(s).nameidx = INVALID
    		end if
    	end if

    '' global..
    else
		hashDel sname, symbhashTB(), FB.INITSYMBOLNODES

		strpDel symbolTB(s).nameidx
		strpDel symbolTB(s).aliasidx
	end if

	if( freeup ) then
    	if( symbolTB(s).v.dims > 0 ) then
    		hDelVarDims s
    	end if

    	symbDelSymbolNode s
    end if

end sub

'':::::
sub symbDelConstUDTOrEnum( byval s as integer )
    dim sname as string

    if( s = INVALID ) then
    	exit sub
    end if

	sname = strpGet( symbolTB(s).nameidx )

	'' local?
	if( symbolTB(s).scope > 0 ) then
		hashDel sname, locsymbhashTB(), FB.INITLOCSYMBOLNODES

    '' global..
    else
		hashDel sname, symbhashTB(), FB.INITSYMBOLNODES
	end if

	strpDel symbolTB(s).nameidx
	strpDel symbolTB(s).aliasidx

    symbDelSymbolNode s

end sub

'':::::
sub symbDelLocalSymbols static
    dim i as integer, n as integer, s as integer

	i = ctx.locsym.head
    do while( i <> INVALID )
    	n = locsymbolTB(i).nxt

    	s = locsymbolTB(i).s
    	if( (symbolTB(s).alloctype and FB.ALLOCTYPE.SHARED) = 0 ) then

    		select case symbolTB(s).class
    		case FB.SYMBCLASS.VAR
    			symbDelVar s
    		case FB.SYMBCLASS.CONST, FB.SYMBCLASS.UDT, FB.SYMBCLASS.ENUM
    			symbDelConstUDTOrEnum s
    		case FB.SYMBCLASS.LABEL
    			symbDelLabel s
    		end select

    	end if

		symbDelLocSymbolNode i

		i = n
    loop

    'strpDump

end sub

'':::::
sub symbFreeLocalDynSymbols( byval proc as integer, byval issub as integer ) static
    dim i as integer, n as integer, s as integer
    dim strg as integer, expr as integer, vr as integer
    dim fres as integer

    '' can't free function's result, that's will be done by the rtlib
    if( issub ) then
    	fres = INVALID
    else
    	fres = symbLookupFunctionResult( proc )
	end if

	i = ctx.locsym.head
    do while( i <> INVALID )
    	n = locsymbolTB(i).nxt

    	s = locsymbolTB(i).s
    	if( symbolTB(s).class = FB.SYMBCLASS.VAR ) then
    		if( (symbolTB(s).alloctype and (FB.ALLOCTYPE.SHARED or FB.ALLOCTYPE.STATIC)) = 0 ) then

				'' not an argument?
    			if( (symbolTB(s).alloctype and (FB.ALLOCTYPE.ARGUMENTBYDESC or _
    				  							FB.ALLOCTYPE.ARGUMENTBYVAL or _
    				  							FB.ALLOCTYPE.ARGUMENTBYREF or _
    				  							FB.ALLOCTYPE.TEMP)) = 0 ) then

					if( symbolTB(s).v.dims > 0 ) then
						if( (symbolTB(s).alloctype and FB.ALLOCTYPE.DYNAMIC) > 0 ) then
							rtlArrayErase s
						elseif( symbolTB(s).typ = FB.SYMBTYPE.STRING ) then
							rtlArrayStrErase s
						end if

					elseif( symbolTB(s).typ = FB.SYMBTYPE.STRING ) then
						'' not funct's result?
						if( s <> fres ) then
							strg = astNewVAR( s, 0, IR.DATATYPE.STRING )
							expr = rtlStrDelete( strg )
							astFlush expr, vr
						end if
					end if

				end if

    		end if
    	end if

    	i = n
    loop

end sub


'':::::
function symbCheckLabels as integer
    dim i as integer

    i = symbGetFirstNode
    do while( i <> INVALID )

    	if( symbolTB(i).scope = env.scope ) then
    		if( symbolTB(i).class = FB.SYMBCLASS.LABEL ) then
    			if( not symbolTB(i).l.declared ) then
    				symbCheckLabels = i
    				exit function
    			end if
    		end if
    	end if

    	i = symbGetNextNode( i )
    loop

	symbCheckLabels = INVALID

end function
