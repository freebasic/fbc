''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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
		do while( typeGetDatatype( t ) = FB_DATATYPE_POINTER )
			t = typeDeref( t )
			cnt += 1
		loop
	end scope
#endmacro

'':::::
sub rtlAddIntrinsicProcs _
	( _
		byval procdef as FB_RTL_PROCDEF ptr _
	) static

	dim as integer attrib, doadd, i
	dim as integer param_len, ptrcnt
	dim as FBSYMBOL ptr proc
	dim as ASTNODE ptr param_optval
	dim as FBSYMBOL ptr subtype

	'' for each proc..
	do
		if( procdef->name = NULL ) then
			exit do
		end if

		doadd = TRUE
		if( (procdef->options and (FB_RTL_OPT_MT or FB_RTL_OPT_VBSYMB)) <> 0 ) then
			doadd = fbLangOptIsSet( FB_LANG_OPT_MT or FB_RTL_OPT_VBSYMB )
		end if

		if( doadd ) then
			proc = symbPreAddProc( NULL )
			
			'' for each parameter..
			for i = 0 to procdef->params-1
				subtype = NULL
				with procdef->paramTb(i)
					if( .isopt ) then
						attrib = FB_SYMBATTRIB_OPTIONAL

						select case as const .dtype
						case FB_DATATYPE_STRING
							'' only NULL can be used
							param_optval = astNewCONSTstr( "" )

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							param_optval = astNewCONSTf( .optval, .dtype )

						'' function pointers need a symbol built so they can check matches
						case typeSetType(FB_DATATYPE_FUNCTION, 1)
							dim as integer inner_attrib, func_arg
							dim as integer inner_param_len, inner_ptrcnt
							dim as ASTNODE ptr inner_param_optval
							dim as FBSYMBOL ptr inner_proc
							
							'' scan through the next args as child args
							inner_proc = symbPreAddProc( NULL )
							for func_arg = 0 to .optval-1
								i += 1
								
								with procdef->paramTb(i)
									if( .isopt ) then
										inner_attrib = FB_SYMBATTRIB_OPTIONAL
										select case as const .dtype
										case FB_DATATYPE_STRING
											'' only NULL can be used
											inner_param_optval = astNewCONSTstr( "" )
				
										case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
											inner_param_optval = astNewCONSTf( .optval, .dtype )
				
										case else
											inner_param_optval = astNewCONSTi( .optval, .dtype )
										end select
									else
										inner_param_optval = NULL
										inner_attrib = 0
									end if
										
									if( .dtype <> INVALID ) then
										inner_param_len = symbCalcParamLen( .dtype, NULL, .mode )
									else
										inner_param_len = FB_POINTERSIZE
									end if
									
									CNTPTR( .dtype, inner_ptrcnt )
									
									symbAddProcParam( inner_proc, NULL, _
													  .dtype, NULL, typeGetPtrCnt(.dtype), _
													  inner_param_len, .mode, INVALID, _
													  inner_attrib, inner_param_optval )
								end with
							next
							
							'' next arg is result type
							i += 1
							with procdef->paramTb(i)
								
								'' add it
								subtype = symbAddPrototype( inner_proc, _
															NULL, NULL, NULL, _
															.dtype, NULL, typeGetPtrCnt(.dtype), _
															0, FB_FUNCMODE_DEFAULT, _
															FB_SYMBOPT_DECLARING )
								
								if( subtype <> NULL ) then
									symbSetIsFuncPtr( subtype )
								end if
								
							end with
							
							param_optval = NULL
						
						case else
							param_optval = astNewCONSTi( .optval, .dtype )

						end select
					else
						attrib = 0
						param_optval = NULL
					end if

					if( .dtype <> INVALID ) then
						param_len = symbCalcParamLen( .dtype, subtype, .mode )
					else
						param_len = FB_POINTERSIZE
					end if
					
					CNTPTR( .dtype, ptrcnt )

					symbAddProcParam( proc, NULL, _
							  	  	 .dtype, subtype, ptrcnt, _
							  	  	 param_len, .mode, INVALID, _
							  	  	 attrib, param_optval )

				end with
			next

			''
			if( (procdef->options and FB_RTL_OPT_OVER) <> 0 ) then
				attrib = FB_SYMBATTRIB_OVERLOADED
			else
				attrib = 0
			end if

			''
			CNTPTR( procdef->dtype, ptrcnt )

			if( procdef->alias = NULL ) then
				procdef->alias = procdef->name
			end if

			'' ordinary proc?
			if( (procdef->options and FB_RTL_OPT_OPERATOR) = 0 ) then
				proc = symbAddPrototype( proc, _
								 	 	 procdef->name, procdef->alias, NULL, _
								 	 	 procdef->dtype, NULL, ptrcnt, _
								 	 	 attrib, procdef->callconv, _
								 	 	 FB_SYMBOPT_DECLARING or FB_SYMBOPT_RTL )

			'' operator..
			else
				proc = symbAddOperator( proc, _
										cast( AST_OP, procdef->name ), NULL, NULL, _
    						    		procdef->dtype, NULL, ptrcnt, _
    					        		attrib or FB_SYMBATTRIB_OPERATOR, _
    					        		procdef->callconv, _
    					        		FB_SYMBOPT_DECLARING or FB_SYMBOPT_RTL )

    			if( proc <> NULL ) then
    				symbGetMangling( proc ) = FB_MANGLING_CPP
    			end if
			end if

			if( proc <> NULL ) then
				symbSetProcCallback( proc, procdef->callback )
				if( (procdef->options and FB_RTL_OPT_ERROR) <> 0 ) then
					symbSetIsThrowable( proc )
				end if
			else
				if( (procdef->options and FB_RTL_OPT_OPERATOR) = 0 ) then
					errReportEx( FB_ERRMSG_DUPDEFINITION, *procdef->name )
				else
					errReport( FB_ERRMSG_DUPDEFINITION )
				end if
			end if
		end if

		'' next
		procdef += 1
	loop

end sub

'':::::
function rtlProcLookup _
	( _
		byval pname as zstring ptr, _
		byval pidx as integer _
	) as FBSYMBOL ptr

    dim as FBSYMCHAIN ptr chain_ = any

    '' not cached yet? -- this won't work if #undef is used
    '' what is pretty unlikely with internal fb_* procs
	if( rtlLookupTB( pidx ) = NULL ) then
		chain_ = symbLookupAt( @symbGetGlobalNamespc( ), pname, FALSE, FALSE )
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



