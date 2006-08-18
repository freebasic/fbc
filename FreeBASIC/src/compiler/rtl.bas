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


#macro CNTPTR(dtype,cnt)
	scope
		dim as integer t
		t = dtype
		cnt = 0
		do while( t >= FB_DATATYPE_POINTER )
			t -= FB_DATATYPE_POINTER
			cnt += 1
		loop
	end scope
#endmacro

'':::::
sub rtlAddIntrinsicProcs( ) static

	dim as string proc_aliasname, param_optstr
	dim as integer proc_params, proc_dtype, proc_mode, attrib, doadd, i
	dim as integer param_dtype, param_len, param_mode, param_opt, ptrcnt
	dim as FBSYMBOL ptr proc
	dim as FBRTLCALLBACK proc_callback
	dim as ASTNODE ptr param_optval
	dim as FBVALUE value
	dim as zstring ptr proc_name, proc_alias
	dim as FB_RTL_OPT proc_options

	''
	do
		'' for each proc..
		read proc_name
		if( proc_name = NULL ) then
			exit do
		end if

		read proc_aliasname
		read proc_dtype, proc_mode
		read proc_callback, proc_options
		read proc_params

		doadd = TRUE
		if( (proc_options and FB_RTL_OPT_MT) <> 0 ) then
			doadd = fbLangOptIsSet( FB_LANG_OPT_MT )
		end if

		proc = symbPreAddProc( NULL )

		'' for each parameter..
		for i = 0 to proc_params-1
			read param_dtype, param_mode, param_opt

			if( param_opt ) then
				attrib = FB_SYMBATTRIB_OPTIONAL

				select case as const param_dtype
				case FB_DATATYPE_STRING
					read param_optstr
					param_optval = astNewCONSTstr( param_optstr )

				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					read value.long
					param_optval = astNewCONSTl( value.long, param_dtype )

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					read value.float
					param_optval = astNewCONSTf( value.float, param_dtype )

				case else
					read value.int
					param_optval = astNewCONSTi( value.int, param_dtype )
				end select

			else
				attrib = 0
				param_optval = NULL
			end if

			if( param_dtype <> INVALID ) then
				param_len = symbCalcParamLen( param_dtype, NULL, param_mode )
			else
				param_len = FB_POINTERSIZE
			end if

			CNTPTR( param_dtype, ptrcnt )

			symbAddProcParam( proc, NULL, _
							  param_dtype, NULL, ptrcnt, _
							  param_len, param_mode, INVALID, _
							  attrib, param_optval )
		next

		''
		if( (proc_options and FB_RTL_OPT_OVER) <> 0 ) then
			attrib = FB_SYMBATTRIB_OVERLOADED
		else
			attrib = 0
		end if

		''
		CNTPTR( proc_dtype, ptrcnt )

		if( len( proc_aliasname ) = 0 ) then
			proc_alias = proc_name
		else
			proc_alias = strptr( proc_aliasname )
		end if

		if( doadd ) then
			proc = symbAddPrototype( proc, _
								 	 proc_name, proc_alias, "fb", _
								 	 proc_dtype, NULL, ptrcnt, _
								 	 attrib, proc_mode, _
								 	 FB_SYMBOPT_DECLARING )

			if( proc <> NULL ) then
				symbSetIsRTL( proc )
				symbSetProcCallback( proc, proc_callback )
				if( (proc_options and FB_RTL_OPT_ERROR) <> 0 ) then
					symbSetIsThrowable( proc )
				end if
			else
				errReportEx( FB_ERRMSG_DUPDEFINITION, *proc_name )
			end if
		end if
	loop

end sub

'':::::
function rtlProcLookup _
	( _
		byval pname as zstring ptr, _
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
function rtlCalcExprLen _
	( _
		byval expr as ASTNODE ptr, _
		byval unpadlen as integer = TRUE _
	) as integer static

	dim as FBSYMBOL ptr s
	dim as integer dtype

	function = -1

	dtype = astGetDataType( expr )
	select case as const dtype
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		function = rtlCalcStrLen( expr, dtype )

	case FB_DATATYPE_STRUCT
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
function rtlCalcStrLen _
	( _
		byval expr as ASTNODE ptr, _
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



