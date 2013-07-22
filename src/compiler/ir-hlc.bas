'' intermediate representation - high-level, direct to "C" output
''
'' chng: dec/2006 written [v1ctor]
'' chng: apr/2008 function calling implemented / most operators implemented [sir_mud - sir_mud(at)users(dot)sourceforge(dot)net]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "flist.bi"
#include once "lex.bi"

type IRCALLARG
	param	as FBSYMBOL ptr
	vr	as IRVREG ptr
	level	as integer
end type

'' The stack of nested sections allows us to go back and emit text to
'' the headers of parent sections, while already working on emitting
'' something else in an inner section.
'' (most commonly used for UDT declarations, which are only emitted
''  when they're needed by something else that's being emitted)
''
'' index 0 is the "toplevel" section,
'' index 1 is the "body" where procedures are emitted into,
'' the rest is used for nested procedure/scope blocks.
''
'' "body" is separate from "toplevel" to allow adding declarations to
'' "toplevel", while the procedures are appended to "body", one after
'' another. Then, once all procedures are emitted, "body" is closed,
'' and is appended to "toplevel". At that point we're done emitting
'' anyways and don't need to add stuff to toplevel's header anymore.
''
'' This kind of container/body pair is not currently needed for procs/scopes,
'' because there we emit declarations "in line" instead of moving all to the
'' top of the scope. For the toplevel emitting all at once makes sense because
'' it is more efficient to check the symbol tables for called procedures only
'' once during _emitEnd() instead of once during every _emitProcBegin().
'' Note that _emitBegin() is called before parsing has even started,
'' so the global declarations can't be emitted from there already.

const MAX_SECTIONS = FB_MAXSCOPEDEPTH + 1

type SECTIONENTRY
	text		as string
	old		as integer '' old junk text (that is only kept around to keep the string allocated)?
	indent		as integer '' current indendation level to be used when emitting lines into this section
end type

enum
	EXPRCLASS_TEXT = 0
	EXPRCLASS_IMM
	EXPRCLASS_SYM
	EXPRCLASS_CAST
	EXPRCLASS_UOP
	EXPRCLASS_BOP
end enum

type EXPRNODE
	class		as integer  '' EXPRCLASS_*

	'' This expression's type, to determine whether CASTs are needed or not
	dtype		as integer
	subtype		as FBSYMBOL ptr

	l		as EXPRNODE ptr  '' CAST/UOP/BOP
	r		as EXPRNODE ptr  '' BOP

	union
		text		as zstring ptr  '' TEXT
		val		as FBVALUE      '' IMM
		sym		as FBSYMBOL ptr '' SYM
		op		as integer      '' UOP/BOP
	end union
end type

type EXPRCACHENODE
	'' Each cache entry associates an expression tree with a vreg id,
	'' allowing expressions to be looked up for certain vreg accesses,
	'' instead of having to be emitted as #defines or temp vars.
	''
	'' Having a separate list for the cache is faster than cycling through
	'' the whole ctx.exprnodes list. Often there will be only 1 (UOPs) or
	'' 2 (BOPs) expression trees cached, since the AST usually accesses
	'' expression results right when emitting the next expression/statement.
	vregid		as integer
	expr		as EXPRNODE ptr
end type

type IRHLCCTX
	sections(0 to MAX_SECTIONS-1)	as SECTIONENTRY
	section				as integer '' Current section to write to
	sectiongosublevel		as integer

	regcnt				as integer      '' register counter used to name vregs
	vregTB				as TFLIST
	callargs			as TLIST        '' IRCALLARG's during emitPushArg/emitCall[Ptr]
	linenum				as integer

	anonstack			as TLIST  '' stack of nested anonymous structs/unions in a struct/union

	varini				as string
	variniscopelevel		as integer

	fbctinf				as string

	asm_line			as string  '' line of inline asm built up by _emitAsm*()
	asm_i				as integer '' next operand/symbol index
	asm_output			as string  '' output constraints in gcc's syntax
	asm_input			as string  '' input constraints in gcc's syntax

	exprnodes			as TLIST   '' EXPRNODE
	exprtext			as string  '' buffer used by exprFlush() to build the final text
	exprcache			as TLIST   '' EXPRCACHENODE
end type

declare function hEmitType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string

declare sub hEmitStruct( byval s as FBSYMBOL ptr, byval is_ptr as integer )

declare sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

declare sub exprFreeNode( byval n as EXPRNODE ptr )
#if __FB_DEBUG__
declare sub exprDump( byval n as EXPRNODE ptr )
#endif

'' globals
dim shared as IRHLCCTX ctx

'' same order as FB_DATATYPE
dim shared as const zstring ptr dtypeName(0 to FB_DATATYPES-1) = _
{ _
	@"void"     , _ '' void
	@"int8"     , _ '' byte
	@"uint8"    , _ '' ubyte
	NULL        , _ '' char
	@"int16"    , _ '' short
	@"uint16"   , _ '' ushort
	NULL        , _ '' wchar
	NULL        , _ '' integer
	NULL        , _ '' uint
	NULL        , _ '' enum
	NULL        , _ '' bitfield
	@"int32"    , _ '' long
	@"uint32"   , _ '' ulong
	@"int64"    , _ '' longint
	@"uint64"   , _ '' ulongint
	@"float"    , _ '' single
	@"double"   , _ '' double
	@"FBSTRING" , _ '' string
	NULL        , _ '' fix-len string
	NULL        , _ '' struct
	NULL        , _ '' namespace
	NULL        , _ '' function
	@"void"     , _ '' fwdref (needed for any un-resolved fwdrefs)
	NULL          _ '' pointer
}

private sub _init( )
	flistInit( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )
	listInit( @ctx.callargs, 32, sizeof( IRCALLARG ), LIST_FLAGS_NOCLEAR )
	listInit( @ctx.anonstack, 8, sizeof( FBSYMBOL ptr ), LIST_FLAGS_NOCLEAR )
	listInit( @ctx.exprnodes, 32, sizeof( EXPRNODE ), LIST_FLAGS_CLEAR )
	listInit( @ctx.exprcache, 8, sizeof( EXPRCACHENODE ), LIST_FLAGS_NOCLEAR )
	irSetOption( IR_OPT_FPUIMMEDIATES or IR_OPT_NOINLINEOPS )

	'' 64bit?
	if( fbCpuTypeIs64bit( ) ) then
		dtypeName(FB_DATATYPE_INTEGER) = @"int64"
		dtypeName(FB_DATATYPE_UINT   ) = @"uint64"
	else
		dtypeName(FB_DATATYPE_INTEGER) = @"int32"
		dtypeName(FB_DATATYPE_UINT   ) = @"uint32"
	end if
end sub

private sub _end( )
	listEnd( @ctx.exprcache )
	listEnd( @ctx.exprnodes )
	listEnd( @ctx.anonstack )
	listEnd( @ctx.callargs )
	flistEnd( @ctx.vregTB )
end sub

'' "Begin/end" to be used to opening/closing sections whenever opening/closing
'' procs/scopes and also for the special sections 0 (header) and 1 (body).
private sub sectionBegin( )
	ctx.section += 1
	assert( ctx.section < MAX_SECTIONS )
	'' Tell next hWriteLine() to overwrite instead of appending,
	'' to overwrite pre-existing string data, keeping the string allocated
	with( ctx.sections(ctx.section) )
		.old = TRUE
		if( ctx.section > 0 ) then
			'' Use at least the parent section's indentation
			'' (some emitting functions will temporarily increase
			'' it for code nested inside {} etc.)
			.indent = ctx.sections(ctx.section-1).indent
		else
			'' Start indendation at zero TAB's
			.indent = 0
		end if
	end with
end sub

'' Write line to current section (indentation & newline are automatically added)
private sub sectionWriteLine( byval s as zstring ptr )
	with( ctx.sections(ctx.section) )
		if( .old ) then
			if( .indent > 0 ) then
				.text = string( .indent, TABCHAR )
				.text += *s
			else
				.text = *s
			end if
			.old = FALSE
		else
			if( .indent > 0 ) then
				.text += string( .indent, TABCHAR )
			end if
			.text += *s
		end if
		.text += NEWLINE
	end with
end sub

private sub sectionIndent( )
	ctx.sections(ctx.section).indent += 1
end sub

private sub sectionUnindent( )
	assert( ctx.sections(ctx.section).indent > 0 )
	ctx.sections(ctx.section).indent -= 1
end sub

private function sectionInsideProc( ) as integer
	'' 0 and 1 are toplevel, 2+ means inside proc
	function = (ctx.section >= 2)
end function

private sub sectionEnd( )
	dim as SECTIONENTRY ptr parent = any, child = any

	assert( ctx.section >= 0 )

	if( ctx.section > 0 ) then
		'' Append to parent section, if anything was written
		parent = @ctx.sections(ctx.section-1)
		child = @ctx.sections(ctx.section)
		if( child->old = FALSE ) then
			if( parent->old ) then
				parent->text = child->text
				parent->old = FALSE
			else
				parent->text += child->text
			end if
		end if
	end if

	ctx.section -= 1
end sub

'' "Gosub" for temporarily writing to another section than the current one
private function sectionGosub( byval section as integer ) as integer
	assert( (section >= 0) and (section <= ctx.section) )
	function = ctx.section
	ctx.section = section
	ctx.sectiongosublevel += 1
end function

'' "Return" to restore the previous current section
private sub sectionReturn( byval section as integer )
	assert( ctx.sectiongosublevel > 0 )
	ctx.sectiongosublevel -= 1
	ctx.section = section
end sub

'' Main emitting function
'' Writes out line of code to current section, and adds #line's
private sub hWriteLine _
	( _
		byval s as zstring ptr, _
		byval noline as integer = FALSE _
	)

	static as string ln

	if( env.clopt.debug and (noline = FALSE) ) then
		ln = "#line " + str( ctx.linenum )
		ln += " """ + hReplace( env.inf.name, "\", $"\\" ) + """"
		sectionWriteLine( ln )
	end if

	sectionWriteLine( s )

end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

enum EMITPROC_OPTIONS
	EMITPROC_ISPROTO   = &h1
	EMITPROC_ISPROCPTR = &h2
end enum

private sub hAppendCtorAttrib _
	( _
		byref ln as string, _
		byval proc as FBSYMBOL ptr, _
		byval in_front as integer _
	)

	dim as integer priority = any

	if( proc->stats and (FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALDTOR) ) then
		if( in_front = FALSE ) then
			ln += " "
		end if
		ln += "__attribute__(( "
		if( proc->stats and FB_SYMBSTATS_GLOBALCTOR ) then
			ln += "constructor"
		else
			ln += "destructor"
		end if

		priority = symbGetProcPriority( proc )
		if( priority <> 0 ) then
			ln += "( " + str( priority ) + " )"
		end if

		ln += " ))"
		if( in_front ) then
			ln += " "
		end if
	end if
end sub

private function hEmitProcHeader _
	( _
		byval proc as FBSYMBOL ptr, _
		byval options as EMITPROC_OPTIONS _
	) as string

	dim as string ln, mangled

	if( options = 0 ) then
		'' ctor/dtor flags on bodies
		hAppendCtorAttrib( ln, proc, TRUE )
	end if

	if( (options and EMITPROC_ISPROCPTR) = 0 ) then
		if( env.clopt.export and (env.target.options and FB_TARGETOPT_EXPORT) ) then
			if( symbIsExport( proc ) ) then
				ln += "__declspec( dllexport ) "
			end if
		end if

		if( symbIsPrivate( proc ) ) then
			ln += "static "
		end if
	end if

	'' Function result type (is 'void' for subs)
	ln += hEmitType( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), _
					symbGetProcRealSubtype( proc ) )

	''
	'' Calling convention if needed (for function pointers it's usually not
	'' put in this place, but should work nonetheless)
	''
	'' Note: Pascal is like Stdcall (callee cleans up stack), except that
	'' arguments are pushed left-to-right (same order as written in code,
	'' not reversed like Cdecl/Stdcall).
	'' The symbGetProc*Param() macros take care of changing the order when
	'' cycling through parameters of Pascal functions. Together with Stdcall
	'' this results in a double-reverse resulting in the proper ABI.
	''
	'' For non-x86, don't emit any calling convention at all, it would just
	'' be ignored anyways (for x86_64 and ARM it seems that way at least).
	''
	if( fbCpuTypeIsX86( ) ) then
		select case( symbGetProcMode( proc ) )
		case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS, FB_FUNCMODE_PASCAL
			select case( env.clopt.target )
			case FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
				'' MinGW recognizes this shorter & prettier version
				ln += " __stdcall"
			case else
				'' Linux GCC only accepts this
				ln += " __attribute__((stdcall))"
			end select
		end select
	end if

	ln += " "

	mangled = *symbGetMangledName( proc )

	'' Identifier
	if( options and EMITPROC_ISPROCPTR ) then
		ln += "(*"
		ln += mangled
		ln += ")"
	else
		ln += mangled
	end if

	'' Parameter list
	ln += "( "

	'' If returning a struct, there's an extra parameter
	dim as FBSYMBOL ptr hidden = NULL
	if( symbProcReturnsOnStack( proc ) ) then
		if( options and EMITPROC_ISPROTO ) then
			hidden = symbGetSubType( proc )
			ln += hEmitType( typeAddrOf( symbGetType( hidden ) ), hidden )
		else
			hidden = proc->proc.ext->res
			ln += hEmitType( typeAddrOf( symbGetType( hidden ) ), symbGetSubtype( hidden ) )
			ln += " " + *symbGetMangledName( hidden )
		end if

		if( symbGetProcParams( proc ) > 0 ) then
			ln += ", "
		end if
	end if

	var param = symbGetProcLastParam( proc )

	if( (hidden = NULL) and (param = NULL) ) then
		ln += "void"
	end if

	while( param )
		if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
			ln += "..."
		else
			var dtype = symbGetType( param )
			var subtype = param->subtype
			symbGetRealParamDtype( param->param.mode, dtype, subtype )
			ln += hEmitType( dtype, subtype )

			if( (options and EMITPROC_ISPROTO) = 0 ) then
				ln += " " + *symbGetMangledName( symbGetParamVar( param ) )
			end if
		end if

		param = symbGetProcPrevParam( proc, param )
		if( param ) then
			ln += ", "
		end if
	wend

	ln += " )"

	if( ((options and EMITPROC_ISPROCPTR) = 0) and _
	    ((options and EMITPROC_ISPROTO) <> 0)        ) then
#if 0
		'' Add an extra <asm("mangledname")> to prevent gcc
		'' from adding the stdcall @N suffix. asm() can only
		'' be used on prototypes.
		select case( symbGetProcMode( proc ) )
		case FB_FUNCMODE_STDCALL_MS, FB_FUNCMODE_PASCAL
			'' Must manually add an underscore prefix if the
			'' target requires it, because symb-mangling
			'' won't do that for -gen gcc.
			if( env.target.options and FB_TARGETOPT_UNDERSCORE ) then
				mangled  = "_" + mangled
			end if
			ln += " asm(""" + mangled + """)"
		end select
#endif
		'' ctor/dtor flags on prototypes
		hAppendCtorAttrib( ln, proc, FALSE )
	end if

	function = ln
end function

private function hGetUdtTag( byval sym as FBSYMBOL ptr ) as string
	if( symbIsStruct( sym ) ) then
		if( symbGetUDTIsUnion( sym ) ) then
			function = "union "
		else
			function = "struct "
		end if
	end if
end function

private function hGetUdtId( byval sym as FBSYMBOL ptr ) as string
	dim as FBSYMBOL ptr ns = any
	dim as string id

	ns = symbGetNamespace( sym )
	do until( ns = @symbGetGlobalNamespc( ) )
		id += *symbGetName( ns )
		id += "$"
		ns = symbGetNamespace( ns )
	loop

	if( sym->id.alias ) then
		id += *sym->id.alias
	else
		id += *symbGetName( sym )
	end if

	function = id
end function

private function hGetUdtName( byval sym as FBSYMBOL ptr ) as string
	function = hGetUdtTag( sym ) + hGetUdtId( sym )
end function

private sub hEmitEnum( byval s as FBSYMBOL ptr )
	dim as string ln

	symbSetIsEmitted( s )

	ln = "typedef "
	'' no subtype, to avoid infinite recursion
	ln += hEmitType( FB_DATATYPE_ENUM, NULL )
	ln += " "
	ln += hGetUdtName( s )
	ln += ";"
	hWriteLine( ln )
end sub

private sub hEmitUDT( byval s as FBSYMBOL ptr, byval is_ptr as integer )
	dim as integer section = any

	if( s = NULL ) then
		return
	end if

	if( symbGetIsEmitted( s ) ) then
		return
	end if

	if( symbIsLocal( s ) ) then
		'' Write declaration to corresponding scope
		'' (FB_MAINSCOPE=0 maps to section index 1)
		section = 1 + symbGetScope( s )

		'' Local to FB main? Convert to explicit main() function...
		'' (should only happen while emitting main(), since we won't
		'' see main's locals from elsewhere)
		if( symbGetScope( s ) = FB_MAINSCOPE ) then
			section += 1
		end if

		'' Switching from a parent to a child scope isn't allowed,
		'' the UDT declaration will be forced to be emitted in the
		'' parent scope anyways, since apparently that's where we
		'' need it. (used by _procAllocStaticVars())
		if( section > ctx.section ) then
			section = ctx.section
		end if
	else
		'' Write to toplevel
		section = 0
	end if

	section = sectionGosub( section )

	select case as const symbGetClass( s )
	case FB_SYMBCLASS_ENUM
		hEmitEnum( s )

	case FB_SYMBCLASS_STRUCT
		hEmitStruct( s, is_ptr )

	case FB_SYMBCLASS_PROC
		if( symbGetIsFuncPtr( s ) ) then
			hWriteLine( "typedef " + hEmitProcHeader( s, EMITPROC_ISPROTO or EMITPROC_ISPROCPTR ) + ";" )
			symbSetIsEmitted( s )
		end if

	end select

	sectionReturn( section )
end sub

'' Returns "[N]" (N = array size) if the symbol is an array or a fixlen string.
private function hEmitArrayDecl( byval sym as FBSYMBOL ptr ) as string
	dim as string s

	'' Emit all array dimensions individually
	'' (This lets array initializers rely on gcc to fill uninitialized
	'' elements with zeroes)
	select case( symbGetClass( sym ) )
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		if( (symbGetIsDynamic( sym ) = FALSE) and _
		    (symbGetArrayDimensions( sym ) <> 0) ) then
			dim as FBVARDIM ptr d = symbGetArrayFirstDim( sym )
			while( d )
				'' elements = ubound( array, d ) - lbound( array, d ) + 1
				s += "[" + str( d->upper - d->lower + 1 ) + "]"
				d = d->next
			wend
		end if
	end select

	'' If it's a fixed-length string, add an extra array dimension
	'' (zstring * 5 becomes char[5])
	dim as longint length = 0
	select case( symbGetType( sym ) )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		length = symbGetStrLen( sym )
	case FB_DATATYPE_WCHAR
		length = symbGetWstrLen( sym )
	end select
	if( length > 0 ) then
		s += "[" + str( length ) + "]"
	end if

	function = s
end function

private sub hEmitVar( byval sym as FBSYMBOL ptr, byval varini as zstring ptr )
	dim as string ln

	'' Never used?
	if( symbGetIsAccessed( sym ) = FALSE ) then
		'' Extern?
		if( symbIsExtern( sym ) ) then
			return
		end if
	end if

	'' Shared (not Local) or Static, but not Common/Public/Extern?
	if( ((symbGetAttrib( sym ) and (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) = 0) and _
	    ((not symbIsLocal( sym )) or symbIsStatic( sym )) ) then
		ln += "static "
	end if

	ln += hEmitType( symbGetType( sym ), symbGetSubType( sym ) )
	ln += " " + *symbGetMangledName( sym )
	ln += hEmitArrayDecl( sym )

	if( symbIsImport( sym ) ) then
		ln += " __attribute__((dllimport))"
	end if

	'' allocation modifier
	if( symbGetAttrib( sym ) and (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN) ) then
		hWriteLine( "extern " + ln + ";" )
		if( symbIsCommon( sym ) ) then
			ln += " __attribute__((common))"
		elseif( symbIsExtern( sym ) ) then
			'' Just an Extern that's used but not allocated in this module
			return
		end if
	end if

	if( varini ) then
		ln += " = " + *varini
	end if

	hWriteLine( ln + ";" )
end sub

private sub hEmitVariable( byval s as FBSYMBOL ptr )
	'' already allocated?
	if( symbGetVarIsAllocated( s ) ) then
		return
	end if

	symbSetVarIsAllocated( s )

	'' literal? don't emit..
	if( symbGetIsLiteral( s ) ) then
		return
	end if

	'' initialized? only if not local or local and static
	if( symbGetIsInitialized( s ) and (symbIsLocal( s ) = FALSE or symbIsStatic( s ))  ) then
		'' extern?
		if( symbIsExtern( s ) ) then
			return
		end if

		'' never referenced?
		if( symbIsLocal( s ) = FALSE ) then
			if( symbGetIsAccessed( s ) = FALSE ) then
				'' not public?
				if( symbIsPublic( s ) = FALSE ) then
					return
				end if
			end if
		end if

		astTypeIniFlush( s->var_.initree, s, AST_INIOPT_ISINI or AST_INIOPT_ISSTATIC )

		s->var_.initree = NULL
		return
	end if

	'' dynamic? only the array descriptor is emitted
	if( symbGetIsDynamic( s ) ) then
		return
	end if

	'' a string or array descriptor?
	if( symbGetLen( s ) <= 0 ) then
		return
	end if

	hEmitVar( s, NULL )
end sub

private sub hEmitGccBuiltinWrapper( byval sym as FBSYMBOL ptr )
	dim as integer count = any
	dim as FBSYMBOL ptr param = any
	dim as string params

	count = 0
	param = symbGetProcLastParam( sym )

	while( param )
		params += "temp_ppparam$" + str( count )

		param = symbGetProcPrevParam( sym, param )
		if( param ) then
			params += ", "
		end if

		count += 1
	wend

	params = *symbGetMangledName( sym ) + "( " + params + " )"

	hWriteLine( "#define " + params + " __builtin_" + params, TRUE )
end sub

private sub hEmitFuncProto( byval s as FBSYMBOL ptr )
	dim as integer section = any

	if( symbGetIsAccessed( s ) = FALSE ) then
		return
	end if

	if( symbGetMangledName( s ) = NULL ) then
		return
	end if

	'' One of our built-in FTOI routines? Those are declared by
	'' hEmitFTOIBuiltins(), not here.
	if( symbGetIsIrHlcBuiltin( s ) ) then
		return
	end if

	'' All procedure declarations go into the toplevel header
	section = sectionGosub( 0 )

	'' gcc builtin? gen a wrapper..
	if( symbGetIsGccBuiltin( s ) ) then
		hEmitGccBuiltinWrapper( s )
	else
		hWriteLine( hEmitProcHeader( s, EMITPROC_ISPROTO ) + ";" )
	end if

	sectionReturn( section )
end sub

private sub hPushAnonParents _
	( _
		byval baseparent as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr _
	)

	if( parent = baseparent ) then
		exit sub
	end if

	'' Recurse
	hPushAnonParents( baseparent, parent->parent )

	'' Push parents in top-down order
	assert( symbIsStruct( parent ) )
	if( symbGetUDTIsUnion( parent ) ) then
		hWriteLine( "union {", TRUE )
	else
		hWriteLine( "struct {", TRUE )
	end if
	sectionIndent( )
	*cptr( FBSYMBOL ptr ptr, listNewNode( @ctx.anonstack ) ) = parent

end sub

private sub hPopAnonParents( byval anonnode as FBSYMBOL ptr ptr )
	while( listGetTail( @ctx.anonstack ) <> anonnode )
		sectionUnindent( )
		hWriteLine( "};", TRUE )
		listDelNode( @ctx.anonstack, listGetTail( @ctx.anonstack ) )
	wend
end sub

private sub hEmitStruct _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_ptr as integer _
	)

	dim as string ln
	dim as integer skip = any, dtype = any, align = any
	dim as FBSYMBOL ptr subtype = any, fld = any
	dim as FBSYMBOL ptr ptr anonnode = any

	'' Already in the process of emitting this UDT?
	if( symbGetIsBeingEmitted( s ) ) then
		'' This means there is a circular dependency with another UDT.
		'' One of the references can be a pointer only though,
		'' because UDTs cannot contain each-other, so this can always
		'' be solved by using a forward reference.
		if( is_ptr ) then
			'' Emit a forward reference for this struct (if not yet done).
			'' HACK: reusing the accessed flag (that's used by variables only)
			if( symbGetIsAccessed( s ) = FALSE ) then
				symbSetIsAccessed( s )
				hWriteLine( hGetUdtName( s ) + ";" )
			end if
			exit sub
		end if
	end if

	symbSetIsBeingEmitted( s )

	'' Emit types of fields
	fld = symbUdtGetFirstField( s )
	while( fld )
		hEmitUDT( symbGetSubtype( fld ), typeIsPtr( symbGetType( fld ) ) )
		fld = symbUdtGetNextField( fld )
	wend

	'' Has this UDT been emitted in the mean time?
	'' (due to one of the fields causing a circular dependency)
	if( symbGetIsEmitted( s ) ) then
		exit sub
	end if

	'' Emit it now
	symbSetIsEmitted( s )

	'' Header: struct|union [attributes...] id {
	ln = hGetUdtTag( s )

	'' Work-around mingw32 gcc bug 52991; packing is broken for ms_struct
	'' stucts, which is the default under -mms-bitfields, which is on by
	'' default in mingw32 gcc 4.7.
	if( (env.clopt.target = FB_COMPTARGET_WIN32) and _
	    (symbGetUDTAlign( s ) > 0) ) then
		ln += "__attribute__((gcc_struct)) "
	end if

	ln += hGetUdtId( s )
	ln += " {"
	hWriteLine( ln, TRUE )
	sectionIndent( )

	'' Write out the elements
	fld = symbUdtGetFirstField( s )
	while( fld )
		if( fld->parent = s ) then
			'' Field from main UDT
			hPopAnonParents( NULL )
		else
			'' Field from a nested anonymous union/struct
			'' Check the stack to decide whether we have to start
			'' nesting further, or instead go upwards, or stay at
			'' the current level.

			'' Already on stack?
			anonnode = listGetTail( @ctx.anonstack )
			while( anonnode )
				if( *anonnode = fld->parent ) then
					exit while
				end if
				anonnode = listGetPrev( anonnode )
			wend

			if( anonnode ) then
				'' Already on stack, i.e. we go upwards
				'' Pop the stack until we reach the proper level
				hPopAnonParents( anonnode )
			else
				'' Not yet on stack, i.e. deeper nesting
				'' Push each new nested struct/union onto the stack
				hPushAnonParents( s, fld->parent )
			end if
		end if

		'' For bitfields, emit only the container field, not the
		'' individual bitfields (bitfields are merged into a "container"
		'' given by the type of the first bitfield; if further bitfields
		'' don't fit a new container is started, etc.)
		''
		'' Alternatively we could emit bitfields explicitly via ": N",
		'' but that would depend on gcc's ABI and we'd have to emit
		'' things like __attribute__((ms_struct)) too for msbitfields...
		if( symbGetType( fld ) = FB_DATATYPE_BITFIELD ) then
			skip = (symbGetSubtype( fld )->bitfld.bitpos <> 0)
		else
			skip = FALSE
		end if

		if( skip = FALSE ) then
			dtype = symbGetType( fld )
			subtype = symbGetSubtype( fld )
			ln = hEmitType( dtype, subtype )
			ln += " " + *symbGetName( fld )
			ln += hEmitArrayDecl( fld )

			'' Field alignment (FIELD = N)?
			align = symbGetUDTAlign( s )
			if( align > 0 ) then
				'' The aligned(N) attribute alone increases the alignment,
				'' together with packed it decreases it.
				'' FIELD = N in FB only decreases alignment, but never increases it.
				skip = (align >= typeCalcNaturalAlign( dtype, subtype ))

				'' Don't add unnecessary attributes on nested structures
				'' that are already packed to the same alignment,
				'' gcc would show a warning in that case.
				if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
					skip or= (align >= symbGetUDTAlign( subtype ))
				end if

				if( skip = FALSE ) then
					ln += " __attribute__((packed, aligned(" + str( align ) + ")))"
				end if
			end if

			ln += ";"
			hWriteLine( ln, TRUE )
		end if

		fld = symbUdtGetNextField( fld )
	wend

	'' Close any remaining nested anonymous structs/unions
	hPopAnonParents( NULL )

	'' Close UDT body
	assert( listGetHead( @ctx.anonstack ) = NULL )
	sectionUnindent( )
	hWriteLine( "};", TRUE )

	symbResetIsBeingEmitted( s )

end sub

private sub hEmitDecls( byval s as FBSYMBOL ptr, byval procs as integer )
	while( s )
		select case as const( symbGetClass( s ) )
		case FB_SYMBCLASS_NAMESPACE
			hEmitDecls( symbGetNamespaceTbHead( s ), procs )

		case FB_SYMBCLASS_STRUCT
			hEmitDecls( symbGetCompSymbTb( s ).head, procs )

		case FB_SYMBCLASS_SCOPE
			hEmitDecls( symbGetScopeSymbTbHead( s ), procs )

		case FB_SYMBCLASS_VAR
			if( procs ) then
				exit select
			end if

			'' Skip DATA descriptor arrays here,
			'' they're handled by hEmitDataStmt()
			if( symbGetType( s ) = FB_DATATYPE_STRUCT ) then
				if( symbGetSubtype( s ) = ast.data.desc ) then
					exit select
				end if
			end if

			hEmitVariable( s )

		case FB_SYMBCLASS_PROC
			if( procs = FALSE ) then
				exit select
			end if

			if( symbGetIsFuncPtr( s ) = FALSE ) then
				hEmitFuncProto( s )
			end if

		end select

		s = s->next
	wend
end sub

private sub hEmitDataStmt( )
	var s = astGetLastDataStmtSymbol( )
	do while( s <> NULL )
 		hEmitVariable( s )
		s = s->var_.data.prev
	loop
end sub

private sub hWriteX86FTOI _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	dim as string rtype_str, rtype_suffix
	select case rtype
	case FB_DATATYPE_LONG
		rtype_str = "int32"
		rtype_suffix = "l"
	case FB_DATATYPE_LONGINT
		rtype_str = "int64"
		rtype_suffix = "q"
	end select

	dim as string ptype_str, ptype_suffix
	select case ptype
	case FB_DATATYPE_SINGLE
		ptype_str = "float"
		ptype_suffix = "s"

	case FB_DATATYPE_DOUBLE
		ptype_str = "double"
		ptype_suffix = "l"
	end select

	if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
		rtype_suffix = ""
		ptype_suffix = ""
	end if

	hWriteLine( "", TRUE )
	hWriteLine( "static inline " + rtype_str + " fb_" + fname +  "( " + ptype_str + " value )", TRUE )
	hWriteLine( "{", TRUE )
	sectionIndent( )
		hWriteLine( "volatile " + rtype_str + " result;", TRUE )
		hWriteLine( "__asm__(", TRUE )
		sectionIndent( )
			hWriteLine( """fld" + ptype_suffix + " %1;"""  , TRUE )
			hWriteLine( """fistp" + rtype_suffix + " %0;""", TRUE )
			hWriteLine( ":""=m"" (result)", TRUE )
			hWriteLine( ":""m"" (value)"  , TRUE )
		sectionUnindent( )
		hWriteLine( ");", TRUE )
		hWriteLine( "return result;", TRUE )
	sectionUnindent( )
	hWriteLine( "}", TRUE )

end sub

private sub hWriteGenericFTOI _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	dim as string resulttype, callname

	select case rtype
	case FB_DATATYPE_LONG
		resulttype = "int32"
	case FB_DATATYPE_LONGINT
		resulttype = "int64"
	end select

	select case ptype
	case FB_DATATYPE_SINGLE
		callname = "rintf"
	case FB_DATATYPE_DOUBLE
		callname = "rint"
	end select

	hWriteLine( "#define fb_" + fname +  "( value ) ((" + resulttype + ")__builtin_" + callname + "( value ))", TRUE )

end sub

private sub hWriteFTOI _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	if( fbCpuTypeIsX86( ) ) then
		hWriteX86FTOI( fname, rtype, ptype )
	else
		hWriteGenericFTOI( fname, rtype, ptype )
	end if

end sub

private sub hEmitFTOIBuiltins( )
	'' Special conversion routines for:
	''    single/double -> [unsigned] byte/short/integer/longint
	'' (which one will be used where is determined at AST/RTL)
	''
	'' Simple C casting as in '(int)floatvar' cannot be used because it
	'' just truncates instead of rounding to nearest.
	''
	'' There are at max 4 routines generated:
	''    single -> int
	''    single -> longint
	''    double -> int
	''    double -> longint
	'' and all other cases reuse those.
	''
	'' A special case to watch out for: float -> unsigned int conversions.
	'' When converting to unsigned integer, it has to be converted to
	'' longint first, to avoid truncating to signed integer. That's a
	'' limitation of the ASM routines, and the ASM emitter is having the
	'' same problem, see emit_x86.bas:_emitLOADF2I() & co.

	'' single
	if( symbGetIsAccessed( PROCLOOKUP( FTOSL ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( FTOUL ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( FTOUI ) ) ) then
		hWriteFTOI( "ftosl", FB_DATATYPE_LONGINT, FB_DATATYPE_SINGLE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOUL ) ) ) then
		hWriteLine( "#define fb_ftoul( v ) ((uint64)fb_ftosl( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOUI ) ) ) then
		hWriteLine( "#define fb_ftoui( v ) ((uint32)fb_ftosl( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOSI ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( FTOSS ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( FTOUS ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( FTOSB ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( FTOUB ) ) ) then
		hWriteFTOI( "ftosi", FB_DATATYPE_LONG, FB_DATATYPE_SINGLE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOSS ) ) ) then
		hWriteLine( "#define fb_ftoss( v ) ((int16)fb_ftosi( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOUS ) ) ) then
		hWriteLine( "#define fb_ftous( v ) ((uint16)fb_ftosi( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOSB ) ) ) then
		hWriteLine( "#define fb_ftosb( v ) ((int8)fb_ftosi( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( FTOUB ) ) ) then
		hWriteLine( "#define fb_ftoub( v ) ((uint8)fb_ftosi( v ))", TRUE )
	end if

	'' double
	if( symbGetIsAccessed( PROCLOOKUP( DTOSL ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( DTOUL ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( DTOUI ) ) ) then
		hWriteFTOI( "dtosl", FB_DATATYPE_LONGINT, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOUL ) ) ) then
		hWriteLine( "#define fb_dtoul( v ) ((uint64)fb_dtosl( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOUI ) ) ) then
		hWriteLine( "#define fb_dtoui( v ) ((uint32)fb_dtosl( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOSI ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( DTOSS ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( DTOUS ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( DTOSB ) ) or _
	    symbGetIsAccessed( PROCLOOKUP( DTOUB ) ) ) then
		hWriteFTOI( "dtosi", FB_DATATYPE_LONG, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOSS ) ) ) then
		hWriteLine( "#define fb_dtoss( v ) ((int16)fb_dtosi( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOUS ) ) ) then
		hWriteLine( "#define fb_dtous( v ) ((uint16)fb_dtosi( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOSB ) ) ) then
		hWriteLine( "#define fb_dtosb( v ) ((int8)fb_dtosi( v ))", TRUE )
	end if

	if( symbGetIsAccessed( PROCLOOKUP( DTOUB ) ) ) then
		hWriteLine( "#define fb_dtoub( v ) ((uint8)fb_dtosi( v ))", TRUE )
	end if

end sub

private function _emitBegin( ) as integer
	if( hFileExists( env.outf.name ) ) then
		kill env.outf.name
	end if

	env.outf.num = freefile
	if( open( env.outf.name, for binary, access read write, as #env.outf.num ) <> 0 ) then
		return FALSE
	end if

	ctx.section = -1
	ctx.sectiongosublevel = 0
	ctx.regcnt = 0
	ctx.linenum = 0

	'' header
	sectionBegin( )

	if( env.clopt.debug ) then
		_emitDBG( AST_OP_DBG_LINEINI, NULL, 0 )
	end if

	hWriteLine( "// Compilation of " + env.inf.name + " started at " + time( ) + " on " + date( ), TRUE )
	hWriteLine( "", TRUE )

	hWriteLine( "typedef   signed char       int8;", TRUE )
	hWriteLine( "typedef unsigned char      uint8;", TRUE )
	hWriteLine( "typedef   signed short      int16;", TRUE )
	hWriteLine( "typedef unsigned short     uint16;", TRUE )
	hWriteLine( "typedef   signed int        int32;", TRUE )
	hWriteLine( "typedef unsigned int       uint32;", TRUE )
	hWriteLine( "typedef   signed long long  int64;", TRUE )
	hWriteLine( "typedef unsigned long long uint64;", TRUE )
	if( fbCpuTypeIs64bit( ) ) then
		hWriteLine( "typedef struct { char *data; int64 len; int64 size; } FBSTRING;", TRUE )
	else
		hWriteLine( "typedef struct { char *data; int32 len; int32 size; } FBSTRING;", TRUE )
	end if

	'' body
	sectionBegin( )

	function = TRUE
end function

private sub _emitEnd( byval tottime as double )
	dim as integer section = any
	dim as EXPRCACHENODE ptr cachenode = any
	dim as EXPRNODE ptr node = any

	'' Switch to header section temporarily
	section = sectionGosub( 0 )

	'' Append global declarations to the header of the toplevel section.
	'' This must be done during _emitEnd() instead of _emitBegin() because
	'' _emitBegin() is called even before any input code is parsed.

	'' Emit proc decls first (because of function pointer initializers
	'' taking the address of procedures)
	hEmitDecls( symbGetGlobalTbHead( ), TRUE )

	'' Then the variables
	hEmitDecls( symbGetGlobalTbHead( ), FALSE )

	'' DATA descriptor arrays must be emitted based on the order indicated
	'' by the FBSYMBOL.var_.data.prev linked list, and not in the symtb
	'' order as done by hEmitDecls().
	'' Also, DATA array initializers can reference globals by taking their
	'' address, so they must be emitted after the other global declarations.
	hEmitDataStmt( )

	hEmitFTOIBuiltins( )

	sectionReturn( section )

	'' body (is appended to header section)
	sectionEnd( )

	hWriteLine( "", TRUE )
	hWriteLine( "// Total compilation time: " + str( tottime ) + " seconds.", TRUE )

	'' Emit & close the main section
	if( ctx.sections(0).old = FALSE ) then
		if( put( #env.outf.num, , ctx.sections(0).text ) <> 0 ) then
		end if
	end if
	sectionEnd( )

	if( close( #env.outf.num ) <> 0 ) then
		'' ...
	end if
	env.outf.num = 0

	assert( ctx.sectiongosublevel = 0 )
	assert( ctx.section = -1 )

	do
		cachenode = listGetHead( @ctx.exprcache )
		if( cachenode = NULL ) then
			exit do
		end if
		listDelNode( @ctx.exprcache, cachenode )
	loop

	do
		node = listGetHead( @ctx.exprnodes )
		if( node = NULL ) then
			exit do
		end if
		exprFreeNode( node )
	loop
end sub

'':::::
private function _getOptionValue _
	( _
		byval opt as IR_OPTIONVALUE _
	) as integer

	select case opt
	case IR_OPTIONVALUE_MAXMEMBLOCKLEN
		return 0

	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

	end select

end function

private sub _procBegin( byval proc as FBSYMBOL ptr )
	proc->proc.ext->dbg.iniline = lexLineNum( )
end sub

private sub _procEnd( byval proc as FBSYMBOL ptr )
	proc->proc.ext->dbg.endline = lexLineNum( )
end sub

private sub _scopeBegin( byval s as FBSYMBOL ptr )
end sub

private sub _scopeEnd( byval s as FBSYMBOL ptr )
end sub

private sub _procAllocStaticVars( byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr desc = any
	dim as integer section = any

	''
	'' Emit all statics with dtor into the toplevel header section,
	'' so their dtor wrappers can see them.
	''
	'' This can't be done for all statics, since they can use local UDTs,
	'' and emitting those as globals too would be hard. For static with
	'' dtors though we can be sure they're not using local UDTs, because
	'' UDTs with dtors aren't allowed inside scopes.
	''

	section = sectionGosub( 0 )

	while( sym )
		select case( symbGetClass( sym ) )
		'' scope block? recursion..
		case FB_SYMBCLASS_SCOPE
			_procAllocStaticVars( symbGetScopeSymbTbHead( sym ) )

		'' variable?
		case FB_SYMBCLASS_VAR
			'' static with dtor?
			if( symbIsStatic( sym ) and symbHasDtor( sym ) ) then
				hEmitVariable( sym )

				''
				'' Check whether it's a dynamic array with a corresponding
				'' descriptor that needs to be emitted instead.
				'' (it won't be detected by above check itself,
				'' as it's of FB_ARRAYDESC type)
				''
				'' It's the descriptor that matters for dynamic
				'' arrays - the dynamic array symbol itself is
				'' not even emitted by hEmitVariable().
				''
				'' Note that for static locals the descriptor and the
				'' descriptor UDT will be local too, but since we're
				'' emitting to the toplevel section, the descriptor
				'' will end up there, and hEmitUDT() isn't allowed
				'' to emit the descriptor UDT locally.
				'' (this way we force it to be emitted globally)
				''
				desc = symbGetArrayDescriptor( sym )
				if( desc ) then
					hEmitVariable( desc )
				end if
			end if
		end select

		sym = symbGetNext( sym )
	wend

	sectionReturn( section )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hNewVR _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval vtype as integer _
	) as IRVREG ptr

	dim as IRVREG ptr v = any

	v = flistNewItem( @ctx.vregTB )

	v->typ = vtype
	v->dtype = dtype
	v->subtype = subtype
	v->sym = NULL
	v->reg = INVALID
	v->vidx	= NULL
	v->ofs = 0

	function = v

end function

'':::::
private function _allocVreg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as IRVREG ptr

	function = hNewVR( dtype, subtype, IR_VREGTYPE_REG )

end function

private function _allocVrImm _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )
	vr->value.i = value

	function = vr
end function

private function _allocVrImmF _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as double _
	) as IRVREG ptr

	dim as IRVREG ptr vr = any

	vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )
	vr->value.f = value

	function = vr
end function

'':::::
private function _allocVrVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_VAR )

	vr->sym = symbol
	vr->ofs = ofs

	function = vr

end function

'':::::
private function _allocVrIdx _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval mult as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IDX )

	vr->sym = symbol
	vr->ofs = ofs
	vr->vidx = vidx

	function = vr

end function

'':::::
private function _allocVrPtr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_PTR )

	vr->ofs = ofs
	vr->vidx = vidx

	function = vr

end function

'':::::
private function _allocVrOfs _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_OFS )

	vr->sym = symbol
	vr->ofs = ofs

	function = vr

end function

'':::::
private sub _setVregDataType _
	( _
		byval vreg as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	if( vreg <> NULL ) then
		vreg->dtype = dtype
		vreg->subtype = subtype
	end if

end sub

private sub hLoadVreg( byval vreg as IRVREG ptr )
	if( vreg = NULL ) then
		exit sub
	end if

	'' reg?
	if( vreg->typ = IR_VREGTYPE_REG ) then
		if( vreg->reg <> INVALID ) then
			exit sub
		end if

		vreg->reg = ctx.regcnt
		ctx.regcnt += 1
	end if

	'' index?
	if( vreg->vidx <> NULL ) then
		hLoadVreg( vreg->vidx )
	end if
end sub

private function hEmitType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string

	dim as string s
	dim as integer ptrcount = any

	ptrcount = typeGetPtrCnt( dtype )
	dtype = typeGetDtOnly( dtype )

	select case as const( dtype )
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		if( subtype ) then
			hEmitUDT( subtype, (ptrcount > 0) )
			s = hGetUdtName( subtype )
		elseif( dtype = FB_DATATYPE_ENUM ) then
			s = *dtypeName(typeGetRemapType( dtype ))
		else
			s = *dtypeName(FB_DATATYPE_VOID)
		end if

	case FB_DATATYPE_FUNCTION
		assert( ptrcount > 0 )
		ptrcount -= 1
		hEmitUDT( subtype, (ptrcount > 0) )
		s = *symbGetMangledName( subtype )

	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		'' Emit ubyte instead of char,
		'' and ubyte/ushort/uinteger instead of wchar_t
		s = *dtypeName(typeGetRemapType( dtype ))

	case FB_DATATYPE_FIXSTR
		'' Ditto (but typeGetRemapType() returns FB_DATATYPE_FIXSTR,
		'' so do it manually)
		s = *dtypeName(FB_DATATYPE_UBYTE)

	case FB_DATATYPE_BITFIELD
		s = *dtypeName(symbGetType( subtype ))

	case else
		s = *dtypeName(dtype)
	end select

	if( ptrcount > 0 ) then
		s += string( ptrcount, "*" )
	end if

	function = s
end function

private function exprNew _
	( _
		byval class_ as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any

	n = listNewNode( @ctx.exprnodes )
	n->class = class_
	n->dtype = dtype
	n->subtype = subtype

	function = n
end function

private sub exprFreeNode( byval n as EXPRNODE ptr )
	if( n->class = EXPRCLASS_TEXT ) then
		ZstrFree( n->text )
	end if
	listDelNode( @ctx.exprnodes, n )
end sub

private sub exprFreeTree( byval n as EXPRNODE ptr )
	if( n->l ) then
		exprFreeTree( n->l )
	end if
	if( n->r ) then
		exprFreeTree( n->r )
	end if
	exprFreeNode( n )
end sub

private function exprNewTEXT _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval s as zstring ptr _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any

	n = exprNew( EXPRCLASS_TEXT, dtype, subtype )
	n->text = ZstrDup( s )

	function = n
end function

private function exprNewIMMi _
	( _
		byval i as longint, _
		byval dtype as integer = FB_DATATYPE_INTEGER _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any

	n = exprNew( EXPRCLASS_IMM, dtype, NULL )
	n->val.i = i

	function = n
end function

private function exprNewIMMf _
	( _
		byval f as double, _
		byval dtype as integer _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any

	n = exprNew( EXPRCLASS_IMM, dtype, NULL )
	n->val.f = f

	function = n
end function

private function symbIsCArray( byval sym as FBSYMBOL ptr ) as integer
	'' No bydesc/byref, those are emitted as pointers...
	if( symbIsParamBydescOrByref( sym ) ) then
		return FALSE
	end if

	select case( symbGetClass( sym ) )
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		'' No dynamic arrays, they're just descriptor structs
		if( symbGetIsDynamic( sym ) ) then
			return FALSE
		end if

		if( symbGetArrayDimensions( sym ) <> 0 ) then
			return TRUE
		end if
	end select

	'' Fixed-length strings are emitted as arrays,
	'' string literals are emitted as string literals,
	'' both are pointers in C
	select case( symbGetType( sym ) )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		return TRUE
	end select

	return FALSE
end function

private function exprNewCAST _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as EXPRNODE ptr _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any

	'' Don't add a CAST if l already has the desired type
	if( (dtype = l->dtype) and (subtype = l->subtype) ) then
		return l
	end if

	'' Don't cast if l has a compatible type (e.g. 32bit int vs. 32bit long)
	'' (same class, same size, same signedness, and no pointers involved)
	if( (typeGetClass( l->dtype ) = typeGetClass( dtype )) and _
	    (typeIsSigned( l->dtype ) = typeIsSigned( dtype )) and _
	    (not typeIsPtr( l->dtype )) and (not typeIsPtr( dtype )) and _
	    (typeGetSize( l->dtype ) = typeGetSize( dtype )) ) then
		return l
	end if

	'' "(foo*)(bar*)"? Discard the bar* cast and cast only to foo*,
	'' pointers are pointers, such double casts are useless.
	if( l->class = EXPRCLASS_CAST ) then
		if( (typeGetPtrCnt( dtype ) > 0) and (typeGetPtrCnt( l->dtype ) > 0) ) then
			l->dtype = dtype
			l->subtype = subtype
			return l
		end if
	end if

	n = exprNew( EXPRCLASS_CAST, dtype, subtype )
	n->l = l

	function = n
end function

private function exprNewSYM( byval sym as FBSYMBOL ptr ) as EXPRNODE ptr
	dim as EXPRNODE ptr n = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	if( symbIsLabel( sym ) ) then
		'' &&label is a void* in GCC
		'' This is handled as a single SYM instead of ADDROF( SYM ),
		'' because a label is not a proper expression on its own.
		dtype = typeAddrOf( FB_DATATYPE_VOID )
		subtype = NULL
	elseif( symbIsProc( sym ) ) then
		'' &proc
		'' Similar to labels above, this is only used to take the
		'' address of functions, not to call them, so the '&' is
		'' part of the SYM.
		dtype = typeAddrOf( FB_DATATYPE_FUNCTION )
		subtype = sym
	elseif( symbIsCArray( sym ) ) then
		dtype = FB_DATATYPE_INVALID
		subtype = NULL
	else
		dtype = symbGetType( sym )
		subtype = symbGetSubtype( sym )
	end if

	n = exprNew( EXPRCLASS_SYM, dtype, subtype )
	n->sym = sym

	'' Array? Add CAST to make it a pointer to the first element,
	'' instead of a pointer to the array.
	if( dtype = FB_DATATYPE_INVALID ) then
		n = exprNewCAST( typeAddrOf( symbGetType( sym ) ), symbGetSubtype( sym ), n )
	end if

	function = n
end function

private function typeCBop _
	( _
		byval op as integer, _
		byval a as integer, _
		byval asubtype as FBSYMBOL ptr, _
		byval b as integer, _
		byval bsubtype as FBSYMBOL ptr _
	) as integer

	'' Result of relational/comparison operators is int
	select case( op )
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		return FB_DATATYPE_LONG
	end select

	'' This tries to do C operand type promotion (and is probably not
	'' 100% accurate), in order to figure out the result type of BOP/UOP
	'' in the C output code, to allow the expression emitting decide
	'' whether it needs to insert casts in the C output code or not.
	''
	'' This might only actually make a difference in rare cases;
	'' it depends on what kind of BOPs the AST tries to emit.
	''
	'' 1. Operands < int/uint (i.e. byte, short) are promoted to int/uint.
	'' 2. For operands >= int/uint, one operand is promoted to match the
	''    other, if necessary. (except for bitshifts, where the rhs' type
	''    isn't taken into account, unlike FB)

	a = typeGet( a )
	b = typeGet( b )

	'' Float types take precedence (?)
	if( (a = FB_DATATYPE_DOUBLE) or (b = FB_DATATYPE_DOUBLE) ) then
		return FB_DATATYPE_DOUBLE
	end if
	if( (a = FB_DATATYPE_SINGLE) or (b = FB_DATATYPE_SINGLE) ) then
		return FB_DATATYPE_SINGLE
	end if

	'' Promote 8bit/16bit types to 32bit,
	'' and normalize 32bit types to FB_DATATYPE_LONG
	if( typeGetSize( a ) <= 4 ) then
		a = iif( typeIsSigned( a ), FB_DATATYPE_LONG, FB_DATATYPE_ULONG )
	end if
	if( typeGetSize( b ) <= 4 ) then
		b = iif( typeIsSigned( b ), FB_DATATYPE_LONG, FB_DATATYPE_ULONG )
	end if

	'' Promote signed to unsigned
	if( (not typeIsSigned( a )) or (not typeIsSigned( b )) ) then
		a = typeToUnsigned( a )
		b = typeToUnsigned( b )
	end if

	'' Promote to 64bit, iff a 64bit operand is involved,
	'' and normalize to FB_DATATYPE_LONGINT
	if( (typeGetSize( a ) = 8) or (typeGetSize( b ) = 8) ) then
		a = iif( typeIsSigned( a ), FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT )
		b = iif( typeIsSigned( b ), FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT )
	end if

	'' Promote signed to unsigned
	if( (not typeIsSigned( a )) or (not typeIsSigned( b )) ) then
		a = typeToUnsigned( a )
		b = typeToUnsigned( b )
	end if

	function = a
end function

private function exprNewUOP _
	( _
		byval op as integer, _
		byval l as EXPRNODE ptr _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any
	dim as integer dtype = any, solved_out = any

	solved_out = FALSE

	'' Similar to BOPs, the C type promotion rules should be applied
	'' to determine the UOP's result type.
	select case( op )
	case AST_OP_ADDROF
		'' peep-hole optimization:
		'' ADDROF( DEREF( x ) ) -> x
		if( l->class = EXPRCLASS_UOP ) then
			solved_out = (l->op = AST_OP_DEREF)
		end if

		dtype = l->dtype
		dtype = typeAddrOf( dtype )

	case AST_OP_DEREF
		'' peep-hole optimization:
		'' DEREF( ADDROF( x ) ) -> x
		if( l->class = EXPRCLASS_UOP ) then
			solved_out = (l->op = AST_OP_ADDROF)
		end if

		dtype = l->dtype
		assert( typeGetPtrCnt( dtype ) > 0 )
		dtype = typeDeref( dtype )

	case AST_OP_NEG, AST_OP_NOT
		'' peep-hole optimization:
		''    -(-(foo)) -> foo
		''    ~(~(foo)) -> foo
		if( l->class = EXPRCLASS_UOP ) then
			solved_out = (l->op = op)
		end if

		dtype = typeCBop( op, l->dtype, l->subtype, FB_DATATYPE_INTEGER, NULL )

	case else
		assert( FALSE )
	end select

	if( solved_out ) then
		n = l->l
		exprFreeNode( l )
		return n
	end if

	n = exprNew( EXPRCLASS_UOP, dtype, l->subtype )
	n->l = l
	n->op = op

	function = n
end function

private function exprNewBOP _
	( _
		byval op as integer, _
		byval l as EXPRNODE ptr, _
		byval r as EXPRNODE ptr _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr n = any
	dim as integer dtype = any

	'' To find out the BOPs result type, apply C type promotion rules
	dtype = typeCBop( op, l->dtype, l->subtype, r->dtype, r->subtype )

	'' BOPs should only be done on simple int/float types,
	'' and on pointers only after casting to ubyte* first,
	'' so no subtype needs to be preserved here.

	n = exprNew( EXPRCLASS_BOP, dtype, NULL )
	n->l = l
	n->r = r
	n->op = op

	function = n
end function

'' Add expression root node to cache list, with the corresponding vreg id,
'' allowing it to be looked up later (when the AST accesses that vreg).
private sub exprCache( byval vregid as integer, byval expr as EXPRNODE ptr )
	dim as EXPRCACHENODE ptr entry = any
	entry = listNewNode( @ctx.exprcache )
	entry->vregid = vregid
	entry->expr = expr
end sub

private function exprLookup( byval vregid as integer ) as EXPRNODE ptr
	dim as EXPRCACHENODE ptr entry = any

	'' Find the node corresponding to that vreg, if any.
	entry = listGetHead( @ctx.exprcache )
	while( entry )
		if( entry->vregid = vregid ) then
			exit while
		end if
		entry = listGetNext( entry )
	wend

	if( entry ) then
		function = entry->expr
		listDelNode( @ctx.exprcache, entry )
	else
		function = NULL
	end if
end function

private function hEmitInt _
	( _
		byval dtype as integer, _
		byval value as longint _
	) as string

	dim as string s

	if( typeIsSigned( dtype ) ) then
		s = str( value )

		'' Prevent GCC warnings for INT_MIN/LLONG_MIN:
		'' The '-' minus sign doesn't count as part of the number
		'' literal, and 2147483648 is too big for a 32bit integer,
		'' so it must be marked as unsigned.
		if( typeGetSize( dtype ) = 8 ) then
			if( value = -9223372036854775808ull ) then
				s += "u"
			end if
			s += "ll"
		else
			if( value = -2147483648u ) then
				s += "u"
			end if
		end if
	else
		if( typeGetSize( dtype ) = 8 ) then
			s = str( culngint( value ) ) + "ull"
		else
			s = str( culng( value ) ) + "u"
		end if
	end if

	function = s
end function

private function hEmitFloat _
	( _
		byval dtype as integer, _
		byval value as double _
	) as string

	dim as string s
	dim as ulong expval = any

	'' x86 little-endian assumption
	expval = cast( ulong ptr, @value )[1]

	select case( expval )
	'' +/- infinity?
	case &h7FF00000UL, &hFFF00000UL
		if( dtype = FB_DATATYPE_DOUBLE ) then
			if( expval and &h80000000ul ) then
				s += "(-__builtin_inf())"
			else
				s += "__builtin_inf()"
			end if
		else
			if( expval and &h80000000ul ) then
				s += "(-__builtin_inff())"
			else
				s += "__builtin_inff()"
			end if
		end if

	'' +/- NaN? Quiet-NaN's only
	case &h7FF80000UL, &hFFF80000UL
		if( dtype = FB_DATATYPE_DOUBLE ) then
			if( expval and &h80000000ul ) then
				s += "(-__builtin_nan( """" ))"
			else
				s += "__builtin_nan( """" )"
			end if
		else
			if( expval and &h80000000ul ) then
				s += "(-__builtin_nanf( """" ))"
			else
				s += "__builtin_nanf( """" )"
			end if
		end if

	case else
		if( dtype = FB_DATATYPE_DOUBLE ) then
			s = str( value )
		else
			s = str( csng( value ) )
		end if

		'' Append .0 if there is no dot or exponent yet,
		'' to prevent gcc from treating it as int
		'' (e.g. 1 -> 1.0, but 0.1 or 1e-100 can stay as-is)
		if( instr( s, any "e." ) = 0 ) then
			s += ".0"
		end if

		'' float type suffix
		if( dtype = FB_DATATYPE_SINGLE ) then
			s += "f"
		end if

	end select

	function = s
end function

private sub hBuildStrLit _
	( _
		byref ln as string, _
		byval z as zstring ptr, _
		byval length as longint _  '' including null terminator
	)

	dim as integer ch = any

	'' Convert the string to something suitable for C
	'' (assuming internal escape sequences have already been solved out
	'' using hUnescape())
	'' Non-ASCII characters and also \ or " must be escaped, but also care
	'' must be taken when normal chars following an escape sequence would
	'' be seen as part of that escape sequence. This is handled by splitting
	'' the string literal in two at that position.

	ln += """"

	'' Don't bother emitting the null terminator explicitly - gcc will add
	'' it automatically already
	for i as integer = 0 to length - 2
		ch = (*z)[i]

		if( hCharNeedsEscaping( ch, asc( """" ) ) ) then
			'' Emit in \xNN escape form
			ln += $"\x" + hex( ch, 2 )

			'' Is there an 0-9, a-f or A-F char following?
			if( i < (length - 1) ) then
				if( hIsValidHexDigit( (*z)[i + 1] ) ) then
					'' Split up the string literal to prevent
					'' the compiler from treating this following
					'' char as part of the escape sequence
					ln += """ """
				end if
			end if
		else
			'' Emit as-is
			ln += chr( ch )
		end if
	next

	ln += """"
end sub

private sub hBuildWstrLit _
	( _
		byref ln as string, _
		byval w as wstring ptr, _
		byval length as longint _  '' including null terminator
	)

	dim as integer ch = any
	dim as integer wcharsize = any

	'' (ditto)

	ln += "L"""
	wcharsize = typeGetSize( FB_DATATYPE_WCHAR )

	'' Don't bother emitting the null terminator explicitly - gcc will add
	'' it automatically already
	for i as integer = 0 to length - 2
		ch = (*w)[i]

		if( hCharNeedsEscaping( ch, asc( """" ) ) ) then
			ln += $"\x" + hex( ch, wcharsize * 2 )

			if( i < (length - 1) ) then
				if( hIsValidHexDigit( (*w)[i + 1] ) ) then
					ln += """ L"""
				end if
			end if
		else
			ln += chr( ch )
		end if
	next

	ln += """"
end sub

private function hBopToStr( byval op as integer ) as zstring ptr
	select case as const( op )
	case AST_OP_ADD
		function = @" + "
	case AST_OP_SUB
		function = @" - "
	case AST_OP_MUL
		function = @" * "
	case AST_OP_DIV
		function = @" / "
	case AST_OP_INTDIV
		function = @" / "
	case AST_OP_MOD
		function = @" % "
	case AST_OP_SHL
		function = @" << "
	case AST_OP_SHR
		function = @" >> "
	case AST_OP_AND
		function = @" & "
	case AST_OP_OR
		function = @" | "
	case AST_OP_XOR
		function = @" ^ "
	case AST_OP_EQ
		function = @" == "
	case AST_OP_GT
		function = @" > "
	case AST_OP_LT
		function = @" < "
	case AST_OP_NE
		function = @" != "
	case AST_OP_GE
		function = @" >= "
	case AST_OP_LE
		function = @" <= "
	end select
end function

'' Builds up final expression text, walking the EXPRNODE tree
private sub hExprFlush( byval n as EXPRNODE ptr, byval need_parens as integer )
	dim as EXPRNODE ptr l = any
	dim as FBSYMBOL ptr sym = any

	select case as const( n->class )
	case EXPRCLASS_TEXT
		ctx.exprtext += *n->text

	case EXPRCLASS_IMM
		if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
			ctx.exprtext += hEmitFloat( n->dtype, n->val.f )
		else
			ctx.exprtext += hEmitInt( n->dtype, n->val.i )
		end if

	case EXPRCLASS_SYM
		sym = n->sym

		'' String literal?
		if( symbGetIsLiteral( sym ) ) then
			if( symbGetType( sym ) = FB_DATATYPE_WCHAR ) then
				ctx.exprtext += "(" + hEmitType( typeAddrOf( FB_DATATYPE_WCHAR ), NULL ) + ")"
				hBuildWstrLit( ctx.exprtext, hUnescapeW( symbGetVarLitTextW( sym ) ), symbGetWstrLen( sym ) )
			else
				ctx.exprtext += "(" + hEmitType( typeAddrOf( FB_DATATYPE_CHAR ), NULL ) + ")"
				hBuildStrLit( ctx.exprtext, hUnescape( symbGetVarLitText( sym ) ), symbGetStrLen( sym ) )
			end if
		else
			if( symbIsLabel( sym ) ) then
				ctx.exprtext += "&&"
			elseif( symbIsProc( sym ) ) then
				ctx.exprtext += "&"
			end if
			ctx.exprtext += *symbGetMangledName( sym )
		end if

	case EXPRCLASS_CAST
		ctx.exprtext += "("
		ctx.exprtext += hEmitType( n->dtype, n->subtype )
		ctx.exprtext += ")"
		hExprFlush( n->l, TRUE )

	case EXPRCLASS_UOP
		select case( n->op )
		case AST_OP_ADDROF
			ctx.exprtext += "&"
		case AST_OP_DEREF
			ctx.exprtext += "*"
		case AST_OP_NEG
			ctx.exprtext += "-"
		case AST_OP_NOT
			ctx.exprtext += "~"
		case else
			assert( FALSE )
		end select

		'' Add parentheses around UOPs to avoid -(-(foo)) looking like
		'' --foo which looks like the -- operator to gcc...
		need_parens = (n->l->class = EXPRCLASS_UOP)
		if( need_parens ) then
			ctx.exprtext += "("
		end if
		hExprFlush( n->l, TRUE )
		if( need_parens ) then
			ctx.exprtext += ")"
		end if

	case EXPRCLASS_BOP
		'' Add parentheses around BOPs if the parent needs it
		'' (looks like parentheses are unnecessary for all the other
		'' expressions though, CAST/UOP should work fine without
		'' parentheses around their operand)
		if( need_parens ) then
			ctx.exprtext += "("
		end if
		hExprFlush( n->l, TRUE )
		ctx.exprtext += *hBopToStr( n->op )
		hExprFlush( n->r, TRUE )
		if( need_parens ) then
			ctx.exprtext += ")"
		end if

	end select
end sub

private function exprFlush _
	( _
		byval n as EXPRNODE ptr, _
		byval need_parens as integer = FALSE _
	) as string

	hExprFlush( n, need_parens )

	function = ctx.exprtext
	ctx.exprtext = ""

	exprFreeTree( n )
end function

#if __FB_DEBUG__
private sub exprDump( byval n as EXPRNODE ptr )
	static as integer level
	dim as string s

	level += 1

	select case as const( n->class )
	case EXPRCLASS_TEXT
		s = "TEXT( " + *n->text + " )"

	case EXPRCLASS_IMM
		if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
			s = "IMM( " + hEmitFloat( n->dtype, n->val.f ) + " )"
		else
			s = "IMM( " + hEmitInt( n->dtype, n->val.i ) + " )"
		end if

	case EXPRCLASS_SYM
		s = "SYM( "

		'' String literal?
		if( symbGetIsLiteral( n->sym ) ) then
			if( symbGetType( n->sym ) = FB_DATATYPE_WCHAR ) then
				hBuildWstrLit( s, hUnescapeW( symbGetVarLitTextW( n->sym ) ), symbGetWstrLen( n->sym ) )
			else
				hBuildStrLit( s, hUnescape( symbGetVarLitText( n->sym ) ), symbGetStrLen( n->sym ) )
			end if
		else
			if( symbIsLabel( n->sym ) ) then
				s += "&&"
			elseif( symbIsProc( n->sym ) ) then
				s += "&"
			end if
			s += *symbGetMangledName( n->sym )
		end if

		s += " )"

	case EXPRCLASS_CAST
		s = "CAST( " + hEmitType( n->dtype, n->subtype ) + " )"

	case EXPRCLASS_UOP
		s = "UOP( "
		select case( n->op )
		case AST_OP_ADDROF
			s += "&"
		case AST_OP_DEREF
			s += "*"
		case AST_OP_NEG
			s += "-"
		case AST_OP_NOT
			s += "~"
		end select
		s += " )"

	case EXPRCLASS_BOP
		s = "BOP( " + *hBopToStr( n->op ) + " )"

	end select

	s += " as " + symbTypeToStr( n->dtype, n->subtype ) + ", " + hex( n->subtype, 8 )

	print str( level ), string( level, " " ) + s

	select case( n->class )
	case EXPRCLASS_CAST, EXPRCLASS_UOP
		exprDump( n->l )
	case EXPRCLASS_BOP
		exprDump( n->l )
		exprDump( n->r )
	end select

	level -= 1
end sub
#endif

private function exprNewOFFSET _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as longint _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr l = any

	l = exprNewSYM( sym )

	'' Add '&' for things that aren't pointers already
	if( (symbIsImport( sym ) or symbIsCArray( sym ) or _
	     symbIsProc( sym ) or symbIsLabel( sym )) = FALSE ) then
		l = exprNewUOP( AST_OP_ADDROF, l )
	end if

	'' Add on the byte offset, if any
	if( ofs <> 0 ) then
		'' Cast to ubyte ptr to work around C's pointer arithmetic
		l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
		l = exprNewBOP( AST_OP_ADD, l, exprNewIMMi( ofs ) )
	end if

	function = l
end function

private function exprNewVREG _
	( _
		byval vreg as IRVREG ptr, _
		byval is_lvalue as integer = FALSE _
	) as EXPRNODE ptr

	dim as EXPRNODE ptr l = any
	dim as integer dtype = any, have_offset = any
	dim as FBSYMBOL ptr subtype = any

	select case as const( vreg->typ )
	case IR_VREGTYPE_VAR, IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		if( vreg->sym = NULL ) then
			'' No symbol attached, but vidx instead, unless the
			'' address was given as a constant,
			'' e.g. in derefs like *cptr(byte ptr, 0),
			'' then there is neither a symbol nor vidx,
			'' but just the "offset".
			''    *(vregtype*)offset
			''    *(vregtype*)vidx
			''    *(vregtype*)((uint8*)vidx + offset)

			if( vreg->vidx ) then
				'' recursion
				l = exprNewVREG( vreg->vidx )

				if( vreg->ofs <> 0 ) then
					'' Cast to ubyte ptr to work around C's pointer arithmetic
					l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
					l = exprNewBOP( AST_OP_ADD, l, exprNewIMMi( vreg->ofs ) )
				end if
			else
				l = exprNewIMMi( vreg->ofs )
			end if

			l = exprNewCAST( typeAddrOf( vreg->dtype ), vreg->subtype, l )
			l = exprNewUOP( AST_OP_DEREF, l )
			exit select
		end if

		assert( symbIsProc( vreg->sym ) = FALSE )  '' should be an IR_VREGTYPE_OFS
		assert( symbIsLabel( vreg->sym ) = FALSE ) '' should be handled in _emitAddr()

		'' memory accesses - stack vars, arrays, UDT fields, ptr derefs
		''
		'' - offsets are byte offsets as calculated by the AST
		'' - vreg's dtype can be different from symbol's dtype,
		''   e.g. UDT var + field access, or due to type casting.
		'' - vregs can be structs/strings here in the C backend
		'' - C doesn't allow direct casting to/from structs, but we can
		''   do a deref/addrof trick like *(vregtype*)&udtvar instead.
		'' - no float <-> int conversions should be done here, so be
		''   careful with vregdtype=integer while sym=floatvar etc.,
		''   the work-around (again) is the deref/addrof trick.
		''
		'' simple var accesses:
		''        sym
		''        (vregtype)sym
		'' ptr derefs:
		''        *(vregtype*)sym
		''        *(vregtype*)((uint8*)sym + offset)
		'' array accesses (idx):
		''        *(vregtype*)((uint8*)sym + vidx + offset)
		'' field accesses:
		''        *(vregtype*)&sym
		''        *(vregtype*)((uint8*)&sym + offset)

		have_offset = ((vreg->ofs <> 0) or (vreg->vidx <> NULL))

		'' Check whether to do plain access or deref/addrof trick
		'' - any offset? use trick, to allow doing +offset
		'' - symbol is an array in the C code? (arrays, fixlen strings...)
		''   cannot just do (elementtype)carray, it must always be
		''   *(elementtype*)carray to access the memory in these cases.
		dim as integer is_carray = symbIsCArray( vreg->sym )
		dim as integer do_deref = have_offset or is_carray

		dim as integer is_ptr = typeIsPtr( symbGetType( vreg->sym ) )
		dim as integer symdtype = symbGetType( vreg->sym )
		dim as FBSYMBOL ptr symsubtype = symbGetSubtype( vreg->sym )

		'' Emitted as pointer?
		if( symbIsParamByRef( vreg->sym ) or symbIsImport( vreg->sym ) or is_carray ) then
			is_ptr = TRUE
			symdtype = typeAddrOf( symdtype )
		end if

		l = exprNewSYM( vreg->sym )

		'' Different types?
		if( (vreg->dtype <> symdtype) or (vreg->subtype <> symsubtype) ) then
			'' a) float <-> int: access raw bytes instead of converting
			'' b) struct <-> any other: ensure valid C syntax

			'' different data classes?
			do_deref or= (typeGetClass( vreg->dtype ) <> typeGetClass( symdtype ))

			'' any structs involved? (note: FBSTRINGs are structs in the C code too!)
			select case( typeGet( vreg->dtype ) )
			case FB_DATATYPE_STRING, FB_DATATYPE_STRUCT
				do_deref = TRUE
			case else
				select case( typeGet( symdtype ) )
				case FB_DATATYPE_STRING, FB_DATATYPE_STRUCT
					do_deref = TRUE
				end select
			end select
		end if

		if( do_deref = FALSE ) then
			'' Plain access is enough
			exit select
		end if

		'' Deref/addrof trick

		'' Add '&' for things that aren't pointers already
		if( is_ptr = FALSE ) then
			l = exprNewUOP( AST_OP_ADDROF, l )
		end if
		if( have_offset ) then
			'' Cast to ubyte ptr to work around C's pointer arithmetic
			l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
			if( vreg->vidx <> NULL ) then
				l = exprNewBOP( AST_OP_ADD, l, exprNewVREG( vreg->vidx ) )
			end if
			if( vreg->ofs <> 0 ) then
				l = exprNewBOP( AST_OP_ADD, l, exprNewIMMi( vreg->ofs ) )
			end if
		end if

		'' cast to vregdtype*
		l = exprNewCAST( typeAddrOf( vreg->dtype ), vreg->subtype, l )

		'' deref to get vregdtype
		l = exprNewUOP( AST_OP_DEREF, l )

	case IR_VREGTYPE_OFS
		'' Accessing a global, including string literals and function
		'' symbols (used when taking address of functions).
		l = exprNewOFFSET( vreg->sym, vreg->ofs )

	case IR_VREGTYPE_IMM
		static as string s

		'' An immediate -- a constant value
		'' It should be cast to the vreg's type for cases like
		''    "cptr(any ptr, 0)"
		'' where the constant has some pointer type, and we'd like to
		'' avoid gcc warnings about pointers...

		dtype = vreg->dtype

		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			l = exprNewIMMf( vreg->value.f, dtype )
		else
			l = exprNewIMMi( vreg->value.i, dtype )
		end if

	case IR_VREGTYPE_REG
		'' Access to existing vreg (e.g. BOP result)
		l = exprLookup( vreg->reg )
		if( l = NULL ) then
			'' Accessing a previous vreg a second time
			'' This currently should only happen with -exx pointer
			'' or array checking function calls, where the AST is
			'' reusing the function result vreg. Since the vreg is
			'' a call result, the C backend will have emitted a
			'' temp var, allowing this reuse to work.
			l = exprNewTEXT( vreg->dtype, vreg->subtype, "vr$" + str( vreg->reg ) )
		end if

	end select

	if( is_lvalue = FALSE ) then
		l = exprNewCAST( vreg->dtype, vreg->subtype, l )
	end if

	function = l
end function

private sub _emitLabel( byval label as FBSYMBOL ptr )
	'' Only when inside normal procedures
	'' (NAKED procedures don't increase the indentation)
	if( sectionInsideProc( ) ) then
		hWriteLine( *symbGetMangledName( label ) + ":;" )
	end if
end sub

'' store an expression into a vreg
private sub exprSTORE _
	( _
		byval vr as IRVREG ptr, _
		byval r as EXPRNODE ptr, _
		byval has_sidefx as integer = FALSE _
	)

	static as string ln, tempvar
	dim as EXPRNODE ptr l = any

	if( irIsREG( vr ) ) then
		if( has_sidefx ) then
			'' Expressions (REG) with side-effects (i.e. CALLs)
			'' should be emitted immediately in-place, that's what
			'' the AST expects, like with the ASM backend.
			''  a) due to the side-effects
			''  b) because sometimes it leaves the vreg dangling
			''     and relies only on the side-effects, e.g. when
			''     calling functions that return their UDT result
			''     through a hidden parameter. The CALL expression
			''     must be emitted, but the result vreg won't ever
			''     be accessed.
			'' 
			'' -> Create a temp var and use that as the new vreg
			'' expression, instead of the original expr itself:
			''    type tempvar = expr;
			'' (no cast needed, the assignment has the same effect)
			tempvar = "vr$" + str( vr->reg )

			ln = hEmitType( vr->dtype, vr->subtype )
			ln += " " + tempvar + " = "
			ln += exprFlush( r )
			ln += ";"

			hWriteLine( ln )

			r = exprNewTEXT( vr->dtype, vr->subtype, tempvar )
		else
			r = exprNewCAST( vr->dtype, vr->subtype, r )
		end if

		'' Put the expression on hold, it'll be used in the following
		'' access to that vreg, instead of being emitted right here
		'' as a #define or temp var.
		exprCache( vr->reg, r )
	else
		'' Store into existing vreg (assign to var/deref, i.e. lvalue)
		''    vreg = (vregtype)r;
		'' FB allows noconv casts (no data class/size change) on the
		'' lhs, but C does not, the rhs should be casted here instead,
		'' although it probably doesn't matter much either way.
		l = exprNewVREG( vr, TRUE )

		'' 1st to the desired vreg type
		r = exprNewCAST( vr->dtype, vr->subtype, r )

		if( typeIsPtr( l->dtype ) or typeIsPtr( r->dtype ) ) then
			'' 2nd to void* to avoid gcc ptr warnings
			r = exprNewCAST( l->dtype, l->subtype, r )
		end if

		ln = exprFlush( l )
		ln += " = "
		ln += exprFlush( r )
		ln += ";"

		hWriteLine( ln )
	end if

end sub

private sub _emitBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval ex as FBSYMBOL ptr _
	)

	dim as EXPRNODE ptr l = any, r = any

	hLoadVreg( v1 )
	hLoadVreg( v2 )
	hLoadVreg( vr )

	l = exprNewVREG( v1 )
	r = exprNewVREG( v2 )

	select case as const( op )
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		if( vr = NULL ) then
			'' Conditional branch
			static as string s
			s = "if( "
			s += exprFlush( exprNewBOP( op, l, r ) )
			s += " ) goto "
			s += *symbGetMangledName( ex )
			s += ";"
			hWriteLine( s )
			exit sub
		end if
	end select

	if( vr = NULL ) then
		vr = v1
	end if

	select case as const( op )
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		'' Must work-around C's boolean logic values and convert the "boolean"
		'' 1 to -1 while 0 stays 0 to match FB.
		l = exprNewUOP( AST_OP_NEG, exprNewBOP( op, l, r ) )

	case AST_OP_ADD, AST_OP_SUB, AST_OP_MUL, AST_OP_DIV, AST_OP_INTDIV, _
	     AST_OP_MOD, AST_OP_SHL, AST_OP_SHR, AST_OP_AND, AST_OP_OR, _
	     AST_OP_XOR
		dim as integer is_ptr_arith = ((op = AST_OP_ADD) or (op = AST_OP_SUB))

		'' Cast to byte ptr to work around C's pointer arithmetic
		if( is_ptr_arith and typeIsPtr( v1->dtype ) ) then
			l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
		end if
		if( is_ptr_arith and typeIsPtr( v2->dtype ) ) then
			r = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, r )
		end if

		'' Ensure '/' means floating point divide by casting to double
		'' For AST_OP_INTDIV this is not needed, since the AST will already
		'' cast both operands to integer before doing the intdiv.
		if( op = AST_OP_DIV ) then
			l = exprNewCAST( FB_DATATYPE_DOUBLE, NULL, l )
			r = exprNewCAST( FB_DATATYPE_DOUBLE, NULL, r )
		end if

		l = exprNewBOP( op, l, r )

	case AST_OP_EQV
		'' vr = ~(v1 ^ v2)
		l = exprNewUOP( AST_OP_NOT, exprNewBOP( AST_OP_XOR, l, r ) )

	case AST_OP_IMP
		'' vr = ~v1 | v2
		l = exprNewBOP( AST_OP_OR, exprNewUOP( AST_OP_NOT, l ), r )

	end select

	exprSTORE( vr, l )
end sub

private sub _emitUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( vr )

	if( vr = NULL ) then
		vr = v1
	end if

	exprSTORE( vr, exprNewUOP( op, exprNewVREG( v1 ) ) )

end sub

private sub _emitStore( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	hLoadVreg( v1 )
	hLoadVreg( v2 )
	exprSTORE( v1, exprNewVREG( v2 ) )
end sub

private sub _emitSpillRegs( )
	/' do nothing '/
end sub

private sub _emitLoad( byval v1 as IRVREG ptr )
	/' do nothing '/
end sub

private sub _emitLoadRes( byval v1 as IRVREG ptr, byval vr as IRVREG ptr )
	_emitStore( vr, v1 )
	hWriteLine( "return " + exprFlush( exprNewVREG( vr ) ) + ";" )
end sub

private sub _emitAddr _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	static as string s
	dim as EXPRNODE ptr l = NULL

	hLoadVreg( v1 )
	hLoadVreg( vr )

	select case( op )
	case AST_OP_ADDROF
		'' Taking address of label?
		if( (v1->typ = IR_VREGTYPE_VAR) and (v1->sym <> NULL) ) then
			if( symbIsLabel( v1->sym ) ) then
				''
				'' special case used by FB error handling code
				''
				'' The VAR vreg's dtype for the label access
				'' is useless because 1) the AST is inconsistently
				'' using integer or byte and 2) labels cannot be
				'' casted anyways.
				''
				'' The only thing that matters is the dtype of the
				'' result vreg (the type of the ADDROF expression).
				''
				l = exprNewSYM( v1->sym )
				l = exprNewCAST( vr->dtype, vr->subtype, l )
				exit select
			end if
		end if

		l = exprNewUOP( AST_OP_ADDROF, exprNewVREG( v1, TRUE /' lvalue '/ ) )

	case AST_OP_DEREF
		'' Note: The deref is already done in the vreg itself; as in
		'' the ASM backend, no explicit deref operation is needed.
		l = exprNewVREG( v1 )

	end select

	exprSTORE( vr, l )
end sub

private sub hDoCall _
	( _
		byref s as string, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	dim as IRCALLARG ptr arg = any

	'' Flush argument list
	s += "( "
	arg = listGetTail( @ctx.callargs )
	while( arg andalso (arg->level = level) )
		dim as IRCALLARG ptr prev = listGetPrev( arg )

		var expr = exprNewVREG( arg->vr )

		'' param will be NULL for hidden struct result arg, since
		'' no corresponding PARAM exists.
		if( arg->param ) then
			'' Cast arg to param's type to prevent gcc warning.
			'' (this will be done by astNewARG() already, except for
			'' BYREF AS ANY params, where the exact type will only
			'' be known later, or never)
			var dtype = symbGetType( arg->param )
			var subtype = arg->param->subtype
			symbGetRealParamDtype( arg->param->param.mode, dtype, subtype )
			expr = exprNewCAST( dtype, subtype, expr )
		end if

		s += exprFlush( expr )

		listDelNode( @ctx.callargs, arg )

		if( prev ) then
			if( prev->level = level ) then
				s += ", "
			end if
		end if

		arg = prev
	wend
	s += " )"

	if( vr = NULL ) then
		s += ";"
		hWriteLine( s )
	else
		hLoadVreg( vr )
		exprSTORE( vr, exprNewTEXT( vr->dtype, vr->subtype, s ), TRUE )
	end if

end sub

private sub _emitCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	static as string s

	s = *symbGetMangledName( proc )
	hDoCall( s, bytestopop, vr, level )

end sub

private sub _emitCallPtr _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer, _
		byval level as integer _
	)

	static as string s

	s = "(" + exprFlush( exprNewVREG( v1 ) ) + ")"
	hDoCall( s, bytestopop, vr, level )

end sub

private sub _emitJumpPtr( byval v1 as IRVREG ptr )
	hWriteLine( "goto *" + exprFlush( exprNewVREG( v1 ), TRUE ) + ";" )
end sub

private sub _emitBranch( byval op as integer, byval label as FBSYMBOL ptr )
	assert( op = AST_OP_JMP )
	hWriteLine( "goto " + *symbGetMangledName( label ) + ";" )
end sub

private sub _emitJmpTb _
	( _
		byval v1 as IRVREG ptr, _
		byval tbsym as FBSYMBOL ptr, _
		byval values as ulongint ptr, _
		byval labels as FBSYMBOL ptr ptr, _
		byval labelcount as integer, _
		byval deflabel as FBSYMBOL ptr, _
		byval minval as ulongint, _
		byval maxval as ulongint _
	)

	dim as string tb, temp, ln
	dim as FBSYMBOL ptr label = any
	dim as EXPRNODE ptr l = any
	dim as integer i = any

	'' SELECT CASE AS CONST always uses a temp var, no need to worry about side effects
	assert( v1->typ = IR_VREGTYPE_VAR )
	temp = exprFlush( exprNewVREG( v1 ) )

	if( labelcount <= 0 ) then
		'' Empty jump table, just jump directly to the ELSE block or END SELECT
		hWriteLine( "goto " + *symbGetMangledName( deflabel ) + ";", TRUE )

		'' Silence gcc warning about the unused temp var
		hWriteLine( "(void)" + temp + ";", TRUE )
		exit sub
	end if

	tb = *symbUniqueId( )

	l = exprNewIMMi( maxval - minval + 1 )
	hWriteLine( "static const void* " + tb + "[" + exprFlush( l ) + "] = {", TRUE )
	sectionIndent( )

	i = 0
	for value as ulongint = minval to maxval
		assert( i < labelcount )
		if( value = values[i] ) then
			label = labels[i]
			i += 1
		else
			label = deflabel
		end if
		hWriteLine( "&&" + *symbGetMangledName( label ) + ",", TRUE )
	next

	sectionUnindent( )
	hWriteLine( "};", TRUE )

	if( minval > 0 ) then
		'' if( temp < minval ) goto deflabel
		l = exprNewTEXT( FB_DATATYPE_UINT, NULL, temp )
		l = exprNewBOP( AST_OP_LT, l, exprNewIMMi( minval ) )
		hWriteLine( "if( " + exprFlush( l ) + " ) goto " + *symbGetMangledName( deflabel ) + ";", TRUE )
	end if

	'' if( temp > maxval ) then goto deflabel
	l = exprNewTEXT( FB_DATATYPE_UINT, NULL, temp )
	l = exprNewBOP( AST_OP_GT, l, exprNewIMMi( maxval ) )
	hWriteLine( "if( " + exprFlush( l ) + " ) goto " + *symbGetMangledName( deflabel ) + ";", TRUE )

	'' l = jumptable[l - minval]
	l = exprNewTEXT( FB_DATATYPE_UINT, NULL, temp )
	l = exprNewBOP( AST_OP_SUB, l, exprNewIMMi( minval ) )
	hWriteLine( "goto *" + tb + "[" + exprFlush( l ) + "];", TRUE )

end sub

private sub _emitMem _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as longint _
	)

	select case op
	case AST_OP_MEMCLEAR
		hWriteLine("__builtin_memset( " + exprFlush( exprNewVREG( v1 ) ) + ", 0, " + exprFlush( exprNewVREG( v2 ) ) + " );" )
	case AST_OP_MEMMOVE
		hWriteLine("__builtin_memcpy( " + exprFlush( exprNewVREG( v1 ) ) + ", " + exprFlush( exprNewVREG( v2 ) ) + ", " + str( bytes ) + " );" )
	end select

end sub

private sub _emitDECL( byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr array = any

	'' Emit locals/statics locally, except statics with dtor - those are
	'' handled in _procAllocStaticVars(), including their dynamic array
	'' descriptors (if any).
	if( symbIsStatic( sym ) and symbHasDtor( sym ) ) then
		exit sub
	end if

	'' Check whether it's a dynamic array descriptor with a back link to
	'' the corresponding array that needs to be checked instead...
	'' (the descriptor needs to be handled like the array)
	assert( symbIsVar( sym ) )
	array = sym->var_.desc.array
	if( array ) then
		if( symbIsStatic( array ) and symbHasDtor( array ) ) then
			exit sub
		end if
	end if

	hEmitVariable( sym )
end sub

'':::::
private sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

	if( op = AST_OP_DBG_LINEINI ) then
		ctx.linenum = ex
	end if

end sub

private sub _emitComment( byval text as zstring ptr )
	static as string s

	s = *text
	s = trim( s )

	if( len( s ) > 0 ) then
		if( right( s, 1 ) = "\" ) then
			s += "not_an_escape"
		end if
		hWriteLine( "// " + s, TRUE )
	end if
end sub

private function hGetMangledNameForASM( byval sym as FBSYMBOL ptr ) as string
	dim as string mangled

	mangled = *symbGetMangledName( sym )

	''
	'' Must manually add an underscore prefix if the target requires it,
	'' because symb-mangling won't do that for -gen gcc.
	''
	'' (assuming this function will only be used by NAKED procedures,
	''  which cannot have local variables or parameters)
	''
	if( env.target.options and FB_TARGETOPT_UNDERSCORE ) then
		mangled  = "_" + mangled
	end if

	if( symbIsProc( sym ) ) then
		if( symbGetProcMode( sym ) = FB_FUNCMODE_STDCALL ) then
			'' Add the @N suffix for STDCALL
			mangled += "@"
			mangled += str( symbCalcProcParamsLen( sym ) )
		end if
	end if

	function = mangled
end function

private sub _emitAsmBegin( )
	'' -asm intel: FB asm blocks are expected to be in Intel format as
	''             usual; we have to convert them to the GCC format here.
	'' -asm att: FB asm blocks are expected to be in the GCC format,
	''           i.e. quoted and including constraints if needed.
	ctx.asm_line = "__asm__"

	'' Only when inside normal procedures
	'' (NAKED procedures don't increase the indentation)
	if( sectionInsideProc( ) ) then
		ctx.asm_line += " __volatile__"
	end if

	ctx.asm_line += "( "

	if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
		ctx.asm_line += """"
		if( sectionInsideProc( ) ) then
			ctx.asm_line += $"\t"
		end if
		ctx.asm_i = 0
		ctx.asm_output = ""
		ctx.asm_input = ""
	end if
end sub

private sub _emitAsmText( byval text as zstring ptr )
	ctx.asm_line += *text
end sub

private sub _emitAsmSymb( byval sym as FBSYMBOL ptr )
	dim as string id

	'' In NAKED procedure?
	if( sectionInsideProc( ) = FALSE ) then
		ctx.asm_line += hGetMangledNameForASM( sym )
		exit sub
	end if

	id = *symbGetMangledName( sym )

	if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
		'' Insert %0 -%9 place holders, gcc will fill in the proper
		'' DWORD PTR [ebp+N] for them based on input/output operands.
		'  - unfortunately we don't know whether this symbol is used
		''   as input, output or both, so we enlist as operand for both,
		''   and use the %i for the output operand.
		ctx.asm_line += "%" + str( ctx.asm_i )
		ctx.asm_i += 1

		'' output operand constraint: "=m" (symbol)
		'' input operand constraint:   "m" (symbol)
		if( len( ctx.asm_output ) > 0 ) then
			ctx.asm_output += ", "
			ctx.asm_input  += ", "
		end if
		ctx.asm_output += """=m"" (" + id + ")"
		ctx.asm_input  +=  """m"" (" + id + ")"
	else
		ctx.asm_line += id
	end if
end sub

private sub _emitAsmEnd( )
	if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
		if( sectionInsideProc( ) ) then
			ctx.asm_line += $"\n"
		end if

		ctx.asm_line += """"

		'' Only when inside normal procedures
		'' (NAKED procedures don't increase the indentation)
		if( sectionInsideProc( ) ) then
			ctx.asm_line += " : " + ctx.asm_output
			ctx.asm_line += " : " + ctx.asm_input

			'' We don't know what registers etc. will be trashed,
			'' so assume everything...
			ctx.asm_line += " : ""cc"", ""memory"""
			ctx.asm_line += ", ""eax"", ""ebx"", ""ecx"", ""edx"", ""esp"", ""edi"", ""esi"""
			if( env.clopt.fputype = FB_FPUTYPE_SSE ) then
				ctx.asm_line += ", ""mm0"", ""mm1"", ""mm2"", ""mm3"", ""mm4"", ""mm5"", ""mm6"", ""mm7"""
				ctx.asm_line += ", ""xmm0"", ""xmm1"", ""xmm2"", ""xmm3"", ""xmm4"", ""xmm5"", ""xmm6"", ""xmm7"""
			end if
		end if
	end if

	ctx.asm_line += " );"

	hWriteLine( ctx.asm_line )
end sub

private sub _emitVarIniBegin( byval sym as FBSYMBOL ptr )
	ctx.varini = ""
	ctx.variniscopelevel = 0
end sub

private sub _emitVarIniEnd( byval sym as FBSYMBOL ptr )
	hEmitVar( sym, ctx.varini )
	ctx.varini = ""
end sub

private sub hVarIniSeparator( )
	if( ctx.variniscopelevel > 0 ) then
		ctx.varini += ", "
	end if
end sub

private sub _emitVarIniI( byval dtype as integer, byval value as longint )
	ctx.varini += hEmitInt( dtype, value )
	hVarIniSeparator( )
end sub

private sub _emitVarIniF( byval dtype as integer, byval value as double )
	ctx.varini += hEmitFloat( dtype, value )
	hVarIniSeparator( )
end sub

private sub _emitVarIniOfs( byval sym as FBSYMBOL ptr, byval ofs as longint )
	dim as EXPRNODE ptr l = any

	l = exprNewOFFSET( sym, ofs )

	'' Cast to void* to prevent gcc ptr warnings (FB should handle that)
	l = exprNewCAST( typeAddrOf( FB_DATATYPE_VOID ), NULL, l )

	ctx.varini += exprFlush( l )
	hVarIniSeparator( )
end sub

private sub _emitVarIniStr _
	( _
		byval varlength as longint, _    '' without null terminator
		byval literal as zstring ptr, _
		byval litlength as longint _     '' without null terminator
	)

	'' Simple fixed-length string initialized from string literal
	'' "..."

	'' String literal too long? (GCC would show a warning)
	if( litlength > varlength ) then
		'' Cut off; may be empty afterwards
		litlength = varlength
	end if

	hBuildStrLit( ctx.varini, hUnescape( literal ), litlength + 1 )

	hVarIniSeparator( )

end sub

private sub _emitVarIniWstr _
	( _
		byval varlength as longint, _  '' without null terminator
		byval literal as wstring ptr, _
		byval litlength as longint _   '' without null terminator
	)

	dim as uinteger ch = any
	dim as integer wcharsize = any

	'' In Linux GCC, wchar_t and thus L"..." expressions use signed int,
	'' but FB uses unsigned integers. But GCC will show an error when doing
	''    unsigned int mywstring[] = L"foo"
	'' so we must emit it as
	''    unsigned int mywstring[] = { L'f', L'o', L'o' }

	ctx.varini += "{ "
	literal = hUnescapeW( literal )
	wcharsize = typeGetSize( FB_DATATYPE_WCHAR )

	'' String literal too long?
	if( litlength > varlength ) then
		'' Cut off; may be empty afterwards
		litlength = varlength
	end if

	for i as integer = 0 to litlength - 1
		if( i > 0 ) then
			ctx.varini += ", "
		end if

		ctx.varini += "L'"

		ch = (*literal)[i]

		if( hCharNeedsEscaping( ch, asc( "'" ) ) ) then
			ctx.varini += $"\x" + hex( ch, wcharsize * 2 )
		else
			ctx.varini += chr( ch )
		end if

		ctx.varini += "'"
	next

	ctx.varini += " }"

	hVarIniSeparator( )

end sub

private sub _emitVarIniPad( byval bytes as longint )
	'' Nothing to do -- we're using {...} for structs and each array
	'' dimension, and gcc will zero-initialize any uninitialized elements,
	'' aswell as add padding between fields etc. where needed.
end sub

private sub _emitVarIniScopeBegin( )
	ctx.variniscopelevel += 1
	ctx.varini += "{ "
end sub

private sub _emitVarIniScopeEnd( )
	'' Trim separator at the end, to make the output look a bit more clean
	'' (this isn't needed though, since the extra comma is allowed in C)
	if( right( ctx.varini, 2 ) = ", " ) then
		ctx.varini = left( ctx.varini, len( ctx.varini ) - 2 )
	end if

	ctx.varini += " }"
	ctx.variniscopelevel -= 1
	hVarIniSeparator( )
end sub

private sub _emitFbctinfBegin( )
	hWriteLine( "", TRUE )

	'' static         - should not be a public symbol
	'' const          - read-only
	'' char[]         - a string
	'' used attribute - prevent removal due to optimizations
	'' section attribute - This global must be put into a custom .fbctinf
	''                     section, as done by the ASM backend.
	ctx.fbctinf = "static const char "
	ctx.fbctinf += "__attribute__((used, section(""." + FB_INFOSEC_NAME + """))) "
	ctx.fbctinf += "__fbctinf[] = """
end sub

private sub _emitFbctinfString( byval s as zstring ptr )
	ctx.fbctinf += *s + $"\0"
end sub

private sub _emitFbctinfEnd( )
	'' Cut off unnecessary \0 at the end; gcc will add it automatically,
	'' since it's a string literal...
	if( right( ctx.fbctinf, 2 ) = $"\0" ) then
		ctx.fbctinf = left( ctx.fbctinf, len( ctx.fbctinf ) - 2 )
	end if
	ctx.fbctinf += """;"
	hWriteLine( ctx.fbctinf, TRUE )
end sub

private sub _emitProcBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr _
	)

	dim as string mangled

	hWriteLine( "", TRUE )

	if( env.clopt.debug ) then
		_emitDBG( AST_OP_DBG_LINEINI, proc, proc->proc.ext->dbg.iniline )
		ctx.linenum = 0
	end if

	'' NAKED procedure? Use inline asm, since gcc doesn't support
	'' __attribute__((naked)) on x86
	if( symbIsNaked( proc ) ) then
		mangled = hGetMangledNameForASM( proc )
		hWriteLine( "__asm__( "".globl " + mangled + """ );", TRUE )
		hWriteLine( "__asm__( """ + mangled + ":"" );", TRUE )
		exit sub
	end if

#if 0
	'' If the asm("mangledname") work-around is needed to tell gcc to not
	'' add the @N suffix for stdcall  procedures, emit an extra prototype
	'' right above the procedure body, because asm() is only allowed on
	'' prototypes.
	select case( symbGetProcMode( proc ) )
	case FB_FUNCMODE_STDCALL_MS, FB_FUNCMODE_PASCAL
		hWriteLine( hEmitProcHeader( proc, EMITPROC_ISPROTO ), TRUE )
	end select
#endif

	sectionBegin( )

	hWriteLine( hEmitProcHeader( proc, 0 ), TRUE )

	hWriteLine( "{", TRUE )
	sectionIndent( )

end sub

private sub _emitProcEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

	dim as string mangled

	'' NAKED procedure? Use inline asm, since gcc doesn't support
	'' __attribute__((naked)) on x86
	if( symbIsNaked( proc ) ) then
		'' Emit .size like ASM backend, for Linux
		if( env.clopt.target = FB_COMPTARGET_LINUX ) then
			mangled = hGetMangledNameForASM( proc )
			hWriteLine( "__asm__( "".size " + mangled + ", .-" + mangled + """ );", TRUE )
		end if
		exit sub
	end if

	sectionUnindent( )
	hWriteLine( "}", TRUE )

	sectionEnd( )

end sub

private sub _emitPushArg _
	( _
		byval param as FBSYMBOL ptr, _
		byval vr as IRVREG ptr, _
		byval udtlen as longint, _
		byval level as integer _
	)

	'' Remember for later, so during _emitCall[Ptr] we can emit the whole
	'' call in one go
	dim as IRCALLARG ptr arg = listNewNode( @ctx.callargs )
	arg->param = param
	arg->vr = vr
	arg->level = level

end sub

private sub _emitScopeBegin( byval s as FBSYMBOL ptr )
	sectionBegin( )
	hWriteLine( "{", TRUE )
	sectionIndent( )
end sub

private sub _emitScopeEnd( byval s as FBSYMBOL ptr )
	sectionUnindent( )
	hWriteLine( "}", TRUE )
	sectionEnd( )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

dim shared as IR_VTBL irhlc_vtbl = _
( _
	@_init, _
	@_end, _
	@_emitBegin, _
	@_emitEnd, _
	@_getOptionValue, _
	@_procBegin, _
	@_procEnd, _
	NULL, _
	NULL, _
	NULL, _
	@_scopeBegin, _
	@_scopeEnd, _
	@_procAllocStaticVars, _
	@_emitStore, _
	@_emitLabel, _
	@_emitLabel, _
	NULL, _
	@_emitProcBegin, _
	@_emitProcEnd, _
	@_emitPushArg, _
	@_emitAsmBegin, _
	@_emitAsmText, _
	@_emitAsmSymb, _
	@_emitAsmEnd, _
	@_emitComment, _
	@_emitBop, _
	@_emitUop, _
	@_emitStore, _
	@_emitSpillRegs, _
	@_emitLoad, _
	@_emitLoadRes, _
	NULL, _
	@_emitAddr, _
	@_emitCall, _
	@_emitCallPtr, _
	NULL, _
	@_emitJumpPtr, _
	@_emitBranch, _
	@_emitJmpTb, _
	@_emitMem, _
	@_emitScopeBegin, _
	@_emitScopeEnd, _
	@_emitDECL, _
	@_emitDBG, _
	@_emitVarIniBegin, _
	@_emitVarIniEnd, _
	@_emitVarIniI, _
	@_emitVarIniF, _
	@_emitVarIniOfs, _
	@_emitVarIniStr, _
	@_emitVarIniWstr, _
	@_emitVarIniPad, _
	@_emitVarIniScopeBegin, _
	@_emitVarIniScopeEnd, _
	@_emitFbctinfBegin, _
	@_emitFbctinfString, _
	@_emitFbctinfEnd, _
	@_allocVreg, _
	@_allocVrImm, _
	@_allocVrImmF, _
	@_allocVrVar, _
	@_allocVrIdx, _
	@_allocVrPtr, _
	@_allocVrOfs, _
	@_setVregDataType, _
	NULL, _
	NULL, _
	NULL, _
	NULL _
)
