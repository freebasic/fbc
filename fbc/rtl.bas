''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

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
declare sub			rtlGosubModInit		( )

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
declare sub			rtlGosubModEnd		( )


type RTLCTX
	arglist		as TLIST
end type

''globals
	dim shared ctx as RTLCTX
	dim shared rtlLookupTB(0 to FB_RTL_INDEXES-1) as FBSYMBOL ptr


'':::::
sub rtlInit static

	listNew( @ctx.arglist, 8*4, len( FB_CALL_ARG ), LIST_FLAGS_NOCLEAR )

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
	rtlGosubModInit( )

end sub

'':::::
sub rtlEnd

	rtlGosubModEnd( )
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

	listFree( @ctx.arglist )

	'' reset the table as the pointers will change if
	'' the compiler is reinitialized
	erase rtlLookupTB

end sub

'':::::
sub rtlAddIntrinsicProcs _
	( _
		byval procdef as FB_RTL_PROCDEF ptr _
	)

	'' for each proc..
	do
		if( procdef->name = NULL ) then
			exit do
		end if

		dim as integer doadd = TRUE
		if( (procdef->options and (FB_RTL_OPT_MT or FB_RTL_OPT_VBSYMB)) <> 0 ) then
			doadd = fbLangOptIsSet( FB_LANG_OPT_MT or FB_RTL_OPT_VBSYMB )
		end if

		if( doadd ) then
			if( (procdef->options and FB_RTL_OPT_QBONLY) <> 0 ) then
				doadd = ( env.clopt.lang = FB_LANG_QB )
			end if
			if( (procdef->options and FB_RTL_OPT_FBONLY) <> 0 ) then
				doadd = ( env.clopt.lang = FB_LANG_FB )
			end if
			if( (procdef->options and FB_RTL_OPT_NOFB) <> 0 ) then
				doadd = ( env.clopt.lang <> FB_LANG_FB )
			end if
		end if

		if( doadd ) then
			dim as FBSYMBOL ptr proc = symbPreAddProc( NULL )

			'' for each parameter..
			for i as integer = 0 to procdef->params-1
				dim as FBSYMBOL ptr subtype = NULL
				with procdef->paramTb(i)
					dim as integer attrib = any
					dim as ASTNODE ptr param_optval = any
					if( .isopt ) then
						attrib = FB_SYMBATTRIB_OPTIONAL

						select case as const .dtype
						case FB_DATATYPE_STRING
							'' only NULL can be used
							param_optval = astNewCONSTstr( "" )

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							param_optval = astNewCONSTf( .optval, .dtype )

						'' function pointers need a symbol built so they can check matches
						case typeAddrOf( FB_DATATYPE_FUNCTION )
							dim as integer inner_attrib = any, func_arg = any
							dim as integer inner_param_len = any
							dim as ASTNODE ptr inner_param_optval = any
							dim as FBSYMBOL ptr inner_proc = any

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

									if( .dtype <> FB_DATATYPE_INVALID ) then
										inner_param_len = symbCalcParamLen( .dtype, NULL, .mode )
									else
										inner_param_len = FB_POINTERSIZE
									end if

									symbAddProcParam( inner_proc, _
													  NULL, NULL, _
													  .dtype, NULL, inner_param_len, _
													  .mode, _
													  inner_attrib, _
													  inner_param_optval )
								end with
							next

							'' next arg is result type

							i += 1
							with procdef->paramTb(i)

								'' add it
								subtype = symbAddPrototype( inner_proc, _
															NULL, hMakeTmpStrNL( ), NULL, _
															.dtype, NULL, _
															0, FB_FUNCMODE_DEFAULT, _
															FB_SYMBOPT_DECLARING )

								if( subtype <> NULL ) then
									symbSetIsFuncPtr( subtype )
								end if

								'' due to the ambiguity (need to say it's optional to
								'' even get to this point), the symbol's return type will
								'' be what specifies if the parent symbol is optional
                                if( .isopt = FALSE ) then
                                	attrib = 0
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

					dim as integer lgt = FB_POINTERSIZE
					if( .dtype <> FB_DATATYPE_INVALID ) then
						lgt = symbCalcParamLen( .dtype, subtype, .mode )
					else
						.dtype = typeAddrOf( FB_DATATYPE_VOID )
					end if

					var parm = symbAddProcParam( proc, _
					                             NULL, NULL, _
					                             .dtype, subtype, _
					                             lgt, .mode, _
					                             attrib, param_optval )

					if( .check_const ) then
						symbSetIsRTLConst( parm )
					end if

				end with
			next

			''
			dim as FB_SYMBATTRIB attrib = 0
			if( (procdef->options and FB_RTL_OPT_OVER) <> 0 ) then
				attrib = FB_SYMBATTRIB_OVERLOADED
			end if

			if( (procdef->options and FB_RTL_OPT_STRSUFFIX) <> 0 ) then
				attrib or= FB_SYMBATTRIB_SUFFIXED
			end if

			''
			dim as zstring ptr pname = procdef->name

			'' add the '__' prefix if the proc wasn't present in QB and we are in '-lang qb' mode
			if( (procdef->options and FB_RTL_OPT_NOQB) <> 0 ) then
				if( fbLangIsSet( FB_LANG_QB ) ) then
					if( procdef->alias = NULL ) then
						static as string tmp_alias
						tmp_alias = *pname
						procdef->alias = strptr( tmp_alias )
        			end if

        			static as string tmp_name
        			tmp_name = "__" + *pname
        			pname = strptr( tmp_name )
				end if
			end if

			''
			if( procdef->alias = NULL ) then
				procdef->alias = pname
			end if

			'' ordinary proc?
			if( (procdef->options and FB_RTL_OPT_OPERATOR) = 0 ) then
				proc = symbAddPrototype( proc, _
								 	 	 pname, procdef->alias, NULL, _
								 	 	 procdef->dtype, NULL, _
								 	 	 attrib, procdef->callconv, _
								 	 	 FB_SYMBOPT_DECLARING or FB_SYMBOPT_RTL )

			'' operator..
			else
				proc = symbAddOperator( proc, _
										cast( AST_OP, pname ), NULL, NULL, _
    						    		procdef->dtype, NULL, _
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

				if( (procdef->options and FB_RTL_OPT_DUPDECL) <> 0 ) then
					symbSetIsDupDecl( proc )
				end if

				if( (procdef->options and FB_RTL_OPT_GCCBUILTIN) <> 0 ) then
					symbSetIsGccBuiltin( proc )
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
			'' try to prefix it with a '__' if in -lang qb mode
			if( fbLangIsSet( FB_LANG_QB ) ) then
        		static as string tmp_name
        		tmp_name = "__" + *pname
        		pname = strptr( tmp_name )
        		chain_ = symbLookupAt( @symbGetGlobalNamespc( ), pname, FALSE, FALSE )
        		if( chain_ = NULL ) then
					errReportEx( FB_ERRMSG_UNDEFINEDSYMBOL, *pname )
					rtlLookupTB( pidx ) = NULL
				else
					rtlLookupTB( pidx ) = chain_->sym
				end if

			else
				errReportEx( FB_ERRMSG_UNDEFINEDSYMBOL, *pname )
				rtlLookupTB( pidx ) = NULL
			end if
		else
			rtlLookupTB( pidx ) = chain_->sym
		end if
	end if

	function = rtlLookupTB( pidx )

end function

'':::::
function rtlOvlProcCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval param1 as ASTNODE ptr, _
		byval param2 as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FB_ERRMSG err_num = any
    dim as integer args = 0
    dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )

	var arg = symbAllocOvlCallArg( @ctx.arglist, @arg_list, FALSE )
	arg->expr = param1
	arg->mode = FB_PARAMMODE_BYVAL
	args += 1

	if( param2 <> NULL ) then
		arg = symbAllocOvlCallArg( @ctx.arglist, @arg_list, FALSE )
		arg->expr = param2
		arg->mode = FB_PARAMMODE_BYVAL
		args += 1
	end if

	var proc = symbFindClosestOvlProc( sym, args, arg_list.head, @err_num, FB_SYMBLOOKUPOPT_NONE )

	if( proc = NULL ) then
		symbFreeOvlCallArgs( @ctx.arglist, @arg_list )
		return NULL
	end if

	var procexpr = astNewCALL( proc, NULL )

    '' add to tree
	arg = arg_list.head
	do while( arg <> NULL )
        var nxt = arg->next

		if( astNewARG( procexpr, arg->expr, FB_DATATYPE_INVALID, arg->mode ) = NULL ) then
			return NULL
		end if

		symbFreeOvlCallArg( @ctx.arglist, arg )

		'' next
		arg = nxt
	loop

	function = procexpr

end function

'':::::
'' note: this function must be called *before* astNewARG(e) because the
''       expression 'e' can be changed inside the former (address-of string's etc)
function rtlCalcExprLen _
	( _
		byval expr as ASTNODE ptr, _
		byval unpadlen as integer = TRUE _
	) as integer

	dim as FBSYMBOL ptr s = any
	dim as integer dtype = any

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
	) as integer

	dim as FBSYMBOL ptr s

	select case as const typeGet( dtype )
	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
		function = 0

	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		s = astGetSymbol( expr )
		'' pointer?
		if( s = NULL ) then
			function = 0
		else
			if( symbGetType( s ) <> typeGetDtAndPtrOnly( dtype ) ) then
				function = 0
			else
				function = symbGetStrLen( s )
			end if
		end if

	case FB_DATATYPE_WCHAR
		s = astGetSymbol( expr )
		'' pointer?
		if( s = NULL ) then
			function = 0
		else
			if( symbGetType( s ) <> typeGetDtAndPtrOnly( dtype ) ) then
				function = 0
			else
				function = symbGetWStrLen( s )
			end if
		end if

	case else
		function = -1
	end select

end function
