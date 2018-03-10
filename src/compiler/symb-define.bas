'' symbol table module for defines and macros
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "lex.bi"
#include once "hlp.bi"

#include once "datetime.bi"
#include once "string.bi"

type SYMBDEF
	name			as const zstring ptr
	value			as zstring ptr
	flags			as integer  '' FB_DEFINE_FLAGS_*
	proc			as FBS_DEFINE_PROC
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

private function hDefDate_cb() as string static
	function = date
end function

private function hDefDateISO_cb() as string static
	function = format( now( ), "yyyy-mm-dd" )
end function

private function hDefTime_cb() as string static
	function = time
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
	function = str( env.clopt.assertions )
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

	function = str( res )
end function

private function hDefLang_cb() as string static
	function = fbGetLangName( env.clopt.lang )
end function

private function hDefBackend_cb() as string static
	select case env.clopt.backend
	case FB_BACKEND_GAS
		function = "gas"
	case FB_BACKEND_GCC
		function = "gcc"
	case FB_BACKEND_LLVM
		function = "llvm"
	end select
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

private function hMacro_getArg( byval argtb as LEXPP_ARGTB ptr, byval num as integer = 0 ) as zstring ptr
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
	
	hUcase(res, res)
	
	function = res
	
end function
	
private function hDefUniqueIdPush_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string
	
	var id = hMacro_getArg( argtb )
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
	
	var uid = symbUniqueId()
	elm->name = allocate(len(*uid)+1)
	*elm->name = *uid
	elm->prev = stk->top

	stk->top = elm
	
	function = ""
end function

private function hDefUniqueId_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string
	var id = hMacro_getArg( argtb )
	if( id = null ) then
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
		return ""
	end if
	
	var stk = cast(SYMB_DEF_UniqueId_Stack ptr, hashLookup(@symb.def.uniqueid.dict, id))
	
	ZstrFree(id)
	
	function = iif(stk <> NULL, *stk->top->name, "")
end function

private function hDefUniqueIdPop_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string	
	var id = hMacro_getArg( argtb )
	if( id = null ) then
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
		return ""
	end if
	
	var stk = cast(SYMB_DEF_UniqueId_Stack ptr, hashLookup(@symb.def.uniqueid.dict, id))
	
	ZstrFree(id)
	
	if( stk <> NULL ) then
		deallocate(stk->top->name)
		stk->top = stk->top->prev
	end if
	
	function = ""
end function

private function hDefArgSplit_cb( byval argtb as LEXPP_ARGTB ptr, byval errnum as integer ptr ) as string
	var arg = hMacro_getArg( argtb, 0 )
	var sep = hMacro_getArg( argtb, 1 )
	var ret = hMacro_getArg( argtb, 2 )
	if( arg = null or sep = null or ret = null ) then
		*errnum = FB_ERRMSG_ARGCNTMISMATCH
		return ""
	end if

	var cnt = 0
	var retn = valint(*ret)
	
	redim res() as string
	hSplitStr(*arg, *sep, res())
	
	if( retn < 1 or retn > ubound(res)+1 ) then
		*errnum = FB_ERRMSG_SYNTAXERROR
		return ""
	end if
	
	ZstrFree(ret)
	ZstrFree(sep)
	ZstrFree(arg)
	
	function = res(retn-1)
	
end function


'' Intrinsic #defines which are always defined
dim shared defTb(0 to ...) as SYMBDEF => _
{ _
	_ '' name                     constant value  flags                callback (if value isn't constant)
	(@"__FB_VERSION__"        , @FB_VERSION   , FB_DEFINE_FLAGS_STR, NULL               ), _
	(@"__FB_BUILD_DATE__"     , @FB_BUILD_DATE, FB_DEFINE_FLAGS_STR, NULL               ), _
	(@"__FB_VER_MAJOR__"      , @FB_VER_MAJOR , 0                  , NULL               ), _
	(@"__FB_VER_MINOR__"      , @FB_VER_MINOR , 0                  , NULL               ), _
	(@"__FB_VER_PATCH__"      , @FB_VER_PATCH , 0                  , NULL               ), _
	(@"__FB_SIGNATURE__"      , @FB_SIGN      , FB_DEFINE_FLAGS_STR, NULL               ), _
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
	(@"__FB_GCC__"            , NULL          , 0                  , @hDefGcc_cb        ) _
}

type SYMBMACRO
	name			as const zstring ptr
	proc			as FBS_MACRO_PROC
	nparams			as integer
	params(0 to 4)	as const zstring ptr
end type

'' Intrinsic #macros which are always defined
dim shared macroTb(0 to ...) as SYMBMACRO => _
{ _
	(@"__FB_UNIQUEID_PUSH__"  , @hDefUniqueIdPush_cb	, 1, { (@"ID") } ),  _
	(@"__FB_UNIQUEID__"       , @hDefUniqueId_cb 		, 1, { (@"ID") } ), _
	(@"__FB_UNIQUEID_POP__"   , @hDefUniqueIdPop_cb		, 1, { (@"ID") } ), _
	(@"__FB_ARGSPLIT__"   	  , @hDefArgSplit_cb		, 3, { (@"ARG"), (@"SEP"), (@"RETNUM") } ) _
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
		symbAddDefine( @"__FB_ASM__", NULL, 0, FALSE, @hDefAsm_cb, FB_DEFINE_FLAGS_STR )
	end select

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
			
		var sym = symbAddDefineMacro( macroTb(i).name, NULL, macroTb(i).nparams, firstparam, 0 )
		sym->def.mproc = macroTb(i).proc
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
		byval proc as FBS_DEFINE_PROC, _
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
    				   	 FB_DATATYPE_CHAR, NULL )
    if( sym = NULL ) then
    	exit function
    end if

	sym->def.text	= ZstrAllocate( lgt )
	*sym->def.text = *text
	sym->lgt = lgt
	sym->def.params	= 0
	sym->def.paramhead = NULL
	sym->def.isargless = isargless
	sym->def.dproc = proc
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
		byval proc as FBS_DEFINE_PROC, _
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
    				   	 FB_DATATYPE_WCHAR, NULL )
    if( sym = NULL ) then
    	exit function
    end if

	sym->def.textw = WstrAllocate( lgt )
	*sym->def.textw = *text
	sym->lgt = lgt
	sym->def.params = 0
	sym->def.paramhead = NULL
	sym->def.isargless = isargless
	sym->def.dproc = proc
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
    				   	 FB_DATATYPE_INVALID, NULL )
    if( sym = NULL ) then
    	exit function
    end if

	sym->def.tokhead = tokhead
	sym->def.params = params
	sym->def.paramhead = paramhead
	sym->def.isargless = FALSE
	sym->def.mproc = NULL
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
    param->name	= ZstrAllocate( len( *id ) )
    hUcase( *id, *param->name )

    '' add to hash, for fast lookup
    index = hashHash( param->name )

    '' dup definition? !!!FIXME!!! don't do this check for system headers !!!FIXME!!!
    if( hashLookupEx( @symb.def.paramhash, param->name, index ) <> NULL ) then
    	ZstrFree( param->name )
    	listDelNode( @symb.def.paramlist, param )
    	return NULL
    end if

    symb.def.hash(symb.def.param).item = hashAdd( @symb.def.paramhash, _
    										      param->name, _
    										      param, _
    										      index )

    symb.def.hash(symb.def.param).index = index

    ''
    param->num = symb.def.param
    param->next	= NULL

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
	t->next	= NULL

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


