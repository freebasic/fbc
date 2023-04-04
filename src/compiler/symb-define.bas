'' symbol table module for defines and macros
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "lex.bi"
#include once "hlp.bi"
#include once "pp.bi"

#include once "datetime.bi"
#include once "string.bi"

type SYMBDEF
	name            as const zstring ptr
	value           as zstring ptr
	flags           as integer  '' FB_DEFINE_FLAGS_*
	proc            as FBS_DEFINE_PROCZ
end type

private function hDefFile_cb() as string static
	function = env.inf.name
end function

private function hDefPath_cb() as string static
	function = fbGetInputFileParentDir( )
end function

private function hDefFunction_cb() as string
	if( symbGetIsMainProc( parser.currproc ) ) then
		function = FB_MAINPROCNAME
	elseif( symbGetIsModLevelProc( parser.currproc ) ) then
		function = FB_MODLEVELNAME
	else
		function = *symbGetFullProcName( parser.currproc )
	end if
end function

private function hDefLine_cb() as string static
	function = str( lexLineNum( ) )
end function

private function UnixTimeToDateSerial( byval dat as longint ) as double
	return 25569# + (cdbl(dat) / 86400#)
end function

/'
'' for reference, reverse of UnixTimeToDateSerial()
private function DateSerialToUnixTime( byval dat as double ) as longint
	return (dat - 25569#) * 86400#
end function
'/

private function hCheckSourceDateEpoch( byref s as string ) as boolean
	dim tmp as string
	dim value as double

	'' ignore trailing/leading spaces
	tmp = trim( s )

	'' don't allow if it was only spaces
	if( len(tmp) = 0 ) then
		return FALSE
	end if

	'' Any invalid characters? (only allow characters 0123456789)
	for i as integer = 0 to len(tmp)-1
		if( (s[i] < CHAR_0) or (s[i] > CHAR_9) ) then
			return FALSE
		end if
	next

	'' don't allow if greater than 9999-12-31 23:59:59
	value = culngint(s)
	if( culngint(value) > 253402300799ull ) then
		return FALSE
	end if

	return TRUE
end function

private function hGetCompileTime() as double

	'' usage = 0 - first time called - do checks
	''         1 - use current date/time
	''         2 - SOURCE_DATE_EPOCH set and valid
	''
	'' source_date_epoch = cached value of SOURCE_DATE_EPOCH

	static usage as integer = 0
	static source_date_epoch as double = 0

	if( usage = 0 ) then
		dim ret as string

		usage = 1
		ret = environ( "SOURCE_DATE_EPOCH" )

		if( len(ret) > 0 ) then
			if( hCheckSourceDateEpoch( ret ) ) then
				source_date_epoch = UnixTimeToDateSerial( culngint(ret) )
				usage = 2
			else
				errReportEx( FB_ERRMSG_MALFORMEDSOURCEDATEEPOCH, NULL )
			end if
		end if
	end if

	if( usage = 2 ) then
		function = source_date_epoch
	else
		function = now()
	end if
end function

private function hDefDate_cb() as string static
	function = format( hGetCompileTime(), "mm-dd-yyyy" )
end function

private function hDefDateISO_cb() as string static
	function = format( hGetCompileTime(), "yyyy-mm-dd" )
end function

private function hDefTime_cb() as string static
	function = format( hGetCompileTime(), "hh:nn:ss" )
end function

private function hDefMultithread_cb() as string static
	function = str( env.clopt.multithreaded )
end function

private function hDefOptByval_cb() as string
	function = str( env.opt.parammode = FB_PARAMMODE_BYVAL )
end function

private function hDefOptDynamic_cb() as string
	function = str( env.opt.dynamic = TRUE )
end function

private function hDefOptEscape_cb() as string
	function = str( env.opt.escapestr = TRUE )
end function

private function hDefOptExplicit_cb() as string
	function = str( env.opt.explicit = TRUE )
end function

private function hDefOptPrivate_cb() as string
	function = str( env.opt.procpublic = FALSE )
end function

private function hDefOptGosub_cb() as string
	function = str( env.opt.gosub = TRUE )
end function

private function hDefGui_cb () as string
	function = str( env.clopt.modeview = FB_MODEVIEW_GUI )
end function

private function hDefOptimize_cb () as string
	function = str( fbGetOption( FB_COMPOPT_OPTIMIZELEVEL ) )
end function

private function hDefOutExe_cb() as string
	function = str( env.clopt.outtype = FB_OUTTYPE_EXECUTABLE )
end function

private function hDefOutLib_cb() as string
	function = str( env.clopt.outtype = FB_OUTTYPE_STATICLIB )
end function

private function hDefOutDll_cb() as string
	function = str( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB )
end function

private function hDefOutObj_cb() as string
	function = str( env.clopt.outtype = FB_OUTTYPE_OBJECT )
end function

private function hDefDebug_cb() as string
	function = str( env.clopt.debug )
end function

private function hDefErr_cb() as string
	dim as integer res = &h0000

	if( env.clopt.errorcheck ) then
		res = &h0001
	end if

	if( env.clopt.resumeerr ) then
		res or= &h0002
	end if

	if( env.clopt.extraerrchk ) then
		res or= &h0004
	end if

	if( env.clopt.arrayboundchk ) then
		res or= &h0008
	end if

	if( env.clopt.nullptrchk ) then
		res or= &h0010
	end if

	if( env.clopt.assertions ) then
		res or= &h0020
	end if

	if( env.clopt.debuginfo ) then
		res or= &h0040
	end if

	if( env.clopt.debug ) then
		res or= &h0080
	end if

	if( env.clopt.errlocation ) then
		res or= &h0100
	end if

	if( env.clopt.unwindinfo ) then
		res or= &h0200
	end if

	function = str( res )
end function

private function hDefLang_cb() as string static
	function = fbGetLangName( env.clopt.lang )
end function

private function hDefBackend_cb() as string static
	function = fbGetBackendName( env.clopt.backend )
end function

private function hDefFpu_cb() as string static
	select case fbGetOption( FB_COMPOPT_FPUTYPE )
	case FB_FPUTYPE_FPU
		return "x87"
	case FB_FPUTYPE_SSE
		return "sse"
	case else
		assert( 0 )
	end select
end function

private function hDefFpmode_cb() as string static
	select case fbGetOption( FB_COMPOPT_FPMODE )
	case FB_FPMODE_PRECISE
		return "precise"
	case FB_FPMODE_FAST
		return "fast"
	case else
		assert( 0 )
	end select
end function

private function hDefGcc_cb() as string static
	function = str( (env.clopt.backend = FB_BACKEND_GCC) )
end function

private function hDefAsm_cb() as string
	select case( env.clopt.asmsyntax )
	case FB_ASMSYNTAX_INTEL : function = "intel"
	case FB_ASMSYNTAX_ATT   : function = "att"
	end select
end function

private function hMacro_getArgZ( byval argtb as LEXPP_ARGTB ptr, byval num as integer = 0 ) as zstring ptr
	dim as zstring ptr res = NULL

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		var dt = argtb->tb(num).text.data
		if( dt = NULL ) then
			return null
		end if
		ZstrAssign(@res, dt)
	else
		var dt = argtb->tb(num).textw.data
		if( dt = NULL ) then
			return null
		end if
		ZstrAssignW(@res, dt)
	end if

	function = res

end function

private function hMacro_getArgW( byval argtb as LEXPP_ARGTB ptr, byval num as integer = 0 ) as wstring ptr

	static as DWSTRING res
	DWstrAssign( res, NULL )

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		var dt = argtb->tb(num).text.data
		if( dt = NULL ) then
			return null
		end if
		DWstrConcatAssignA(res, dt)
	else
		var dt = argtb->tb(num).textw.data
		if( dt = NULL ) then
			return null
		end if
		DWstrConcatAssign(res, dt)
	end if

	function = res.data

end function

private function hMacro_EvalZ( byval arg as zstring ptr, byval errnum as integer ptr ) as string

	'' the expression should have already been handled in hLoadMacro|hLoadMacroW
	'' so, if we do get here, just pass the argument back as-is
	'' !!!TODO!!! - DZSTRING can be replaced by STRING
	dim as DZSTRING res
	DZStrAssign( res, NULL )

	if( env.includerec >= FB_MAXINCRECLEVEL ) then
		*errnum = FB_ERRMSG_RECLEVELTOODEEP
		return *res.data
	end if

	if( arg ) then

		'' create a lightweight context push for the lexer
		'' like an include file, but no named include file
		'' - text to expand is to be loaded in LEX.CTX->DEFTEXT[W]
		'' - use the parser to build an AST for the literal result

		lexPushCtx()
		lexInit( FALSE, TRUE )

		'' prevent cExpression from writing to .pp.bas file
		lex.ctx->reclevel += 1

		DZstrAssign( lex.ctx->deftext, *arg )
		lex.ctx->defptr = lex.ctx->deftext.data
		lex.ctx->deflen += len( *arg )

		'' Add an end of expression marker so that the parser
		'' doesn't read past the end of the expression text
		'' by appending an LFCHAR to the end of the expression
		'' It would be better to use the explicit EOF character,
		'' but we can't appened an extra NUL character to a zstring

		DZstrConcatAssign( lex.ctx->deftext, LFCHAR )
		lex.ctx->defptr = lex.ctx->deftext.data
		lex.ctx->deflen += len( LFCHAR )

		dim expr as ASTNODE ptr = cExpression( )
		var errmsg = FB_ERRMSG_OK

		if( expr <> NULL ) then
			expr = astOptimizeTree( expr )

			if( astIsCONST( expr ) ) then
				DZStrAssign( res, astConstFlushToStr( expr ) )

				'' any tokens still in the buffer? cExpression() should have used them all
				if( lexGetToken( ) <> FB_TK_EOL ) then
					errmsg = FB_ERRMSG_SYNTAXERROR
				end if
			elseif( astIsConstant( expr ) ) then
				DZStrAssign( res, symbGetConstStrAsStr( expr->sym ) )
				'' any tokens still in the buffer? cExpression() should have used them all
				if( lexGetToken( ) <> FB_TK_EOL ) then
					errmsg = FB_ERRMSG_SYNTAXERROR
				end if
				astDelTree( expr )
			else
				astDelTree( expr )
				errmsg = FB_ERRMSG_EXPECTEDCONST
				DZStrAssign( res, !"\000" )
			end if
		else
			errmsg = FB_ERRMSG_SYNTAXERROR
		end if

		lex.ctx->reclevel -= 1

		lexPopCtx()

		if( errmsg <> FB_ERRMSG_OK ) then
			errReportEx( errmsg, *arg )
			'' error recovery: skip until next line (in the buffer)
			hSkipUntil( FB_TK_EOL, TRUE )
		end if

	end if

	function = *res.data

end function

private function hMacro_EvalW( byval arg as wstring ptr, byval errnum as integer ptr ) as wstring ptr

	'' the expression should have already been handled in hLoadMacro|hLoadMacroW
	'' so, if we do get here, just pass the argument back as-is
	'' !!!TODO!!! - We must use DWSTRING since we don't have a built-in var-len wstring
	'' but, if we did have a var-len wstring, we should use it instead

	static as DWSTRING res
	DWStrAssign( res, NULL )

	if( env.includerec >= FB_MAXINCRECLEVEL ) then
		*errnum = FB_ERRMSG_RECLEVELTOODEEP
		return res.data
	end if

	if( arg ) then

		'' create a lightweight context push for the lexer
		'' like an include file, but no named include file
		'' - text to expand is to be loaded in LEX.CTX->DEFTEXT[W]
		'' - use the parser to build an AST for the literal result

		lexPushCtx()
		lexInit( FALSE, TRUE )

		'' prevent cExpression from writing to .pp.bas file
		lex.ctx->reclevel += 1

		DWstrAssign( lex.ctx->deftextw, *arg )
		lex.ctx->defptrw = lex.ctx->deftextw.data
		lex.ctx->deflen += len( *arg )

		'' Add an end of expression marker so that the parser
		'' doesn't read past the end of the expression text
		'' by appending an LFCHAR to the end of the expression
		'' It would be better to use the explicit EOF character,
		'' but we can't appened an extra NUL character to a zstring

		DWstrConcatAssign( lex.ctx->deftextw, LFCHAR )
		lex.ctx->defptrw = lex.ctx->deftextw.data
		lex.ctx->deflen += len( LFCHAR )

		dim expr as ASTNODE ptr = cExpression( )
		var errmsg = FB_ERRMSG_OK

		if( expr <> NULL ) then
			expr = astOptimizeTree( expr )

			if( astIsCONST( expr ) ) then
				DWStrAssign( res, astConstFlushToWstr( expr ) )

				'' any tokens still in the buffer? cExpression() should have used them all
				if( lexGetToken( ) <> FB_TK_EOL ) then
					errmsg = FB_ERRMSG_SYNTAXERROR
				end if
			elseif( astIsConstant( expr ) ) then
				DWStrAssign( res, symbGetConstStrAsWstr( expr->sym ) )
				'' any tokens still in the buffer? cExpression() should have used them all
				if( lexGetToken( ) <> FB_TK_EOL ) then
					errmsg = FB_ERRMSG_SYNTAXERROR
				end if
				astDelTree( expr )
			else
				astDelTree( expr )
				errmsg = FB_ERRMSG_EXPECTEDCONST
				DWStrAssign( res, !"\u0000" )
			end if
		else
			errmsg = FB_ERRMSG_SYNTAXERROR
		end if

		lex.ctx->reclevel -= 1

		lexPopCtx()

		if( errmsg <> FB_ERRMSG_OK ) then
			errReportEx( errmsg, *arg )
			'' error recovery: skip until next line (in the buffer)
			hSkipUntil( FB_TK_EOL, TRUE )
		end if

	end if

	function = res.data

end function

private function hDefUniqueIdPush_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_UNIQUEID_PUSH__( STACKID )

	''  if skipping over code, don't cause side effects
	if( pp.skipping ) then
		return ""
	end if

	var id = hMacro_getArgZ( argtb )
	if( id = null ) then
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
		return ""
	end if

	var stk = cast(SYMB_DEF_UniqueId_Stack ptr, hashLookup(@symb.def.uniqueid.dict, id))

	if( stk = NULL ) then
		stk = callocate(len(SYMB_DEF_UniqueId_Stack))
		hashAdd(@symb.def.uniqueid.dict, id, stk, cuint( INVALID ))
	else
		ZstrFree(id)
	end if

	var elm = cast(SYMB_DEF_UniqueId_Elm ptr, allocate(len(SYMB_DEF_UniqueId_Elm)))

	var uid = symbUniqueId(true)
	elm->name = allocate(len(*uid)+1)
	*elm->name = *uid
	elm->prev = stk->top

	stk->top = elm

	function = ""
end function

private function hDefUniqueId_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_UNIQUEID__( STACKID )

	''  if skipping over code, don't cause side effects
	if( pp.skipping ) then
		return ""
	end if

	var id = hMacro_getArgZ( argtb )
	if( id = null ) then
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
		return ""
	end if

	var stk = cast(SYMB_DEF_UniqueId_Stack ptr, hashLookup(@symb.def.uniqueid.dict, id))

	ZstrFree(id)

	if( stk <> NULL ) then
		if( stk->top <> NULL ) then
			function = *stk->top->name
			exit function
		end if
	end if

	function = ""
end function

private function hDefUniqueIdPop_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_UNIQUEID_POP__( STACKID )

	''  if skipping over code, don't cause side effects
	if( pp.skipping ) then
		return ""
	end if

	var id = hMacro_getArgZ( argtb )
	if( id = null ) then
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
		return ""
	end if

	var stk = cast(SYMB_DEF_UniqueId_Stack ptr, hashLookup(@symb.def.uniqueid.dict, id))

	ZstrFree(id)

	if( stk <> NULL ) then
		if( stk->top <> NULL ) then
			deallocate(stk->top->name)
			stk->top = stk->top->prev
		else
			*errnum = FB_ERRMSG_SYNTAXERROR
		end if
	else
		*errnum = FB_ERRMSG_SYNTAXERROR
	end if

	function = ""
end function

private function hDefArgCount_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_ARG_COUNT__( ARGS... )

	if( argtb ) then
		return str( argtb->count )
	end if
	function = str(0)
end function

private function hDefArgExtract_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_ARG_EXTRACT__(NUMARG, ARGS...)
	'' Retuns empty string on invalid index, rather than compile error

	var res = ""
	var numStr = hMacro_getArgZ( argtb, 0 )

	if( numStr <> NULL ) then
		'' Is NUMARG a number
		'' Val returns 0 on failure which we can't detect from a valid 0
		'' so check and construct the number manually

		dim as string varstr = hMacro_EvalZ( numStr, errnum )
		dim as long index

		if( hStr2long( varstr, index ) ) then
			if( index >= 0 ) then
				dim numVarArgs As ULong = argtb->count - 1
				if(index < numVarArgs) then
					var argString = hMacro_getArgZ( argtb, 1 )
					dim varArgs() as string

					if( hStr2Args( argString, varArgs() ) > 0 ) then
						res = varArgs(index)
					end if

					ZStrFree(argString)
				end if
			else
				'' expected positive
				*errnum = FB_ERRMSG_SYNTAXERROR
			end if
		else
			'' NUMARG isn't a number
			*errnum = FB_ERRMSG_SYNTAXERROR
		end if

		ZStrFree(numStr)

	else '' No args
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if
	return res

end function

private function hDefArgLeft_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_ARG_LEFTTOF__( ARG, SEP [, RET = ""] )

	var res = ""
	var arg = hMacro_getArgZ( argtb, 0 )
	var sep = hMacro_getArgZ( argtb, 1 )
	var ret = hMacro_getArgZ( argtb, 2 )

	if( (arg <> NULL) and (sep <> NULL) ) then
		dim tokens() as string
		var numtoks = hStr2Tok(arg, tokens())

		if( numtoks > 0 ) then
			hUcase(sep, sep)

			for i as integer = 0 to numtoks-1
				if( ucase(tokens(i)) = *sep ) then
					for j as integer = 0 to i - 1
						if( j > 0 ) then
							res += " "
						end if
						res += tokens(j)
					next
					exit for
				end if
			next

			if( len(res) = 0 ) then
				res = *ret
			end if
		else
			*errnum = FB_ERRMSG_SYNTAXERROR
		end if
	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	ZstrFree(ret)
	ZstrFree(sep)
	ZstrFree(arg)

	return res

end function

private function hDefArgRight_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_ARG_RIGHTOF__( ARG, SEP [, RET = ""] )

	var res = ""
	var arg = hMacro_getArgZ( argtb, 0 )
	var sep = hMacro_getArgZ( argtb, 1 )
	var ret = hMacro_getArgZ( argtb, 2 )

	if( (arg <> NULL) and (sep <> NULL) ) then
		dim tokens() as string
		var numtoks = hStr2Tok(arg, tokens())

		if( numtoks > 0 ) then
			hUcase(sep, sep)

			for i as integer = 0 to numtoks-1
				if( ucase(tokens(i)) = *sep ) then
					for j as integer = i + 1 to numtoks-1
						if( len(res) > 0 ) then
							res += " "
						end if
						res += tokens(j)
					next
					exit for
				end if
			next
			if( len(res) = 0 ) then
				res = *ret
			end if
		else
			*errnum = FB_ERRMSG_SYNTAXERROR
		end if
	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	ZstrFree(ret)
	ZstrFree(sep)
	ZstrFree(arg)

	function =  res

end function

private function hDefJoinZ_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_JOIN__( L, R )

	var res = ""
	var l = hMacro_getArgZ( argtb, 0 )
	var r = hMacro_getArgZ( argtb, 1 )

	if( (l <> NULL) and (r <> NULL) ) then
		res = *l + *r
	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	ZstrFree(l)
	ZstrFree(r)

	function = res

end function

private function hDefJoinW_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as wstring ptr

	'' __FB_JOIN__( L, R )

	var l = hMacro_getArgW( argtb, 0 )
	var r = hMacro_getArgW( argtb, 1 )
	static as DWSTRING res

	DWstrAssign( res, NULL )

	if( (l <> NULL) and (r <> NULL) ) then
		DWstrConcatAssign( res, l )
		DWstrConcatAssign( res, r )
	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	function = res.data

end function

private function hDefQuoteZ_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_QUOTE__( arg )

	var arg = hMacro_getArgZ( argtb, 0 )
	var res = ""

	if( arg <> NULL ) then
		'' don't escape, preserve the sequences as-is
		res += "$" + QUOTE
		res += hReplace( arg, QUOTE, QUOTE + QUOTE )
		res += QUOTE
	else
		'' If it's empty, produce an empty string ("")
		res += QUOTE + QUOTE
	end if

	ZstrFree(arg)

	function = res

end function

private function hDefQuoteW_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as wstring ptr

	'' __FB_QUOTE__( arg )

	var arg = hMacro_getArgW( argtb, 0 )
	static as DWSTRING res

	DWstrAssign( res, NULL )

	'' Only if not empty ("..." param can be empty)
	if( arg <> NULL ) then
		'' don't escape, preserve the sequences as-is
		DWstrConcatAssign( res, "$" + QUOTE )
		DWstrConcatAssign( res, *hReplaceW( arg, QUOTE, QUOTE + QUOTE ) )
		DWstrConcatAssign( res, QUOTE )
	else
		'' If it's empty, produce an empty string ("")
		DWstrConcatAssign( res, QUOTE + QUOTE )
	end if

	function = res.data

end function

private function hDefUnquoteZ_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_UNQUOTE__( arg )

	var arg = hMacro_getArgZ( argtb, 0 )
	var res = ""

	'' arg must be of the form [$]"[text]"
	if( arg <> NULL ) then
		var length = len(*arg)

		'' !!!TODO!!! add support for !"escaped-strings"

		'' $"[text]"?
		if( (length >= 3) andalso ((arg[0] = asc( "$" )) and (arg[1] = asc(QUOTE)) and (arg[length-1] = asc(QUOTE))) ) then
			res = hReplace( mid( *arg, 3, length-3 ), QUOTE + QUOTE, QUOTE )

		'' "[text]"?
		elseif( (length >= 2) andalso ((arg[0] = asc(QUOTE)) and (arg[length-1] = asc(QUOTE))) ) then
			'' !!!FIXME!!! check env.opt.escapestr
			res = hReplace( mid( *arg, 2, length-2 ), QUOTE + QUOTE, QUOTE )

		'' anything else, return as-is
		else
			res = *arg
		end if
	end if

	ZstrFree(arg)

	function = res

end function

private function hDefUnquoteW_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as wstring ptr

	'' __FB_UNQUOTE__( arg )

	var arg = hMacro_getArgW( argtb, 0 )
	static as DWSTRING res

	DWstrAssign( res, NULL )

	'' arg must be of the form [$]"[text]"
	if( arg <> NULL ) then
		var length = len(*arg)

		'' !!!TODO!!! add support for !"escaped-strings"

		'' $"[text]"?
		if( (length >= 3) andalso ((arg[0] = asc( "$" )) and (arg[1] = asc(QUOTE)) and (arg[length-1] = asc(QUOTE))) ) then
			DWstrAssign( res, hReplaceW( mid( *arg, 3, length-3 ), QUOTE + QUOTE, QUOTE ) )

		'' "[text]"?
		elseif( (length >= 2) andalso ((arg[0] = asc(QUOTE)) and (arg[length-1] = asc(QUOTE))) ) then
			'' !!!FIXME!!! check env.opt.escapestr
			DWstrAssign( res, hReplaceW( mid( *arg, 2, length-2 ), QUOTE + QUOTE, QUOTE ) )

		'' anything else, return as-is
		else
			DWstrAssign( res, arg )

		end if
	end if

	function = res.data

end function

private function hDefEvalZ_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_EVAL__( arg )

	'' the expression should have already been handled in hLoadMacro|hLoadMacroW
	'' so, if we do get here, just pass the argument back as-is

	var arg = hMacro_getArgZ( argtb, 0 )
	var res = hMacro_EvalZ( arg, errnum )

	ZstrFree(arg)

	function = res

end function

private function hDefEvalW_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as wstring ptr

	'' __FB_EVAL__( arg )

	'' the expression should have already been handled in hLoadMacro|hLoadMacroW
	'' so, if we do get here, just pass the argument back as-is

	var arg = hMacro_getArgW( argtb, 0 )
	static as DWSTRING res
	DWstrAssign( res, hMacro_EvalW( arg, errnum ) )

	function = res.data

end function

private function hDefIifZ_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_IIF__( CMPEXPR, TEXPR, FEXPR )

	var res = ""
	var cexpr = hMacro_getArgZ( argtb, 0 )  '' comparison
	var texpr = hMacro_getArgZ( argtb, 1 )  '' true-expression
	var fexpr = hMacro_getArgZ( argtb, 2 )  '' false-expression

	if( (cexpr <> NULL) and (texpr <> NULL) and (fexpr <> NULL) ) then
		dim as string varstr = hMacro_EvalZ( cexpr, errnum )
		dim as boolean value = cbool( varstr )
		res = iif( cbool( varstr ), *texpr, *fexpr )
	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	ZstrFree(fexpr)
	ZstrFree(texpr)
	ZstrFree(cexpr)

	function =  res

end function

private function hDefIifW_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as wstring ptr

	'' __FB_IIF__( CMPEXPR, TEXPR, FEXPR )

	static res as DWSTRING
	static wvarstr as DWSTRING
	var cexpr = hMacro_getArgW( argtb, 0 )  '' comparison
	var texpr = hMacro_getArgW( argtb, 1 )  '' true-expression
	var fexpr = hMacro_getArgW( argtb, 2 )  '' false-expression

	if( (cexpr <> NULL) and (texpr <> NULL) and (fexpr <> NULL) ) then
		dim as long value = 0
		dim as string varstr
		DWstrAssign( wvarstr, hMacro_EvalW( cexpr, errnum ) )
		varstr = str( wvarstr.data )
		DWstrAssign( res, iif( cbool( varstr ), *texpr, *fexpr ) )
	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	function = res.data

end function

'' If FB_QUERY_SYMBOL changes, update inc/fbc-int/symbol.bi FB_QUERY_SYMBOL
''
enum FB_QUERY_SYMBOL explicit

	'' query type
	symbclass  = &h0000     '' return the symbol's class as FB_SYMBCLASS
	datatype   = &h0001     '' return symbol's type as FB_DATATYPE
	dataclass  = &h0002     '' return the symbol's data class as FB_DATACLASS
	typename   = &h0003     '' return the typename as text
	typenameid = &h0004     '' return the typename as text with specical characters replaced with '_'
	mangleid   = &h0005     '' return the decorated (mangled) type name (WIP)
	exists     = &h0006     '' return if the symbol name / identifier is exists
	querymask  = &h00ff     '' mask for query values

	'' filters
	'' if no filter is given, and filtermask is zero, then the default methods
	'' are used for symbol lookup.  If filtermask is non-zero, then only use
	'' the specified methods for symbol lookup

	identifier = &h0100     '' use identifier & type name symbol lookups
	typeofexpr = &h0200     '' use TYPEOF/expression

	filtermask = &hff00     '' mask for filter values

end enum

private function hDefQuerySymZ_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string

	'' __FB_QUERY_SYMBOL__( WHAT, SYM )

	var res = ""

	if( env.includerec >= FB_MAXINCRECLEVEL ) then
		*errnum = FB_ERRMSG_RECLEVELTOODEEP
		return res
	end if

	var wexpr = hMacro_getArgZ( argtb, 0 )  '' what to look for
	var sexpr = hMacro_getArgZ( argtb, 1 )  '' symbol to look up

	if( (wexpr <> NULL) and (sexpr <> NULL) ) then

		dim as string whatstr = hMacro_EvalZ( wexpr, errnum )
		dim as long whatvalue = clng( whatstr )

		if( hStr2long( whatstr, whatvalue ) ) then
			dim as FB_DATATYPE dtype = FB_DATATYPE_INVALID
			dim as integer is_fixlenstr, retry = FALSE
			dim as longint lgt
			dim as FBSYMBOL ptr sym = NULL, subtype = NULL
			dim as long queryvalue = whatvalue and FB_QUERY_SYMBOL.querymask
			dim as long filtervalue = whatvalue and FB_QUERY_SYMBOL.filtermask

			var errmsg = FB_ERRMSG_OK

			'' create a lightweight context push
			lexPushCtx()
			lexInit( FALSE, TRUE )

			'' prevent cExpression from writing to .pp.bas file
			lex.ctx->reclevel += 1

			DZstrAssign( lex.ctx->deftext, *sexpr )
			lex.ctx->defptr = lex.ctx->deftext.data
			lex.ctx->deflen += len( *sexpr )

			'' if filtervalue is zero then set the default methods to use for
			'' look-up depending on what we are looking for
			if( filtervalue = 0 ) then
				select case queryvalue
				case FB_QUERY_SYMBOL.typename, _
				     FB_QUERY_SYMBOL.typenameid, _
				     FB_QUERY_SYMBOL.mangleid, _
				     FB_QUERY_SYMBOL.exists

					filtervalue or= FB_QUERY_SYMBOL.identifier

				'' case FB_QUERY_SYMBOL.symbclass, _
				''      FB_QUERY_SYMBOL.dataclass, _
				''      FB_QUERY_SYMBOL.datatype
				case else
					filtervalue or= FB_QUERY_SYMBOL.identifier or FB_QUERY_SYMBOL.typeofexpr

				end select
			end if

			'' identifier filter?
			if( (filtervalue and FB_QUERY_SYMBOL.identifier) <> 0 ) then

				'' Try a lookup of the symbol and ideally suppress all errors.  These
				'' will never be used as for any access or expression in emitted code
				'' so we should try to be as persmissive as possible.

				select case lexGetClass( )
				case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, _
				     FB_TKCLASS_QUIRKWD, FB_TKCLASS_OPERATOR

					sym = cIdentifierOrUDTMember( )
				end select

				'' for some symbols, we maybe want to reset and try a TYPEOF below
				'' or parse more for the case of UDT type members

				if( sym ) then
					select case symbGetClass( sym )
					case FB_SYMBCLASS_KEYWORD
						dtype = symbGetFullType( sym )
						if( dtype = FB_DATATYPE_INVALID ) then
							select case queryvalue
							case FB_QUERY_SYMBOL.symbclass, _
							     FB_QUERY_SYMBOL.exists
								lexSkipToken( )
							case else
								sym = NULL
								retry = TRUE
							end select
						else
							lexSkipToken( )
						end if
					case FB_SYMBCLASS_STRUCT
						lexSkipToken( )
						dtype = symbGetFullType( sym )
						subtype = sym
						'' '.'?
						if( lexGetToken( ) = CHAR_DOT ) then
							cUdtTypeMember( dtype, subtype, lgt, is_fixlenstr, sym )
						end if
					case else
						lexSkipToken( )
						dtype = symbGetFullType( sym )
						subtype = symbGetSubtype( sym )
					end select
				end if

				'' if we get to here with a symbol, but we still have more text to
				'' parse after what we've got, assume that the user meant to include
				'' more and re-try as TYPEOF(sym) below.  For example, if sym = 'integer ptr'
				'' then, integer we intially get 'integer' returned as a keyword, but
				'' because there is more, try as typeof.

				'' not the end of 'sym'? retry as TYPEOF
				if( lexGetToken( ) <> FB_TK_EOF ) then
					retry = TRUE
				end if

				if( retry ) then
					sym = NULL

					'' reset the current lexer context and refresh the text to parse.
					lexInit( FALSE, TRUE )

					DZstrAssign( lex.ctx->deftext, *sexpr )
					lex.ctx->defptr = lex.ctx->deftext.data
					lex.ctx->deflen += len( *sexpr )
				end if

			end if

			'' typeof/expression filter?
			if( (filtervalue and FB_QUERY_SYMBOL.typeofexpr) <> 0 ) then

				'' no sym? try TYPEOF( sym ) ...
				if( sym = NULL ) then
					cTypeOf( dtype, subtype, lgt, is_fixlenstr, sym )
				end if

			end if

			'' return results
			select case queryvalue
			case FB_QUERY_SYMBOL.symbclass
				if( sym ) then
					res = str( symbGetClass( sym ) )
				elseif( subtype ) then
					res = str( symbGetClass( subtype ) )
				else
					res = str( 0 )
				end if
			case FB_QUERY_SYMBOL.datatype
				res = str( dtype )
			case FB_QUERY_SYMBOL.dataclass
				res = str( typeGetClass( dtype ) )
			case FB_QUERY_SYMBOL.typename, FB_QUERY_SYMBOL.typenameid
				res = ucase( symbTypeToStr( dtype, subtype, lgt, is_fixlenstr ) )
				if( queryvalue = FB_QUERY_SYMBOL.typenameid ) then
					hReplaceChar( res, asc(" "), asc("_") )
					hReplaceChar( res, asc("."), asc("_") )
					hReplaceChar( res, asc("("), asc("_") )
					hReplaceChar( res, asc(")"), asc("_") )
					hReplaceChar( res, asc("*"), asc("_") )
				end if
			case FB_QUERY_SYMBOL.mangleid
				if( sym ) then
					symbMangleType( res, dtype, sym )
					symbMangleResetAbbrev( )
				elseif( subtype ) then
					symbMangleType( res, dtype, subtype )
					symbMangleResetAbbrev( )
				else
					res = str(0)
				end if
			case FB_QUERY_SYMBOL.exists
				res = str( sym <> NULL )
			case else
				*errnum = FB_ERRMSG_SYNTAXERROR
				res = str( -1 )
			end select

			lex.ctx->reclevel -= 1

			lexPopCtx()

		else
			'' NUMARG isn't a number
			*errnum = FB_ERRMSG_SYNTAXERROR
		end if

	else
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
	end if

	ZstrFree(wexpr)
	ZstrFree(sexpr)

	function =  res

end function

'' Intrinsic #defines which are always defined
dim shared defTb(0 to ...) as SYMBDEF => _
{ _
	_ '' name                     constant value  flags                callback (if value isn't constant)
	(@"__FB_VERSION__"        , @FB_VERSION       , FB_DEFINE_FLAGS_STR, NULL           ), _
	(@"__FB_BUILD_DATE__"     , @FB_BUILD_DATE    , FB_DEFINE_FLAGS_STR, NULL           ), _
	(@"__FB_BUILD_DATE_ISO__" , @FB_BUILD_DATE_ISO, FB_DEFINE_FLAGS_STR, NULL           ), _
	(@"__FB_VER_MAJOR__"      , @FB_VER_MAJOR     , 0                  , NULL           ), _
	(@"__FB_VER_MINOR__"      , @FB_VER_MINOR     , 0                  , NULL           ), _
	(@"__FB_VER_PATCH__"      , @FB_VER_PATCH     , 0                  , NULL           ), _
	(@"__FB_SIGNATURE__"      , @FB_SIGN          , FB_DEFINE_FLAGS_STR, NULL           ), _
	(@"__FB_BUILD_SHA1__"     , @FB_BUILD_SHA1    , FB_DEFINE_FLAGS_STR, NULL           ), _
	(@"__FB_MT__"             , NULL          , 0                  , @hDefMultithread_cb), _
	(@"__FILE__"              , NULL          , FB_DEFINE_FLAGS_STR, @hDefFile_cb       ), _
	(@"__FILE_NQ__"           , NULL          , 0                  , @hDefFile_cb       ), _
	(@"__FUNCTION__"          , NULL          , FB_DEFINE_FLAGS_STR, @hDefFunction_cb   ), _
	(@"__FUNCTION_NQ__"       , NULL          , 0                  , @hDefFunction_cb   ), _
	(@"__LINE__"              , NULL          , 0                  , @hDefLine_cb       ), _
	(@"__DATE__"              , NULL          , FB_DEFINE_FLAGS_STR, @hDefDate_cb       ), _
	(@"__DATE_ISO__"          , NULL          , FB_DEFINE_FLAGS_STR, @hDefDateISO_cb    ), _
	(@"__TIME__"              , NULL          , FB_DEFINE_FLAGS_STR, @hDefTime_cb       ), _
	(@"__PATH__"              , NULL          , FB_DEFINE_FLAGS_STR, @hDefPath_cb       ), _
	(@"__FB_OPTION_BYVAL__"   , NULL          , 0                  , @hDefOptByval_cb   ), _
	(@"__FB_OPTION_DYNAMIC__" , NULL          , 0                  , @hDefOptDynamic_cb ), _
	(@"__FB_OPTION_ESCAPE__"  , NULL          , 0                  , @hDefOptEscape_cb  ), _
	(@"__FB_OPTION_EXPLICIT__", NULL          , 0                  , @hDefOptExplicit_cb), _
	(@"__FB_OPTION_PRIVATE__" , NULL          , 0                  , @hDefOptPrivate_cb ), _
	(@"__FB_OPTION_GOSUB__"   , NULL          , 0                  , @hDefOptGosub_cb   ), _
	(@"__FB_OUT_EXE__"        , NULL          , 0                  , @hDefOutExe_cb     ), _
	(@"__FB_OUT_LIB__"        , NULL          , 0                  , @hDefOutLib_cb     ), _
	(@"__FB_OUT_DLL__"        , NULL          , 0                  , @hDefOutDll_cb     ), _
	(@"__FB_OUT_OBJ__"        , NULL          , 0                  , @hDefOutObj_cb     ), _
	(@"__FB_DEBUG__"          , NULL          , 0                  , @hDefDebug_cb      ), _
	(@"__FB_ERR__"            , NULL          , 0                  , @hDefErr_cb        ), _
	(@"__FB_LANG__"           , NULL          , FB_DEFINE_FLAGS_STR, @hDefLang_cb       ), _
	(@"__FB_BACKEND__"        , NULL          , FB_DEFINE_FLAGS_STR, @hDefBackend_cb    ), _
	(@"__FB_FPU__"            , NULL          , FB_DEFINE_FLAGS_STR, @hDefFpu_cb        ), _
	(@"__FB_FPMODE__"         , NULL          , FB_DEFINE_FLAGS_STR, @hDefFpmode_cb     ), _
	(@"__FB_GCC__"            , NULL          , 0                  , @hDefGcc_cb        ), _
	(@"__FB_GUI__"            , NULL          , 0                  , @hDefGui_cb        ), _
	(@"__FB_OPTIMIZE__"       , NULL          , 0                  , @hDefoptimize_cb   )  _
}

type SYMBMACRO
	name            as const zstring ptr
	flags           as FB_DEFINE_FLAGS
	procz           as FBS_MACRO_PROCZ
	procw           as FBS_MACRO_PROCW
	nparams         as integer
	params(0 to 4)  as const zstring ptr
end type

'' Intrinsic #macros which are always defined
dim shared macroTb(0 to ...) as SYMBMACRO => _
{ _
	(@"__FB_UNIQUEID_PUSH__"  , 0                       , @hDefUniqueIdPush_cb, NULL                 , 1, { (@"ID") } ),  _
	(@"__FB_UNIQUEID__"       , 0                       , @hDefUniqueId_cb    , NULL                 , 1, { (@"ID") } ), _
	(@"__FB_UNIQUEID_POP__"   , 0                       , @hDefUniqueIdPop_cb , NULL                 , 1, { (@"ID") } ), _
	(@"__FB_ARG_COUNT__"      , FB_DEFINE_FLAGS_VARIADIC, @hDefArgCount_cb    , NULL                 , 1, { (@"ARGS") } ), _
	(@"__FB_ARG_EXTRACT__"    , FB_DEFINE_FLAGS_VARIADIC, @hDefArgExtract_cb  , NULL                 , 2, { (@"ARGNUM"), (@"ARGS") } ), _
	(@"__FB_ARG_LEFTOF__"     , FB_DEFINE_FLAGS_VARIADIC, @hDefArgLeft_cb     , NULL                 , 3, { (@"ARG"), (@"SEP"), (@"RET") } ), _
	(@"__FB_ARG_RIGHTOF__"    , FB_DEFINE_FLAGS_VARIADIC, @hDefArgRight_cb    , NULL                 , 3, { (@"ARG"), (@"SEP"), (@"RET") } ), _
	(@"__FB_JOIN__"           , 0                       , @hDefJoinZ_cb       , @hDefJoinW_cb        , 2, { (@"L"), (@"R") } ), _
	(@"__FB_QUOTE__"          , 0                       , @hDefQuoteZ_cb      , @hDefQuoteW_cb       , 1, { (@"ARG") } ), _
	(@"__FB_UNQUOTE__"        , 0                       , @hDefUnquoteZ_cb    , @hDefUnquoteW_cb     , 1, { (@"ARG") } ), _
	(@"__FB_EVAL__"           , 0                       , @hDefEvalZ_cb       , @hDefEvalW_cb        , 1, { (@"ARG") } ), _
	(@"__FB_IIF__"            , 0                       , @hDefIifZ_cb        , @hDefIifW_cb         , 3, { (@"CMPEXPR"), (@"TEXPR"), (@"FEXPR") } ), _
	(@"__FB_QUERY_SYMBOL__"   , 0                       , @hDefQuerySymZ_cb   , NULL                 , 2, { (@"WHAT"), (@"SYM") } ) _
}

sub symbDefineInit _
	( _
		byval ismain as integer _
	)

	dim as string value
	dim as const zstring ptr def = any

	listInit( @symb.def.paramlist, FB_INITDEFARGNODES, len( FB_DEFPARAM ), LIST_FLAGS_NOCLEAR )
	listInit( @symb.def.toklist, FB_INITDEFTOKNODES, len( FB_DEFTOK ), LIST_FLAGS_NOCLEAR )
	hashInit( @symb.def.uniqueid.dict, 16, true )

	'' add the pre-defines
	for i as integer = 0 to ubound( defTb )
		value = *defTb(i).value

		if( defTb(i).value <> NULL ) then
			if( defTb(i).flags and FB_DEFINE_FLAGS_STR ) then
				value = QUOTE + value + QUOTE
			end if
		end if

		symbAddDefine( defTb(i).name, value, len( value ), _
			FALSE, defTb(i).proc, defTb(i).flags )
	next

	'' Add __FB_<target>__ define
	symbAddDefine( "__FB_" + ucase( *env.target.id ) + "__", NULL, 0 )
	if( env.clopt.target = FB_COMPTARGET_JS ) then
		symbAddDefine( @"__FB_LINUX__", NULL, 0 )
	end if

	'' add __FB_UNIX__ / __FB_PCOS__ defines, as necessary
	if( env.target.options and FB_TARGETOPT_UNIX ) then
		symbAddDefine( @"__FB_UNIX__", NULL, 0 )
	else
		symbAddDefine( @"__FB_PCOS__", NULL, 0 )
	end if

	if( fbIs64bit( ) ) then
		symbAddDefine( @"__FB_64BIT__", NULL, 0 )
	end if

	select case( fbGetCpuFamily( ) )
	case FB_CPUFAMILY_ARM, FB_CPUFAMILY_AARCH64
		symbAddDefine( @"__FB_ARM__", NULL, 0 )
	case FB_CPUFAMILY_X86, FB_CPUFAMILY_X86_64
		symbAddDefine( @"__FB_X86__", NULL, 0 )
		symbAddDefine( @"__FB_ASM__", NULL, 0, FALSE, @hDefAsm_cb, FB_DEFINE_FLAGS_STR )
	case FB_CPUFAMILY_PPC, FB_CPUFAMILY_PPC64, FB_CPUFAMILY_PPC64LE
		symbAddDefine( @"__FB_PPC__", NULL, 0 )
	end select

	if( fbIsHostBigEndian( ) ) then
		symbAddDefine( @"__FB_BIGENDIAN__", NULL, 0 )
	end if

	'' add "main" define
	if( ismain ) then
		symbAddDefine( "__FB_MAIN__", NULL, 0 )
	end if

	'' add SSE define
	if( env.clopt.fputype >= FB_FPUTYPE_SSE ) then
		symbAddDefine( "__FB_SSE__", NULL, 0 )
	end if

	'' add vectorization define
	value = str( env.clopt.vectorize )
	symbAddDefine( "__FB_VECTORIZE__", value, len( value ) )

	'' macro params
	symb.def.param = 0

	hashInit( @symb.def.paramhash, FB_MAXDEFINEARGS )

	'' add the macros
	for i as integer = 0 to ubound( macroTb )

		var firstparam = symbAddDefineParam( NULL, macroTb(i).params(0) )

		var lastparam = firstparam
		for j as integer = 1 to macroTb(i).nparams-1
			lastparam = symbAddDefineParam( lastparam, macroTb(i).params(j) )
		next

		'' TODO: if any macros are added that don't need params, then
		'' flags should be stored in macroTb
		var sym = symbAddDefineMacro( macroTb(i).name, NULL, macroTb(i).nparams, firstparam, macroTb(i).flags or FB_DEFINE_FLAGS_NEEDPARENS )
		sym->def.mprocz = macroTb(i).procz
		sym->def.mprocw = macroTb(i).procw
	next

end sub

'':::::
sub symbDefineEnd( )

	'' macro params
	hashEnd( @symb.def.paramhash )

	symb.def.param = 0

	hashEnd( @symb.def.uniqueid.dict )
	listEnd( @symb.def.paramlist )
	listEnd( @symb.def.toklist )

end sub

'':::::
function symbAddDefine _
	( _
		byval symbol as const zstring ptr, _
		byval text as zstring ptr, _
		byval lgt as integer, _
		byval isargless as integer, _
		byval proc as FBS_DEFINE_PROCZ, _
		byval flags as FB_DEFINE_FLAGS _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	'' allocate new node (always on global hash, ns' won't work in lexer)
	sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
		NULL, _
		NULL, @symbGetGlobalHashTb( ), _
		FB_SYMBCLASS_DEFINE, _
		symbol, NULL, _
		FB_DATATYPE_CHAR, NULL, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )
	if( sym = NULL ) then
		exit function
	end if

	sym->def.text   = ZstrAllocate( lgt )
	*sym->def.text = *text
	sym->lgt = lgt
	sym->def.params = 0
	sym->def.paramhead = NULL
	sym->def.isargless = isargless
	sym->def.dprocz = proc
	sym->def.flags = flags

	function = sym

end function

'':::::
function symbAddDefineW _
	( _
		byval symbol as zstring ptr, _
		byval text as wstring ptr, _
		byval lgt as integer, _
		byval isargless as integer, _
		byval proc as FBS_DEFINE_PROCZ, _
		byval flags as FB_DEFINE_FLAGS _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	'' allocate new node (always on global hash, ns' won't work in lexer)
	sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
		NULL, _
		NULL, @symbGetGlobalHashTb( ), _
		FB_SYMBCLASS_DEFINE, _
		symbol, NULL, _
		FB_DATATYPE_WCHAR, NULL, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )
	if( sym = NULL ) then
		exit function
	end if

	sym->def.textw = WstrAllocate( lgt )
	*sym->def.textw = *text
	sym->lgt = lgt
	sym->def.params = 0
	sym->def.paramhead = NULL
	sym->def.isargless = isargless
	sym->def.dprocz = proc
	sym->def.flags = flags

	function = sym

end function

'':::::
function symbAddDefineMacro _
	( _
		byval symbol as const zstring ptr, _
		byval tokhead as FB_DEFTOK ptr, _
		byval params as integer, _
		byval paramhead as FB_DEFPARAM ptr, _
		byval flags as FB_DEFINE_FLAGS _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	'' allocate new node (always on global hash, ns' won't work in lexer)
	sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
		NULL, _
		NULL, @symbGetGlobalHashTb( ), _
		FB_SYMBCLASS_DEFINE, _
		symbol, NULL, _
		FB_DATATYPE_INVALID, NULL, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )
	if( sym = NULL ) then
		exit function
	end if

	sym->def.tokhead = tokhead
	sym->def.params = params
	sym->def.paramhead = paramhead
	sym->def.isargless = FALSE
	sym->def.mprocz = NULL
	sym->def.mprocw = NULL
	sym->def.flags = flags

	function = sym

end function

'':::::
private sub hResetDefHash( )
	dim as integer i

	for i = 0 to symb.def.param-1
		hashDel( @symb.def.paramhash, symb.def.hash(i).item, symb.def.hash(i).index )
	next

	symb.def.param = 0

end sub

'':::::
function symbAddDefineParam _
	( _
		byval lastparam as FB_DEFPARAM ptr, _
		byval id as const zstring ptr _
	) as FB_DEFPARAM ptr static

	dim as FB_DEFPARAM ptr param
	dim as uinteger index

	function = NULL

	param = listNewNode( @symb.def.paramlist )

	if( lastparam <> NULL ) then
		lastparam->next = param

	'' new param list..
	else
		'' reset the old list, if any
		if( symb.def.param > 0 ) then
			hResetDefHash( )
		end if
	end if

	''
	param->name = ZstrAllocate( len( *id ) )
	hUcase( *id, *param->name )

	'' add to hash, for fast lookup
	index = hashHash( param->name )

	'' dup definition? !!!FIXME!!! don't do this check for system headers !!!FIXME!!!
	if( hashLookupEx( @symb.def.paramhash, param->name, index ) <> NULL ) then
		ZstrFree( param->name )
		listDelNode( @symb.def.paramlist, param )
		return NULL
	end if

	symb.def.hash(symb.def.param).item = _
		hashAdd( @symb.def.paramhash, param->name, param, index )

	symb.def.hash(symb.def.param).index = index

	''
	param->num = symb.def.param
	param->next = NULL

	symb.def.param += 1

	function = param

end function

'':::::
function symbAddDefineTok _
	( _
		byval lasttok as FB_DEFTOK ptr, _
		byval dtype as FB_DEFTOK_TYPE _
	) as FB_DEFTOK ptr static

	dim t as FB_DEFTOK ptr

	function = NULL

	t = listNewNode( @symb.def.toklist )

	if( lasttok <> NULL ) then
		lasttok->next = t
	end if

	t->prev = lasttok
	t->next = NULL

	''
	t->type = dtype
	select case as const dtype
	case FB_DEFTOK_TYPE_TEX
		t->text = NULL
	case FB_DEFTOK_TYPE_TEXW
		t->textw = NULL
	end select

	function = t

end function

'':::::
function symbDelDefineTok _
	( _
		byval tok as FB_DEFTOK ptr _
	) as FB_DEFTOK ptr static

	'' warning: this should only be used to remove the tail tokens
	if( tok->prev <> NULL ) then
		tok->prev->next = NULL
		function = tok->prev
	else
		function = NULL
	end if

	select case tok->type
	case FB_DEFTOK_TYPE_TEX
		ZstrFree( tok->text )
	case FB_DEFTOK_TYPE_TEXW
		WstrFree( tok->textw )
	end select

	listDelNode( @symb.def.toklist, tok )

end function

'':::::
private sub hDelDefineParams( byval s as FBSYMBOL ptr )
	dim as FB_DEFPARAM ptr param, nxt

	param = s->def.paramhead
	do while( param <> NULL )
		nxt = param->next
		ZstrFree( param->name )

		listDelNode( @symb.def.paramlist, param )

		param = nxt
	loop

end sub

'':::::
private sub hDelDefineTokens( byval s as FBSYMBOL ptr )
	dim as FB_DEFTOK ptr tok, nxt

	tok = s->def.tokhead
	do while( tok <> NULL )
		nxt = tok->next

		symbDelDefineTok( tok )

		tok = nxt
	loop

end sub

'':::::
function symbDelDefine _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	function = FALSE

	if( s = NULL ) then
		exit function
	end if

	''
	if( symbGetDefineParams( s ) = 0 ) then
		if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
			ZstrFree( s->def.text )
		else
			WstrFree( s->def.textw )
		end if
	else
		hDelDefineTokens( s )
	end if

	''
	hDelDefineParams( s )

	'' del the define node
	symbFreeSymbol( s )

	''
	function = TRUE

end function


