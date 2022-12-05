''
'' "high level" IR interface for emitting C code
''
'' The C backend is called "high level" in comparison to the ASM backend, but
'' actually produces pretty low-level, ABI-dependant C code, using gcc as the
'' "assembler". It works with mostly the same low-level operations that would
'' be sent to the ASM backend (for example: labels and jumps instead of if/else
'' blocks).
''
'' - Some math operations are transparently implemented using gcc __builtin_*()
''   functions. For others, we let the AST know that we can't handle them here,
''   and it will call RTL functions instead.
''
'' - Float to int conversions need special treatment to achieve FB's rounding
''   behaviour. Simple C casting as in '(int)floatvar' cannot be used because it
''   just truncates instead of rounding to nearest. Thus we use 4 helper
''   routines (float|double -> int32|int64) that are implemented in x86 ASM
''   (as done by the ASM backend) or using __builtin_nearbyint[f]().
''
'' - Field accesses, pointer indexing, struct layout/field alignment, etc. is
''   all still calculated on the FB side, i.e. the generated C code is
''   ABI-dependant. sizeof()/offsetof() are evaluated purely on the FB side,
''   it's impossible to pass all constant expressions on to the C backend.
''   (constants, array bounds, fixstr lengths, multi-dim indexing, ...)
''
'' - va_* vararg macros can't be supported with the C backend, they are too
''   different from C's va_*() macros.
''   1. For example, FB's va_first/va_arg can be called repeatedly, that's not
''      possible with C's va_start/va_arg. Acccessing the current arg and
''      advancing to the next is two separate functions in FB, but combined in
''      one in C. It's impossible to reliably & automatically translate from one
''      to the other.
''   2. It's not possible to implement va_first() as "address-of last named
''      parameter" as done for the ASM backend, because gcc sometimes puts
''      parameters into temp vars, and then addrof on that parameter returns the
''      temp var, not the parameter.
''   3. On x86 va_list is just a pointer (exactly what's needed for va_first())
''      but for x86_64 it's not that easy. Varargs may be passed in registers.
''   4. It'd be "nice" to be able to read out all var args into a buffer and
''      allow that to be accessed through FB's va_* macros, but that's not
''      possible because there's no way to know how many varargs there are.
''
'' - Calling conventions/name mangling:
''
''    * We sometimes make use of gcc's asm("nameToUseInAsm") feature which is
''      similar to ALIAS.
''
''    * Cdecl and Stdcall (stdcall with @N) are easily emitted for GCC on
''      individual functions.
''
''    * Special case for stdcall + functions returning UDTs, where we already
''      had to "lower the AST on the FB-side" to use a hidden pointer parameter
''      and pointer result, instead of plain UDT result (see hGetReturnType()):
''
''      gcc doesn't know that the "hidden" result parameter is special and thus
''      calculates it into the @N suffix. We need to use an asm() alias to avoid
''      that.
''
''    * StdcallMs (stdcall without @N) is not directly supported by gcc, only at
''      the linker level through ld --kill-at etc. We need it for individual
''      functions though, not the entire executable/DLL. We can achieve that by
''      using asm() aliases.
''
''      Because gcc inserts these asm() names into DLL export tables as-is,
''      without stripping the underscore prefix, we must emit the exports
''      manually using inline ASM instead of __attribute__((dllexport)) to get
''      them to work correctly.
''
''    * Pascal is like StdcallMs except that arguments are pushed left-to-right
''      (same order as written in code, not reversed like Cdecl/Stdcall). The
''      symbGetProc*Param() macros take care of changing the order when cycling
''      through parameters of Pascal functions, and by together with such
''      functions being emitted as Stdcall this results in a double-reverse
''      resulting in the proper ABI.
''
''    * For non-x86, there's no need to emit cdecl/stdcall/... at all because
''      they don't exist (on x86_64 or ARM etc.) and gcc ignores the attributes.
''
'' - "boolean" is implemented as int8, instead of C99's _Bool type (even though
''   FB's boolean is supposed to be compatible with C's _Bool), because that way
''   we can avoid undefined behaviour if values other than 0/1 are stored in the
''   boolean, and get the same behaviour as with the ASM backend. Of course that
''   also means we have to add code for converting int/float to 0/1 when casting
''   them to boolean.
''
'' - Avoiding C's undefined behaviour where possible. This is important because
''   otherwise we can't rely on gcc to generate meaningful code when
''   "optimizations" are enabled. As a (hopefully nice-to-have) side-effect,
''   some of the FB features/behaviour that originates from the x86 ASM backend
''   are guaranteed to work just the same with the C backend, no matter what
''   architecture.
''    - using gcc's -fwrapv to get well-defined signed integer overflow
''    - emitting the extra AND mask operation on the rhs of SHL/SHR, to ensure
''      that the shift amount is in the range 0..sizeof(lhs)*8-1.
''      (astNewBOP() already handles this for constant shift amounts)
''    - relying on gcc to provide well-defined signed shl on negative integers
''      (https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html)
''

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "flist.bi"
#include once "lex.bi"
#include once "ir-private.bi"

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
	text        as string
	old         as integer '' old junk text (that is only kept around to keep the string allocated)?
	indent      as integer '' current indendation level to be used when emitting lines into this section
end type

enum
	EXPRCLASS_TEXT = 0
	EXPRCLASS_IMM
	EXPRCLASS_SYM
	EXPRCLASS_CAST
	EXPRCLASS_UOP
	EXPRCLASS_BOP
	EXPRCLASS_MACRO
end enum

type EXPRNODE
	class       as integer  '' EXPRCLASS_*

	'' This expression's type, to determine whether CASTs are needed or not
	dtype       as integer
	subtype     as FBSYMBOL ptr

	l           as EXPRNODE ptr  '' CAST/UOP/BOP
	r           as EXPRNODE ptr  '' BOP

	union
		text    as zstring ptr  '' TEXT
		val     as FBVALUE      '' IMM
		sym     as FBSYMBOL ptr '' SYM
		op      as integer      '' UOP/BOP
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
	vregid      as integer
	expr        as EXPRNODE ptr
end type

enum
	BUILTIN_F2I           = (1 shl 0)
	BUILTIN_F2L           = (1 shl 1)
	BUILTIN_F2UL          = (1 shl 2)
	BUILTIN_D2I           = (1 shl 3)
	BUILTIN_D2L           = (1 shl 4)
	BUILTIN_D2UL          = (1 shl 5)
	BUILTIN_STATICASSERT  = (1 shl 6)
end enum

type IRHLCCTX
	sections(0 to MAX_SECTIONS-1)   as SECTIONENTRY
	section                 as integer '' Current section to write to
	sectiongosublevel       as integer

	linenum                 as integer
	escapedinputfilename    as string
	usedbuiltins            as uinteger  '' BUILTIN_*

	anonstack               as TLIST  '' stack of nested anonymous structs/unions in a struct/union

	varini                  as string
	variniscopelevel        as integer

	fbctinf                 as string
	exports                 as string

	exprnodes               as TLIST   '' EXPRNODE
	exprtext                as string  '' buffer used by exprFlush() to build the final text
	exprcache               as TLIST   '' EXPRCACHENODE

	globalvarpass           as integer  '' Global var emitting is done in 2 passes; this allows the callbacks to identify the current pass.
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
		byval lnum as integer, _
		ByVal filename As zstring ptr = 0 _
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
	@"boolean"  , _ '' boolean
	@"int8"     , _ '' byte
	@"uint8"    , _ '' ubyte
	NULL        , _ '' char
	@"int16"    , _ '' short
	@"uint16"   , _ '' ushort
	NULL        , _ '' wchar
	NULL        , _ '' integer
	NULL        , _ '' uinteger
	NULL        , _ '' enum
	@"int32"    , _ '' long
	@"uint32"   , _ '' ulong
	@"int64"    , _ '' longint
	@"uint64"   , _ '' ulongint
	@"float"    , _ '' single
	@"double"   , _ '' double
	@"FBSTRING" , _ '' string
	NULL        , _ '' fix-len string
	@"__builtin_va_list"  , _ '' va_list
	NULL        , _ '' struct
	NULL        , _ '' namespace
	NULL        , _ '' function
	@"void"     , _ '' fwdref (needed for any un-resolved fwdrefs)
	NULL          _ '' pointer
}

private sub _init( )
	irhlInit( )
	listInit( @ctx.anonstack, 8, sizeof( FBSYMBOL ptr ), LIST_FLAGS_NOCLEAR )
	listInit( @ctx.exprnodes, 32, sizeof( EXPRNODE ), LIST_FLAGS_CLEAR )
	listInit( @ctx.exprcache, 8, sizeof( EXPRCACHENODE ), LIST_FLAGS_NOCLEAR )
	irSetOption( IR_OPT_FPUIMMEDIATES or IR_OPT_MISSINGOPS )

	if( fbIs64bit( ) ) then
		dtypeName(FB_DATATYPE_INTEGER) = dtypeName(FB_DATATYPE_LONGINT)
		dtypeName(FB_DATATYPE_UINT   ) = dtypeName(FB_DATATYPE_ULONGINT)
	else
		dtypeName(FB_DATATYPE_INTEGER) = dtypeName(FB_DATATYPE_LONG)
		dtypeName(FB_DATATYPE_UINT   ) = dtypeName(FB_DATATYPE_ULONG)
	end if
end sub

private sub _end( )
	listEnd( @ctx.exprcache )
	listEnd( @ctx.exprnodes )
	listEnd( @ctx.anonstack )
	irhlEnd( )
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
private sub sectionWriteLine( byref s as string )
	with( ctx.sections(ctx.section) )
		if( .old ) then
			if( .indent > 0 ) then
				.text = string( .indent, TABCHAR )
				.text += s
			else
				.text = s
			end if
			.old = FALSE
		else
			if( .indent > 0 ) then
				.text += string( .indent, TABCHAR )
			end if
			.text += s
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
private sub hWriteLine( byref s as string, byval noline as integer = FALSE )
	static as string ln

	if( env.clopt.debuginfo and (noline = FALSE) ) then
		ln = "#line " + str( ctx.linenum )
		ln += " """ + ctx.escapedinputfilename + """"
		sectionWriteLine( ln )
	end if

	sectionWriteLine( s )
end sub

private sub hUpdateCurrentFileName( byval filename as zstring ptr )
	ctx.escapedinputfilename = hReplace( filename, "\", $"\\" )
end sub

private sub hWriteStaticAssert( byref expr as string )
	dim as integer section = any

	if( (ctx.usedbuiltins and BUILTIN_STATICASSERT) = 0 ) then
		ctx.usedbuiltins or= BUILTIN_STATICASSERT

		'' Emit the #define into the header section, not inside procedures,
		'' and above the 1st use (can't be emitted from _emitEnd() because
		'' then it could appear behind struct declarations...)
		section = sectionGosub( 0 )
		hWriteLine( "#define __FB_STATIC_ASSERT( expr ) extern int __$fb_structsizecheck[(expr) ? 1 : -1]", TRUE )
		sectionReturn( section )
	end if

	hWriteLine( "__FB_STATIC_ASSERT( " + expr + " );" )
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

'' Helper function to add underscore prefix or @N stdcall suffix to mangled
'' procedure names (because symb-mangling doesn't do it for -gen gcc), for use
'' in inline ASM and such.
private function hGetMangledNameForASM _
	( _
		byval sym as FBSYMBOL ptr, _
		byval underscore_prefix as integer _
	) as string

	dim as string mangled

	mangled = *symbGetMangledName( sym )

	if( underscore_prefix and env.underscoreprefix ) then
		mangled  = "_" + mangled
	end if

	'' Add the @N suffix for x86 STDCALL
	if( (fbGetCpuFamily( ) = FB_CPUFAMILY_X86) and symbIsProc( sym ) ) then
		if( symbGetProcMode( sym ) = FB_FUNCMODE_STDCALL ) then
			mangled += "@"
			mangled += str( symbProcCalcStdcallSuffixN( sym ) )
		end if
	end if

	function = mangled
end function

private function hNeedAlias( byval proc as FBSYMBOL ptr ) as integer
	function = FALSE

	'' Only on systems where gcc would use the @N suffix
	if( fbGetCpuFamily( ) <> FB_CPUFAMILY_X86 ) then
		exit function
	end if

	select case( env.clopt.target )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, _
	     FB_COMPTARGET_XBOX

		if( symbGetProcMode( proc ) = FB_FUNCMODE_FASTCALL ) then
			exit function
		end if

	case else
		exit function
	end select

	select case( symbGetProcMode( proc ) )
	'' stdcallms/pascal must be emitted as stdcall and need the alias to
	'' avoid the @N suffix.
	case FB_FUNCMODE_STDCALL_MS, FB_FUNCMODE_PASCAL
		function = TRUE

	'' For stdcall with @N suffix, if the function has a hidden UDT result
	'' pointer parameter, or UDT's passed byval, we need the alias to get
	'' the correct @N suffix. (gcc could calculate the wrong value into the
	'' @N suffix, since it doesn't known about the special result parameter
	'' or byval UDTs).  It should be safe to always generate the alias
	'' ourselves since we already must control for the special cases.
	case FB_FUNCMODE_STDCALL
		function = TRUE
	end select
end function

private function hEmitProcHeader _
	( _
		byval proc as FBSYMBOL ptr, _
		byval options as EMITPROC_OPTIONS _
	) as string

	dim as string ln, mangled
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	if( options = 0 ) then
		'' ctor/dtor flags on bodies
		hAppendCtorAttrib( ln, proc, TRUE )
	end if

	if( (options and EMITPROC_ISPROCPTR) = 0 ) then
		if( symbIsPrivate( proc ) ) then
			ln += "static "
		end if
	end if

	'' Function result type (is 'void' for subs)
	ln += hEmitType( symbGetProcRealType( proc ), _
					symbGetProcRealSubtype( proc ) )

	'' Calling convention if needed (for function pointers it's usually not
	'' put in this place, but should work nonetheless)
	if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86 ) then
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
		case FB_FUNCMODE_THISCALL
			select case( env.clopt.target )
			case FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
				ln += " __thiscall"
			case else
				ln += " __attribute__((thiscall))"
			end select
		case FB_FUNCMODE_FASTCALL
			select case( env.clopt.target )
			case FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
				ln += " __fastcall"
			case else
				ln += " __attribute__((fastcall))"
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
			'' Emit clang-compatible datatype for main()'s argv,
			'' clang is very strict about this...
			if( param->stats and FB_SYMBSTATS_ARGV ) then
				ln += "char**"
			else
				symbGetRealParamDtype( param, dtype, subtype )
				ln += hEmitType( dtype, subtype )
			end if

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
		'' Add asm("mangledname") alias if needed.
		'' asm() can only be be used on prototypes.
		if( hNeedAlias( proc ) ) then
			ln += " asm(""" + hGetMangledNameForASM( proc, TRUE ) + """)"
		end if

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

	if( typeGetMangleDt( symbGetFullType( sym ) ) = FB_DATATYPE_VA_LIST ) then
		'' gcc's __builtin_va_list needs an exact name
		select case symbGetValistType( symbGetFullType( sym ), symbGetSubtype( sym ) )
		case FB_CVA_LIST_BUILTIN_C_STD, FB_CVA_LIST_BUILTIN_AARCH64, FB_CVA_LIST_BUILTIN_ARM
				function = *sym->id.alias
				exit function
		end select
	end if

	'' Prefixing the mangled name with a $ because it may start with a
	'' number which isn't allowed in C.
	function = "$" + *symbGetMangledName( sym )
end function

private function hGetUdtName( byval sym as FBSYMBOL ptr ) as string
	function = hGetUdtTag( sym ) + hGetUdtId( sym )
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

		'' global namespace due the implicit MAIN?
		elseif( symbGetNamespace( s ) = @symbGetGlobalNamespc( ) ) then
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
		'' no subtype, to avoid infinite recursion
		hWriteLine( "typedef " + hEmitType( FB_DATATYPE_ENUM, NULL ) + " " + hGetUdtName( s ) + ";" )

	case FB_SYMBCLASS_STRUCT
		hEmitStruct( s, is_ptr )

	'' We're emitting procptr subtypes as typedefs, instead of expanding them in-place,
	'' because that way we can keep doing the "type id" syntax for local vars, parameters, etc.,
	'' while when expanding procptrs it would become more complicated ("returntype (*id)(parameters)").
	case FB_SYMBCLASS_PROC
		if( symbGetIsFuncPtr( s ) ) then
			'' While emitting a procptr typedef, we may emit a UDT that references this procptr typedef.
			'' For example:
			''     type FBSYMBOL_ as FBSYMBOL
			''     type FBRTLCALLBACK as function(byval as FBSYMBOL_ ptr) as integer
			''     type FBSYMBOL
			''         callback as FBRTLCALLBACK
			''     end type
			''     dim callback as FBRTLCALLBACK
			'' In a case like that, we should take care not to emit the typedef twice, because that
			'' isn't allowed by older gcc versions.

			'' 1. Build the procedure declaration and emit its dependencies...
			var decl = hEmitProcHeader( s, EMITPROC_ISPROTO or EMITPROC_ISPROCPTR )

			'' 2. Emit this procptr typedef if it wasn't emitted by step 1
			if( symbGetIsEmitted( s ) = FALSE ) then
				hWriteLine( "typedef " + decl + ";" )
				symbSetIsEmitted( s )
			end if
		end if
	end select

	sectionReturn( section )
end sub

'' Returns "[N]" (N = array size) if the symbol is an array or a fixlen string.
private function hEmitArrayDecl( byval sym as FBSYMBOL ptr ) as string
	dim as string s

	'' even dllimport'ed arrays are emitted as pointers, not arrays
	if( symbIsImport( sym ) ) then
		exit function
	end if

	'' Emit all array dimensions individually
	'' (This lets array initializers rely on gcc to fill uninitialized
	'' elements with zeroes)
	select case( symbGetClass( sym ) )
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		if( symbGetIsDynamic( sym ) = FALSE ) then
			for i as integer = 0 to symbGetArrayDimensions( sym ) - 1
				'' elements = ubound( array, d ) - lbound( array, d ) + 1
				s += "[" + str( symbArrayUbound( sym, i ) - symbArrayLbound( sym, i ) + 1 ) + "]"
			next
		end if
	end select

	if( symbIsRef( sym ) = FALSE ) then
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
	end if

	function = s
end function

private sub hEmitVarDecl _
	( _
		byval use_extern as integer, _
		byval sym as FBSYMBOL ptr, _
		byval varini as zstring ptr _
	)

	dim as string ln

	if( use_extern ) then
		ln += "extern "
	elseif( symbIsStatic( sym ) and ((symbGetAttrib( sym ) and (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) = 0) ) then
		ln += "static "
	end if

	dim dtype as integer
	dim subtype as FBSYMBOL ptr
	symbGetRealType( sym, dtype, subtype )

	ln += hEmitType( dtype, sym->subtype )
	ln += " " + *symbGetMangledName( sym )
	ln += hEmitArrayDecl( sym )

	'' dllimport's are handled manually, emitted as pointers and deref'ed
	'' where needed, as with the ASM backend, as opposed to using
	'' __attribute__((dllimport)). The _imp__ prefix will be added by fbc's
	'' name mangling.

	if( symbIsCommon( sym ) and (not use_extern) ) then
		ln += " __attribute__((common))"
	end if

	if( varini ) then
		ln += " = " + *varini
	end if

	ln += ";"
	hWriteLine( ln )
end sub

private sub hMaybeEmitLocalVar( byval sym as FBSYMBOL ptr )
	assert( symbIsLocal( sym ) )

	'' Fake dynamic array symbol? Descriptor will be emitted instead
	'' TODO: Skip unused STATICs
	if( symbGetIsDynamic( sym ) ) then
		exit sub
	end if

	if( (symbGetTypeIniTree( sym ) <> NULL) and symbIsStatic( sym ) ) then
		irhlFlushStaticInitializer( sym )
	else
		hEmitVarDecl( FALSE, sym, NULL )
	end if
end sub

private sub hAllocGlobalVar( byval sym as FBSYMBOL ptr )
	if( symbGetTypeIniTree( sym ) ) then
		'' Unused private global? Don't bother emitting it
		if( (not symbIsPublic( sym )) and (not symbGetIsAccessed( sym )) ) then
			exit sub
		end if
		irhlFlushStaticInitializer( sym )
	else
		hEmitVarDecl( FALSE, sym, NULL )
	end if
end sub

private sub hMaybeEmitGlobalVar( byval sym as FBSYMBOL ptr )
	assert( symbIsLocal( sym ) = FALSE )

	'' String literals? Emitted inline instead of as global vars
	'' Unused EXTERN? Don't bother emitting it
	'' TODO: Skip all unused private globals, not just initialized ones below
	'' Fake dynamic array symbol? Descriptor will be emitted instead
	if( symbGetIsLiteral( sym ) or _
	    (symbIsExtern( sym ) and (not symbGetIsAccessed( sym ))) or _
	    symbGetIsDynamic( sym ) ) then
		exit sub
	end if

	select case( ctx.globalvarpass )
	case 1
		if( symbGetAttrib( sym ) and (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN) ) then
			'' Emit externs as prototypes only for now;
			'' their initializers may reference other not-yet-emitted globals
			hEmitVarDecl( TRUE, sym, NULL )
		else
			'' Emitted other globals normally
			hAllocGlobalVar( sym )
		end if

	case 2
		'' Emit allocated externs
		if( symbGetAttrib( sym ) and (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC) ) then
			hAllocGlobalVar( sym )
		end if

	end select
end sub

private sub hMaybeEmitGlobalVarExceptDataStmt( byval sym as FBSYMBOL ptr )
	'' DATA descriptor? Handled by irForEachDataStmt()
	if( symbIsDataDesc( sym ) ) then
		exit sub
	end if
	hMaybeEmitGlobalVar( sym )
end sub

private sub hMaybeEmitProcProto( byval s as FBSYMBOL ptr )
	dim as integer section = any

	if( symbGetIsFuncPtr( s ) or (not symbGetIsAccessed( s )) ) then
		exit sub
	end if

	if( symbGetMangledName( s ) = NULL ) then
		exit sub
	end if

	'' All procedure declarations go into the toplevel header
	section = sectionGosub( 0 )

	hWriteLine( hEmitProcHeader( s, EMITPROC_ISPROTO ) + ";" )

	sectionReturn( section )
end sub

private sub hEmitFieldTypes( byval udt as FBSYMBOL ptr )
	dim as FBSYMBOL ptr fld = any
	fld = symbUdtGetFirstField( udt )
	while( fld )
		hEmitUDT( symbGetSubtype( fld ), typeIsPtr( symbGetType( fld ) ) )
		fld = symbUdtGetNextField( fld )
	wend
end sub

private function hFindParentAnonAlreadyOnStack _
	( _
		byval fld as FBSYMBOL ptr _
	) as FBSYMBOL ptr ptr

	dim as FBSYMBOL ptr ptr anonnode = any
	dim as FBSYMBOL ptr parent = any

	'' For each parent, starting with the inner-most...
	parent = fld->parent
	do
		'' Check whether it's already on the stack...
		anonnode = listGetTail( @ctx.anonstack )
		while( anonnode )
			if( *anonnode = parent ) then
				return anonnode
			end if
			anonnode = listGetPrev( anonnode )
		wend

		parent = parent->parent
	loop while( parent )

	function = NULL
end function

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

private sub hEmitStructWithFields( byval s as FBSYMBOL ptr )
	dim as integer skip = any, dtype = any, align = any
	dim as FBSYMBOL ptr subtype = any, fld = any
	dim as FBSYMBOL ptr ptr anonnode = any
	dim as string ln

	'' Write out the fields
	fld = symbUdtGetFirstField( s )
	while( fld )

		if( fld->parent = s ) then
			'' Field from main UDT
			hPopAnonParents( NULL )
		else
			'' Field from a nested anonymous union/struct.
			'' Check the stack to decide whether we have to start
			'' nesting further, or instead go upwards, or stay at
			'' the current level.

			'' Find the field's inner-most parent that's already on
			'' stack, if any.
			anonnode = hFindParentAnonAlreadyOnStack( fld )

			'' a) Pop the stack until we reach the proper level,
			''    or stay at the current level.
			'' b) Reset the stack to the main UDT's level
			hPopAnonParents( anonnode )

			'' a) Push any parents that are inside the one that's on stack
			'' b) Push each new nested anon struct/union
			hPushAnonParents( iif( anonnode, *anonnode, s ), fld->parent )
		end if

		'' Don't emit fake dynamic array fields
		skip = symbIsDynamic( fld )

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
					var fieldudtalign = symbGetUDTAlign( subtype )
					if( fieldudtalign > 0 ) then
						skip or= (align >= fieldudtalign)
					end if
				end if

				if( skip = FALSE ) then
					ln += " __attribute__((packed, aligned(" + str( align ) + ")))"
				end if
			end if

			'' The alignment of nested structures which are packed with a
			'' smaller alignment than the natural or specified alignment of the
			'' parent structure has to be specified explicitly,
			'' otherwise the field will be packed too.
			if ( align <= 0 orelse skip ) then
				if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
					var effectivealign = typeCalcNaturalAlign( dtype, subtype )
					if ( align > 0 andalso align < effectivealign ) then
						effectivealign = align
					end if
					var fieldudtalign = symbGetUDTAlign( subtype )
					if( fieldudtalign > 0 andalso effectivealign > fieldudtalign ) then
						ln += " __attribute__((aligned(" + str( effectivealign ) + ")))"
					end if
				end if
			end if

			ln += ";"
			hWriteLine( ln, TRUE )
		end if

		fld = symbUdtGetNextField( fld )
	wend

	'' Close any remaining nested anonymous structs/unions
	hPopAnonParents( NULL )

	assert( listGetHead( @ctx.anonstack ) = NULL )
end sub

private sub hEmitStruct( byval s as FBSYMBOL ptr, byval is_ptr as integer )
	dim as integer emit_fields = any
	dim as string ln

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

	'' Should we emit the fields individually (for better debug info), or
	'' just use a byte array as structure body (to avoid having to worry
	'' about any layout issues)?
	''
	'' (Technically we don't need to emit fields explicitly, since we don't
	'' access them by name, but only by offset as calculated by FB.)
	''
	'' Currently we prefer emitting fields explicitly. Bitfields are the
	'' only case where it's currently not possible, because FB's bitfields
	'' are currently not ABI-compatible to GCC's.
	'' TODO: Emit C bitfields once FB is compatible, for better debug info.
	emit_fields = not symbGetUdtHasBitfield( s )

	if( emit_fields ) then
		hEmitFieldTypes( s )
	end if

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

	if( emit_fields ) then
		hEmitStructWithFields( s )
	else
		hWriteLine( "uint8 __fb_struct_body[" & symbGetLen( s ) & "];", TRUE )
	end if

	'' Close UDT body
	sectionUnindent( )
	hWriteLine( "};", TRUE )

	symbResetIsBeingEmitted( s )

	'' Static assertion to ensure the struct has been emitted correctly,
	'' at least with the correct sizeof(), because if it'd be too small,
	'' that could easily cause stack trashing etc., because local vars
	'' allocated by gcc would be smaller than expected, etc.
	hWriteStaticAssert( "sizeof( " + hGetUdtTag( s ) + hGetUdtId( s ) + " ) == " + str( culngint( symbGetLen( s ) ) ) )
end sub

private sub hWriteX86F2I _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	var rtype_str = hEmitType( rtype, NULL )
	var ptype_str = hEmitType( ptype, NULL )

	dim as string rtype_suffix, ptype_suffix
	if( env.clopt.asmsyntax = FB_ASMSYNTAX_ATT ) then
		select case( typeGetSize( rtype ) )
		case 4
			rtype_suffix = "l"
		case 8
			rtype_suffix = "q"
		end select
		if( ptype = FB_DATATYPE_SINGLE ) then
			ptype_suffix = "s"
		else
			ptype_suffix = "l"
		end if
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
			hWriteLine( ":""st"""  , TRUE )
		sectionUnindent( )
		hWriteLine( ");", TRUE )
		hWriteLine( "return result;", TRUE )
	sectionUnindent( )
	hWriteLine( "}", TRUE )

end sub

private sub hWriteGenericF2I _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	dim as string callname
	if( ptype = FB_DATATYPE_SINGLE ) then
		callname = "nearbyintf"
	else
		callname = "nearbyint"
	end if

	hWriteLine( "#define fb_" + fname +  "( value ) ((" + hEmitType( rtype, NULL ) + ")__builtin_" + callname + "( value ))", TRUE )

end sub

private sub hWriteF2I _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	'' We have inline ASM routines for some cases
	if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86 ) then
		select case( rtype )
		case FB_DATATYPE_LONG, FB_DATATYPE_LONGINT
			hWriteX86F2I( fname, rtype, ptype )
			exit sub
		end select
	end if

	hWriteGenericF2I( fname, rtype, ptype )

end sub

private sub hMaybeEmitProcExport( byval proc as FBSYMBOL ptr )
	if( symbIsExport( proc ) = FALSE ) then
		exit sub
	end if

	'' Code we want in the final ASM file:
	''
	''  .section .drectve
	''  .ascii " -export:\"MangledProcNameWithoutUnderscorePrefix\""
	''
	'' Since that includes double-quotes and backslashes we need to do
	'' lots of escaping when emitting this in strings in GCC inline ASM.

	ctx.exports += !"\t"""
	ctx.exports += $"\t.ascii "
	ctx.exports += $"\"" -export:\\\"""
	ctx.exports += hGetMangledNameForASM( proc, FALSE )
	ctx.exports += $"\\\""\"""
	ctx.exports += $"\n"
	ctx.exports += !"""\n"
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
	ctx.linenum = 0
	ctx.usedbuiltins = 0
	ctx.globalvarpass = 0
	hUpdateCurrentFileName( env.inf.name )

	'' header
	sectionBegin( )

	if( env.clopt.debuginfo ) then
		_emitDBG( AST_OP_DBG_LINEINI, NULL, 0 )
	end if

	hWriteLine( "typedef   signed char       int8;", TRUE )
	hWriteLine( "typedef unsigned char      uint8;", TRUE )
	hWriteLine( "typedef   signed short      int16;", TRUE )
	hWriteLine( "typedef unsigned short     uint16;", TRUE )
	hWriteLine( "typedef   signed int        int32;", TRUE )
	hWriteLine( "typedef unsigned int       uint32;", TRUE )
	hWriteLine( "typedef   signed long long  int64;", TRUE )
	hWriteLine( "typedef unsigned long long uint64;", TRUE )
	if( fbIs64bit( ) ) then
		hWriteLine( "typedef struct { char *data; int64 len; int64 size; } FBSTRING;", TRUE )
	else
		hWriteLine( "typedef struct { char *data; int32 len; int32 size; } FBSTRING;", TRUE )
	end if
	hWriteLine( "typedef int8 boolean;", TRUE )

	'' body
	sectionBegin( )

	function = TRUE
end function

private sub _emitEnd( )
	dim as integer section = any

	hUpdateCurrentFileName( env.inf.name )

	'' Switch to header section temporarily
	section = sectionGosub( 0 )

	if( ctx.usedbuiltins and BUILTIN_F2I  ) then hWriteF2I( "F2I" , FB_DATATYPE_LONG    , FB_DATATYPE_SINGLE )
	if( ctx.usedbuiltins and BUILTIN_F2L  ) then hWriteF2I( "F2L" , FB_DATATYPE_LONGINT , FB_DATATYPE_SINGLE )
	if( ctx.usedbuiltins and BUILTIN_F2UL ) then hWriteF2I( "F2UL", FB_DATATYPE_ULONGINT, FB_DATATYPE_SINGLE )
	if( ctx.usedbuiltins and BUILTIN_D2I  ) then hWriteF2I( "D2I" , FB_DATATYPE_LONG    , FB_DATATYPE_DOUBLE )
	if( ctx.usedbuiltins and BUILTIN_D2L  ) then hWriteF2I( "D2L" , FB_DATATYPE_LONGINT , FB_DATATYPE_DOUBLE )
	if( ctx.usedbuiltins and BUILTIN_D2UL ) then hWriteF2I( "D2UL", FB_DATATYPE_ULONGINT, FB_DATATYPE_DOUBLE )

	'' Append global declarations to the header of the toplevel section.
	'' This must be done during _emitEnd() instead of _emitBegin() because
	'' _emitBegin() is called even before any input code is parsed.

	'' Emit procedure prototypes first (because of function pointer
	'' initializers taking the address of procedures)
	symbForEachGlobal( FB_SYMBCLASS_PROC, @hMaybeEmitProcProto )

	''
	'' Emit global vars based on the order they were added to the global
	'' symbol table. It's the order they were found in the FB source code,
	'' and any initializers were only allowed to reference already declared
	'' variables, so we should never run into a case where a variable
	'' initializer references a global that wasn't declared yet.
	''
	'' Tricky case: Externs can be split into 2 declarations in the FB code:
	''        extern p as integer ptr
	''        dim shared x as integer
	''        dim shared p as integer ptr = @x
	'' essentially becomes
	''        public dim shared p as integer ptr = @x
	''        dim shared x as integer
	'' I.e. initializers of PUBLIC may have forward references.
	''
	'' To work around this, we must emit globals in 2 passes, essentially
	'' undoing the merging of extern prototype and allocation.
	''
	'' Special case: DATA descriptors, which must be emitted manually using
	'' their own list, to ensure they're emitted in the right order, because
	'' their internal initializers can reference each-other in different
	'' order than the declaration order.
	''

	ctx.globalvarpass = 1
	symbForEachGlobal( FB_SYMBCLASS_VAR, @hMaybeEmitGlobalVarExceptDataStmt )
	irForEachDataStmt( @hMaybeEmitGlobalVar )

	ctx.globalvarpass = 2
	symbForEachGlobal( FB_SYMBCLASS_VAR, @hMaybeEmitGlobalVarExceptDataStmt )
	irForEachDataStmt( @hMaybeEmitGlobalVar )

	sectionReturn( section )

	'' even though we are putting this asm section at the end of the emitted C file
	'' gcc might move it around when compiling the C lising and the ASM block ends up
	'' (typically?) at the beginning of the C source.  Appears to be a change in if
	'' gcc locates this before or after the first '.text. directive when it writes out
	'' the ASM listing from the C listing: somewhere between gcc 7.1 and gcc 7.4.
	'' Explicity close the .drectve section by switching to .text section and presume
	'' that it comensates for the gcc'a choice of section location.
	'' DLL export table
	if( env.clopt.export and (env.target.options and FB_TARGETOPT_EXPORT) ) then
		symbForEachGlobal( FB_SYMBCLASS_PROC, @hMaybeEmitProcExport )
		if( len( ctx.exports ) > 0 ) then
			hWriteLine( !"\n__asm__( \n\t\".section .drectve\\n\"\n" + ctx.exports + ");", TRUE )
			hWriteLine( "__asm__( "".text"" );" )
		end if
		ctx.exports = ""
	end if

	'' body (is appended to header section)
	sectionEnd( )

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

	assert( listGetHead( @ctx.exprcache ) = NULL )
	assert( listGetHead( @ctx.exprnodes ) = NULL )

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

private function _supportsOp _
	( _
		byval op as integer, _
		byval dtype as integer _
	) as integer
	'' Only these aren't available as either C ops or __builtin_*'s
	select case as const( op )
	case AST_OP_SGN, AST_OP_FIX, AST_OP_FRAC, AST_OP_RSQRT, AST_OP_RCP
		function = FALSE
	case else
		function = TRUE
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

private function hIsStaticWithDtor( byval sym as FBSYMBOL ptr ) as integer
	function = symbIsStatic( sym ) and (not symbIsRef( sym )) and symbHasDtor( sym )
end function

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
			if( hIsStaticWithDtor( sym ) ) then
				hMaybeEmitLocalVar( sym )

				''
				'' Check whether it's a dynamic array with a corresponding
				'' descriptor that needs to be emitted instead.
				'' (it won't be detected by above check itself,
				'' as it's of FB_ARRAYDESC type)
				''
				'' It's the descriptor that matters for dynamic
				'' arrays - the dynamic array symbol itself is
				'' not even emitted by hMaybeEmitLocalVar().
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
					hMaybeEmitLocalVar( desc )
				end if
			end if
		end select

		sym = symbGetNext( sym )
	wend

	sectionReturn( section )
end sub

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

private function hEmitType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string

	dim as string s
	dim as integer ptrcount = any

	'' replace type with __builtin_va_list if
	'' the mangle modifier was given
	if( symbIsBuiltinVaListType( dtype, subtype ) ) then
		select case symbGetValistType( dtype, subtype )
		case FB_CVA_LIST_BUILTIN_POINTER
			dtype = typeJoinDtOnly( typeDeref(dtype), FB_DATATYPE_VA_LIST )
		case else
			dtype = typeJoinDtOnly( dtype, FB_DATATYPE_VA_LIST )
		end select
	end if
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

	'' Integer literals can only be emitted as either 32bit int or 64bit long long,
	'' if other types are needed, an exprNewCAST() should be done afterwards.
	if( typeGetSize( dtype ) = 8 ) then
		dtype = iif( typeIsSigned( dtype ), FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT )
	else
		dtype = iif( typeIsSigned( dtype ), FB_DATATYPE_LONG, FB_DATATYPE_ULONG )
	end if

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
	if( symbIsRef( sym ) or symbIsParamVarBydescOrByref( sym ) or symbIsImport( sym ) ) then
		return FALSE
	end if

	select case( symbGetClass( sym ) )
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		'' No dynamic arrays, they're just descriptor structs
		if( symbIsDynamic( sym ) ) then
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

	'' Don't add a CAST if l already has the desired type
	if( (dtype = l->dtype) and (subtype = l->subtype) ) then
		return l
	end if

	'' Don't cast if l has a compatible type (e.g. 32bit int vs. 32bit long)
	'' (same class, same size, same signedness, no pointers involved,
	'' both booleans or none)
	if( (typeGetSizeType( l->dtype ) = typeGetSizeType( dtype )) and _
	    (not typeIsPtr( l->dtype )) and (not typeIsPtr( dtype )) ) then
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

	var n = exprNew( EXPRCLASS_CAST, dtype, subtype )
	n->l = l
	function = n
end function

private function exprNewMACRO _
	( _
		byval op as AST_OP, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as EXPRNODE ptr, _
		byval r as EXPRNODE ptr _
	) as EXPRNODE ptr

	var n = exprNew( EXPRCLASS_MACRO, dtype, subtype )
	n->op = op
	n->l = l
	n->r = r
	function = n
end function

private function exprNewSYM( byval sym as FBSYMBOL ptr ) as EXPRNODE ptr
	dim as EXPRNODE ptr n = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' Dynamic array (fake dynamic array symbol)? Remap to array descriptor,
	'' since that's what it will be emitted as.
	if( symbIsVar( sym ) and symbIsDynamic( sym ) ) then
		sym = sym->var_.array.desc
		assert( sym )
	end if

	if( symbIsLabel( sym ) ) then
		'' &&label is a void* in GCC
		'' This is handled as a single SYM instead of ADDROF( SYM ),
		'' because a label is not a proper expression on its own.
		n = exprNew( EXPRCLASS_SYM, typeAddrOf( FB_DATATYPE_VOID ), NULL )
		n->sym = sym

	elseif( symbIsProc( sym ) ) then
		'' &proc
		'' Similar to labels above, this is only used to take the
		'' address of functions, not to call them, so the '&' is
		'' part of the SYM.
		n = exprNew( EXPRCLASS_SYM, typeAddrOf( FB_DATATYPE_FUNCTION ), sym )
		n->sym = sym

	'' Array? Add CAST to make it a pointer to the first element,
	'' instead of a pointer to the array.
	elseif( symbIsCArray( sym ) ) then
		n = exprNew( EXPRCLASS_SYM, FB_DATATYPE_INVALID, NULL )
		n->sym = sym

		n = exprNewCAST( typeAddrOf( symbGetType( sym ) ), symbGetSubtype( sym ), n )

	'' main()'s argv? It's emitted as int8** (char**), not as uint8** (zstring ptr ptr),
	'' so specify the type manually instead of deriving it from the FB symbol.
	'' exprNewVREG() will add the cast to uint8** where needed.
	elseif( (symbIsVar( sym ) or (sym->class = FB_SYMBCLASS_PARAM)) and _
	        ((sym->stats and FB_SYMBSTATS_ARGV) <> 0) ) then
		n = exprNew( EXPRCLASS_SYM, typeMultAddrOf( FB_DATATYPE_BYTE, 2 ), NULL )
		n->sym = sym

	else
		symbGetRealType( sym, dtype, subtype )

		n = exprNew( EXPRCLASS_SYM, dtype, subtype )
		n->sym = sym
	end if

	function = n
end function

private function typeCBop _
	( _
		byval op as integer, _
		byval a as integer, _
		byval b as integer _
	) as integer

	'' Result of relational/comparison operators is int
	if( astOpIsRelational( op ) ) then
		return FB_DATATYPE_LONG
	end if

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
	select case as const( op )
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

		dtype = typeCBop( op, l->dtype, l->dtype )


	case AST_OP_ABS, AST_OP_FLOOR, _
	     AST_OP_SIN, AST_OP_ASIN, _
	     AST_OP_COS, AST_OP_ACOS, _
	     AST_OP_TAN, AST_OP_ATAN, _
	     AST_OP_SQRT, AST_OP_LOG, AST_OP_EXP
		'' Builtin float ops (sin/cos/tan etc.) return what they're given,
		'' abs() works with long & longint too, but same behaviour
		dtype = l->dtype

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
	dtype = typeCBop( op, l->dtype, r->dtype )

	'' BOPs should only be done on simple int/float types,
	'' and on pointers only after casting to ubyte* first,
	'' so no subtype needs to be preserved here.

	'' if both are pointers, and either has a mangle modifier, then
	'' cast both sides to ubyte*, otherwise, gcc may warn about comparing
	'' distinct pointer types without a cast.  For example with pointers
	'' to __builtin_va_list types.  AST should have already rejected
	'' invalid comparisons or warned on suspicious comparisons.
	select case as const( op )
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		if( typeIsPtr( l->dtype ) and typeIsPtr( r->dtype ) ) then
			if( (typeGetMangleDt( l->dtype ) = FB_DATATYPE_VA_LIST) or _
				(typeGetMangleDt( r->dtype ) = FB_DATATYPE_VA_LIST) ) then
				l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
				r = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, r )
			end if
		end if
	end select

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

		'' Convert to exact representation using C99-compatible hex format
		s = hFloatToHex_C99( value )

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
			if( hIsValidHexDigit( (*z)[i+1] ) ) then
				'' Split up the string literal to prevent
				'' the compiler from treating this following
				'' char as part of the escape sequence
				ln += """ """
			end if
		elseif( ch = asc( "?" ) ) then
			ln += "?"
			'' If the following string literal content would form a
			'' trigraph, it must be escaped
			if( (*z)[i+1] = asc( "?" ) ) then
				assert( (i+2) < length )  '' null terminator not yet reached
				select case( (*z)[i+2] )
				case asc( "=" ), asc( "/" ), asc( "'" ), _
				     asc( "(" ), asc( ")" ), asc( "!" ), _
				     asc( "<" ), asc( ">" ), asc( "-" )
					'' Split up the string literal between the two '??', ditto
					ln += """ """
				end select
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
			if( hIsValidHexDigit( (*w)[i+1] ) ) then
				ln += """ L"""
			end if
		elseif( ch = asc( "?" ) ) then
			ln += "?"
			if( (*w)[i+1] = asc( "?" ) ) then
				assert( (i+2) < length )  '' null terminator not yet reached
				select case( (*w)[i+2] )
				case asc( "=" ), asc( "/" ), asc( "'" ), _
				     asc( "(" ), asc( ")" ), asc( "!" ), _
				     asc( "<" ), asc( ">" ), asc( "-" )
					ln += """ L"""
				end select
			end if
		else
			ln += chr( ch )
		end if
	next

	ln += """"
end sub

private function hBopToStr( byval op as integer ) as zstring ptr
	select case as const( op )
	case AST_OP_ADD : function = @" + "
	case AST_OP_SUB : function = @" - "
	case AST_OP_MUL : function = @" * "
	case AST_OP_DIV : function = @" / "
	case AST_OP_INTDIV : function = @" / "
	case AST_OP_MOD : function = @" % "
	case AST_OP_SHL : function = @" << "
	case AST_OP_SHR : function = @" >> "
	case AST_OP_AND : function = @" & "
	case AST_OP_OR  : function = @" | "
	case AST_OP_XOR : function = @" ^ "
	case AST_OP_EQ  : function = @" == "
	case AST_OP_GT  : function = @" > "
	case AST_OP_LT  : function = @" < "
	case AST_OP_NE  : function = @" != "
	case AST_OP_GE  : function = @" >= "
	case AST_OP_LE  : function = @" <= "
	end select
end function

private function hUopToStr _
	( _
		byval op as integer, _
		byval dtype as integer, _
		byref is_builtin as integer _
	) as zstring ptr

	is_builtin = FALSE

	select case( op )
	case AST_OP_ADDROF : function = @"&"
	case AST_OP_DEREF  : function = @"*"
	case AST_OP_NEG    : function = @"-"
	case AST_OP_NOT    : function = @"~"

	case AST_OP_ABS
		is_builtin = TRUE

		select case as const( typeGetSizeType( dtype ) )
		case FB_SIZETYPE_FLOAT32
			function = @"__builtin_fabsf"
		case FB_SIZETYPE_FLOAT64
			function = @"__builtin_fabs"
		case FB_SIZETYPE_INT64, FB_SIZETYPE_UINT64
			function = @"__builtin_llabs"
		case else
			function = @"__builtin_abs"
		end select

	case else
		is_builtin = TRUE

		'' ignore any const qualifier
		if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_SINGLE ) then
			select case as const( op )
			case AST_OP_SIN   : function = @"__builtin_sinf"
			case AST_OP_ASIN  : function = @"__builtin_asinf"
			case AST_OP_COS   : function = @"__builtin_cosf"
			case AST_OP_ACOS  : function = @"__builtin_acosf"
			case AST_OP_TAN   : function = @"__builtin_tanf"
			case AST_OP_ATAN  : function = @"__builtin_atanf"
			case AST_OP_SQRT  : function = @"__builtin_sqrtf"
			case AST_OP_LOG   : function = @"__builtin_logf"
			case AST_OP_EXP   : function = @"__builtin_expf"
			case AST_OP_FLOOR : function = @"__builtin_floorf"
			case else          : assert( FALSE )
			end select
		else
			assert( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_DOUBLE )
			select case as const( op )
			case AST_OP_SIN   : function = @"__builtin_sin"
			case AST_OP_ASIN  : function = @"__builtin_asin"
			case AST_OP_COS   : function = @"__builtin_cos"
			case AST_OP_ACOS  : function = @"__builtin_acos"
			case AST_OP_TAN   : function = @"__builtin_tan"
			case AST_OP_ATAN  : function = @"__builtin_atan"
			case AST_OP_SQRT  : function = @"__builtin_sqrt"
			case AST_OP_LOG   : function = @"__builtin_log"
			case AST_OP_EXP   : function = @"__builtin_exp"
			case AST_OP_FLOOR : function = @"__builtin_floor"
			case else          : assert( FALSE )
			end select
		end if
	end select

end function

private sub hImm2Text( byref s as string, byval n as EXPRNODE ptr )
	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		s += hEmitFloat( n->dtype, n->val.f )
	else
		assert( (n->dtype <> FB_DATATYPE_BOOLEAN) orelse ((n->val.i = 1) or (n->val.i = 0)) )
		s += hEmitInt( n->dtype, n->val.i )
	end if
end sub

private sub hSym2Text( byref s as string, byval sym as FBSYMBOL ptr )
	'' String literal?
	if( symbGetIsLiteral( sym ) ) then
		if( symbGetType( sym ) = FB_DATATYPE_WCHAR ) then
			hBuildWstrLit( s, hUnescapeW( symbGetVarLitTextW( sym ) ), symbGetWstrLen( sym ) )
		else
			hBuildStrLit( s, hUnescape( symbGetVarLitText( sym ) ), symbGetStrLen( sym ) )
		end if
	else
		if( symbIsLabel( sym ) ) then
			s += "&&"
		elseif( symbIsProc( sym ) ) then
			s += "&"
		end if
		s += *symbGetMangledName( sym )
	end if
end sub

'' Builds up final expression text, walking the EXPRNODE tree
private sub hExprFlush( byval n as EXPRNODE ptr, byval need_parens as integer )
	dim as EXPRNODE ptr l = any
	dim as FBSYMBOL ptr sym = any
	dim as integer is_builtin = any

	select case as const( n->class )
	case EXPRCLASS_TEXT
		ctx.exprtext += *n->text

	case EXPRCLASS_IMM
		hImm2Text( ctx.exprtext, n )

	case EXPRCLASS_SYM
		hSym2Text( ctx.exprtext, n->sym )

	case EXPRCLASS_CAST
		'' (type)l
		ctx.exprtext += "(" + hEmitType( n->dtype, n->subtype ) + ")"
		hExprFlush( n->l, TRUE )

	case EXPRCLASS_MACRO
		select case( n->op )
		case AST_OP_VA_ARG
			'' cva_arg(l, type) := __builtin_va_arg(l, type)
			ctx.exprtext += "__builtin_va_arg( "
			hExprFlush( n->l, TRUE )
			ctx.exprtext += ", "
			ctx.exprtext += hEmitType( n->dtype, n->subtype )
			ctx.exprtext += ")"

		case AST_OP_VA_START
			'' cva_start(l, r) := __builtin_va_start(l, r)
			ctx.exprtext += "__builtin_va_start( "
			hExprFlush( n->l, TRUE )
			ctx.exprtext += ", "
			hExprFlush( n->r, TRUE )
			ctx.exprtext += ")"

		case AST_OP_VA_END
			'' cva_end(l) := __builtin_va_end(l)
			ctx.exprtext += "__builtin_va_end( "
			hExprFlush( n->l, TRUE )
			ctx.exprtext += ")"

		case AST_OP_VA_COPY
			'' cva_copy(l, r) := __builtin_va_copy(l, r)
			ctx.exprtext += "__builtin_va_copy( "
			hExprFlush( n->l, TRUE )
			ctx.exprtext += ", "
			hExprFlush( n->r, TRUE )
			ctx.exprtext += ")"

		case else
			assert( FALSE )
		end select


	case EXPRCLASS_UOP
		ctx.exprtext += *hUopToStr( n->op, n->dtype, is_builtin )

		'' Add parentheses around UOPs to avoid -(-(foo)) looking like
		'' --foo which looks like the -- operator to gcc. Or, add the
		'' parentheses for __builtin_* calls.
		need_parens = (n->l->class = EXPRCLASS_UOP) or is_builtin
		if( need_parens ) then
			ctx.exprtext += "("
			if( is_builtin ) then
				ctx.exprtext += " "
			end if
		end if
		hExprFlush( n->l, TRUE )
		if( need_parens ) then
			if( is_builtin ) then
				ctx.exprtext += " "
			end if
			ctx.exprtext += ")"
		end if

	case EXPRCLASS_BOP
		select case( n->op )
		case AST_OP_ATAN2
			if( n->dtype = FB_DATATYPE_SINGLE ) then
				ctx.exprtext += "__builtin_atan2f"
			else
				ctx.exprtext += "__builtin_atan2"
			end if
			ctx.exprtext += "("
			hExprFlush( n->l, FALSE )
			ctx.exprtext += ", "
			hExprFlush( n->r, FALSE )
			ctx.exprtext += ")"
		case else
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

	'' Indentation
	s += space( (level - 1) * 4 )

	static names(0 to ...) as zstring ptr => { _
		@"TEXT", _ '' EXPRCLASS_TEXT
		@"IMM" , _ '' EXPRCLASS_IMM
		@"SYM" , _ '' EXPRCLASS_SYM
		@"CAST", _ '' EXPRCLASS_CAST
		@"UOP" , _ '' EXPRCLASS_UOP
		@"BOP" , _ '' EXPRCLASS_BOP
		@"MACRO" _ '' EXPRCLASS_MACRO
	}

	s += *names(n->class)
	s += typeDumpToStr( n->dtype, n->subtype )
	s += " "

	select case as const( n->class )
	case EXPRCLASS_TEXT
		s += *n->text

	case EXPRCLASS_IMM
		hImm2Text( s, n )

	case EXPRCLASS_SYM
		hSym2Text( s, n->sym )

	case EXPRCLASS_CAST
		s += hEmitType( n->dtype, n->subtype )

	case EXPRCLASS_MACRO
		s += hEmitType( n->dtype, n->subtype )

	case EXPRCLASS_UOP
		s += *hUopToStr( n->op, n->dtype, FALSE )

	case EXPRCLASS_BOP
		select case( n->op )
		case AST_OP_ATAN2
			if( n->dtype = FB_DATATYPE_SINGLE ) then
				s += "__builtin_atan2f"
			else
				s += "__builtin_atan2"
			end if
		case else
			s += *hBopToStr( n->op )
		end select

	end select

	print s

	select case( n->class )
	case EXPRCLASS_CAST, EXPRCLASS_UOP
		exprDump( n->l )
	case EXPRCLASS_BOP
		exprDump( n->l )
		exprDump( n->r )
	case EXPRCLASS_MACRO
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
		'' addrof var:
		''        (vregtype)((uint8*)&sym + offset)

		have_offset = ((vreg->ofs <> 0) or (vreg->vidx <> NULL))

		'' Check whether to do plain access or deref/addrof trick
		'' - any offset? use trick, to allow doing +offset
		'' - symbol is an array in the C code? (arrays, fixlen strings...)
		''   cannot just do (elementtype)carray, it must always be
		''   *(elementtype*)carray to access the memory in these cases.
		var is_c_array = symbIsCArray( vreg->sym )
		var do_deref = have_offset or is_c_array

		l = exprNewSYM( vreg->sym )

		dim as integer symdtype = l->dtype
		dim as FBSYMBOL ptr symsubtype = l->subtype

		'' Different types?
		if( (vreg->dtype <> symdtype) or (vreg->subtype <> symsubtype) ) then
			'' a) float <-> int: access raw bytes instead of converting
			'' b) struct <-> any other: ensure valid C syntax

			'' different data classes?
			do_deref or= (typeGetClass( vreg->dtype ) <> typeGetClass( symdtype ))

			'' any structs involved? (note: FBSTRINGs are structs in the C code too!)
			select case( typeGet( vreg->dtype ) )
			case FB_DATATYPE_STRING
				do_deref = TRUE
			case FB_DATATYPE_STRUCT
				'' don't deref if it is a va_list[1] type, unless we going to anyway
				do_deref or= not symbIsValistStructArray( symbGetFullType( vreg->sym ), symbGetSubType( vreg->sym ) )
			case else
				select case( typeGet( symdtype ) )
				case FB_DATATYPE_STRING
					do_deref = TRUE
				case FB_DATATYPE_STRUCT
					'' don't deref if it is a va_list[1] type, unless we going to anyway
					do_deref or= not symbIsValistStructArray( symbGetFullType( vreg->sym ), symbGetSubType( vreg->sym ) )
				end select
			end select
		end if

		if( do_deref = FALSE ) then
			'' Plain access is enough
			exit select
		end if

		'' Deref/addrof trick

		'' Add '&' if symbol isn't emitted as pointer already
		if( is_c_array = FALSE ) then
			l = exprNewUOP( AST_OP_ADDROF, l )
		end if
		if( have_offset ) then
			if( is_c_array ) then
				'' Cast to intptr_t to work around gcc out side of array bounds
				'' warnings if we are casting from FBSTRING array to pointer
				'' fbc uses a kind of virtual pointer for the an array's (0,..)
				'' index; technically this is undefinded behaviour in C and is
				'' impossible to cast away even when using pointer only casts
				'' in the same expression.  Some gcc optimizations cause a
				'' a warning when setting a pointer for the array's virtual
				'' index location.  To fix this for compliant C code, would
				'' need to rewrite the array descriptor to contain only the
				'' offset value from actual memory pointer and compute the
				'' array access fully on each array element access.
				l = exprNewCAST( FB_DATATYPE_INTEGER, NULL, l )
			else
				'' Cast to ubyte ptr to work around C's pointer arithmetic
				l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
			end if
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
		'' An immediate -- a constant value
		'' The integer literal can be emitted as 32bit or 64bit,
		'' signed or unsigned, and afterwards it should be cast to the
		'' vreg's type for cases like
		''    "cptr(any ptr, 0)"
		'' where the constant has some pointer type, and we'd like to
		'' avoid gcc warnings about pointers...

		dtype = vreg->dtype
		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			l = exprNewIMMf( vreg->value.f, dtype )
		elseif( dtype = FB_DATATYPE_BOOLEAN ) then
			l = exprNewIMMi( iif( vreg->value.i, 1, 0 ) )
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
		byval label as FBSYMBOL ptr _
	)

	dim as EXPRNODE ptr l = any, r = any

	l = exprNewVREG( v1 )
	r = exprNewVREG( v2 )

	'' Conditional branch?
	if( label ) then
		assert( vr = NULL )
		static as string s
		s = "if( "
		s += exprFlush( exprNewBOP( op, l, r ) )
		s += " ) goto "
		s += *symbGetMangledName( label )
		s += ";"
		hWriteLine( s )
		exit sub
	end if

	if( vr = NULL ) then
		vr = v1
	end if

	select case as const( op )
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		l = exprNewBOP( op, l, r )

		'' comparisons returning a boolean produce 0/1,
		'' comparisons returning an integer produce 0/-1.
		if( vr->dtype <> FB_DATATYPE_BOOLEAN ) then
			l = exprNewUOP( AST_OP_NEG, l )
		end if

	case AST_OP_ADD, AST_OP_SUB
		'' Cast to byte ptr to work around C's pointer arithmetic
		if( typeIsPtr( v1->dtype ) ) then
			l = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, l )
		end if
		if( typeIsPtr( v2->dtype ) ) then
			r = exprNewCAST( typeAddrOf( FB_DATATYPE_UBYTE ), NULL, r )
		end if
		l = exprNewBOP( op, l, r )

	case AST_OP_DIV
		'' Ensure '/' means floating point divide by casting to double
		'' For AST_OP_INTDIV this is not needed, since the AST will already
		'' cast both operands to integer before doing the intdiv.
		l = exprNewCAST( FB_DATATYPE_DOUBLE, NULL, l )
		r = exprNewCAST( FB_DATATYPE_DOUBLE, NULL, r )
		l = exprNewBOP( op, l, r )

	case AST_OP_MUL, AST_OP_INTDIV, AST_OP_MOD, _
	     AST_OP_AND, AST_OP_OR, AST_OP_XOR
		l = exprNewBOP( op, l, r )

	case AST_OP_SHL, AST_OP_SHR
		'' Mask the shift amount to ensure it's valid, avoiding C UB
		r = exprNewBOP( AST_OP_AND, r, exprNewIMMi( typeGetBits( l->dtype ) - 1 ) )

		l = exprNewBOP( op, l, r )

	case AST_OP_EQV
		l = exprNewBOP( AST_OP_XOR, l, r )
		if( vr->dtype = FB_DATATYPE_BOOLEAN ) then
			'' vr = (v1 xor v2) xor 1
			l = exprNewBOP( AST_OP_XOR, l, exprNewIMMi( 1 ) )
		else
			'' vr = not (v1 xor v2)
			l = exprNewUOP( AST_OP_NOT, l )
		end if

	case AST_OP_IMP
		if( vr->dtype = FB_DATATYPE_BOOLEAN ) then
			'' vr = (v1 xor 1) or v2
			l = exprNewBOP( AST_OP_XOR, l, exprNewIMMi( 1 ) )
		else
			'' vr = (not v1) or v2
			l = exprNewUOP( AST_OP_NOT, l )
		end if
		l = exprNewBOP( AST_OP_OR, l, r )

	end select

	exprSTORE( vr, l )
end sub

private sub _emitUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	if( vr = NULL ) then
		vr = v1
	end if

	var expr = exprNewVREG( v1 )

	'' boolean NOT?
	if( (op = AST_OP_NOT) and (vr->dtype = FB_DATATYPE_BOOLEAN) ) then
		'' booleans store 0/1, and a boolean NOT is supposed to produce
		'' the inverse 1/0 boolean. Thus it can't be implemented as
		'' bitwise NOT.
		'' Do: <expr == 0>
		'' We could also do <!expr>, but we don't support emitting the
		'' ! operator at the moment.
		expr = exprNewBOP( AST_OP_EQ, expr, exprNewIMMi( 0 ) )
	else
		expr = exprNewUOP( op, expr )
	end if

	exprSTORE( vr, expr )

end sub

'' v1 = cast( <v1's dtype>, v2 )
private sub _emitConvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	var r = exprNewVREG( v2 )

	'' float/int := bool?
	if( (v1->dtype <> FB_DATATYPE_BOOLEAN) and (r->dtype = FB_DATATYPE_BOOLEAN) ) then
		'' 0/-1 := 0/1
		if( r->class = EXPRCLASS_IMM ) then
			r->val.i = (r->val.i <> 0)
			r->dtype = FB_DATATYPE_LONG
		else
			r = exprNewUOP( AST_OP_NEG, r )
		end if

	'' bool := float/int?
	elseif( (v1->dtype = FB_DATATYPE_BOOLEAN) and (r->dtype <> FB_DATATYPE_BOOLEAN) ) then
		'' 0/1 := zero/non-zero
		if( r->class = EXPRCLASS_IMM ) then
			'' (FB's <> 0 produces 0/-1 so we have to negate to get 0/1)
			r->val.i = - iif( typeGetClass( r->dtype ) = FB_DATACLASS_FPOINT, _
			                  r->val.f <> 0, r->val.i <> 0 )
			r->dtype = FB_DATATYPE_LONG
		else
			'' (expr != 0) (C's != produces the 0/1 we want)
			r = exprNewBOP( AST_OP_NE, r, exprNewIMMi( 0 ) )
		end if

	'' int := float? Needs special treatment to achieve FB's rounding behaviour
	elseif( (typeGetClass( v1->dtype ) = FB_DATACLASS_INTEGER) and _
	        (typeGetClass( r->dtype ) = FB_DATACLASS_FPOINT) ) then

		'' ((type)fb_F2I( r ))
		''
		'' If converting to integer <= int32: use fb_*2I()
		'' If converting to uint32 or int64: use fb_*2L()
		''   (uint32: need to avoid truncation to int32)
		'' If converting to uint64: use fb_*2UL()
		''   (need to avoid truncation to int64)

		dim s as string, tempdtype as integer
		select case( typeGetSizeType( v1->dtype ) )
		case is <= FB_SIZETYPE_INT32
			if( r->dtype = FB_DATATYPE_SINGLE ) then
				s = "fb_F2I" : ctx.usedbuiltins or= BUILTIN_F2I
			else
				s = "fb_D2I" : ctx.usedbuiltins or= BUILTIN_D2I
			end if
			tempdtype = FB_DATATYPE_LONG
		case is <= FB_SIZETYPE_INT64
			if( r->dtype = FB_DATATYPE_SINGLE ) then
				s = "fb_F2L" : ctx.usedbuiltins or= BUILTIN_F2L
			else
				s = "fb_D2L" : ctx.usedbuiltins or= BUILTIN_D2L
			end if
			tempdtype = FB_DATATYPE_LONGINT
		case else
			if( r->dtype = FB_DATATYPE_SINGLE ) then
				s = "fb_F2UL" : ctx.usedbuiltins or= BUILTIN_F2UL
			else
				s = "fb_D2UL" : ctx.usedbuiltins or= BUILTIN_D2UL
			end if
			tempdtype = FB_DATATYPE_ULONGINT
		end select
		s += "( " + exprFlush( r ) + " )"
		r = exprNewTEXT( tempdtype, NULL, s )
	end if

	exprSTORE( v1, r )
end sub

private sub _emitStore( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
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

	dim as EXPRNODE ptr l = NULL

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
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' Flush argument list
	s += "( "
	arg = listGetTail( @irhl.callargs )
	while( arg andalso (arg->level = level) )
		dim as IRCALLARG ptr prev = listGetPrev( arg )

		var expr = exprNewVREG( arg->vr )

		'' param will be NULL for hidden struct result arg, since
		'' no corresponding PARAM exists.
		if( arg->param andalso (arg->param->param.mode <> FB_PARAMMODE_VARARG)  ) then
			'' Cast arg to param's type to prevent gcc warning.
			'' (this will be done by astNewARG() already, except for
			'' BYREF AS ANY params, where the exact type will only
			'' be known later, or never)
			symbGetRealParamDtype( arg->param, dtype, subtype )
			expr = exprNewCAST( dtype, subtype, expr )
		end if

		s += exprFlush( expr )

		listDelNode( @irhl.callargs, arg )

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
		byval proc as FBSYMBOL ptr, _
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
		byval bias as ulongint, _
		byval span as ulongint _
	)

	dim as string tb, temp, ln
	dim as EXPRNODE ptr l = any

	var dtype = v1->dtype
	assert( (dtype = FB_DATATYPE_UINT) or (dtype = FB_DATATYPE_ULONGINT) )

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

	l = exprNewIMMi( span + 1 )
	hWriteLine( "static const void* " + tb + "[" + exprFlush( l ) + "] = {", TRUE )
	sectionIndent( )

	var i = 0
	var value = 0
	do
		assert( i < labelcount )

		dim as FBSYMBOL ptr label
		if( value = values[i] ) then
			label = labels[i]
			i += 1
		else
			label = deflabel
		end if
		hWriteLine( "&&" + *symbGetMangledName( label ) + ",", TRUE )

		if( value = span ) then
			exit do
		end if
		value += 1
	loop

	sectionUnindent( )
	hWriteLine( "};", TRUE )

	'' if( (temp-bias) > span ) then goto deflabel
	l = exprNewTEXT( dtype, NULL, temp )
	if( bias <> 0 ) then
		l = exprNewBOP( AST_OP_SUB, l, exprNewIMMi( bias, dtype ) )
	end if
	l = exprNewBOP( AST_OP_GT, l, exprNewIMMi( span, dtype ) )
	hWriteLine( "if( " + exprFlush( l ) + " ) goto " + *symbGetMangledName( deflabel ) + ";", TRUE )

	'' l = jumptable[l - bias]
	l = exprNewTEXT( dtype, NULL, temp )
	l = exprNewBOP( AST_OP_SUB, l, exprNewIMMi( bias, dtype ) )
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
		hWriteLine("__builtin_memcpy( " + exprFlush( exprNewVREG( v1 ) ) + ", " + exprFlush( exprNewVREG( v2 ) ) + ", " + str( cunsg( bytes ) ) + " );" )
	end select

end sub

private sub _emitMacro _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	dim as EXPRNODE ptr l = any, r = any

	select case op
	case AST_OP_VA_START
		l = exprNewVREG( v1 )
		r = exprNewVREG( v2 )
		hWriteLine( exprFlush( exprNewMACRO( op, FB_DATATYPE_INVALID, NULL, l, r ) ) + ";" )

	case AST_OP_VA_END
		l = exprNewVREG( v1 )
		hWriteLine( exprFlush( exprNewMACRO( op, FB_DATATYPE_INVALID, NULL, l, NULL ) ) + ";" )

	case AST_OP_VA_ARG
		l = exprNewVREG( v1 )
		l = exprNewMACRO( op, vr->dtype, vr->sym, l, NULL )
		exprSTORE( vr, l )

	case AST_OP_VA_COPY
		l = exprNewVREG( v1 )
		r = exprNewVREG( v2 )
		hWriteLine( exprFlush( exprNewMACRO( op, FB_DATATYPE_INVALID, NULL, l, r ) ) + ";" )

	end select

end sub

private sub _emitDECL( byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr array = any

	assert( symbIsLocal( sym ) )

	'' Emit locals/statics locally, except statics with dtor - those are
	'' handled in _procAllocStaticVars(), including their dynamic array
	'' descriptors (if any).
	if( hIsStaticWithDtor( sym ) ) then
		exit sub
	end if

	'' Check whether it's a dynamic array descriptor with a back link to
	'' the corresponding array that needs to be checked instead...
	'' (the descriptor needs to be handled like the array)
	assert( symbIsVar( sym ) )
	array = sym->var_.desc.array
	if( array ) then
		if( hIsStaticWithDtor( array ) ) then
			exit sub
		end if
	end if

	hMaybeEmitLocalVar( sym )
end sub

'':::::
private sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		ByVal filename As zstring ptr _
	)

	if( op = AST_OP_DBG_LINEINI ) then
		ctx.linenum = lnum
		if( filename <> NULL ) then
			hUpdateCurrentFileName( filename )
		end if
	end if

end sub

private sub _emitComment( byval text as zstring ptr )
	dim as integer length = any
	static as string s

	s = *text
	s = trim( s )

	length = len( s )
	if( length > 0 ) then
		if( s[length-1] = asc( "\" ) ) then
			s += "not_an_escape"
		end if
		hWriteLine( "// " + s, TRUE )
	end if
end sub

''
'' -asm intel: FB asm blocks are expected to be in Intel format as usual;
''             we have to convert them to the GCC format here.
''
'' Some x86-specific examples:
''
''    myLabel:
''    asm
''        mov eax, [myVar]
''        mov eax, offset myFunction
''        jmp myLabel
''    end asm
''
'' =>
''
''    myLabel:
''    asm("mov eax, [%0]\n"
''        : "+m" (MYVAR$0)            // output contraints
''        :                           // input contraints
''        : "cc", "memory", "eax", "ebx", "ecx", "edx", "esp", "edi", "esi");  // clobbered flags/memory/registers
''    asm("mov eax, offset myFunction\n" : : : /*clobber list*/);
''    asm goto("jmp %l0" : /*no outputs allowed with goto*/ : : /*clobber list*/ : myLabel);
''
''  * references to variables are replaced by %N place-holders, and we add
''    memory constraints (both output/input, using "+m", because we don't know
''    what the ASM code does).
''    This lets gcc replace the variable references by the proper stack offset
''    expression (i.e. esp+N or ebp-N).
''
''    Actually gcc inserts something like <DWORD PTR [ebp-N]>, not just <ebp-N>,
''    corresponding to the referenced variable's data type. Thus, FB inline ASM
''    like this:
''        dword ptr [a]
''    is effectively turned into
''        dword ptr [dword ptr [a]]
''
''    But it's ok, because the GNU assembler apparently uses the outer-most
''    size specifier only, which means the user's size specifier overrides the
''    one inserted by gcc.
''        dim x as long
''        asm
''            div dword ptr [dword ptr [x]]
''            div byte ptr [dword ptr [x]]
''        end asm
''    compiled into an .o with -gen gas, and then disassembled with objdump -M intel -d:
''        div DWORD PTR [ebp-0x4]
''        div BYTE PTR [ebp-0x4]
''
''  * Functions can be emitted as-is (using the external/mangled name),
''    the assembler will recognize them already.
''
''  * references to labels are replaced by %lN place-holders, and the special
''    "asm goto" syntax must be used.
''
''  * gcc's optimizations require us to specify what flags/memory/registers are
''    overwritten/changed by the ASM code. Since we don't know what the ASM code
''    does, we add all flags/memory/registers to the clobbered list...
''
'' -asm att: FB asm blocks are expected to be in the GCC format already,
''           i.e. quoted and including constraints if needed.
''
private function hFindLabelInSeenList( _
	byref labellist as TLIST, _
	byval labelsym as FBSYMBOL ptr _
) as long
	dim as FBSYMBOL ptr ptr symnode = listGetHead( @labellist )
	dim as long index = -1, curindex = 0
	do
		if symnode = NULL then exit do
		if *symnode = labelsym then
			index = curindex
			exit do
		end if
		symnode = listGetNext( symnode )
		curindex += 1
	loop
	return index
end function

private sub _emitAsmLine( byval asmtokenhead as ASTASMTOK ptr )
	'' 1st pass to count some stats (no emitting yet)
	dim as integer uses_label, labelindex, labelindexbase
	dim as TLIST seenlabellist
	listInit( @seenlabellist, 8, sizeof( FBSYMBOL ptr ) )
	var n = asmtokenhead
	while( n )
		if( n->type = AST_ASMTOK_SYMB ) then
			select case( n->sym->class )
			case FB_SYMBCLASS_LABEL
				'' Determine whether to use <asm()> or <asm goto()>
				uses_label = TRUE
			case FB_SYMBCLASS_VAR
				'' Find first valid index into the label list;
				'' it starts behind the constraints.
				'' We'll emit 1 input operand per variable (and no outputs).
				labelindex += 1
			end select
		end if
		n = n->next
	wend

	labelindexbase = labelindex
	dim as string ln = "__asm__"

	'' Only when inside normal procedures
	'' (NAKED procedures don't increase the indentation)
	if( sectionInsideProc( ) ) then
		ln += " __volatile__"
	end if

	if( uses_label ) then
		ln += " goto"
	end if

	ln += "( "

	dim asmcode as string

	'' 2nd pass - emitting
	dim as integer operandindex
	dim as string outputconstraints, inputconstraints, labellist
	n = asmtokenhead
	while( n )

		select case( n->type )
		case AST_ASMTOK_TEXT
			'' -asm intel: ASM keywords, string literals, constants, etc.
			'' -asm att: String literals containing the ASM, tokens for the constraints lists, etc.
			'' Symbol references in the asm strings for -asm att must use the ASM name already,
			'' since we don't parse the string literal content.
			asmcode += *n->text

		case AST_ASMTOK_SYMB
			if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
				if( sectionInsideProc( ) ) then
					select case( n->sym->class )
					case FB_SYMBCLASS_VAR
						'' Referencing a variable: insert %N place-holder...
						'' (N refers to N'th operand written in the whole
						'' asm [goto]([outputs...] inputs... [labels...]) statement)
						asmcode += "%" & operandindex
						operandindex += 1

						'' ... and add the symbol to a constraint list
						if( uses_label ) then
							'' read-only input operand constraint: "m" (symbol)
							'' "asm goto" doesn't allow output constraints, so we can only use
							'' input constraints. Hopefully there are no jump instructions that
							'' modify their memory operand...
							if( len( inputconstraints ) > 0 ) then
								inputconstraints  += ", "
							end if
							inputconstraints  +=  """m"" (" + *symbGetMangledName( n->sym ) + ")"
						else
							'' read+write output operand constraint: "+m" (symbol)
							if( len( outputconstraints ) > 0 ) then
								outputconstraints += ", "
							end if
							outputconstraints += """+m"" (" + *symbGetMangledName( n->sym ) + ")"
						end if

					case FB_SYMBCLASS_LABEL
						'' Referencing a label: insert %lN place-holder
						'' (N refers to N'th operand written in whole
						'' asm goto(outputs... inputs... labels...) statement)

						'' GCC only allows a label to be in the label list once
						'' no matter how many times it appears in the code, so we keep track
						'' of what we've seen to make sure we only emit labels into the list once
						'' and subsequent access use the previous index
						dim as integer labelnum = any
						dim as FBSYMBOL ptr labelsym = n->sym
						dim as long seenlabelindex = hFindLabelInSeenList( seenlabellist, labelsym )
						if seenlabelindex <> -1 then
							labelnum = seenlabelindex + labelindexbase
						else
							labelnum = labelindex
							labelindex += 1
							*CPtr(FBSYMBOL ptr ptr, listNewNode( @seenlabellist ) ) = labelsym
							if( len( labellist ) > 0 ) then
								labellist += ", "
							end if
							labellist += *symbGetMangledName( labelsym )
						end if

						asmcode += "%l" & labelnum

					case else
						'' Referencing a procedure: no gcc constraints needed;
						'' instead emit the symbol directly with its ASM name.
						asmcode += hGetMangledNameForASM( n->sym, TRUE )
					end select
				else
					'' Inside NAKED procedure: Currently emitted as pure inline asm,
					'' so constraints are (hopefully!?) not needed.
					asmcode += hGetMangledNameForASM( n->sym, TRUE )
				end if
			else
				'' -asm att: Since the FB inline asm is in gcc's format already,
				'' AST_ASMTOK_SYMB can only appear for symbol tokens in the constraints list,
				'' for which we must emit the symbol with its C name.
				'' FIXME: AST_ASMTOK_SYMB (reference to C symbol) can't be supported inside NAKED procedures currently,
				'' because they are emitted as pure inline asm (string literals).
				asmcode += *symbGetMangledName( n->sym )
			end if

		end select

		n = n->next
	wend
	listEnd( @seenlabellist )

	if( env.clopt.asmsyntax = FB_ASMSYNTAX_INTEL ) then
		''
		'' Escape double quotes, backslashes, etc. in the asm text,
		'' for example to emit .ascii directives correctly:
		''
		'' .bas:
		''    asm
		''        .ascii $"zzz\""\0"
		''    end asm
		''
		'' .c (-gen gcc -asm intel):
		''    __asm__ __volatile__(
		''        ".ascii \x22zzz\x5C\x22\x5C" "0\x22"
		''        :  :  : "cc", "memory", ...
		''    );
		''
		'' .asm:
		''    .ascii "zzz\"\0"
		''
		hBuildStrLit( ln, strptr( asmcode ), len( asmcode ) + 1 )

		'' Only when inside normal procedures
		'' (NAKED procedures don't increase the indentation)
		if( sectionInsideProc( ) ) then
			ln += " : " + outputconstraints
			ln += " : " + inputconstraints

			'' We don't know what registers etc. will be trashed,
			'' so assume everything... except for rsp/esp - gcc requires a valid
			'' stack to preserve registers and if the asm code clobbers esp/rsp
			'' then there is no way to get it back after esp/rsp changes to
			'' something else.  User is always responsible for handling the stack
			'' registers.
			''
			ln += " : ""cc"", ""memory"""

			select case( fbGetCpuFamily( ) )
			case FB_CPUFAMILY_X86, FB_CPUFAMILY_X86_64
				if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86 ) then
					ln += ", ""eax"", ""ebx"", ""ecx"", ""edx"", ""edi"", ""esi"""
				else
					ln += ", ""rax"", ""rbx"", ""rcx"", ""rdx"", ""rdi"", ""rsi"""
					ln += ", ""r8"", ""r9"", ""r10"", ""r11"", ""r12"", ""r13"", ""r14"", ""r15"""
				end if

				'' gcc seems to only accept the mm* registers if SSE was enabled via gcc command line options
				if( env.clopt.fputype = FB_FPUTYPE_SSE ) then
					ln += ", ""mm0"", ""mm1"", ""mm2"", ""mm3"", ""mm4"", ""mm5"", ""mm6"", ""mm7"""
					ln += ", ""xmm0"", ""xmm1"", ""xmm2"", ""xmm3"", ""xmm4"", ""xmm5"", ""xmm6"", ""xmm7"""
					if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86_64 ) then
						ln += ", ""xmm8"", ""xmm9"", ""xmm10"", ""xmm11"", ""xmm12"", ""xmm13"", ""xmm14"", ""xmm15"""
					end if
				end if

			case FB_CPUFAMILY_ARM, FB_CPUFAMILY_AARCH64
				'' TODO
				ln += ", ""r0"", ""r1"", ""r2"", ""r3"", ""r4"", ""r5"", ""r6"""
				'''ln += ", ""r7""" '' not always accepted by gcc
				ln += ", ""r8"", ""r9"", ""r10"", ""r11"", ""r12"", ""r13"", ""r14"", ""r15"""

				if( fbGetCpuFamily( ) = FB_CPUFAMILY_AARCH64 ) then
					ln += ", ""r16"", ""r17"", ""r18"", ""r19"""
					ln += ", ""r20"", ""r21"", ""r22"", ""r23"", ""r24"", ""r25"", ""r26"", ""r27"", ""r28"""
					''ln += ", ""r29""" '' not always accepted by gcc
					ln += ", ""r30"""
				end if
			end select

			if( uses_label ) then
				ln += " : " + labellist
			end if
		end if
	else
		''
		'' Pass asm text through as-is, assuming it is in the gcc format
		''
		'' .bas:
		''    asm
		''        "incl %0\n" : "+m" (a) : :
		''    end asm
		''
		'' .c (-gen gcc -asm att):
		''    __asm__ __volatile__( "incl %0\n" : "+m" (A$0) : : );
		''
		'' .asm:
		''    incl -16(%ebp)
		''
		ln += asmcode
	end if

	ln += " );"

	hWriteLine( ln )
end sub

private sub _emitVarIniBegin( byval sym as FBSYMBOL ptr )
	ctx.varini = ""
	ctx.variniscopelevel = 0
end sub

private sub _emitVarIniEnd( byval sym as FBSYMBOL ptr )
	hEmitVarDecl( FALSE, sym, ctx.varini )
	ctx.varini = ""
end sub

private sub hVarIniSeparator( )
	if( ctx.variniscopelevel > 0 ) then
		ctx.varini += ", "
	end if
end sub

private sub _emitVarIniI( byval sym as FBSYMBOL ptr, byval value as longint )
	var dtype = symbGetType( sym )

	'' AST stores boolean true as -1, but we emit it as 1 for gcc compatibility
	if( (dtype = FB_DATATYPE_BOOLEAN) and (value <> 0) ) then
		value = 1
	end if

	var l = exprNewIMMi( value, dtype )
	if( symbIsRef( sym ) ) then
		dtype = typeAddrOf( dtype )
	end if
	l = exprNewCAST( dtype, sym->subtype, l )

	ctx.varini += exprFlush( l )
	hVarIniSeparator( )
end sub

private sub _emitVarIniF( byval sym as FBSYMBOL ptr, byval value as double )
	var dtype = symbGetType( sym )
	var l = exprNewIMMf( value, dtype )
	if( symbIsRef( sym ) ) then
		dtype = typeAddrOf( dtype )
	end if
	l = exprNewCAST( dtype, sym->subtype, l )
	ctx.varini += exprFlush( l )
	hVarIniSeparator( )
end sub

private sub _emitVarIniOfs _
	( _
		byval sym as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval ofs as longint _
	)

	dim as EXPRNODE ptr l = any

	l = exprNewOFFSET( rhs, ofs )

	var dtype = symbGetType( sym )
	if( symbIsRef( sym ) ) then
		dtype = typeAddrOf( dtype )
	end if
	l = exprNewCAST( dtype, sym->subtype, l )

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

private sub _emitVarIniScopeBegin( byval sym as FBSYMBOL ptr, byval is_array as integer )
	ctx.variniscopelevel += 1
	ctx.varini += "{ "
end sub

private sub _emitVarIniScopeEnd( )
	'' Trim separator at the end, to make the output look a bit more clean
	'' (this isn't needed though, since the extra comma is allowed in C)
	if( right( ctx.varini, 2 ) = ", " ) then
		'' fbc doesn't optimize this very well and on long strings it becomes expensive
		'' it's built in to the run-time, so revert to normal expression
		'' if we don't have fb_leftself defined yet.
		#ifndef fb_leftself
			ctx.varini = left( ctx.varini, len( ctx.varini ) - 2 )
		#else
			fb_leftself( ctx.varini, len( ctx.varini ) - 2 )
		#endif
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
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DARWIN) then
		'' Must specify a segment name (can use any name)
		ctx.fbctinf += "__attribute__((used, section(""__DATA," + FB_INFOSEC_NAME + """))) "
	else
		ctx.fbctinf += "__attribute__((used, section(""." + FB_INFOSEC_NAME + """))) "
	end if
	ctx.fbctinf += "__fbctinf[] = """
end sub

private sub _emitFbctinfString( byval s as const zstring ptr )
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

	hUpdateCurrentFileName( symbGetProcIncFile( proc ) )

	irhlEmitProcBegin( )

	dim as string mangled

	assert( listGetHead( @ctx.exprcache ) = NULL )
	assert( listGetHead( @ctx.exprnodes ) = NULL )

	hWriteLine( "", TRUE )

	if( env.clopt.debuginfo ) then
		_emitDBG( AST_OP_DBG_LINEINI, proc, proc->proc.ext->dbg.iniline )
	end if

	'' NAKED procedure? Use inline asm, since gcc doesn't support
	'' __attribute__((naked)) on x86
	if( symbIsNaked( proc ) ) then
		mangled = hGetMangledNameForASM( proc, TRUE )
		hWriteLine( "__asm__( "".text"" );" )
		hWriteLine( "__asm__( "".globl " + mangled + """ );" )
		hWriteLine( "__asm__( """ + mangled + ":"" );" )
		exit sub
	end if

	sectionBegin( )

	'' If an asm("mangledname") alias is needed, emit an extra prototype
	'' right above the procedure body, because asm() is only allowed on
	'' prototypes.
	if( hNeedAlias( proc ) ) then
		hWriteLine( hEmitProcHeader( proc, EMITPROC_ISPROTO ) + ";" )
	end if

	hWriteLine( hEmitProcHeader( proc, 0 ) )

	hWriteLine( "{" )
	sectionIndent( )

end sub

private sub _emitProcEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

	dim as string mangled
	dim as EXPRCACHENODE ptr cachenode = any

	'' NAKED procedure? Use inline asm, since gcc doesn't support
	'' __attribute__((naked)) on x86
	if( symbIsNaked( proc ) ) then
		'' Emit .size like ASM backend, for Linux
		if( env.clopt.target = FB_COMPTARGET_LINUX ) then
			mangled = hGetMangledNameForASM( proc, TRUE )
			hWriteLine( "__asm__( "".size " + mangled + ", .-" + mangled + """ );", TRUE )
		end if
		exit sub
	end if

	sectionUnindent( )
	hWriteLine( "}" )

	sectionEnd( )

	'' Forget any left-over expression nodes (unused function results)
	do
		cachenode = listGetHead( @ctx.exprcache )
		if( cachenode = NULL ) then
			exit do
		end if
		exprFreeTree( cachenode->expr )
		listDelNode( @ctx.exprcache, cachenode )
	loop
	assert( listGetHead( @ctx.exprcache ) = NULL )
	assert( listGetHead( @ctx.exprnodes ) = NULL )

	irhlEmitProcEnd( )

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
	@_supportsOp, _
	@_procBegin, _
	@_procEnd, _
	NULL, _
	NULL, _
	NULL, _
	@_scopeBegin, _
	@_scopeEnd, _
	@_procAllocStaticVars, _
	@_emitConvert, _
	@_emitLabel, _
	@_emitLabel, _
	NULL, _
	@_emitProcBegin, _
	@_emitProcEnd, _
	@irhlEmitPushArg, _
	@_emitAsmLine, _
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
	@_emitMacro, _
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
	@irhlAllocVreg, _
	@irhlAllocVrImm, _
	@irhlAllocVrImmF, _
	@irhlAllocVrVar, _
	@irhlAllocVrIdx, _
	@irhlAllocVrPtr, _
	@irhlAllocVrOfs, _
	@_setVregDataType, _
	NULL, _
	NULL, _
	NULL, _
	NULL _
)
