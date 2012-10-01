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

	regcnt				as integer      '' register counter used to name vregs
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

declare sub hEmitStruct( byval s as FBSYMBOL ptr, byval is_ptr as integer )

declare sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

'' globals
dim shared as IRHLCCTX ctx

private sub _init( )
	flistInit( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )
	listInit( @ctx.callargs, 32, sizeof(IRCALLARG), LIST_FLAGS_NOCLEAR )
	irSetOption( IR_OPT_FPUIMMEDIATES or IR_OPT_NOINLINEOPS )
end sub

private sub _end( )
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
		hAppendCtorAttrib( ln, proc, FALSE )
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

private sub hEmitFuncProto _
	( _
		byval s as FBSYMBOL ptr, _
		byval checkcalled as integer = TRUE _
	)

	dim as integer section = any

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
	section = sectionGosub( 0 )

	'' gcc builtin? gen a wrapper..
	if( symbGetIsGccBuiltin( s ) ) then
		hEmitGccBuiltinWrapper( s )
	else
		hWriteLine( hEmitProcHeader( s, EMITPROC_ISPROTO ) + ";" )
	end if

	sectionReturn( section )

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
		id = *symbUniqueId( )
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

	'' Emit method declarations for this UDT from here, because hEmitDecls()
	'' that is usually used to emit declarations of called procedures does
	'' not check UDT methods.
	'' The method declarations are not part of the struct anymore,
	'' but they will include references to it (the THIS pointer).
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
	dim as integer section = any

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

	'' same order as FB_DATATYPE
	static as const zstring ptr dtypeName(0 to FB_DATATYPES-1) = _
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
		NULL        , _ '' enum
		NULL        , _ '' bitfield
		@"long"     , _ '' long
		@"ulong"    , _ '' ulong
		@"longint"  , _ '' longint
		@"ulongint" , _ '' ulongint
		@"single"   , _ '' single
		@"double"   , _ '' double
		@"string"   , _ '' string
		@"fixstr"   , _ '' fix-len string
		NULL        , _ '' struct
		NULL        , _ '' namespace
		NULL        , _ '' function
		NULL        , _ '' fwd-ref
		NULL          _ '' pointer
	}

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
			s = *dtypeName(FB_DATATYPE_VOID)
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

private function hEmitFloat _
	( _
		byval dtype as integer, _
		byval value as double _
	) as string

	dim as string s
	dim as integer expval = any

	'' x86 little-endian assumption
	expval = cast( integer ptr, @value )[1]

	select case( expval )
	'' +/- infinity?
	case &h7FF00000UL, &hFFF00000UL
		if( dtype = FB_DATATYPE_DOUBLE ) then
			if( expval and &h80000000 ) then
				s += "(-__builtin_inf())"
			else
				s += "__builtin_inf()"
			end if
		else
			if( expval and &h80000000 ) then
				s += "(-__builtin_inff())"
			else
				s += "__builtin_inff()"
			end if
		end if

	'' +/- NaN? Quiet-NaN's only
	case &h7FF80000UL, &hFFF80000UL
		if( dtype = FB_DATATYPE_DOUBLE ) then
			if( expval and &h80000000 ) then
				s += "(-__builtin_nan( """" ))"
			else
				s += "__builtin_nan( """" )"
			end if
		else
			if( expval and &h80000000 ) then
				s += "(-__builtin_nanf( """" ))"
			else
				s += "__builtin_nanf( """" )"
			end if
		end if

	case else
		s = str( value )

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

	'' Fixed-length strings are emitted as arrays
	select case( symbGetType( sym ) )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		return TRUE
	end select

	return FALSE
end function

private function hEmitOffset( byval sym as FBSYMBOL ptr, byval ofs as integer ) as string
	dim as string s
	dim as integer is_ptr = any

	'' (for offset added below)
	if( ofs <> 0 ) then
		s += "((ubyte*)"
	end if

	'' For literal strings, just emit as C string literal, not as label as in asm
	if( symbGetIsLiteral( sym ) ) then
		if( symbGetType( sym ) = FB_DATATYPE_WCHAR ) then
			s += "L"""
			s += hEscapeToHexW( symbGetVarLitTextW( sym ) )
			s += """"
		else
			s += """" + *hEscape( symbGetVarLitText( sym ) ) + """"
		end if
	else
		is_ptr = symbIsImport( sym ) or symbIsCArray( sym )
		if( is_ptr = FALSE ) then
			if( symbIsLabel( sym ) ) then
				s += "&&"
			else
				s += "&"
			end if
		end if
		s += *symbGetMangledName( sym )
	end if

	'' Offset (in bytes)
	if( ofs <> 0 ) then
		s += " + " + str( ofs ) + ")"
	end if

	function = s
end function

private function hEmitVreg _
	( _
		byval vreg as IRVREG ptr, _
		byval cast_ok as integer = TRUE _
	) as string

	dim as string s
	dim as integer do_cast = any, have_offset = any

	do_cast = FALSE

	select case as const( vreg->typ )
	case IR_VREGTYPE_VAR, IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		if( vreg->sym = NULL ) then
			'' No symbol attached, but vidx instead, unless the
			'' address was given as a constant,
			'' e.g. in derefs like *cptr(byte ptr, 0),
			'' then there is neither a symbol nor vidx,
			'' but just the "offset".
			''    (*(vregtype*)offset)
			''    (*(vregtype*)vidx)
			''    (*(vregtype*)((ubyte*)vidx + offset))
			s += "(*(" + hEmitType( vreg->dtype, vreg->subtype, EMITTYPE_ADDPTR ) + ")"

			if( vreg->vidx ) then
				have_offset = (vreg->ofs <> 0)

				if( have_offset ) then
					s += "((ubyte*)"
				end if

				'' recursion
				s += hEmitVreg( vreg->vidx )

				if( have_offset ) then
					s += " + " + str( vreg->ofs ) + ")"
				end if
			else
				s += str( vreg->ofs )
			end if

			s += ")"

			exit select
		end if

		assert( symbIsProc( vreg->sym ) = FALSE )

		'' Address of label?
		if( symbIsLabel( vreg->sym ) ) then
			'' Special case used by FB error handling code.
			'' We return &label here; then _emitAddr() will add
			'' another & to get &&label.
			'' The VAR vreg dtype for the label access is useless,
			'' the only thing that matters is the vreg type of the
			'' ADDROF expression (see _emitAddr()).
			do_cast = FALSE
			s = "&" + *symbGetMangledName( vreg->sym )
			exit select
		end if

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
		''        (*(vregtype*)sym)
		''        (*(vregtype*)((ubyte*)sym + offset))
		'' array accesses (idx):
		''        (*(vregtype*)((ubyte*)sym + vidx + offset))
		'' field accesses:
		''        (*(vregtype*)&sym)
		''        (*(vregtype*)((ubyte*)&sym + offset))

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

		'' Emitted as pointer?
		if( symbIsParamByRef( vreg->sym ) or symbIsImport( vreg->sym ) or is_carray ) then
			is_ptr or= TRUE
			symdtype = typeAddrOf( symdtype )
		end if

		'' Different types?
		if( (vreg->dtype <> symdtype) or _
		    (vreg->subtype <> symbGetSubType( vreg->sym )) ) then
			do_cast = TRUE

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
			'' Plain access
			s += *symbGetMangledName( vreg->sym )
			exit select
		end if

		'' Deref/addrof trick
		do_cast = FALSE

		s += "(*(" + hEmitType( vreg->dtype, vreg->subtype, EMITTYPE_ADDPTR ) + ")"

		if( have_offset ) then
			'' Cast to ubyte ptr to work around C's pointer arithmetic.
			s += "((ubyte*)"
		end if

		'' The '&' is only needed for things that aren't pointers already
		if( is_ptr = FALSE ) then
			s += "&"
		end if

		s += *symbGetMangledName( vreg->sym )

		if( vreg->vidx <> NULL ) then
			s += " + " + hEmitVreg( vreg->vidx )
		end if
		if( vreg->ofs <> 0 ) then
			s += " + " + str( vreg->ofs )
		end if

		if( have_offset ) then
			s += ")"
		end if
		s += ")"

	case IR_VREGTYPE_OFS
		'' Accessing a global, including string literals and function
		'' symbols (used when taking address of functions).

		'' In case of @func, both vreg->subtype and vreg->sym point to
		'' the proc, not a funcptr signature symbol and a funcptr
		'' variable. In this scenario symbGetType( vreg->sym ) is the
		'' proc's return value type, not the funcptr type, so we can't
		'' rely on it to detect type casting of funcptrs.
		'' Taking address of a function?
		if( (typeGetDtOnly( vreg->dtype ) = FB_DATATYPE_FUNCTION) and _
		    symbIsProc( vreg->sym ) and _
		    (symbGetIsFuncPtr( vreg->sym ) = FALSE) ) then
			'' sym is a real proc. Unless the vreg is just a function pointer to it,
			'' it was type-casted.
			do_cast = (vreg->dtype <> typeAddrOf( FB_DATATYPE_FUNCTION )) or (vreg->subtype <> vreg->sym)
		else
			do_cast = (vreg->dtype <> symbGetType( vreg->sym )) or _
				  (vreg->subtype <> symbGetSubType( vreg->sym ))
		end if

		s += hEmitOffset( vreg->sym, vreg->ofs )

	case IR_VREGTYPE_IMM
		'' An immediate -- a constant value
		select case( vreg->dtype )
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, _
		     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT, _
		     FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			'' No cast needed for these cases, the number literal
			'' type suffixes will take care of the typing

		case else
			'' Handles casting int literals to byte/short (not sure
			'' if that's ever needed, but oh well), and more
			'' importantly casting number literals to pointer types
			'' as in "cptr(any ptr, 0)" for example.
			do_cast = TRUE
		end select

		select case as const( vreg->dtype )
		case FB_DATATYPE_LONGINT
			s += hEmitLong( vreg->value.long )
		case FB_DATATYPE_ULONGINT
			s += hEmitUlong( vreg->value.long )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			s += hEmitFloat( vreg->dtype, vreg->value.float )
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

	case IR_VREGTYPE_REG
		'' Accessing a vreg that was declared previously, for example
		'' the result of a BOP. A cast is needed here in case the vreg
		'' was type-casted after being declared, this can happen when
		'' casting expressions like BOPs or calls.
		do_cast = TRUE
		s += "vr$" + str( vreg->reg )

	end select

	if( do_cast and cast_ok ) then
		s = "((" + hEmitType( vreg->dtype, vreg->subtype ) + ")(" + s + "))"
	end if

	function = s
end function

private sub _emitLabel( byval label as FBSYMBOL ptr )
	'' Only when inside normal procedures
	'' (NAKED procedures don't increase the indentation)
	if( sectionInsideProc( ) ) then
		hWriteLine( *symbGetMangledName( label ) + ":;" )
	end if
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
		hWriteLine( "static const void* " + *symbGetMangledName( label ) + "[] = {", TRUE )
		sectionIndent( )

	case AST_JMPTB_END
		hWriteLine( "(void*)0", TRUE )
		sectionUnindent( )
		hWriteLine( "};", TRUE )

	case AST_JMPTB_LABEL
		hWriteLine( "&&" + *symbGetMangledName( label ) + ",", TRUE )
	end select

end sub

private sub hEmitVregDecl _
	( _
		byval vr as IRVREG ptr, _
		byref expr as string, _
		byval use_assign as integer = FALSE _
	)

	dim as string ln

	if( irIsREG( vr ) ) then
		'' Declare vreg as new variable or #define
		if( use_assign ) then
			ln = hEmitType( vr->dtype, vr->subtype ) + " "
		end if
	else
		'' Assign to existing vreg
		use_assign = TRUE
	end if

	if( use_assign ) then
		'' The lvalue can't have cast at the toplevel as in
		''    (type)foo = bar
		'' it must be
		''    foo = (type)bar
		'' unless foo is just a var with proper type already.
		ln += hEmitVreg( vr, FALSE ) + " = "
	else
		assert( irIsREG( vr ) )
		ln = "#define vr$" + str( vr->reg ) + " "
	end if

	ln += "(" + hEmitType( vr->dtype, vr->subtype ) + ")("
	ln += expr
	ln += ")"
	if( use_assign ) then
		ln += ";"
	end if

	hWriteLine( ln )

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
		bop += "(ubyte*)"
	end if
	'' Ensure '/' means floating point divide by casting to double
	'' For AST_OP_INTDIV this is not needed, since the AST will already
	'' cast both operands to integer before doing the intdiv.
	if( op = AST_OP_DIV ) then
		bop += "(double)"
	end if
	bop += hEmitVreg( v1 )

	'' Operation
	bop += hBOPToStr( op )

	'' Right operand - same checks as for left one above
	if( rptr ) then
		bop += "(ubyte*)"
	end if
	if( op = AST_OP_DIV ) then
		bop += "(double)"
	end if
	bop += hEmitVreg( v2 )

	if( lptr or rptr ) then
		bop += ")"
	end if
	if( is_comparison ) then
		bop += "))"
	end if

	hEmitVregDecl( vr, bop )

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
		hEmitVregDecl( vr, "~(" + hEmitVreg( v1 ) + "^" + hEmitVreg( v2 ) + ")" )

	case AST_OP_IMP
		if( vr = NULL ) then
			vr = v1
		end if

		'' vr = ~v1 | v2
		hEmitVregDecl( vr, "~" + hEmitVreg( v1 ) + "|" + hEmitVreg( v2 ) )

	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		if( vr <> NULL ) then
			'' Comparison expression
			hWriteBOP( op, vr, v1, v2, TRUE )
		else
			'' Conditional branch
			dim as string ln
			ln += "if ("
			ln += hEmitVreg( v1 )
			ln += hBOPToStr( op )
			ln += hEmitVreg( v2 )
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

	hEmitVregDecl( vr, op + "(" + hEmitVreg( v1 ) + ")" )

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

private sub _emitStore( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	hLoadVreg( v1 )
	hLoadVreg( v2 )
	hEmitVregDecl( v1, hEmitVreg( v2 ) )
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
	hWriteLine( "return " + hEmitVreg( vr ) + ";" )

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
		'' Casts are disallowed here because '&' requires an lvalue,
		'' and also in case of taking address of label.
		'' (The AST does a VAR access with some dtype (byte or int)
		''  but for the backends the only thing that matters is the
		''  pointer type after taking the address of the label.
		''  No real VAR access can be done, afterall a label is
		''  nothing that's stored in memory.)
		hEmitVregDecl( vr, "&" + hEmitVreg( v1, FALSE ) )

	case AST_OP_DEREF
		hEmitVregDecl( vr, hEmitVreg( v1 ) )

	end select

end sub

private function hEmitCallArgs( byval level as integer ) as string
	var ln = "( "

	dim as IRCALLARG ptr arg = listGetTail( @ctx.callargs )
	while( arg andalso (arg->level = level) )
		dim as IRCALLARG ptr prev = listGetPrev( arg )

		ln += hEmitVreg( arg->vr )

		listDelNode( @ctx.callargs, arg )

		if( prev ) then
			if( prev->level = level ) then
				ln += ", "
			end if
		end if

		arg = prev
	wend

	ln += " )"

	function = ln
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
		hEmitVregDecl( vr, *pname + ln, TRUE )
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

	hDoCall( "(" + hEmitVreg( v1 ) + ")", bytestopop, vr, level )

end sub

private sub _emitJumpPtr( byval v1 as IRVREG ptr )
	hWriteLine( "goto *" + hEmitVreg( v1 ) + ";" )
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
		hWriteLine("__builtin_memset( " + hEmitVreg( v1 ) + ", 0, " + hEmitVreg( v2 ) + " );" )
	case AST_OP_MEMMOVE
		hWriteLine("__builtin_memcpy( " + hEmitVreg( v1 ) + ", " + hEmitVreg( v2 ) + ", " + str( bytes ) + " );" )
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
	ctx.varini += hEmitFloat( dtype, value )
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
	@_emitJmpTb, _
	@_emitBop, _
	@_emitUop, _
	@_emitStore, _
	@_emitSpillRegs, _
	@_emitLoad, _
	@_emitLoadRes, _
	NULL, _
	NULL, _
	@_emitAddr, _
	@_emitCall, _
	@_emitCallPtr, _
	NULL, _
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
	NULL _
)
