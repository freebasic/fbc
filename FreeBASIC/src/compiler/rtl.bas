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
declare sub			rtlProfileModInit	( )
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
declare sub			rtlProfileModEnd	( )
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
	rtlProfileModInit( )
	rtlStringModInit( )
	rtlSystemModInit( )

end sub

'':::::
sub rtlEnd

	rtlSystemModEnd( )
	rtlStringModEnd( )
	rtlProfileModEnd( )
	rtlPrintModEnd( )
	rtlMemModEnd( )
	rtlMathModEnd( )
	rtlMacroModEnd( )
	rtlGfxModEnd( )
	rtlFileModEnd( )
	rtlErrorModEnd( )
	rtlDataModEnd( )
	rtlConsoleModEnd( )
	rtlArrayModEnd( )

	'' reset the table as the pointers will change if
	'' the compiler is reinitialized
	erase rtlLookupTB

end sub


#define CNTPTR(typ,t,cnt)						_
	t = typ                                     : _
	cnt = 0                                     : _
	do while( t >= FB_DATATYPE_POINTER )		: _
		t -= FB_DATATYPE_POINTER				: _
		cnt += 1								: _
	loop


'':::::
sub rtlAddIntrinsicProcs( )
	dim as integer typ
	dim as string aname, optstr
	dim as integer p, pargs, ptype, pmode, pattrib
	dim as integer a, atype, alen, amode, optional, ptrcnt, checkerror, overloaded
	dim as FBSYMBOL ptr proc
	dim as FBRTLCALLBACK pcallback
	dim as ASTNODE ptr optval
	dim as FBVALUE value
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
		read pcallback, checkerror, overloaded
		read pargs

		assert( ( checkerror and ptype = FB_DATATYPE_INTEGER ) or not checkerror )

		proc = symbPreAddProc( NULL )

		'' for each parameter..
		for a = 0 to pargs-1
			read atype, amode, optional

			if( optional ) then
				select case as const atype
				case FB_DATATYPE_STRING
					read optstr
					optval = astNewCONSTstr( optstr )

				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					read value.long
					optval = astNewCONSTl( value.long, atype )

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					read value.float
					optval = astNewCONSTf( value.float, atype )

				case else
					read value.int
					optval = astNewCONSTi( value.int, atype )
				end select

			else
				optval = NULL
			end if

			if( atype <> INVALID ) then
				alen = symbCalcParamLen( atype, NULL, amode )
			else
				alen = FB_POINTERSIZE
			end if

			CNTPTR( atype, typ, ptrcnt )

			symbAddProcParam( proc, NULL, _
							  atype, NULL, ptrcnt, _
							  alen, amode, INVALID, _
							  optional, optval )
		next

		''
		if( overloaded ) then
			pattrib = FB_SYMBATTRIB_OVERLOADED
		else
			pattrib = 0
		end if

		''
		CNTPTR( ptype, typ, ptrcnt )

		if( len( aname ) = 0 ) then
			palias = pname
		else
			palias = strptr( aname )
		end if

		proc = symbAddPrototype( proc, _
								 pname, palias, "fb", _
								 ptype, NULL, ptrcnt, _
								 pattrib, pmode, TRUE )

		''
		if( proc <> NULL ) then
			symbSetIsRTL( proc )
			symbSetProcCallback( proc, pcallback )
			if( checkerror ) then
				symbSetIsThrowable( proc )
			end if
		else
			errReportEx( FB_ERRMSG_DUPDEFINITION, *pname )
		end if
	loop

end sub

'':::::
function rtlProcLookup( byval pname as zstring ptr, _
			   			byval pidx as integer _
			 		  ) as FBSYMBOL ptr static

    dim as integer id, class
    dim as FBSYMCHAIN ptr chain_

    '' not cached yet? -- this won't work if #undef is used
    '' what is pretty unlikely with internal fb_* procs
	if( rtlLookupTB( pidx ) = NULL ) then
		chain_ = symbLookup( pname, id, class )
		if( chain_ = NULL ) then
			errReportEx( FB_ERRMSG_UNDEFINEDSYMBOL, *pname )
			rtlLookupTB( pidx ) = NULL
		else
			rtlLookupTB( pidx ) = chain_->sym
		end if
	end if

	function = rtlLookupTB( pidx )

end function

'':::::
'' note: this function must be called *before* astNewARG(e) because the
''       expression 'e' can be changed inside the former (address-of string's etc)
function rtlCalcExprLen( byval expr as ASTNODE ptr, _
						 byval unpadlen as integer = TRUE _
					   ) as integer static

	dim as FBSYMBOL ptr s
	dim as integer dtype

	function = -1

	dtype = astGetDataType( expr )
	select case as const dtype
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		function = rtlCalcStrLen( expr, dtype )

	case FB_DATATYPE_USERDEF
		s = astGetSubtype( expr )
		if( s <> NULL ) then
			'' if it's a type field that's an udt, no padding is
			'' ever added, unpadlen must be always TRUE
			if( astIsFIELD( expr ) ) then
				unpadlen = TRUE
			end if

			function = symbGetUDTLen( s, unpadlen )

		else
			function = 0
		end if

	case else
		function = symbCalcLen( dtype, NULL )
	end select

end function

'':::::
'' note: this function must be called *before* astNewARG(e) because the
''		 expression 'e' can be changed inside the former (address-of string's etc)
function rtlCalcStrLen( byval expr as ASTNODE ptr, _
						byval dtype as integer _
					  ) as integer static

	dim as FBSYMBOL ptr s

	select case as const dtype
	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
		function = 0

	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		s = astGetSymbol( expr )
		'' pointer?
		if( s = NULL ) then
			function = 0
		else
			function = symbGetStrLen( s )
		end if

	case FB_DATATYPE_WCHAR
		s = astGetSymbol( expr )
		'' pointer?
		if( s = NULL ) then
			function = 0
		else
			function = symbGetWstrLen( s )
		end if

	case else
		function = -1
	end select

end function



