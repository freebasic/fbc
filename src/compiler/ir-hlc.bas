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
    vr as IRVREG ptr
    level as integer
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

type IRHLCCTX
	sections(0 to MAX_SECTIONS-1)	as SECTIONENTRY
	section				as integer '' Current section to write to
	sectiongosublevel		as integer
	origsection			as integer

	regcnt				as integer     ' temporary labels counter
	lblcnt				as integer
	tmpcnt				as integer
	vregTB				as TFLIST
	callargs			as TLIST        '' IRCALLARG's during emitPushArg/emitCall[Ptr]
	jmptbsym			as FBSYMBOL ptr
	linenum				as integer

	varini				as string
	variniscopelevel		as integer

	asm_line			as string  '' line of inline asm built up by _emitAsm*()
	asm_i				as integer '' next operand/symbol index
	asm_output			as string  '' output constraints in gcc's syntax
	asm_input			as string  '' input constraints in gcc's syntax
end type

enum EMITTYPE_OPTIONS
	'' Used to turn string into string* on function results
	EMITTYPE_ISRESULT = &h00000001

	'' Adds an extra * for byref params and in some other places
	'' (should be used instead of hEmitType( typeAddrOf( dtype ), ... )
	'' because that could overflow the dtype's pointer count)
	EMITTYPE_ADDPTR   = &h00000002
end enum

declare function hEmitType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval options as EMITTYPE_OPTIONS = 0 _
	) as string

declare function hVregToStr _
	( _
		byval vreg as IRVREG ptr, _
		byval addcast as integer = TRUE _
	) as string

declare sub hEmitStruct( byval s as FBSYMBOL ptr, byval is_ptr as integer )

declare sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

'' globals
dim shared as IRHLCCTX ctx

'' same order as FB_DATATYPE
dim shared as const zstring ptr dtypeName(0 to FB_DATATYPES-1) = _
{ _
    @"void"     , _ '' void
    @"byte"     , _ '' byte
    @"ubyte"    , _ '' ubyte
    @"char"     , _ '' char
    @"short"    , _ '' short
    @"ushort"   , _ '' ushort
    @"wchar"    , _ '' wchar
    @"integer"  , _ '' int
    @"uinteger" , _ '' uint
    @"integer"  , _ '' enum
    @"integer"  , _ '' bitfield
    @"long"     , _ '' long
    @"ulong"    , _ '' ulong
    @"longint"  , _ '' longint
    @"ulongint" , _ '' ulongint
    @"single"   , _ '' single
    @"double"   , _ '' double
    @"string"   , _ '' string
    @"fixstr"   , _ '' fix-len string
    @""         , _ '' struct
    @""         , _ '' namespace
    @""         , _ '' function
    @"void"     , _ '' fwd-ref
    @"void *"     _ '' pointer
}

private sub _init(byval backend as FB_BACKEND)
	flistInit( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )
	listInit( @ctx.callargs, 32, sizeof(IRCALLARG), LIST_FLAGS_NOCLEAR )

	irSetOption( IR_OPT_HIGHLEVEL or IR_OPT_FPUIMMEDIATES or _
	             IR_OPT_NOINLINEOPS )
end sub

private sub _end()
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
private sub sectionGosub( byval section as integer )
	'' One "jump" to a previous section is allowed, but only one since
	'' we don't use a stack to backtrack. It's possible though that
	'' sectionGosub/Return() are used recursively.
	if( ctx.sectiongosublevel = 0 ) then
		ctx.origsection = ctx.section
		ctx.section = section
	else
		assert( ctx.section = section )
	end if
	ctx.sectiongosublevel += 1
end sub

'' "Return" to restore the previous current section
private sub sectionReturn( )
	assert( ctx.sectiongosublevel > 0 )
	ctx.sectiongosublevel -= 1
	if( ctx.sectiongosublevel = 0 ) then
		ctx.section = ctx.origsection
	end if
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

enum EMITPROC_OPTIONS
	EMITPROC_ISPROTO   = &h1
	EMITPROC_ISPROCPTR = &h2
end enum

private sub hAppendCtorAttrib( byref ln as string, byval proc as FBSYMBOL ptr )
	dim as integer priority = any

	if( proc->stats and (FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALDTOR) ) then
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

		ln += " )) "
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
		hAppendCtorAttrib( ln, proc )
	end if

	if( (options and EMITPROC_ISPROCPTR) = 0 ) then
		if( symbIsExport( proc ) ) then
			ln += "__declspec(dllexport) "
		end if

		if( symbIsPrivate( proc ) ) then
			ln += "static "
		end if
	end if

	'' Function result type (is 'void' for subs)
	ln += hEmitType( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), symbGetSubType( proc ), EMITTYPE_ISRESULT )

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
	select case( symbGetProcMode( proc ) )
	case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS, FB_FUNCMODE_PASCAL
		ln += " __attribute__((stdcall))"
	end select

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
	if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
		if( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ) = typeAddrOf( symbGetType( proc ) ) ) then
			if( options and EMITPROC_ISPROTO ) then
				hidden = symbGetSubType( proc )
				ln += hEmitType( symbGetType( hidden ), hidden, EMITTYPE_ADDPTR )
			else
				hidden = proc->proc.ext->res
				ln += hEmitType( symbGetType( hidden ), symbGetSubtype( hidden ), EMITTYPE_ADDPTR )
				ln += " " + *symbGetMangledName( hidden )
			end if

			if( symbGetProcParams( proc ) > 0 ) then
				ln += ", "
			end if
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
			var pvar = iif( options and EMITPROC_ISPROTO, param, symbGetParamVar( param ) )
			var dtype = symbGetType( pvar )
			var subtype = symbGetSubType( pvar )
			dim as EMITTYPE_OPTIONS type_options = 0

			select case( param->param.mode )
			case FB_PARAMMODE_BYVAL
				select case( symbGetType( param ) )
				'' byval string? it's actually an pointer to a zstring
				case FB_DATATYPE_STRING
					type_options = EMITTYPE_ADDPTR
					dtype = typeJoin( dtype, FB_DATATYPE_CHAR )

				case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
					'' has a dtor, copy ctor or virtual methods? it's a copy..
					if( symbCompIsTrivial( symbGetSubtype( param ) ) = FALSE ) then
						type_options = EMITTYPE_ADDPTR
					end if
				end select

			case FB_PARAMMODE_BYREF
				type_options = EMITTYPE_ADDPTR

			case FB_PARAMMODE_BYDESC
				type_options = EMITTYPE_ADDPTR
				dtype = FB_DATATYPE_STRUCT
				subtype = symb.arrdesctype
			end select

			ln += hEmitType( dtype, subtype, type_options )

			if( (options and EMITPROC_ISPROTO) = 0 ) then
				ln += " " + *symbGetMangledName( pvar )
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
		hAppendCtorAttrib( ln, proc )
	end if

	function = ln
end function

private function hGetUDTName _
	( _
        byval s as FBSYMBOL ptr, _
        byval need_original_name as integer = FALSE _
    ) as string

    dim as FBSYMBOL ptr ns = symbGetNamespace( s )

    var sig = ""
    do until( ns = @symbGetGlobalNamespc( ) )
    	sig += *symbGetName( ns )
    	sig += "$"
    	ns = symbGetNamespace( ns )
    loop

    if( s->id.alias <> NULL ) then
    	sig += *s->id.alias
    else
    	sig += *symbGetName( s )
    EndIf

    if( need_original_name = FALSE ) then
        '' see the HACK in hEmitStruct()
        if( symbGetIsAccessed( s ) ) then
            sig += "$type"
        end if
    end if

    function = sig

end function

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
	else
		'' Write to toplevel
		section = 0
	end if

	sectionGosub( section )

	select case as const symbGetClass( s )
	case FB_SYMBCLASS_ENUM
		symbSetIsEmitted( s )
		hWriteLine( "typedef int " + hGetUDTName( s ) + ";" )

	case FB_SYMBCLASS_STRUCT
		hEmitStruct( s, is_ptr )

	case FB_SYMBCLASS_PROC
		if( symbGetIsFuncPtr( s ) ) then
			hWriteLine( "typedef " + hEmitProcHeader( s, EMITPROC_ISPROTO or EMITPROC_ISPROCPTR ) + ";" )
			symbSetIsEmitted( s )
		end if

	end select

	sectionReturn( )
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
	dim as integer length = 0
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
	if( symbIsCommon( sym ) ) then
		hWriteLine( "extern " + ln + ";" )
		ln += " __attribute__((common))"
	elseif( symbGetAttrib( sym ) and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN) ) then
		hWriteLine( "extern " + ln + ";" )

		'' just an extern that was never allocated? exit..
		if( symbIsExtern( sym ) ) then
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

		'' extern or jump-tb?
    	if( symbIsExtern( s ) ) then
			return
		elseif( symbGetIsJumpTb( s ) ) then
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

		astTypeIniFlush( s->var_.initree, _
						 s, _
						 AST_INIOPT_ISINI or AST_INIOPT_ISSTATIC )

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

private sub hEmitFuncProto _
	( _
		byval s as FBSYMBOL ptr, _
		byval checkcalled as integer = TRUE _
	)

	if( checkcalled and not symbGetIsCalled( s ) ) then
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
	sectionGosub( 0 )

	'' gcc builtin? gen a wrapper..
	if( symbGetIsGccBuiltin( s ) ) then
		hEmitGccBuiltinWrapper( s )
	else
		hWriteLine( hEmitProcHeader( s, EMITPROC_ISPROTO ) + ";" )
	end if

	sectionReturn( )

end sub

private sub hEmitStruct _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_ptr as integer _
	)

	dim as string ln, id
	dim as integer skip = any

	var tname = "struct"
	if( symbGetUDTIsUnion( s ) ) then
		tname = "union"
	end if

	'' Already in the process of emitting this UDT?
	if( symbGetIsBeingEmitted( s ) ) then
		'' This means there is a circular dependency with another UDT.
		'' One of the references can be a pointer only though,
		'' because UDTs cannot contain each-other, so this can always
		'' be solved by using a forward reference.
		if( is_ptr ) then
			'' Emit a forward reference for this struct (if not yet done),
			'' and remember it for emitting later.
			'' HACK: reusing the accessed flag (that's used by variables only)
			if( symbGetIsAccessed( s ) = FALSE ) then
				symbSetIsAccessed( s )
				ln = "typedef " + tname
				ln += " _" + hGetUDTName( s, TRUE )
				ln += " " + hGetUDTName( s, FALSE ) + ";"
				hWriteLine( ln )
			end if
			exit sub
		end if
	end if

	symbSetIsBeingEmitted( s )

	'' Emit types of fields
	var e = symbGetUDTFirstElm( s )
	do while( e <> NULL )
		hEmitUDT( symbGetSubtype( e ), typeIsPtr( symbGetType( e ) ) )
		e = symbGetUDTNextElm( e )
	loop

	'' Has this UDT been emitted in the mean time?
	'' (due to one of the fields causing a circular dependency)
	if( symbGetIsEmitted( s ) ) then
		exit sub
	end if

	'' Emit it now
	symbSetIsEmitted( s )

	'' UDT name
	if( symbGetName( s ) = NULL ) then
		id = *hMakeTmpStrNL( )
	else
		id = hGetUDTName( s, TRUE )
	end if

	hWriteLine( "typedef " + tname + " _" + id + " {", TRUE )

	'' Alignment (field = N)
	var attrib = ""
	if( s->udt.align > 0 ) then
		if( s->udt.align = 1 ) then
			attrib = " __attribute__((packed))"
		else
			attrib = " __attribute__((aligned (" & s->udt.align & ")))"
		end if
	end if

	'' Write out the elements
	sectionIndent( )
	e = symbGetUDTFirstElm( s )
	while( e )
		''
		'' For bitfields, emit only the container field, not the
		'' individual bitfields (bitfields are merged into a "container"
		'' given by the type of the first bitfield; if further bitfields
		'' don't fit a new container is started, etc.)
		''
		'' Alternatively we could emit bitfields explicitly via ": N",
		'' but that would depend on gcc's ABI and we'd have to emit
		'' things like __attribute__((ms_struct)) too for msbitfields...
		''
		if( symbGetType( e ) = FB_DATATYPE_BITFIELD ) then
			skip = (symbGetSubtype( e )->bitfld.bitpos <> 0)
		else
			skip = FALSE
		end if

		if( skip = FALSE ) then
			ln = hEmitType( symbGetType( e ), symbGetSubtype( e ) )
			ln += " " + *symbGetName( e )
			ln += hEmitArrayDecl( e )
			ln += attrib
			ln += ";"
			hWriteLine( ln, TRUE )
		end if

		e = symbGetUDTNextElm( e )
	wend

	'' Close UDT body
	sectionUnindent( )
	hWriteLine( "} " + id + ";", TRUE )

	symbResetIsBeingEmitted( s )

	'' Emit methods (not part of the struct anymore, but they will include
	'' references to self (this))
	e = symbGetCompSymbTb( s ).head
	do while( e <> NULL )
		'' method?
		if( symbIsProc( e ) ) then
			if( symbGetIsFuncPtr( e ) = FALSE ) then
				hEmitFuncProto( e, FALSE )
			end if
		end if
		e = e->next
	loop

end sub

private sub hEmitDecls( byval s as FBSYMBOL ptr, byval procs as integer )
	while( s )
		select case as const( symbGetClass( s ) )
		case FB_SYMBCLASS_NAMESPACE
			hEmitDecls( symbGetNamespaceTbHead( s ), procs )

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

'':::::
private sub hEmitTypedefs( )

	'' typedef's for debugging
	hWriteLine( "typedef char byte;", TRUE )
	hWriteLine( "typedef unsigned char ubyte;", TRUE )
	hWriteLine( "typedef unsigned short ushort;", TRUE )
	hWriteLine( "typedef int integer;", TRUE )
	hWriteLine( "typedef unsigned int uinteger;", TRUE )
	hWriteLine( "typedef unsigned long ulong;", TRUE )
	hWriteLine( "typedef long long longint;", TRUE )
	hWriteLine( "typedef unsigned long long ulongint;", TRUE )
	hWriteLine( "typedef float single;", TRUE )
	hWriteLine( "typedef struct _string { char *data; int len; int size; } string;", TRUE )
	hWriteLine( "typedef char fixstr;", TRUE )

	'' Target-dependant wchar type
	dim as string wchartype
	select case as const( env.target.wchar )
	case FB_DATATYPE_UBYTE      '' DOS
		wchartype = "ubyte"
	case FB_DATATYPE_USHORT     '' Windows, cygwin
		wchartype = "ushort"
	case else                   '' Linux & co
		'' Normally our wstring type is unsigned, but gcc's wchar_t
		'' is signed, and we must use the exact same or else fixed-length
		'' wstring initializers (VarIniWstr) using L"abc" wouldn't work.
		'' (If this is a problem, then VarIniWstr must be changed to
		'' emit wstring initializers as { L'a', L'b', L'c', 0 } instead)
		wchartype = "integer"
	end select
	hWriteLine( "typedef " + wchartype + " wchar;", TRUE )

end sub

private sub hWriteFTOI _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	dim as string rtype_str, rtype_suffix
	select case rtype
	case FB_DATATYPE_INTEGER
		rtype_str = "integer"
		rtype_suffix = "l"

	case FB_DATATYPE_LONGINT
		rtype_str = "longint"
		rtype_suffix = "q"
	end select

	dim as string ptype_str, ptype_suffix
	select case ptype
	case FB_DATATYPE_SINGLE
		ptype_str = "single"
		ptype_suffix = "s"

	case FB_DATATYPE_DOUBLE
		ptype_str = "double"
		ptype_suffix = "l"
	end select

	if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
		rtype_suffix = ""
		ptype_suffix = ""
	end if

	'' TODO: x86 specific
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
	if( symbGetIsCalled( PROCLOOKUP( FTOSL ) ) or _
	    symbGetIsCalled( PROCLOOKUP( FTOUL ) ) or _
	    symbGetIsCalled( PROCLOOKUP( FTOUI ) ) ) then
		hWriteFTOI( "ftosl", FB_DATATYPE_LONGINT, FB_DATATYPE_SINGLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUL ) ) ) then
		hWriteLine( "#define fb_ftoul( v ) (ulongint)fb_ftosl( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUI ) ) ) then
		hWriteLine( "#define fb_ftoui( v ) (uinteger)fb_ftosl( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSI ) ) or _
	    symbGetIsCalled( PROCLOOKUP( FTOSS ) ) or _
	    symbGetIsCalled( PROCLOOKUP( FTOUS ) ) or _
	    symbGetIsCalled( PROCLOOKUP( FTOSB ) ) or _
	    symbGetIsCalled( PROCLOOKUP( FTOUB ) ) ) then
		hWriteFTOI( "ftosi", FB_DATATYPE_INTEGER, FB_DATATYPE_SINGLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSS ) ) ) then
		hWriteLine( "#define fb_ftoss( v ) (short)fb_ftosi( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUS ) ) ) then
		hWriteLine( "#define fb_ftous( v ) (ushort)fb_ftosi( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSB ) ) ) then
		hWriteLine( "#define fb_ftosb( v ) (byte)fb_ftosi( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUB ) ) ) then
		hWriteLine( "#define fb_ftoub( v ) (ubyte)fb_ftosi( v )", TRUE )
	end if

	'' double
	if( symbGetIsCalled( PROCLOOKUP( DTOSL ) ) or _
	    symbGetIsCalled( PROCLOOKUP( DTOUL ) ) or _
	    symbGetIsCalled( PROCLOOKUP( DTOUI ) ) ) then
		hWriteFTOI( "dtosl", FB_DATATYPE_LONGINT, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUL ) ) ) then
		hWriteLine( "#define fb_dtoul( v ) (ulongint)fb_dtosl( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUI ) ) ) then
		hWriteLine( "#define fb_dtoui( v ) (uinteger)fb_dtosl( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSI ) ) or _
	    symbGetIsCalled( PROCLOOKUP( DTOSS ) ) or _
	    symbGetIsCalled( PROCLOOKUP( DTOUS ) ) or _
	    symbGetIsCalled( PROCLOOKUP( DTOSB ) ) or _
	    symbGetIsCalled( PROCLOOKUP( DTOUB ) ) ) then
		hWriteFTOI( "dtosi", FB_DATATYPE_INTEGER, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSS ) ) ) then
		hWriteLine( "#define fb_dtoss( v ) (short)fb_dtosi( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUS ) ) ) then
		hWriteLine( "#define fb_dtous( v ) (ushort)fb_dtosi( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSB ) ) ) then
		hWriteLine( "#define fb_dtosb( v ) (byte)fb_dtosi( v )", TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUB ) ) ) then
		hWriteLine( "#define fb_dtoub( v ) (ubyte)fb_dtosi( v )", TRUE )
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
	ctx.lblcnt = 0
	ctx.tmpcnt = 0
	ctx.linenum = 0

	'' header
	sectionBegin( )

	if( env.clopt.debug ) then
		_emitDBG( AST_OP_DBG_LINEINI, NULL, 0 )
	end if

	hWriteLine( "// Compilation of " + env.inf.name + " started at " + time( ) + " on " + date( ), TRUE )
	hWriteLine( "", TRUE )

	hEmitTypedefs( )

	'' body
	sectionBegin( )

	function = TRUE
end function

private sub _emitEnd( byval tottime as double )
	'' Switch to header section temporarily
	sectionGosub( 0 )

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

	sectionReturn( )

	'' body (is appended to header section)
	sectionEnd( )

	hWriteLine( "", TRUE )
	hWriteLine( "// Total compilation time: " + str( tottime ) + " seconds. ", TRUE )

	'' Emit & close the main section
	if( ctx.sections(0).old = FALSE ) then
		if( put( #env.outf.num, , ctx.sections(0).text ) <> 0 ) then
		end if
	end if
	sectionEnd( )

	''
	if( close( #env.outf.num ) <> 0 ) then
		'' ...
	end if

	env.outf.num = 0

	assert( ctx.sectiongosublevel = 0 )
	assert( ctx.section = -1 )
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

'':::::
private sub _procBegin _
	( _
		byval proc as FBSYMBOL ptr _
	)

	proc->proc.ext->dbg.iniline = lexLineNum( )

end sub

'':::::
private sub _procEnd _
	( _
		byval proc as FBSYMBOL ptr _
	)

	proc->proc.ext->dbg.endline = lexLineNum( )

end sub

'':::::
private sub _scopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

end sub

'':::::
private sub _scopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

end sub

'':::::
private function _makeTmpStr _
	( _
		byval islabel as integer _
	) as zstring ptr

	static as zstring * 6 + 10 + 1 res

	if( islabel ) then
		res = "label$" & ctx.lblcnt
		ctx.lblcnt += 1
	else
		res = "tmp$" & ctx.tmpcnt
		ctx.tmpcnt += 1
	end if

	function = @res

end function

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

'':::::
private function _allocVrImm _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as integer _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	vr->value.int = value

	function = vr

end function

'':::::
private function _allocVrImm64 _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	vr->value.long = value

	function = vr

end function

'':::::
private function _allocVrImmF _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as double _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	vr->value.float = value

	function = vr

end function

'':::::
private function _allocVrVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as integer _
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
		byval ofs as integer, _
		byval mult as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IDX )

	vr->sym = symbol
	vr->ofs = ofs
	vr->mult = mult
	vr->vidx = vidx

	function = vr

end function

'':::::
private function _allocVrPtr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_PTR )

	vr->ofs = ofs
	vr->mult = 1
	vr->vidx = vidx

	function = vr

end function

'':::::
private function _allocVrOfs _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as integer _
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

'':::::
private sub hLoadVreg _
	( _
		byval vreg as IRVREG ptr _
	)

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
		byval subtype as FBSYMBOL ptr, _
		byval options as EMITTYPE_OPTIONS = 0 _
	) as string

	dim as string s
	dim as integer ptrcount_fb = typeGetPtrCnt( dtype )
	dtype = typeGetDtOnly( dtype )

	dim as integer ptrcount_c = ptrcount_fb
	if( options and EMITTYPE_ADDPTR ) then
		ptrcount_c += 1
	end if

	select case as const( dtype )
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		if( subtype ) then
			hEmitUDT( subtype, (ptrcount_c > 0) )
			s = hGetUDTName( subtype )
		elseif( dtype = FB_DATATYPE_ENUM ) then
			s = *dtypeName(FB_DATATYPE_INTEGER)
		else
			s = "void"
		end if

	case FB_DATATYPE_FUNCTION
		ptrcount_c -= 1
		hEmitUDT( subtype, (ptrcount_c > 0) )
		s = *symbGetMangledName( subtype )

	case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
		s = *dtypeName(dtype)
		if( options and EMITTYPE_ISRESULT ) then
			if( ptrcount_fb = 0 ) then
				ptrcount_c += 1
			end if
		end if

	case FB_DATATYPE_BITFIELD
		if( subtype ) then
			s = *dtypeName(symbGetType( subtype ))
		else
			s = *dtypeName(FB_DATATYPE_INTEGER)
		end if

	case else
		s = *dtypeName(dtype)
	end select

	if( ptrcount_c > 0 ) then
		s += string( ptrcount_c, "*" )
	end if

	function = s
end function

private function hEmitInt( byval value as integer ) as string
	dim as string s = str(value)

	if( value = -2147483648u ) then
		'' Prevent GCC warnings for INT_MIN:
		'' The '-' minus sign doesn't count as part of the number
		'' literal, and 2147483648 is too big for an integer, so it
		'' must be marked as unsigned.
		s += "u"
	end if

	return s
end function

private function hEmitUint( byval value as uinteger ) as string
	return str(value) + "u"
end function

private function hEmitLong( byval value as longint ) as string
	dim as string s = str(value)

	if( value = -9223372036854775808ull ) then
		'' Ditto, prevent warnings for LLONG_MIN
		s += "u"
	end if

	s += "ll"

	return s
end function

private function hEmitUlong( byval value as ulongint ) as string
	return str(value) + "ull"
end function

private function hEmitSingle( byval value as single ) as string
	dim as string s = str( value )

	'' Same considerations as for doubles (see below), and besides,
	'' apparently the 'f' suffix cannot be used unless the literal
	'' really looks like a float, i.e. has a dot or exponent.

	if( instr( s, any "e." ) = 0 ) then
		s += ".0"
	end if

	return s & "f"
end function

private function hEmitDouble( byval value as double ) as string
	dim as string s = str( value )

	'' This can be something like '1', '0.1, or '1e-100'.
	'' We want to make sure gcc always treats it as a double;
	'' unfortunately there is no double type suffix, so we add '.0'
	'' to prevent it from being treated as integer (that would cause
	'' problems with doubles bigger than the int range allows).

	if( instr( s, any "e." ) = 0 ) then
		s += ".0"
	end if

	return s
end function

private sub hAddrOfSymbol( byval sym as FBSYMBOL ptr, byref s as string )
	s += "&"
	'' Use && to get the address of labels (used by error handling code)
	if( symbIsLabel( sym ) ) then
		s += "&"
	end if
end sub

private function hEmitOffset( byval sym as FBSYMBOL ptr, byval ofs as integer ) as string

	dim as string expr

	'' For literal strings, just emit the text, not the label
	if( symbGetIsLiteral( sym ) ) then
		if( symbGetType( sym ) = FB_DATATYPE_WCHAR ) then
			expr += "L"""
			expr += hEscapeToHexW( symbGetVarLitTextW( sym ) )
			expr += """"
		else
			expr += """" + *hEscape( symbGetVarLitText( sym ) ) + """"
		end if
	else
		hAddrOfSymbol( sym, expr )
		'' Name of the array that's being accessed, or the function in @func, etc
		expr += *symbGetMangledName( sym )
	end if

    assert( iif( symbIsProc( sym ), (ofs = 0), TRUE ) )

    '' Cast to actual data type (always a pointer), but not for function pointers
    if( symbIsProc( sym ) = FALSE ) then
        '' Offset (in bytes)
        if( ofs <> 0 ) then
            expr = "((ubyte *)" + expr + " + " + str( ofs ) + ")"
        end if

        expr = "(" + hEmitType( symbGetType( sym ), symbGetSubtype( sym ), EMITTYPE_ADDPTR ) + ")" + expr
    end if

    return expr

end function

'':::::
private function hVregToStr _
	( _
		byval vreg as IRVREG ptr, _
		byval addcast as integer = TRUE _
	) as string

	select case as const vreg->typ
	case IR_VREGTYPE_VAR, IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		dim as string operand

		dim as integer do_deref = any, add_plus = any

		if( vreg->sym <> NULL ) then

			'' type casting?
			if( vreg->dtype <> symbGetType( vreg->sym ) or _
				vreg->subtype <> symbGetSubType( vreg->sym ) ) then

				'' byref or import?
				dim as integer is_ptr = (symbGetAttrib( vreg->sym ) and _
										(FB_SYMBATTRIB_PARAMBYREF or _
										FB_SYMBATTRIB_IMPORT)) or _
										typeIsPtr( symbGetType( vreg->sym ) )

				if( is_ptr = FALSE ) then
					operand += "*("
					operand += hEmitType( vreg->dtype, vreg->subtype, EMITTYPE_ADDPTR )
					operand += ")("

					'' offset or idx?
					if( vreg->ofs <> 0 or vreg->vidx <> NULL ) then
						'' Cast to byte ptr to work around C's pointer arithmetic
						'' (this handles constant offsets)
						operand += "(ubyte *)"
					end if

					hAddrOfSymbol( vreg->sym, operand )
				else
					if( addcast ) then
						operand += "("
						operand += hEmitType( vreg->dtype, vreg->subtype )
						operand += ")"
					end if
					operand += "("
				end if

				do_deref = TRUE
			else
				do_deref = (vreg->ofs <> 0) or (vreg->vidx <> NULL)

				var deref = "*(" + hEmitType( vreg->dtype, vreg->subtype, EMITTYPE_ADDPTR ) + ")"

				if( symbGetArrayDimensions( vreg->sym ) ) then
					do_deref = TRUE
					operand += deref
					'' Same cast to byte ptr for array access as below,
					'' but no addrof (&), because doing &array would give
					'' a pointer to the array, not to the first element,
					'' which is a different data type, which would cause
					'' unnecessary warnings...
					operand += "((ubyte *)"
				elseif( do_deref ) then
					operand += deref
					'' Cast to byte ptr to work around C's pointer arithmetic
					'' (this handles constant offsets)
					operand += "((ubyte *)&"
				end if
			end if

			operand += *symbGetMangledName( vreg->sym )
			add_plus = TRUE

		'' ptr?
		else
			operand = "*(" + hEmitType( vreg->dtype, vreg->subtype, EMITTYPE_ADDPTR ) + ")((ubyte *)"
			do_deref = TRUE
			add_plus = FALSE
		end if

		if( vreg->vidx <> NULL ) then
			if( add_plus ) then
				operand += " + "
			end if
			operand += hVregToStr( vreg->vidx )
			add_plus = TRUE
		end if

		'' offset?
		if( vreg->ofs <> 0 ) then
			if( add_plus ) then
				operand += " + "
			end if
			operand += str( vreg->ofs )
		end if

		if( do_deref ) then
			operand += ")"
		end if

		return operand

	case IR_VREGTYPE_OFS
		return hEmitOffset( vreg->sym, vreg->ofs )

	case IR_VREGTYPE_IMM
		var s = "(" + hEmitType( vreg->dtype, vreg->subtype ) + ")"

		select case as const vreg->dtype
		case FB_DATATYPE_LONGINT
            s += hEmitLong( vreg->value.long )

        case FB_DATATYPE_ULONGINT
            s += hEmitUlong( vreg->value.long )

		case FB_DATATYPE_SINGLE
            s += hEmitSingle( vreg->value.float )

        case FB_DATATYPE_DOUBLE
			s += hEmitDouble( vreg->value.float )

  		case FB_DATATYPE_LONG
  	    	if( FB_LONGSIZE = len( integer ) ) then
                s += hEmitInt( vreg->value.int )
  	    	else
                s += hEmitLong( vreg->value.long )
  	    	end if

        case FB_DATATYPE_ULONG
  	    	if( FB_LONGSIZE = len( integer ) ) then
                s += hEmitUint( vreg->value.int )
  	    	else
                s += hEmitUlong( vreg->value.long )
  	    	end if

		case FB_DATATYPE_UINT
            s += hEmitUint( vreg->value.int )

        case else
            s += hEmitInt( vreg->value.int )

		end select

        return s

	case IR_VREGTYPE_REG
		return "vr$" & vreg->reg

	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
		return "__unknown__"

	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private sub _emitLabel( byval label as FBSYMBOL ptr )
	'' Only when inside normal procedures
	'' (NAKED procedures don't increase the indentation)
	if( sectionInsideProc( ) ) then
		hWriteLine( *symbGetMangledName( label ) + ":;" )
	end if
end sub

'':::::
private sub _emitReturn _
	( _
		byval bytestopop as integer _
	)

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

''::::
private sub _emitJmpTb _
	( _
		byval op as AST_JMPTB_OP, _
		byval dtype as integer, _
		byval label as FBSYMBOL ptr _
	)

	select case op
	case AST_JMPTB_BEGIN
		ctx.jmptbsym = label
		hWriteLine( "static const void * " & *symbGetMangledName( label ) & "[] = {" )
		sectionIndent( )

	case AST_JMPTB_END
		hWriteLine( "(void *)0" )
		sectionUnindent( )
		hWriteLine( "};" )

	case AST_JMPTB_LABEL
		hWriteLine( "&&" + *symbGetMangledName( label ) + "," )
	end select

end sub

'':::::
private sub hEmitVregExpr _
	( _
		byval vr as IRVREG ptr, _
		byref expr as string, _
		byval is_call as integer = FALSE, _
		byval add_cast as integer = TRUE _
	)

	if( irIsREG( vr ) ) then
		var ln = ""
		var id = hVregToStr( vr )

		if( add_cast = FALSE ) then
			if( is_call ) then
				errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
			else
				ln = "#define " & id & " ((" & expr & "))"
			end if
		else
			var typ = hEmitType( vr->dtype, vr->subtype )

			if( is_call ) then
				ln = typ & " " & id & " = (" & typ & ")(" & expr & ");"
			else
				ln = "#define " & id & " ((" & typ & ")(" & expr & "))"
			end if
		End If

		hWriteLine( ln, TRUE )
	else
		hWriteLine( hVregToStr( vr ) + " = (" + expr + ");" )
	end if

end sub

''::::
private function hBOPToStr _
	( _
		byval op as integer _
	) as string

	select case as const op
		case AST_OP_ADD
			return " + "
		case AST_OP_SUB
			return " - "
		case AST_OP_MUL
			return " * "
		case AST_OP_DIV
			return " / "
		case AST_OP_INTDIV
			return " / "
		case AST_OP_MOD
			return " % "
		case AST_OP_SHL
			return " << "
		case AST_OP_SHR
			return " >> "
		case AST_OP_AND
			return " & "
		case AST_OP_OR
			return " | "
		case AST_OP_XOR
			return " ^ "
		case AST_OP_EQ
			return " == "
		case AST_OP_GT
			return " > "
		case AST_OP_LT
			return " < "
		case AST_OP_NE
			return " != "
		case AST_OP_GE
			return " >= "
		case AST_OP_LE
			return " <= "
		case else
			return "unknown_op"
	end select

end function

'':::::
private sub hWriteBOP _
	( _
		byval op as integer, _
		byval vr as IRVREG ptr, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval is_comparison as integer _
	)

	dim as string bop

	if( vr = NULL ) then
		vr = v1
	end if

	dim as integer is_ptr_arith = ((op = AST_OP_ADD) or (op = AST_OP_SUB))
	dim as integer lptr = (is_ptr_arith and typeIsPtr( v1->dtype ))
	dim as integer rptr = (is_ptr_arith and typeIsPtr( v2->dtype ))

	'' Must work-around C's boolean logic values and convert the "boolean"
	'' 1 to -1 while 0 stays 0 to match FB.
	if( is_comparison ) then
		bop += "(-("
	end if

	'' After casting to ubyte ptr for the BOP, cast back to original type
	if( lptr or rptr ) then
		bop += "(" + hEmitType( vr->dtype, vr->subtype ) + ")("
	end if

	'' Left operand:
	'' Cast to byte ptr to work around C's pointer arithmetic
	if( lptr ) then
		bop += "(ubyte *)"
	end if
	'' Ensure '/' means floating point divide by casting to float
	'' For AST_OP_INTDIV this is not needed, since the AST will already
	'' cast both operands to integer before doing the intdiv.
	if( op = AST_OP_DIV ) then
		bop += "(double)"
	end if
	bop += hVregToStr( v1 )

	'' Operation
	bop += hBOPToStr( op )

	'' Right operand - same checks as for left one above
	if( rptr ) then
		bop += "(ubyte *)"
	end if
	if( op = AST_OP_DIV ) then
		bop += "(double)"
	end if
	bop += hVregToStr( v2 )

	'' Close parentheses from above
	if( lptr or rptr ) then
		bop += ")"
	end if
	if( is_comparison ) then
		bop += "))"
	end if

	hEmitVregExpr( vr, bop )

end sub

'':::::
private sub _emitBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval ex as FBSYMBOL ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( v2 )
	hLoadVreg( vr )

	select case as const op
	case AST_OP_ADD, AST_OP_SUB, AST_OP_MUL, AST_OP_DIV, AST_OP_INTDIV, _
		AST_OP_MOD, AST_OP_SHL, AST_OP_SHR, AST_OP_AND, AST_OP_OR, _
		AST_OP_XOR
		hWriteBOP( op, vr, v1, v2, FALSE )

	case AST_OP_EQV
		if( vr = NULL ) then
			vr = v1
		end if

		'' vr = ~(v1 ^ v2)
        hEmitVregExpr( vr, "~(" & hVregToStr( v1 ) & "^" & hVregToStr( v2 ) & ")" )

	case AST_OP_IMP
		if( vr = NULL ) then
			vr = v1
		end if

		'' vr = ~v1 | v2
        hEmitVregExpr( vr, "~" & hVregToStr( v1 ) & "|" & hVregToStr( v2 ) )

	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		if( vr <> NULL ) then
			'' Comparison expression
			hWriteBOP( op, vr, v1, v2, TRUE )
		else
			'' Conditional branch
			dim as string ln
			ln += "if ("
			ln += hVregToStr( v1 )
			ln += hBOPToStr( op )
			ln += hVregToStr( v2 )
			ln += ") goto "
			ln += *symbGetMangledName( ex )
			ln += ";"
			hWriteLine( ln )
		end if
	case else
		errReportEx( FB_ERRMSG_INTERNAL, "Unhandled bop." )
	end select

end sub

'':::::
private sub hWriteUOP _
	( _
		byref op as string, _
		byval vr as IRVREG ptr, _
		byval v1 as IRVREG ptr _
	)

	if( vr = NULL ) then
		vr = v1
	end if

    hEmitVregExpr( vr, op & "(" & hVregToStr( v1 ) & ")" )

end sub

'':::::
private sub _emitUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( vr )

	select case as const op
	case AST_OP_NEG
		hWriteUOP( "-", vr, v1 )

	case AST_OP_NOT
		hWriteUOP( "~", vr, v1 )

	case else
		errReportEx( FB_ERRMSG_INTERNAL, "Unhandled uop." )

	end select

end sub

'':::::
private sub _emitConvert _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( v2 )

	var add_cast = typeGet( to_dtype ) <> FB_DATATYPE_STRUCT
	
	hEmitVregExpr( v1, hVregToStr( v2, add_cast ), FALSE, add_cast )

end sub

'':::::
private sub _emitStore _
	( _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	if( v1 <> v2 ) then
		'' casting needed?
		if( (v1->dtype <> v2->dtype) or (v1->subtype <> v2->subtype) ) then
			_emitConvert( v1->dtype, v1->subtype, v1, v2 )
		else
			hLoadVreg( v1 )
			hLoadVreg( v2 )

            hEmitVregExpr( v1, hVregToStr( v2 ) )
		end if
	end if

end sub

'':::::
private sub _emitSpillRegs _
	( _
	)

	/' do nothing '/

end sub

'':::::
private sub _emitLoad _
	( _
		byval v1 as IRVREG ptr _
	)

	/' do nothing '/

end sub

'':::::
private sub _emitLoadRes _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	_emitStore( vr, v1 )
	hWriteLine( "return " + hVregToStr( vr ) + ";" )

end sub

'':::::
private sub _emitStack _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitPushUDT _
	( _
		byval v1 as IRVREG ptr, _
		byval lgt as integer _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitPushArg _
    ( _
        byval vr as IRVREG ptr, _
        byval plen as integer, _
        byval level as integer _
    )

    '' Remember for later, so during _emitCall[Ptr] we can emit the whole
    '' call in one go
    dim as IRCALLARG ptr arg = listNewNode( @ctx.callargs )
    arg->vr = vr
    arg->level = level

end sub

'':::::
private sub _emitAddr _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( vr )

	select case op
	case AST_OP_ADDROF
        hEmitVregExpr( vr, "&" + hVregToStr( v1, FALSE ) )

	case AST_OP_DEREF
        hEmitVregExpr( vr, hVregToStr( v1 ) )

	end select

end sub

'':::::
private function hEmitCallArgs _
    ( _
        byval level as integer _
    ) as string

    var ln = "( "

    dim as IRCALLARG ptr arg = listGetTail( @ctx.callargs )
    while( arg andalso (arg->level = level) )
        dim as IRCALLARG ptr prev = listGetPrev( arg )

        ln += hVregToStr( arg->vr )

        listDelNode( @ctx.callargs, arg )

        if( prev ) then
            if( prev->level = level ) then
                ln += ", "
            end if
        end if

        arg = prev
    wend

    ln += " )"

    return ln

end function

'':::::
private sub hDoCall _
	( _
		byval pname as zstring ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	var ln = hEmitCallArgs( level )

	if( vr = NULL ) then
		hWriteLine( *pname + ln + ";" )
	else
		hLoadVreg( vr )
        hEmitVregExpr( vr, *pname & ln, TRUE )
	end if

end sub

'':::::
private sub _emitCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	hDoCall( symbGetMangledName( proc ), bytestopop, vr, level )

end sub

'':::::
private sub _emitCallPtr _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer, _
		byval level as integer _
	)

	hDoCall( "(" & hVregToStr( v1 ) & ")", bytestopop, vr, level )

end sub

'':::::
private sub _emitStackAlign _
	( _
		byval bytes as integer _
	)

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitJumpPtr _
	( _
		byval v1 as IRVREG ptr _
	)

	hWriteLine( "goto *" + hVregToStr( v1 ) + ";" )

end sub

'':::::
private sub _emitBranch _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr _
	)

	select case op
	case AST_OP_JMP
		hWriteLine( "goto " + *symbGetMangledName( label ) + ";" )
	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
	end select

end sub

'':::::
private sub _emitMem _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as integer _
	)

	select case op
	case AST_OP_MEMCLEAR
		hWriteLine( "__builtin_memset( " + hVregToStr( v1 ) + ", 0, " + hVregToStr( v2 ) + " );" )
	case AST_OP_MEMMOVE
		hWriteLine( "__builtin_memcpy( " + hVregToStr( v1 ) + ", " + hVregToStr( v2 ) + ", " + str(  bytes ) + " );" )
	end select

end sub

private sub _emitDECL( byval sym as FBSYMBOL ptr )
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
		hWriteLine( "#line " & ex & " """ & hReplace( env.inf.name, "\", $"\\" ) & """", TRUE )
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
			mangled += str( symbGetProcParamsLen( sym ) )
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

private sub _emitVarIniI( byval dtype as integer, byval value as integer )
	if( typeIsSigned( dtype ) ) then
		ctx.varini += hEmitInt( value )
	else
		ctx.varini += hEmitUint( value )
	end if
	hVarIniSeparator( )
end sub

private sub _emitVarIniF( byval dtype as integer, byval value as double )
	if( dtype = FB_DATATYPE_SINGLE ) then
		ctx.varini += hEmitSingle( value )
	else
		ctx.varini += hEmitDouble( value )
	end if
	hVarIniSeparator( )
end sub

private sub _emitVarIniI64( byval dtype as integer, byval value as longint )
	if( typeIsSigned( dtype ) ) then
		ctx.varini += hEmitLong( value )
	else
		ctx.varini += hEmitUlong( value )
	end if
	hVarIniSeparator( )
end sub

private sub _emitVarIniOfs( byval sym as FBSYMBOL ptr, byval ofs as integer )
	ctx.varini += "(void*)" + hEmitOffset( sym, ofs )
	hVarIniSeparator( )
end sub

private sub hEmitVarIniStr _
	( _
		byval totlgt as integer, _
		byref litstr as const zstring ptr, _
		byval litlgt as integer _
	)

	dim as string s = *litstr

	'' String literal too long? (GCC would show a warning)
	if( totlgt < litlgt ) then
		'' Cut off; may be empty afterwards
		s = left( s, totlgt )
	''elseif( totlgt > litlgt ) then
		'' Too short, remaining space will be filled with 0's by GCC
	end if

	'' Simple fixed-length string initialized from string literal
	ctx.varini += """" + s + """"
	hVarIniSeparator( )

end sub

private sub _emitVarIniStr _
	( _
		byval totlgt as integer, _
		byval litstr as zstring ptr, _
		byval litlgt as integer _
	)
	'' "..."
	hEmitVarIniStr( totlgt, hEscape( litstr ), litlgt )
end sub

private sub _emitVarIniWstr _
	( _
		byval totlgt as integer, _
		byval litstr as wstring ptr, _
		byval litlgt as integer _
	)
	'' L"..."
	ctx.varini += "L"
	hEmitVarIniStr( totlgt, hEscapeToHexW( litstr ), litlgt )
end sub

private sub _emitVarIniPad( byval bytes as integer )
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
		hWriteLine( hEmitProcHeader( proc, EMITPROC_ISPROTO ) )
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

sub irHLC_ctor()
	static as IR_VTBL _vtbl = _
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
		NULL, _
		@_emitConvert, _
		@_emitLabel, _
		@_emitLabel, _
		@_emitReturn, _
		@_emitProcBegin, _
		@_emitProcEnd, _
		@_emitPushArg, _
		@_emitAsmBegin, _
		@_emitAsmText, _
		@_emitAsmSymb, _
		@_emitAsmEnd, _
		@_emitComment, _
		@_emitJmpTb, _
		@_emitBop, _
		@_emitUop, _
		@_emitStore, _
		@_emitSpillRegs, _
		@_emitLoad, _
		@_emitLoadRes, _
		@_emitStack, _
		@_emitPushUDT, _
		@_emitAddr, _
		@_emitCall, _
		@_emitCallPtr, _
		@_emitStackAlign, _
		@_emitJumpPtr, _
		@_emitBranch, _
		@_emitMem, _
		@_emitScopeBegin, _
		@_emitScopeEnd, _
		@_emitDECL, _
		@_emitDBG, _
		@_emitVarIniBegin, _
		@_emitVarIniEnd, _
		@_emitVarIniI, _
		@_emitVarIniF, _
		@_emitVarIniI64, _
		@_emitVarIniOfs, _
		@_emitVarIniStr, _
		@_emitVarIniWstr, _
		@_emitVarIniPad, _
		@_emitVarIniScopeBegin, _
		@_emitVarIniScopeEnd, _
		@_allocVreg, _
		@_allocVrImm, _
		@_allocVrImm64, _
		@_allocVrImmF, _
		@_allocVrVar, _
		@_allocVrIdx, _
		@_allocVrPtr, _
		@_allocVrOfs, _
		@_setVregDataType, _
		NULL, _
		NULL, _
		NULL, _
		NULL, _
		@_makeTmpStr _
	)

	ir.vtbl = _vtbl
end sub
