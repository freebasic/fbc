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


'' intrinsic runtime lib core routines
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

declare sub			rtlArrayModInit		( )
declare sub			rtlConsoleModInit	( )
declare sub			rtlDataModInit		( )
declare sub			rtlErrorModInit		( )
declare sub			rtlFileModInit		( )
declare sub			rtlGfxModInit		( )
declare sub			rtlMacroModInit		( )
declare sub			rtlMathModInit		( )
declare sub			rtlMemModInit		( )
declare sub			rtlPrintModInit		( )
declare sub			rtlStringModInit	( )
declare sub			rtlSystemModInit	( )

declare sub			rtlArrayModEnd		( )
declare sub			rtlConsoleModEnd	( )
declare sub			rtlDataModEnd		( )
declare sub			rtlErrorModEnd		( )
declare sub			rtlFileModEnd		( )
declare sub			rtlGfxModEnd		( )
declare sub			rtlMacroModEnd		( )
declare sub			rtlMathModEnd		( )
declare sub			rtlMemModEnd		( )
declare sub			rtlPrintModEnd		( )
declare sub			rtlStringModEnd		( )
declare sub			rtlSystemModEnd		( )


''globals
	dim shared rtlLookupTB(0 to FB_RTL_INDEXES-1) as FBSYMBOL ptr


'':::::
sub rtlInit static

	''
	fbAddDefaultLibs( )

	rtlArrayModInit( )
	rtlConsoleModInit( )
	rtlDataModInit( )
	rtlErrorModInit( )
	rtlFileModInit( )
	rtlGfxModInit( )
	rtlMacroModInit( )
	rtlMathModInit( )
	rtlMemModInit( )
	rtlPrintModInit( )
	rtlStringModInit( )
	rtlSystemModInit( )

end sub

'':::::
sub rtlEnd

	rtlStringModEnd( )
	rtlPrintModEnd( )
	rtlMemModEnd( )
	rtlSystemModEnd( )
	rtlMathModEnd( )
	rtlMacroModEnd( )
	rtlGfxModEnd( )
	rtlFileModEnd( )
	rtlErrorModEnd( )
	rtlDataModEnd( )
	rtlConsoleModEnd( )
	rtlArrayModEnd( )

	'' reset the table as the pointers will change if
	'' the compiler is reseted
	erase rtlLookupTB

end sub


#define CNTPTR(typ,t,cnt)						_
	t = typ                                     : _
	cnt = 0                                     : _
	do while( t >= IR_DATATYPE_POINTER )		: _
		t -= IR_DATATYPE_POINTER				: _
		cnt += 1								: _
	loop


'':::::
sub rtlAddIntrinsicProcs( )
	dim as integer typ
	dim as string aname, optstr
	dim as integer p, pargs, ptype, pmode, palloctype
	dim as integer a, atype, alen, amode, optional, ptrcnt, errorcheck, overloaded
	dim as FBSYMBOL ptr proc
	dim as FBRTLCALLBACK pcallback
	dim as FBVALUE optval
	dim as zstring ptr pname, palias

	''
	do
		'' for each proc..
		read pname
		if( pname = NULL ) then
			exit do
		end if

		read aname
		read ptype, pmode
		read pcallback, errorcheck, overloaded
		read pargs

		assert( ( errorcheck and ptype = FB_SYMBTYPE_INTEGER ) or not errorcheck )

		proc = symbPreAddProc( )

		'' for each argument..
		for a = 0 to pargs-1
			read atype, amode, optional

			if( optional ) then
				select case as const atype
				case IR_DATATYPE_STRING
					read optstr
					optval.str = hAllocStringConst( optstr, 0 )
				case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
					read optval.long
				case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
					read optval.float
				case else
					read optval.int
				end select
			end if

			if( atype <> INVALID ) then
				alen = symbCalcArgLen( atype, NULL, amode )
			else
				alen = FB_POINTERSIZE
			end if

			CNTPTR( atype, typ, ptrcnt )

			symbAddArg( proc, NULL, _
						atype, NULL, ptrcnt, _
						alen, amode, INVALID, _
						optional, @optval )
		next

		''
		if( overloaded ) then
			palloctype = FB_ALLOCTYPE_OVERLOADED
		else
			palloctype = 0
		end if

		''
		CNTPTR( ptype, typ, ptrcnt )

		if( len( aname ) = 0 ) then
			palias = pname
		else
			palias = strptr( aname )
		end if

		proc = symbAddPrototype( proc, _
								 pname, palias, strptr( "fb" ), _
								 ptype, NULL, ptrcnt, _
								 palloctype, pmode, TRUE )

		''
		if( proc <> NULL ) then
			symbSetProcIsRTL( proc, TRUE )
			symbSetProcCallback( proc, pcallback )
			symbSetProcErrorCheck( proc, errorcheck )
		else
			hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *pname )
		end if
	loop

end sub

'':::::
function rtlProcLookup( byval pname as zstring ptr, _
			   			byval pidx as integer _
			 		  ) as FBSYMBOL ptr static

    dim as integer id, class

    '' not cached yet? -- this won't work if #undef is used
    '' what is pretty unlikely with internal fb_* procs
	if( rtlLookupTB( pidx ) = NULL ) then
		rtlLookupTB( pidx ) = symbLookup( pname, id, class )
		if( rtlLookupTB( pidx ) = NULL ) then
			hReportErrorEx( FB_ERRMSG_UNDEFINEDSYMBOL, *pname )
		end if
	end if

	function = rtlLookupTB( pidx )

end function

'':::::
'' note: rtlCalcExprLen must be called *before* astNewPARAM(e) because the
''       expression 'e' can be changed inside the former (address-of string's etc)
function rtlCalcExprLen( byval expr as ASTNODE ptr, _
						 byval realsize as integer = TRUE _
					   ) as integer static

	dim as FBSYMBOL ptr s
	dim as integer lgt, dtype

	function = -1

	dtype = astGetDataType( expr )
	select case dtype
	case IR_DATATYPE_FIXSTR
		function = FIXSTRGETLEN( expr )

	case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
		lgt = ZSTRGETLEN( expr )
		'' char?
		if( lgt = 0 ) then
			function = 1
		else
			function = lgt
		end if

	case IR_DATATYPE_USERDEF
		s = astGetSymbolOrElm( expr )
		if( s <> NULL ) then
			'' if it's a type field that's an udt, no padding is
			'' ever added, realsize is always TRUE
			if( symbIsUDTElm( s ) ) then
				realsize = TRUE
			end if
			function = symbGetUDTLen( symbGetSubtype( s ), realsize )
		else
			function = 0
		end if

	case else
		function = symbCalcLen( dtype, NULL )
	end select

end function

