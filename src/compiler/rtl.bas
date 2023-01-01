'' intrinsic runtime lib core routines
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare sub         rtlArrayModInit     ( )
declare sub         rtlConsoleModInit   ( )
declare sub         rtlDataModInit      ( )
declare sub         rtlErrorModInit     ( )
declare sub         rtlFileModInit      ( )
declare sub         rtlGfxModInit       ( )
declare sub         rtlMacroModInit     ( )
declare sub         rtlMathModInit      ( )
declare sub         rtlMemModInit       ( )
declare sub         rtlPrintModInit     ( )
declare sub         rtlProfileModInit   ( )
declare sub         rtlStringModInit    ( )
declare sub         rtlSystemModInit    ( )
declare sub         rtlGosubModInit     ( )
declare sub         rtlOOPModInit       ( )

declare sub         rtlArrayModEnd      ( )
declare sub         rtlConsoleModEnd    ( )
declare sub         rtlDataModEnd       ( )
declare sub         rtlErrorModEnd      ( )
declare sub         rtlFileModEnd       ( )
declare sub         rtlGfxModEnd        ( )
declare sub         rtlMacroModEnd      ( )
declare sub         rtlMathModEnd       ( )
declare sub         rtlMemModEnd        ( )
declare sub         rtlPrintModEnd      ( )
declare sub         rtlProfileModEnd    ( )
declare sub         rtlStringModEnd     ( )
declare sub         rtlSystemModEnd     ( )
declare sub         rtlGosubModEnd      ( )
declare sub         rtlOOPModEnd        ( )


type RTLCTX
	arglist     as TLIST
end type

''globals
	dim shared ctx as RTLCTX
	dim shared rtlLookupTB(0 to FB_RTL_INDEXES-1) as FBSYMBOL ptr


'':::::
sub rtlInit static

	listInit( @ctx.arglist, 8*4, len( FB_CALL_ARG ), LIST_FLAGS_NOCLEAR )

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
	rtlOOPModInit( )

end sub

'':::::
sub rtlEnd

	rtlOOPModEnd( )
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

	listEnd( @ctx.arglist )

	'' reset the table as the pointers will change if
	'' the compiler is reinitialized
	erase rtlLookupTB

end sub

sub rtlAddIntrinsicProcs( byval procdef as const FB_RTL_PROCDEF ptr )
	dim as FBSYMBOL ptr param = any
	dim as integer callconv = any

	'' for each proc..
	do
		if( procdef->name = NULL ) then
			exit do
		end if

		callconv = procdef->callconv

		'' Use the default FBCALL?
		if( callconv = FB_FUNCMODE_FBCALL ) then
			callconv = env.target.fbcall
		end if

		dim as integer doadd = TRUE
		if( procdef->options and FB_RTL_OPT_MT ) then
			doadd = fbLangOptIsSet( FB_LANG_OPT_MT )
		end if

		if( procdef->options and FB_RTL_OPT_X86ONLY ) then
			doadd and= (fbGetCpuFamily( ) = FB_CPUFAMILY_X86)
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
				with procdef->paramTb(i)
					dim as FBSYMBOL ptr subtype = NULL
					dim as integer dtype = any
					dim as ASTNODE ptr param_optval = any
					if( .isopt ) then
						select case as const typeGetDtAndPtrOnly( .dtype )
						case FB_DATATYPE_STRING
							'' only NULL can be used
							param_optval = astNewCONSTstr( "" )

						case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
							param_optval = astNewCONSTf( .optval, .dtype )

						'' function pointers need a symbol built so they can check matches
						case typeAddrOf( FB_DATATYPE_FUNCTION )
							dim as ASTNODE ptr inner_param_optval = any
							dim as FBSYMBOL ptr inner_proc = any

							'' scan through the next args as child args
							inner_proc = symbPreAddProc( NULL )
							for func_arg as integer = 0 to .optval-1
								i += 1

								with procdef->paramTb(i)
									if( .isopt ) then
										select case as const typeGetDtAndPtrOnly( .dtype )
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
									end if

									param = symbAddProcParam( inner_proc, NULL, .dtype, NULL, iif( .mode = FB_PARAMMODE_BYDESC, -1, 0 ), .mode, 0, 0 )
									symbMakeParamOptional( inner_proc, param, inner_param_optval )
								end with
							next

							'' next arg is result type

							i += 1
							with procdef->paramTb(i)
								'' add it
								'' Note: using FBCALL for the function pointer.
								'' Must match the function's declaration in the
								'' rtlib. Currently only fb_ThreadCreate() is
								'' affected.
								subtype = symbAddProcPtr( inner_proc, .dtype, NULL, 0, 0, env.target.fbcall )
							end with

							param_optval = NULL

						case else
							param_optval = astNewCONSTi( .optval, .dtype )

						end select
					else
						param_optval = NULL
					end if

					dtype = .dtype
					if( dtype = FB_DATATYPE_INVALID ) then
						dtype = typeAddrOf( FB_DATATYPE_VOID )
					end if

					param = symbAddProcParam( proc, NULL, dtype, subtype, iif( .mode = FB_PARAMMODE_BYDESC, -1, 0 ), .mode, 0, 0 )

					symbMakeParamOptional( proc, param, param_optval )
				end with
			next

			''
			dim as FB_SYMBATTRIB attrib = FB_SYMBATTRIB_NONE
			dim as FB_PROCATTRIB pattrib = FB_PROCATTRIB_NONE

			if( (procdef->options and FB_RTL_OPT_OVER) <> 0 ) then
				pattrib = FB_PROCATTRIB_OVERLOADED
			end if

			if( (procdef->options and FB_RTL_OPT_STRSUFFIX) <> 0 ) then
				attrib or= FB_SYMBATTRIB_SUFFIXED
			end if

			dim as const zstring ptr pname = procdef->name
			dim as const zstring ptr palias = procdef->alias

			'' add the '__' prefix if the proc wasn't present in QB and we are in '-lang qb' mode
			if( (procdef->options and FB_RTL_OPT_NOQB) <> 0 ) then
				if( fbLangIsSet( FB_LANG_QB ) ) then
					if( palias = NULL ) then
						static as string tmp_alias
						tmp_alias = *pname
						palias = strptr( tmp_alias )
					end if

					static as string tmp_name
					tmp_name = "__" + *pname
					pname = strptr( tmp_name )
				end if
			end if

			if( palias = NULL ) then
				palias = pname
			end if

			proc = symbAddProc( proc, pname, palias, _
			                    procdef->dtype, NULL, attrib, pattrib, callconv, _
			                    FB_SYMBOPT_DECLARING or FB_SYMBOPT_RTL )

			if( proc <> NULL ) then
				symbSetProcCallback( proc, procdef->callback )
				if( (procdef->options and FB_RTL_OPT_ERROR) <> 0 ) then
					symbSetIsThrowable( proc )
				end if
				if( procdef->options and FB_RTL_OPT_CANBECLONED ) then
					proc->stats or= FB_SYMBSTATS_CANBECLONED
				end if
			else
				errReportEx( FB_ERRMSG_DUPDEFINITION, *procdef->name )
			end if
		end if

		'' next
		procdef += 1
	loop
end sub

'':::::
function rtlProcLookup _
	( _
		byval pname as const zstring ptr, _
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

	var proc = symbFindClosestOvlProc( sym, args, arg_list.head, @err_num, FB_SYMBFINDOPT_NONE )

	if( proc = NULL ) then
		symbFreeOvlCallArgs( @ctx.arglist, @arg_list )
		return NULL
	end if

	var procexpr = astNewCALL( proc, NULL )

	'' add to tree
	arg = arg_list.head
	do while( arg <> NULL )
		var nxt = arg->next

		if( astNewARG( procexpr, arg->expr, , arg->mode ) = NULL ) then
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
function rtlCalcExprLen( byval expr as ASTNODE ptr ) as longint
	dim as FBSYMBOL ptr s = any
	dim as integer dtype = any

	dtype = astGetDataType( expr )
	select case as const dtype
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		function = rtlCalcStrLen( expr, dtype )

	case else
		function = symbCalcLen( dtype, astGetSubtype( expr ) )
	end select
end function

'':::::
'' note: this function must be called *before* astNewARG(e) because the
''       expression 'e' can be changed inside the former (address-of string's etc)
'' !!!TODO!!! - in places where rtlCalcStrLen() is called, if it is a UDT
'' that overloads operator len(), then the value returned by operator len() should
'' be prefered to calculating length in the run-time based on the null terminated
'' length.  Many fb_Wstr* functions will need alternate versions that accept a length
'' parameter.
function rtlCalcStrLen _
	( _
		byval expr as ASTNODE ptr, _
		byval dtype as integer _
	) as longint

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
