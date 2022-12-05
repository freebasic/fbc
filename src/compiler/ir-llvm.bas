''
'' IR interface for emitting LLVM IR to output file
''
'' For comparison, see
''
''    - LLVM IR language reference:
''          http://llvm.org/docs/LangRef.html
''
''    - clang's LLVM IR output (useful to see what LLVM IR code it will produce
''      for certain C constructs):
''          $ clang test.c -S -emit-llvm -o test.ll
''
''    - llc (compiles LLVM IR to native ASM):
''          $ llc -O2 test.ll -o test.asm
''
'' LLVM IR instructions inside procedures look like this:
''
''    %var = alloca i32          ; dim var as int32 ptr = alloca( 4 )
''    store i32 0, i32* %var     ; *var = 0
''  loop:
''    %temp0 = load i32* %var                ; temp0 = *var
''    %temp1 = add i32 %temp0, 1             ; temp1 = temp0 + 1
''    store i32 %temp1, i32* %var            ; *var = temp1
''    %temp2 = load i32* %var                ; temp2 = *var
''    %cond = icmp lt i32 %temp2, 10         ; condition = (temp2 < 10)
''    br i1 %cond, label %loop, label %exit  ; if condition then goto loop else goto exit
''  exit:
''
'' - Operations must be in SSA form, there are no self-ops. Operations that
''   don't return void can be assigned to a %name which can be referenced in
''   following operations. The result values can only be stored into memory
''   by separate/explicit store ops.
''
'' - Operations without name implicitly use the %N naming scheme: %1, %2, %3 ...
''   For fbc it seems better to emit proper names though and not rely on the
''   implicit position-based names, because the IR vreg allocation order does
''   not match the order of emitted operations.
''
'' - Labels begin basic blocks, certain operations (ret, br, ...) end them.
''   Basic blocks without a name/label are given a default name/label similar
''   to the default naming for operations.
''
'' - Labels are not allowed to appear consecutively (a basic block can only
''   have one name), and labels are not allowed in the middle of basic blocks
''   (only after an end operation like ret or br).
''   Both situations can happen in FB code easily (empty scope blocks, GOTO...),
''   so _emitLabel() needs to work around that by inserting no-ops or branches.
''   (a more complex solution would be to remove duplicate labels from the AST,
''    and redirect all uses of the removed label to the label that was kept)
''
'' - Operand types are always emitted explicitly; they are not guessed or
''   automatically derived from the actual operand.
''
'' - All types must match exactly, or llc will complain.
''   Since the AST does not always call irSetVregDataType() or irEmitConvert(),
''   the operations emitting ensures to emit casts if needed.
''
'' - Local variables are allocated from stack using "alloca",
''   the returned value is a pointer to the memory.
''
'' - Procedure parameters are passed as values, not pointers, so if the
''   function wants to take the address of a parameter,
''   it has to alloca a stack variable to hold the parameter value.
''   (that's what clang does)
''
'' - LLVM has some built-in functions (llvm.sin.f32, llvm.sin.f64,
''   llvm.memset.p0i8.i32, etc.) that we can use to implement various operations
''   instead of calling RTL functions (although, LLVM may implement them by
''   calling RTL functions if no optimization possible). Despite being intrinsic
''   these need to be declared globally and called just like normal procedures.
''   It seems best to handle them from here though instead of through the rtl
''   modules (e.g. rtlMathUop() and rtlMathBop()) because, for example, some use
''   i1 parameters (no corresponding FB type), and they're not really external
''   functions anyways (rtl reserved for functions from libc/libfb).
''
'' - Global constructors/destructors must be added to the llvm.global_ctors or
''   llvm.global_dtors arrays (each element = priority + function pointer).
''   There can be only one declaration of either per module, so all ctors/dtors
''   must be emitted into one of the two lists.
''
'' - Procedures can either be declared (if they're extern) or defined (with a
''   body) but not both.
''
'' - va_*() macros: Same issues as with the C backend
''

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "flist.bi"
#include once "lex.bi"
#include once "ir-private.bi"

enum
	SECTION_HEAD  '' global declarations
	SECTION_BODY  '' procedure bodies
	SECTION_FOOT  '' debugging meta data
end enum

enum
	BUILTIN_MEMSET = 0
	BUILTIN_MEMMOVE
	BUILTIN_SINF
	BUILTIN_SIN
	BUILTIN_COSF
	BUILTIN_COS
	BUILTIN_EXPF
	BUILTIN_EXP
	BUILTIN_LOGF
	BUILTIN_LOG
	BUILTIN_SQRTF
	BUILTIN_SQRT
	BUILTIN_FLOORF
	BUILTIN_FLOOR
	BUILTIN_ABSF
	BUILTIN_ABS
	BUILTIN_NEARBYINTF
	BUILTIN_NEARBYINT
	BUILTIN__COUNT
end enum

type BUILTIN
	decl as zstring ptr
	used as integer
end type

dim shared as BUILTIN builtins(0 to BUILTIN__COUNT-1) => _
{ _
	(@"declare void @llvm.memset.p0i8.i32(i8*, i8, i32, i32, i1) nounwind"), _
	(@"declare void @llvm.memmove.p0i8.p0i8.i32(i8*, i8*, i32, i32, i1) nounwind"), _
	(@"declare float  @llvm.sin.f32(float ) nounwind"), _
	(@"declare double @llvm.sin.f64(double) nounwind"), _
	(@"declare float  @llvm.cos.f32(float ) nounwind"), _
	(@"declare double @llvm.cos.f64(double) nounwind"), _
	(@"declare float  @llvm.exp.f32(float ) nounwind"), _
	(@"declare double @llvm.exp.f64(double) nounwind"), _
	(@"declare float  @llvm.log.f32(float ) nounwind"), _
	(@"declare double @llvm.log.f64(double) nounwind"), _
	(@"declare float  @llvm.sqrt.f32(float ) nounwind"), _
	(@"declare double @llvm.sqrt.f64(double) nounwind"), _
	(@"declare float  @llvm.floor.f32(float ) nounwind"), _
	(@"declare double @llvm.floor.f64(double) nounwind"), _
	(@"declare float  @llvm.fabs.f32(float ) nounwind"), _
	(@"declare double @llvm.fabs.f64(double) nounwind"), _
	(@"declare float  @llvm.nearbyint.f32(float ) nounwind"), _
	(@"declare double @llvm.nearbyint.f64(double) nounwind")  _
}

type IRLLVMVARINISCOPE
	is_array as byte
end type

const MAXVARINISCOPES = 128

type IRLLVMCONTEXT
	indent              as integer  '' current indentation used by hWriteLine()
	linenum             as integer

	varini              as string
	variniscopelevel    as integer
	variniscopes(0 to MAXVARINISCOPES-1) as IRLLVMVARINISCOPE

	ctors               as string
	dtors               as string
	ctorcount           as integer
	dtorcount           as integer

	fbctinf             as string
	fbctinf_len         as integer

	section             as integer  '' current section to write to
	head_txt            as string
	body_txt            as string
	foot_txt            as string
end type

declare function hEmitType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string
declare sub hEmitStruct( byval s as FBSYMBOL ptr )
declare sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		ByVal filename As zstring ptr = 0 _
	)
declare function hVregToStr( byval vreg as IRVREG ptr ) as string
declare sub hEmitConvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
declare sub hEmitStore( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
declare sub hEmitBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval label as FBSYMBOL ptr _
	)

'' globals
dim shared as IRLLVMCONTEXT ctx

'' same order as FB_DATATYPE
dim shared as const zstring ptr dtypeName(0 to FB_DATATYPES-1) = _
{ _
	@"i8"       , _ '' void
	@"i8"       , _ '' boolean
	@"i8"       , _ '' byte
	@"i8"       , _ '' ubyte
	@"i8"       , _ '' char
	@"i16"      , _ '' short
	@"i16"      , _ '' ushort
	NULL        , _ '' wchar
	NULL        , _ '' integer
	NULL        , _ '' uinteger
	NULL        , _ '' enum
	@"i32"      , _ '' long
	@"i32"      , _ '' ulong
	@"i64"      , _ '' longint
	@"i64"      , _ '' ulongint
	@"float"    , _ '' single
	@"double"   , _ '' double
	@"%FBSTRING", _ '' string
	@"i8"       , _ '' fix-len string
	@"%struct.va_list", _ '' va_list - not tested, it can be different for every platform
	NULL        , _ '' struct
	NULL        , _ '' namespace
	NULL        , _ '' function
	@"i8"       , _ '' fwdref (needed for any un-resolved fwdrefs)
	NULL          _ '' pointer
}

private sub _init( )
	irhlInit( )

	irSetOption( IR_OPT_FPUIMMEDIATES or IR_OPT_MISSINGOPS )

	'' IR_OPT_CPUSELFBOPS disabled, to prevent AST from producing self-ops.
	'' LLVM does not have self ops, and implementing them manually here would be
	'' unnecessarily complex, especially in cases like:
	''    a = noconvcast(a) op b   (self-bop with type-casted destination vreg)
	'' because _setVregDataType() generates code to represent the cast, and the
	'' resulting REG can't be used as store destination.

	if( fbIs64bit( ) ) then
		dtypeName(FB_DATATYPE_INTEGER) = dtypeName(FB_DATATYPE_LONGINT)
		dtypeName(FB_DATATYPE_UINT   ) = dtypeName(FB_DATATYPE_ULONGINT)
	else
		dtypeName(FB_DATATYPE_INTEGER) = dtypeName(FB_DATATYPE_LONG)
		dtypeName(FB_DATATYPE_UINT   ) = dtypeName(FB_DATATYPE_ULONG)
	end if
end sub

private sub _end( )
	irhlEnd( )
end sub

private sub hWriteLine( byref ln as string )
	if( (ctx.indent > 0) andalso (len( ln ) > 0) ) then
		ln = string( ctx.indent, TABCHAR ) + ln
	end if

	ln += NEWLINE

	'' Write it out to the current section
	select case as const( ctx.section )
	case SECTION_HEAD
		ctx.head_txt += ln
	case SECTION_BODY
		ctx.body_txt += ln
	case SECTION_FOOT
		ctx.foot_txt += ln
	end select
end sub

private sub hInternalCommand( byref message as string )
	hWriteLine( "; " + message )
end sub

private sub hAstCommand( byref message as string )
	hWriteLine( "" )
	hInternalCommand( message )
end sub

private sub hWriteLabel( byval id as zstring ptr )
	ctx.indent -= 1
	hWriteLine( *id + ":" )
	ctx.indent += 1
end sub

private function hSymName( byval sym as FBSYMBOL ptr ) as string
	if( sym->id.alias ) then
		function = *sym->id.alias
	else
		function = *symbGetName( sym )
	end if
end function

private function vregPretty( byval v as IRVREG ptr ) as string
	dim s as string

	select case( v->typ )
	case IR_VREGTYPE_IMM
		if( typeGetClass( v->dtype ) = FB_DATACLASS_FPOINT ) then
			s = str( v->value.f )
		else
			s = str( v->value.i )
		end if

	case IR_VREGTYPE_REG
		if( v->sym ) then
			s = hSymName( v->sym )
		else
			s = "vr" & v->reg
		end if

	case else
		if( v->sym ) then
			s = hSymName( v->sym )
		end if
	end select

	if( v->vidx ) then
		if( len( s ) > 0 ) then
			s += "+"
		end if
		s += vregPretty( v->vidx )
	end if
	if( v->ofs ) then
		s += "+" & v->ofs
	end if
	if( v->mult ) then
		s += "*" & v->mult
	end if

	's += " " + typeDumpToStr( v->dtype, v->subtype )

	function = s
end function

private function hEmitParamName( byval sym as FBSYMBOL ptr ) as string
	function = *symbGetMangledName( sym ) + "$"
end function

private function hEmitProcCallConv( byval proc as FBSYMBOL ptr ) as string
	'' Calling convention
	'' - default if none specified is Cdecl as in C
	'' - must be given on the declaration, on the body,
	''   and on each CALL instruction
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

	if( fbGetCpuFamily( ) <> FB_CPUFAMILY_X86 ) then
		exit function
	end if

	select case as const( symbGetProcMode( proc ) )
	case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS, FB_FUNCMODE_PASCAL
		function = "x86_stdcallcc "
	case FB_FUNCMODE_THISCALL
		function = "x86_thiscall "
	case FB_FUNCMODE_FASTCALL
		function = "x86_fastcall "
	end select
end function

private function hEmitProcHeader _
	( _
		byval proc as FBSYMBOL ptr, _
		byval is_proto as integer, _
		byval is_type as integer _
	) as string

	dim as string ln
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	assert( symbIsProc( proc ) )

	ln += hEmitProcCallConv( proc )

	'' Function result type (is 'void' for subs)
	ln += hEmitType( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), _
				symbGetProcRealSubtype( proc ) )

	ln += " "

	if( is_type = FALSE ) then
		'' @id
		ln += *symbGetMangledName( proc )
	end if

	'' Parameter list
	ln += "( "

	'' If returning a struct, there's an extra parameter
	dim as FBSYMBOL ptr hidden = NULL
	if( symbProcReturnsOnStack( proc ) ) then
		if( is_proto ) then
			hidden = symbGetSubType( proc )
			ln += hEmitType( typeAddrOf( symbGetType( hidden ) ), hidden )
		else
			hidden = proc->proc.ext->res
			ln += hEmitType( typeAddrOf( symbGetType( hidden ) ), symbGetSubtype( hidden ) )
			ln += " " + hEmitParamName( hidden )
		end if

		if( symbGetProcParams( proc ) > 0 ) then
			ln += ", "
		end if
	end if

	var param = symbGetProcLastParam( proc )
	while( param )
		if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
			ln += "..."
		else
			symbGetRealParamDtype( param, dtype, subtype )
			ln += hEmitType( dtype, subtype )

			if( is_proto = FALSE ) then
				'' Proc body? Emit the mangled name of the param var
				'' (the param itself isn't mangled)
				ln += " " + hEmitParamName( symbGetParamVar( param ) )
			end if
		end if

		param = symbGetProcPrevParam( proc, param )
		if( param ) then
			ln += ", "
		end if
	wend

	ln += " )"

	if( is_type = FALSE ) then
		'' Function attributes
		'' TODO: clang emits this for C code, seems good for us too, but if
		'' there will be exceptions, this must be removed...
		ln += " nounwind"

		if( proc->pattrib and FB_PROCATTRIB_NAKED ) then
			ln += " naked"
		end if
	end if

	function = ln
end function

private function hGetUDTName( byval sym as FBSYMBOL ptr ) as string
	dim as FBSYMBOL ptr ns = symbGetNamespace( sym )

	var s = "%"
	do until( ns = @symbGetGlobalNamespc( ) )
		s += *symbGetName( ns )
		s += "."
		ns = symbGetNamespace( ns )
	loop

	if( sym->id.alias <> NULL ) then
		s += *sym->id.alias
	else
		s += *symbGetName( sym )
	end if

	function = s
end function

private sub hEmitUDT( byval s as FBSYMBOL ptr )
	if( s = NULL ) then
		return
	end if

	if( symbGetIsEmitted( s ) ) then
		return
	end if

	var oldsection = ctx.section
	if( symbIsLocal( s ) = FALSE ) then
		ctx.section = SECTION_HEAD
	end if

	select case as const( symbGetClass( s ) )
	case FB_SYMBCLASS_ENUM
		symbSetIsEmitted( s )
		'' no subtype, to avoid infinite recursion
		hWriteLine( hGetUDTName( s ) + " = type " + hEmitType( FB_DATATYPE_ENUM, NULL ) )

	case FB_SYMBCLASS_STRUCT
		hEmitStruct( s )

	end select

	ctx.section = oldsection
end sub

private sub hBuildStrLit _
	( _
		byref ln as string, _
		byval wantedlength as integer, _ '' including null terminator
		byval z as zstring ptr, _
		byval length as integer _        '' ditto
	)

	dim as integer ch = any

	'' Convert the string to LLVM IR format
	'' (assuming internal escape sequences have already been solved out
	'' using hUnescape())
	''
	'' clang turns
	''    "a\0\\\n"
	'' into
	''    [5 x i8] c"a\00\5C\0A\00", align 1
	''
	'' \0 doesn't work, it must be two digits as in \00.

	'' String literal too long?
	if( length > wantedlength ) then
		'' Cut off; may be empty afterwards
		length = wantedlength
	end if

	for i as integer = 0 to length - 1
		ch = (*z)[i]
		'' chars like a-zA-Z0-9 can be emitted literally,
		'' but special chars (including '\') should be encoded in hex
		if( hCharNeedsEscaping( ch, asc( """" ) ) ) then
			'' emit in \XX escape form
			ln += $"\" + hex( ch, 2 )
		else
			'' emit as-is
			ln += chr( ch )
		end if
	next

	'' Pad with zeroes if string literal too short
	while( length < wantedlength )
		ln += $"\00"
		length += 1
	wend
end sub

private sub hBuildWstrLit _
	( _
		byref ln as string, _
		byval wantedlength as integer, _  '' including null terminator
		byval w as wstring ptr, _
		byval length as integer _         '' ditto
	)

	dim as uinteger ch = any, wcharsize = any

	'' (ditto)
	''
	'' clang turns
	''    L"a\0\\\n"
	'' into
	''    [20 x i8] c"a\00\00\00\00\00\00\00\5C\00\00\00\0A\00\00\00\00\00\00\00", align 4
	'' (with Linux 4-byte wchar_t)

	wcharsize = typeGetSize( FB_DATATYPE_WCHAR )

	'' String literal too long?
	if( length > wantedlength ) then
		'' Cut off; may be empty afterwards
		length = wantedlength
	end if

	for i as integer = 0 to length - 1
		ch = (*w)[i]
		'' (ditto)
		if( hCharNeedsEscaping( ch, asc( """" ) ) ) then
			if( wcharsize >= 1 ) then
				ln += $"\" + hex( (ch       ) and &hFF, 2 )
			end if
			if( wcharsize >= 2 ) then
				ln += $"\" + hex( (ch shr  8) and &hFF, 2 )
			end if
			if( wcharsize >= 4 ) then
				ln += $"\" + hex( (ch shr 16) and &hFF, 2 )
				ln += $"\" + hex( (ch shr 24) and &hFF, 2 )
			end if
		else
			ln += chr( ch )
			'' Pad up to wchar_t size
			for j as integer = 2 to wcharsize
				ln += $"\00"
			next
		end if
	next

	'' Pad with zeroes if string literal too short
	while( length < wantedlength )
		'' Pad up to wchar_t size
		for j as integer = 1 to wcharsize
			ln += $"\00"
		next
		length += 1
	wend
end sub

private function hEmitStrLitType( byval length as integer ) as string
	function = "[" + str( length ) + " x i8]"
end function

private function hEmitSymType( byval sym as FBSYMBOL ptr ) as string
	dim s as string

	var dtype = symbGetType( sym )
	if( symbIsRef( sym ) ) then
		s = hEmitType( typeAddrOf( dtype ), sym->subtype )
	else
		select case( dtype )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			s = hEmitStrLitType( sym->lgt )
		case else
			s = hEmitType( dtype, sym->subtype )
		end select
	end if

	if( symbGetIsDynamic( sym ) ) then
		'' Dynamic array vars/fields/params
		'' TODO: emit descriptor type instead of array element type!?
	else
		select case( symbGetClass( sym ) )
		case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
			'' Fixed-size array vars/fields
			''    (0 to 9) as long            =>   [10 x i32]
			''    (0 to 9, 0 to 19) as long   =>   [10 x [20 x i32]]
			for i as integer = symbGetArrayDimensions( sym ) - 1 to 0 step -1
				var elements = symbArrayUbound( sym, i ) - symbArrayLbound( sym, i ) + 1
				s = "[" & elements & " x " + s + "]"
			next
		end select
	end if

	function = s
end function

private sub hEmitVariable( byval sym as FBSYMBOL ptr )
	dim as string ln
	dim as integer is_global = any, length = any

	'' literal?
	if( symbGetIsLiteral( sym ) ) then
		if( symbGetIsAccessed( sym ) = FALSE ) then
			exit sub
		end if

		select case( symbGetType( sym ) )
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			'' string literals are emitted as global char arrays,
			'' this also means a bitcast to char pointer is needed
			'' on every use of the global symbol.
			ln = *symbGetMangledName( sym ) + " = "
			ln += "private constant "
			ln += hEmitSymType( sym )
			ln += " c"""
			if( symbGetType( sym ) = FB_DATATYPE_WCHAR ) then
				length = symbGetWstrLen( sym )
				hBuildWstrLit( ln, length, hUnescapeW( symbGetVarLitTextW( sym ) ), length )
			else
				length = symbGetStrLen( sym )
				hBuildStrLit( ln, length, hUnescape( symbGetVarLitText( sym ) ), length )
			end if
			ln += """"
			hWriteLine( ln )
		case else
			'' float constants are handled as "literals",
			'' at least under the ASM backend
		end select

		exit sub
	end if

	'' initialized? only if not local or local and static
	if( (symbGetTypeIniTree( sym ) <> NULL) and (symbIsLocal( sym ) = FALSE or symbIsStatic( sym )) ) then
		'' never referenced?
		if( symbIsLocal( sym ) = FALSE ) then
			if( symbGetIsAccessed( sym ) = FALSE ) then
				'' not public?
				if( symbIsPublic( sym ) = FALSE ) then
					exit sub
				end if
			end if
		end if

		irhlFlushStaticInitializer( sym )
		exit sub
	end if

	'' dynamic? only the array descriptor is emitted
	if( symbGetIsDynamic( sym ) ) then
		exit sub
	end if

	is_global = symbGetAttrib( sym ) and _
			(FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or _
			FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_STATIC or _
			FB_SYMBATTRIB_SHARED)

	'' Global var:
	''    @sym = global <type> <initvalue>
	'' Stack var:
	''    %sym = alloca <type>
	ln = *symbGetMangledName( sym )
	ln += " = "
	if( is_global ) then
		ln += "global"
	else
		ln += "alloca"
	end if
	ln += " " + hEmitSymType( sym )
	if( is_global ) then
		'' Globals without initializer are zeroed in FB
		ln += " zeroinitializer"
	end if
	hWriteLine( ln )
end sub

private sub hMaybeEmitGlobalVar( byval sym as FBSYMBOL ptr )
	'' Skip DATA descriptor arrays here, they're handled by irForEachDataStmt()
	if( symbIsDataDesc( sym ) = FALSE ) then
		hEmitVariable( sym )
	end if
end sub

private sub hMaybeEmitProcProto( byval s as FBSYMBOL ptr )
	if( symbGetIsFuncPtr( s ) or (not symbGetIsAccessed( s )) ) then
		exit sub
	end if

	if( symbGetMangledName( s ) = NULL ) then
		exit sub
	end if

	'' Only declare functions that won't be defined (don't have a body),
	'' llc doesn't seem to allow DECLARE+DEFINE with the same id
	if( symbGetIsParsed( s ) ) then
		exit sub
	end if

	var oldsection = ctx.section
	ctx.section = SECTION_HEAD
	hWriteLine( "declare " + hEmitProcHeader( s, TRUE, FALSE ) )
	ctx.section = oldsection
end sub

private sub hEmitStruct( byval s as FBSYMBOL ptr )
	dim as FBSYMBOL ptr fld = any

	''
	'' Already emitting this UDT currently? This means there is a circular
	'' dependency between this UDT and one (or multiple) other UDT(s).
	'' Note: LLVM IR doesn't seem to require explicit declaration of
	'' forward references, clang for example generates code like:
	''
	''    %struct.T = type { %struct.T* }
	''    %struct.XX = type { %struct.YY* }
	''    %struct.YY = type { %struct.XX }
	''
	'' On top of that, it seems to be possible to forward reference
	'' structures even directly and not by pointer:
	''
	''    %struct.XX = type { %struct.T }
	''    %struct.T = type { %struct.T* }
	''
	'' ... as long as the type will be fully declared before its first use
	'' in a function/variable declaration etc. This makes UDT emitting
	'' pretty easy compared to the C backend.
	''
	if( symbGetIsBeingEmitted( s ) ) then
		return
	end if

	symbSetIsBeingEmitted( s )

	'' Check every field for non-emitted subtypes
	fld = symbUdtGetFirstField( s )
	while( fld )
		hEmitUDT( symbGetSubtype( fld ) )
		fld = symbUdtGetNextField( fld )
	wend

	'' Was it emitted in the mean time? (maybe one of the fields did that)
	if( symbGetIsEmitted( s ) ) then
		return
	end if

	'' We'll emit it now.
	symbSetIsEmitted( s )

	dim as string ln

	'' UDT name
	if( symbGetName( s ) ) then
		ln += hGetUDTName( s )
	else
		ln += "%" + *symbUniqueId( )
	end if

	var packed = (s->udt.align = 1)

	ln += " = type "
	if( packed ) then ln += "<"
	ln += "{ "

	'' Write out the elements
	fld = symbUdtGetFirstField( s )
	while( fld )

		'' Don't emit fake dynamic array fields
		if( symbIsDynamic( fld ) = FALSE ) then
			ln += hEmitSymType( fld )
		end if

		fld = symbUdtGetNextField( fld )
		if( fld ) then
			ln += ", "
		end if
	wend

	'' Close UDT body
	ln += " }"
	if( packed ) then ln += ">"

	hWriteLine( ln )

	symbResetIsBeingEmitted( s )
end sub

private sub hEmitCtorDtorArrayElement _
	( _
		byval proc as FBSYMBOL ptr, _
		byref s as string _
	)

	if( len( s ) > 0 ) then
		s += ", "
	end if

	s += "{ i32, void ()* } { i32 "
	s += str( symbGetProcPriority( proc ) )
	s += ", void ()* "
	s += *symbGetMangledName( proc )
	s += " }"

end sub

private sub hAddGlobalCtorDtor( byval proc as FBSYMBOL ptr )
	if( symbGetIsFuncPtr( proc ) ) then
		exit sub
	end if

	if( symbGetIsGlobalCtor( proc ) ) then
		ctx.ctorcount += 1
		hEmitCtorDtorArrayElement( proc, ctx.ctors )
	elseif( symbGetIsGlobalDtor( proc ) ) then
		ctx.dtorcount += 1
		hEmitCtorDtorArrayElement( proc, ctx.dtors )
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

	ctx.indent = 0
	ctx.ctors = ""
	ctx.dtors = ""
	ctx.ctorcount = 0
	ctx.dtorcount = 0
	ctx.head_txt = ""
	ctx.body_txt = ""
	ctx.foot_txt = ""
	ctx.linenum = 0
	ctx.section = SECTION_HEAD

	for i as integer = 0 to BUILTIN__COUNT-1
		builtins(i).used = FALSE
	next

	if( env.clopt.debuginfo ) then
		_emitDBG( AST_OP_DBG_LINEINI, NULL, 0 )
	end if

	if( fbIs64bit( ) ) then
		hWriteLine( "%FBSTRING = type { i8*, i64, i64 }" )
	else
		hWriteLine( "%FBSTRING = type { i8*, i32, i32 }" )
	end if

	ctx.section = SECTION_BODY

	function = TRUE
end function

private sub _emitEnd( )
	'' Append global declarations to the header section.
	'' This must be done during _emitEnd() instead of _emitBegin() because
	'' _emitBegin() is called even before any input code is parsed.
	ctx.section = SECTION_HEAD

	for i as integer = 0 to BUILTIN__COUNT-1
		if( builtins(i).used ) then
			hWriteLine( *builtins(i).decl )
		end if
	next

	'' Emit proc decls first (because of function pointer initializers referencing procs)
	hWriteLine( "" )
	symbForEachGlobal( FB_SYMBCLASS_PROC, @hMaybeEmitProcProto )

	'' Then the variables
	hWriteLine( "" )
	symbForEachGlobal( FB_SYMBCLASS_VAR, @hMaybeEmitGlobalVar )

	'' DATA array initializers can reference globals by taking their address,
	'' so they must be emitted after the other global declarations.
	irForEachDataStmt( @hEmitVariable )

	'' Global arrays for global ctors/dtors
	symbForEachGlobal( FB_SYMBCLASS_PROC, @hAddGlobalCtorDtor )
	if( ctx.ctorcount > 0 ) then
		hWriteLine( "@llvm.global_ctors = appending global [" & ctx.ctorcount & " x { i32, void ()* }] [" + ctx.ctors + "]" )
	end if
	if( ctx.dtorcount > 0 ) then
		hWriteLine( "@llvm.global_dtors = appending global [" & ctx.dtorcount & " x { i32, void ()* }] [" + ctx.dtors + "]" )
	end if

	ctx.section = SECTION_FOOT

	' flush all sections to file
	if( put( #env.outf.num, , ctx.head_txt ) <> 0 ) then
	end if
	if( put( #env.outf.num, , ctx.body_txt ) <> 0 ) then
	end if
	if( put( #env.outf.num, , ctx.foot_txt ) <> 0 ) then
	end if

	if( close( #env.outf.num ) <> 0 ) then
		'' ...
	end if

	env.outf.num = 0
end sub

private function _getOptionValue( byval opt as IR_OPTIONVALUE ) as integer
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

	'' These aren't available as llvm.*() built-ins:
	select case as const( op )
	case AST_OP_SGN, AST_OP_FIX, AST_OP_FRAC, _
	     AST_OP_ASIN, AST_OP_ACOS, AST_OP_TAN, AST_OP_ATAN, _
	     AST_OP_RSQRT, AST_OP_RCP
		function = FALSE

	case AST_OP_ABS
		'' There is @llvm.fabs.* for floats, but no @llvm.abs.* for integers
		function = (typeGetClass( dtype ) = FB_DATACLASS_FPOINT)

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

private sub _procAllocArg( byval proc as FBSYMBOL ptr, byval sym as FBSYMBOL ptr )
	dim as string ln

	hAstCommand( "paramvar " + hSymName( sym ) )

	''
	'' Load the parameter values into local stack vars, to support taking
	'' the address of the parameters on stack.
	''
	'' This means there are two symbols per parameter:
	''    - the parameter value in the procedure header
	''    - the alloca operation representing the stack var
	'' they must use different names to avoid collision.
	''

	dim dtype as integer
	dim subtype as FBSYMBOL ptr
	symbGetRealType( sym, dtype, subtype )

	'' %myparam = alloca type
	ln = *symbGetMangledName( sym ) + " = alloca "
	ln += hEmitType( dtype, subtype )
	hWriteLine( ln )

	'' store type %myparam$, type* %myparam
	ln = "store "
	ln += hEmitType( dtype, subtype ) + " " + hEmitParamName( sym )
	ln += ", "
	ln += hEmitType( typeAddrOf( dtype ), subtype ) + " " + *symbGetMangledName( sym )
	hWriteLine( ln )
end sub

private sub _procAllocLocal( byval proc as FBSYMBOL ptr, byval sym as FBSYMBOL ptr )
	hAstCommand( "localvar " + hSymName( sym ) )
	hEmitVariable( sym )
end sub

private sub _scopeBegin( byval s as FBSYMBOL ptr )
end sub

private sub _scopeEnd( byval s as FBSYMBOL ptr )
end sub

private sub _procAllocStaticVars(byval head_sym as FBSYMBOL ptr)
	/' do nothing '/
end sub

private sub _setVregDataType _
	( _
		byval v as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	dim as IRVREG ptr temp0 = any

	if( (v->dtype <> dtype) or (v->subtype <> subtype) ) then
		temp0 = irhlAllocVreg( dtype, subtype )
		hEmitConvert( temp0, v )
		*v = *temp0
	end if

end sub

private sub hAddOffset _
	( _
		byval v as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as longint _
	)

	'' voffset = ptrtoint l
	var voffset = irhlAllocVreg( FB_DATATYPE_INTEGER, NULL )
	hEmitConvert( voffset, v )

	if( ofs <> 0 ) then
		'' voffset += <offset>
		'' (implemented as normal BOP, not self-BOP, because we
		'' can't do self-BOPs on REGs)
		var vimmoffset = irhlAllocVrImm( FB_DATATYPE_INTEGER, NULL, ofs )
		var vnewoffset = irhlAllocVreg( FB_DATATYPE_INTEGER, NULL )
		hEmitBop( AST_OP_ADD, voffset, vimmoffset, vnewoffset, NULL )
		voffset = vnewoffset
	end if

	'' voffset = inttoptr voffset
	_setVregDataType( voffset, dtype, subtype )

	*v = *voffset
end sub

private sub hPrepareAddress( byval v as IRVREG ptr )
	assert( (v->typ = IR_VREGTYPE_VAR) or _
		(v->typ = IR_VREGTYPE_OFS) or _
		(v->typ = IR_VREGTYPE_IDX) or _
		(v->typ = IR_VREGTYPE_PTR) )

	'' VAR - local var access
	'' OFS - global symbol access
	'' IDX - local array indexing
	'' PTR - derefs
	''
	'' In LLVM, references to local/global vars are pointers (addresses)
	'' implicitly, so we turn such vregs into pointers (without having to do
	'' addrof operations), for use with LLVM's load/store operations, which
	'' take addresses, not the memory itself.
	''
	'' If there is an offset or index, it must be added on top of the
	'' base address.

	var addrdtype = v->dtype
	var addrsubtype = v->subtype
	var ofs = v->ofs
	var vidx = v->vidx
	var sym = v->sym

	'' OFS vregs already have pointer type, but others don't
	if( v->typ = IR_VREGTYPE_OFS ) then
		assert( typeIsPtr( addrdtype ) )
	else
		addrdtype = typeAddrOf( addrdtype )
	end if

	if( irIsPTR( v ) ) then
		assert( irIsREG( vidx ) )
		*v = *vidx
	else
		v->typ = IR_VREGTYPE_REG
		v->reg = INVALID
		''v->sym = NULL  '' leaving this for use by hVregToStr()
		v->ofs = 0
		v->vidx = NULL

		if( sym ) then
			symbGetRealType( sym, v->dtype, v->subtype )

			'' vreg is the address of the memory allocated for the sym
			v->dtype = typeAddrOf( v->dtype )

			'' May need to cast from symbol's type to vreg's type (e.g. for field accesses)
			_setVregDataType( v, addrdtype, addrsubtype )
		else
			v->dtype = addrdtype
			v->subtype = addrsubtype
		end if
	end if

	'' TODO: handle vidx too
	if( (vidx <> NULL) or (ofs <> 0) ) then
		hAddOffset( v, addrdtype, addrsubtype, ofs )
	end if
end sub

private sub hLoadVreg( byval v as IRVREG ptr )
	'' LLVM instructions take registers or immediates (including offsets,
	'' i.e. addresses of globals/procedures),
	'' anything else must be loaded into a register first.
	'' (register in LLVM just means a <%N = insn ...> temporary value)

	select case( v->typ )
	case IR_VREGTYPE_REG, IR_VREGTYPE_IMM
		'' Ok as-is, no loading needed

	case IR_VREGTYPE_OFS
		'' global symbol address, no loading needed
		'' (not even an explicit addrof is needed, since symbol
		'' references are pointers implicitly)
		''
		'' with offset:
		''    %0 = ptrtoint foo* @global to i32
		''    %1 = add i32 %0, i32 <offset>
		''    %2 = inttoptr i32 %1 to foo*
		''
		'' without offset:
		'' (no "loading" necessary, handled purely in hVregToStr())
		''    @global
		hPrepareAddress( v )

	case else
		'' memory accesses: stack/global vars, arrays, ptr derefs
		'' Get the address and then load the value stored there.
		hPrepareAddress( v )
		assert( typeIsPtr( v->dtype ) )
		var temp0 = irhlAllocVreg( typeDeref( v->dtype ), v->subtype )
		var s = hVregToStr( temp0 ) + " = load "
		s += hEmitType( typeDeref( v->dtype ), v->subtype ) + ", "
		s += hEmitType( v->dtype, v->subtype ) + " "
		s += hVregToStr( v )
		hWriteLine( s )
		*v = *temp0
	end select
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
	case FB_DATATYPE_VOID
		'' "void*" isn't allowed in LLVM IR, "i8*" must be used instead,
		'' that's why FB_DATATYPE_VOID is mapped to "i8" in the above
		'' table. "void" can only be used for subs.
		if( ptrcount = 0 ) then
			s = "void"
		else
			s = *dtypeName(FB_DATATYPE_VOID)
		end if

	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		if( subtype ) then
			hEmitUDT( subtype )
			s = hGetUdtName( subtype )
		elseif( dtype = FB_DATATYPE_ENUM ) then
			s = *dtypeName(typeGetRemapType( dtype ))
		else
			s = *dtypeName(FB_DATATYPE_VOID)
		end if

	case FB_DATATYPE_FUNCTION
		assert( ptrcount > 0 )
		ptrcount -= 1
		s = hEmitProcHeader( subtype, TRUE, TRUE ) + "*"

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

private function hEmitInt _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as integer _
	) as string

	dim as string s

	select case( dtype )
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
	     FB_DATATYPE_ENUM
		'' It seems like llc doesn't care whether we emit -1 or
		'' 4294967295, it's the bit pattern that matters.
		s = str( value )

	case else
		'' cast the i32 constant to pointer/byte/short type
		'' <castop> (i32 <n> to <type>)
		if( typeIsPtr( dtype ) ) then
			s = "inttoptr "
		else
			s = "trunc "
		end if
		s += "("
		s += hEmitType( FB_DATATYPE_INTEGER, NULL ) + " " + str( value )
		s += " to " + hEmitType( dtype, subtype )
		s += ")"
	end select

	function = s
end function

private function hEmitLong( byval value as longint ) as string
	function = str( value )
end function

private function hEmitFloat( byval value as double ) as string
	'' Single/double float constants can be emitted as decimals or
	'' as raw bytes in 0x hex notation with 16 digits (even singles must
	'' be emitted as doubles, i.e. 16 hex digits, according to the LangRef).
	'' We always use the raw hex form, that avoids any rounding issues
	'' or errors with the decimals...
	function = "0x" + hex( *cptr( ulongint ptr, @value ), 16 )
end function

private function hIsFixLenStr( byval sym as FBSYMBOL ptr ) as integer
	if( symbIsVar( sym ) ) then
		select case( symbGetType( sym ) )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return TRUE
		end select
	end if
	return FALSE
end function

private function hVregToStr( byval v as IRVREG ptr ) as string
	select case as const( v->typ )
	case IR_VREGTYPE_IMM
		if( typeGetClass( v->dtype ) = FB_DATACLASS_FPOINT ) then
			return hEmitFloat( v->value.f )
		end if
		if( typeGetSize( v->dtype ) = 8 ) then
			return hEmitLong( v->value.i )
		end if
		return hEmitInt( v->dtype, v->subtype, v->value.i )

	case IR_VREGTYPE_REG
		'' Normally REGs will have their reg field set, but if
		'' hPrepareAddress() left the sym intact, we're supposed to use
		'' that instead.
		if( v->sym = NULL ) then
			return "%vr" + str( v->reg )
		end if
	end select

	var sym = v->sym

	'' If accessing global fixed-length strings (including string literals)
	'' we have to add an inline type cast, because for example the symbol
	'' reference will be "[10 x i8]*", but we want to have "i8*" instead.
	if( hIsFixLenStr( sym ) ) then
		var s = "bitcast ("
		s += hEmitSymType( sym ) + "* "
		s += *symbGetMangledName( sym )
		s += " to "
		s += hEmitType( typeAddrOf( symbGetType( sym ) ), NULL )
		s += ")"
		return s
	end if

	return *symbGetMangledName( sym )
end function

private sub _emitLabel( byval label as FBSYMBOL ptr )
	hAstCommand( "label " + hSymName( label ) )

	'' end current basic block
	hWriteLine( "br label %" + *symbGetMangledName( label ) )

	'' and start the next one
	hWriteLabel( symbGetMangledName( label ) )
end sub

private function hGetBopCode _
	( _
		byval op as integer, _
		byval dtype as integer _
	) as zstring ptr

	select case as const( op )
	case AST_OP_ADD
		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			function = @"fadd"
		else
			function = @"add"
		end if
	case AST_OP_SUB
		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			function = @"fsub"
		else
			function = @"sub"
		end if
	case AST_OP_MUL
		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			function = @"fmul"
		else
			function = @"mul"
		end if
	case AST_OP_DIV
		function = @"fdiv"
	case AST_OP_INTDIV
		function = @"sdiv"
	case AST_OP_MOD
		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			function = @"frem"
		else
			function = @"srem"
		end if
	case AST_OP_SHL
		function = @"shl"
	case AST_OP_SHR
		function = @"ashr"
	case AST_OP_AND
		function = @"and"
	case AST_OP_OR
		function = @"or"
	case AST_OP_XOR
		function = @"xor"
	case AST_OP_EQ
		function = @"icmp eq"
	case AST_OP_NE
		function = @"icmp ne"
	case AST_OP_GT
		function = @"icmp sgt"
	case AST_OP_LT
		function = @"icmp slt"
	case AST_OP_GE
		function = @"icmp sge"
	case AST_OP_LE
		function = @"icmp sle"
	case AST_OP_EQV
		'' TODO: vr = not (v1 xor v2)
		function = @"eqv"
	case AST_OP_IMP
		'' TODO: vr =  (not v1) or v2
		function = @"imp"

	end select

end function

private sub hLoadOperandsAndWriteBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( v2 )
	_setVregDataType( v1, dtype, subtype )
	_setVregDataType( v2, dtype, subtype )

	var ln = hVregToStr( vr )
	ln += " = "
	ln += *hGetBopCode( op, dtype )
	ln += " "
	ln += hEmitType( dtype, subtype )
	ln += " "
	ln += hVregToStr( v1 )
	ln += ", "
	ln += hVregToStr( v2 )
	hWriteLine( ln )

end sub

private sub hEmitBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval label as FBSYMBOL ptr _
	)

	'' Conditional branch?
	if( label ) then
		assert( vr = NULL )
		vr = irhlAllocVreg( FB_DATATYPE_INTEGER, NULL )

		'' condition = comparison expression
		hLoadOperandsAndWriteBop( op, v1, v2, vr, v1->dtype, v1->subtype )

		'' The conditional branch in LLVM always needs both
		'' true and false labels, to keep the proper basic
		'' block semantics up.
		'' true label = the label given through the BOP,
		'' false label = the code right behind the branch

		'' branch condition, truelabel, falselabel
		var falselabel = *symbUniqueLabel( )
		var ln = "br i1 " + hVregToStr( vr )
		ln += ", "
		ln += "label %" + *symbGetMangledName( label )
		ln += ", "
		ln += "label %" + falselabel
		hWriteLine( ln )

		'' falselabel:
		hWriteLabel( falselabel )
		exit sub
	end if

	var isself = FALSE
	dim v1orig as IRVREG

	if( vr = NULL ) then
		'' v1 bop= b2
		''
		'' Self-BOP - have to allocate a vr manually and store that
		'' into v1 later, because LLVM IR doesn't have self-BOPs.
		''
		'' Also, we have to preserve the "storable" version of v1 - as
		'' a BOP operand it may loaded, turning it into a REG,
		'' but for the store we need the original VAR etc.
		isself = TRUE
		vr = irhlAllocVreg( v1->dtype, v1->subtype )
		v1orig = *v1
	end if

	hLoadOperandsAndWriteBop( op, v1, v2, vr, vr->dtype, vr->subtype )

	'' LLVM comparison ops return i1, but we usually want i32,
	'' so do an sign-extending cast (i1 -1 to i32 -1).
	if( astOpIsRelational( op ) ) then
		var vtemp = irhlAllocVreg( vr->dtype, vr->subtype )
		var ln = hVregToStr( vtemp )
		ln += " = sext "
		ln += "i1 " + hVregToStr( vr )
		ln += " to "
		ln += hEmitType( vr->dtype, vr->subtype )
		hWriteLine( ln )
		*vr = *vtemp
	end if

	'' store self-BOP result
	if( isself ) then
		hEmitStore( @v1orig, vr )
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

	var bopdump = vregPretty( v1 ) + " " + astDumpOpToStr( op ) + " " + vregPretty( v2 )
	if( label ) then
		hAstCommand( "branchbop " + bopdump )
	elseif( vr = NULL ) then
		hAstCommand( "selfbop " + bopdump )
	else
		hAstCommand( "bop " + bopdump )
	end if

	hEmitBop( op, v1, v2, vr, label )

end sub

private sub hBuiltInUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	dim as string ln

	hLoadVreg( v1 )

	ln = hVregToStr( vr ) + " = call "

	if( v1->dtype = FB_DATATYPE_SINGLE ) then
		ln += "float @llvm."
		select case( op )
		case AST_OP_ABS : builtins(BUILTIN_ABSF).used = TRUE : ln += "fabs"
		case AST_OP_SIN : builtins(BUILTIN_SINF).used = TRUE : ln += "sin"
		case AST_OP_COS : builtins(BUILTIN_COSF).used = TRUE : ln += "cos"
		case AST_OP_EXP : builtins(BUILTIN_EXPF).used = TRUE : ln += "exp"
		case AST_OP_LOG : builtins(BUILTIN_LOGF).used = TRUE : ln += "log"
		case AST_OP_SQRT : builtins(BUILTIN_SQRTF).used = TRUE : ln += "sqrt"
		case AST_OP_FLOOR : builtins(BUILTIN_FLOORF).used = TRUE : ln += "floor"
		case else : assert( FALSE )
		end select
		ln += ".f32(float "
	else
		assert( v1->dtype = FB_DATATYPE_DOUBLE )
		ln += "double @llvm."
		select case( op )
		case AST_OP_ABS : builtins(BUILTIN_ABS).used = TRUE : ln += "fabs"
		case AST_OP_SIN : builtins(BUILTIN_SIN).used = TRUE : ln += "sin"
		case AST_OP_COS : builtins(BUILTIN_COS).used = TRUE : ln += "cos"
		case AST_OP_EXP : builtins(BUILTIN_EXP).used = TRUE : ln += "exp"
		case AST_OP_LOG : builtins(BUILTIN_LOG).used = TRUE : ln += "log"
		case AST_OP_SQRT : builtins(BUILTIN_SQRT).used = TRUE : ln += "sqrt"
		case AST_OP_FLOOR : builtins(BUILTIN_FLOOR).used = TRUE : ln += "floor"
		case else : assert( FALSE )
		end select
		ln += ".f64(double "
	end if

	ln += hVregToStr( v1 ) + ")"
	hWriteLine( ln )

end sub

private sub _emitUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	var uopdump = astDumpOpToStr( op ) + " " + vregPretty( v1 )
	if( vr = NULL ) then
		hAstCommand( "selfuop " + uopdump )
	else
		hAstCommand( "uop " + uopdump )
	end if

	'' LLVM IR doesn't have unary operations, corresponding BOPs are
	'' supposed to be used instead. However there are built-in functions
	'' for sin() & co.
	select case( op )
	case AST_OP_NEG
		'' vr = 0 - v1

		dim v1orig as IRVREG

		var isself = FALSE
		if( vr = NULL ) then
			'' Self-UOP
			''
			'' Need to allocate a result REG manually and then store
			'' that into v1 later.
			''
			'' Unfortunately we can't let hEmitBop() handle this,
			'' because in case of a self-BOP it expects the lhs to
			'' be the variable, while here it's the rhs. So we need
			'' to do it manually, by always using a non-self-BOP.
			''
			'' Also, just like hEmitBop(), we have to preserve the
			'' "storable" version of v1, because hEmitBop() may
			'' overwrite it with the loaded version.
			isself = TRUE
			vr = irhlAllocVreg( v1->dtype, v1->subtype )
			v1orig = *v1
		end if

		var zero = irhlAllocVrImm( FB_DATATYPE_INTEGER, NULL, 0 )
		hEmitBop( AST_OP_SUB, zero, v1, vr, NULL )

		if( isself ) then
			hEmitStore( @v1orig, vr )
		end if

	case AST_OP_NOT
		'' vr = v1 xor -1

		'' Just pass on as BOP. Works even for self-UOPs, as v1 will be
		'' the lhs of the self-BOP as expected by hEmitBop().
		var minusone = irhlAllocVrImm( FB_DATATYPE_INTEGER, NULL, -1 )
		hEmitBop( AST_OP_XOR, v1, minusone, vr, NULL )

	case else
		hBuiltInUop( op, v1, vr )
	end select

end sub

private function hGetConvOpCode( byval ldtype as integer, byval rdtype as integer ) as zstring ptr
	if( typeGetClass( ldtype ) = FB_DATACLASS_FPOINT ) then
		if( typeGetClass( rdtype ) = FB_DATACLASS_FPOINT ) then

			'' same size? i.e. due to const -> non-const, then no convert
			if( typeGetSize( ldtype ) = typeGetSize( rdtype ) ) then
				return NULL
			end if

			'' float to float (i.e. single <-> double)
			return iif( typeGetSize( ldtype ) < typeGetSize( rdtype ), @"fptrunc", @"fpext" )
		end if

		'' int to float
		return iif( typeIsSigned( rdtype ), @"sitofp", @"uitofp" )
	end if

	if( typeGetClass( rdtype ) = FB_DATACLASS_FPOINT ) then
		'' float to int (rounding was taken care of above)
		return iif( typeIsSigned( ldtype ), @"fptosi", @"fptoui" )
	end if

	'' int to int

	if( typeIsPtr( ldtype ) ) then
		if( typeIsPtr( rdtype ) ) then
			'' both are pointers, just convert the type
			'' (bitcast only changes the compile-time type, not any bits)
			return @"bitcast"
		end if
		return @"inttoptr"
	elseif( typeIsPtr( rdtype ) ) then
		return @"ptrtoint"
	end if

	'' same size ints?
	if( typeGetSize( ldtype ) = typeGetSize( rdtype ) ) then
		if( typeGetSizeType( ldtype ) = typeGetSizeType( rdtype ) ) then
			'' Do nothing for 32bit Long <-> 32bit Integer, etc.
			return NULL
		end if

		'' signed <-> unsigned
		return @"bitcast"
	end if

	if( typeGetSize( ldtype ) < typeGetSize( rdtype ) ) then
		return @"trunc"
	end if

	return iif( typeIsSigned( ldtype ), @"sext", @"zext" )
end function

private sub hEmitConvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	'' Converting float to int? Needs special treatment to achieve FB's rounding behaviour,
	'' because LLVM's fptosi/fptoui just truncate.
	if( (typeGetClass( v2->dtype ) = FB_DATACLASS_FPOINT) and _
	    (typeGetClass( v1->dtype ) = FB_DATACLASS_INTEGER) ) then
		'' Round v2 by calling llvm.nearbyint() and then using the result
		'' as the new v2. This rounding does float to float, then we can feed
		'' that into fptosi/fptoui to get the [u]int.
		var v0 = irhlAllocVreg( v2->dtype, v2->subtype )
		hLoadVreg( v2 )

		var ln = hVregToStr( v0 ) + " = call "
		if( v2->dtype = FB_DATATYPE_SINGLE ) then
			builtins(BUILTIN_NEARBYINTF).used = TRUE
			ln += "float @llvm.nearbyint.f32(float "
		else
			assert( v2->dtype = FB_DATATYPE_DOUBLE )
			builtins(BUILTIN_NEARBYINT).used = TRUE
			ln += "double @llvm.nearbyint.f64(double "
		end if
		ln += hVregToStr( v2 ) + ")"
		hWriteLine( ln )

		*v2 = *v0
	end if

	assert( (v1->dtype <> v2->dtype) or (v1->subtype <> v2->subtype) )

	var op = hGetConvOpCode( v1->dtype, v2->dtype )
	if( op = NULL ) then
		'' Do nothing for 32bit Long <-> 32bit Integer, etc.
		*v1 = *v2
		exit sub
	end if

	dim v0 as IRVREG ptr
	if( irIsREG( v1 ) ) then
		v0 = v1
	else
		v0 = irhlAllocVreg( v1->dtype, v1->subtype )
	end if

	hLoadVreg( v2 )

	var ln = hVregToStr( v0 ) + " = " + *op + " "
	ln += hEmitType( v2->dtype, v2->subtype )
	ln += " " + hVregToStr( v2 ) + " to "
	ln += hEmitType( v1->dtype, v1->subtype )
	hWriteLine( ln )

	if( irIsREG( v1 ) = FALSE ) then
		hEmitStore( v1, v0 )
	end if
end sub

private sub _emitConvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
	hAstCommand( "conv " + vregPretty( v2 ) + " => " + vregPretty( v1 ) )
	hEmitConvert( v1, v2 )
end sub

private sub hEmitStore( byval l as IRVREG ptr, byval r as IRVREG ptr )
	hLoadVreg( r )
	_setVregDataType( r, l->dtype, l->subtype )

	hPrepareAddress( l )

	var ln = "store "
	ln += hEmitType( typeDeref( l->dtype ), l->subtype ) + " "
	ln += hVregToStr( r ) + ", "
	ln += hEmitType( l->dtype, l->subtype ) + " "
	ln += hVregToStr( l )
	hWriteLine( ln )
end sub

private sub _emitStore( byval l as IRVREG ptr, byval r as IRVREG ptr )
	hAstCommand( "store " + vregPretty( l ) + " := " + vregPretty( r ) )
	hEmitStore( l, r )
end sub

private sub _emitSpillRegs( )
	/' do nothing '/
end sub

private sub _emitLoad( byval v1 as IRVREG ptr )
	/' do nothing '/
end sub

private sub _emitLoadRes _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	hAstCommand( "loadres " + vregPretty( v1 ) )

	hLoadVreg( v1 )
	_setVregDataType( v1, vr->dtype, vr->subtype )

	hWriteLine( "ret " + hEmitType( vr->dtype, vr->subtype ) + " " + hVregToStr( v1 ) )

end sub

private sub _emitAddr _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	dim as string ln

	select case( op )
	case AST_OP_ADDROF
		hAstCommand( "addrof " + vregPretty( v1 ) )

		'' There is no address-of operator in LLVM, because it only
		'' uses addresses to access memory, i.e. everything is a
		'' pointer already.
		''
		'' If a different type is wanted we can do a bitcast,
		'' but without loading the vreg, and if it's the same type
		'' the expression can be re-used as-is.
		hPrepareAddress( v1 )
		_setVregDataType( v1, vr->dtype, vr->subtype )

	case AST_OP_DEREF
		hAstCommand( "deref " + vregPretty( v1 ) )
		hLoadVreg( v1 )

	end select

	assert( irIsREG( vr ) and irIsREG( v1 ) )
	*vr = *v1

end sub

private sub hDoCall _
	( _
		byval pname as zstring ptr, _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	dim as string ln
	dim as IRCALLARG ptr arg = any, prev = any
	dim as IRVREG ptr varg = any, v0 = any

	assert( symbIsProc( proc ) )

	if( vr = NULL ) then
		'' Result discarded? Not allowed in LLVM, so assign to a
		'' temporary result vreg that will be unused.
		if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
			vr = irhlAllocVreg( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), _
						symbGetProcRealSubtype( proc ) )
		end if
	end if

	'' The LLVM call instruction must include the full function signature,
	'' and it has to match the declaration. We have to emit this based on
	'' the proc/param symbols - can't rely on the args, because our AST can
	'' have args with different dtype than the params.

	if( vr ) then
		if( irIsREG( vr ) ) then
			v0 = vr
		else
			v0 = irhlAllocVreg( vr->dtype, vr->subtype )
		end if

		ln = hVregToStr( v0 ) + " = call "
		ln += hEmitProcCallConv( proc )
		ln += hEmitType( v0->dtype, v0->subtype ) + " "
	else
		ln = "call " + hEmitProcCallConv( proc ) + "void "
	end if

	ln += *pname + "( "

	'' args
	arg = listGetTail( @irhl.callargs )
	while( arg andalso (arg->level = level) )
		prev = listGetPrev( arg )

		varg = arg->vr
		hInternalCommand( "arg " + vregPretty( varg ) )
		hLoadVreg( varg )

		'' Emit param's dtype (to match the declaration), not the arg's
		dim dtype as integer
		dim subtype as FBSYMBOL ptr
		if( arg->param ) then
			symbGetRealParamDtype( arg->param, dtype, subtype )
		else
			dtype = varg->dtype
			subtype = varg->subtype
		end if
		ln += hEmitType( dtype, subtype )

		'' Convert arg to param's dtype if needed
		_setVregDataType( varg, dtype, subtype )

		ln += " "
		ln += hVregToStr( varg )

		listDelNode( @irhl.callargs, arg )

		if( prev ) then
			if( prev->level = level ) then
				ln += ", "
			end if
		end if

		arg = prev
	wend

	ln += " )"

	hWriteLine( ln )

	if( vr ) then
		if( irIsREG( vr ) = FALSE ) then
			hEmitStore( vr, v0 )
		end if
	end if
end sub

private sub _emitCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	hAstCommand( "call " + hSymName( proc ) + "()" )
	hDoCall( symbGetMangledName( proc ), proc, bytestopop, vr, level )

end sub

private sub _emitCallPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer, _
		byval level as integer _
	)

	assert( v1->dtype = typeAddrOf( FB_DATATYPE_FUNCTION ) )
	assert( proc = v1->subtype )

	hAstCommand( "callptr " + vregPretty( v1 ) )
	hLoadVreg( v1 )
	hDoCall( hVregToStr( v1 ), proc, bytestopop, vr, level )

end sub

private sub _emitJumpPtr( byval v1 as IRVREG ptr )
	hAstCommand( "jumpptr " + vregPretty( v1 ) )
	hLoadVreg( v1 )
	hWriteLine( "goto *" & hVregToStr( v1 ) )
end sub

private sub _emitBranch( byval op as integer, byval label as FBSYMBOL ptr )
	hAstCommand( "goto " + hSymName( label ) )
	'' GOTO label
	assert( op = AST_OP_JMP )

	'' The jump ends the current basic block...
	hWriteLine( "br label %" + *symbGetMangledName( label ) )

	'' so, we need to add a dummy label afterwards (starts new basic block)
	hWriteLabel( symbUniqueLabel( ) )
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

	hAstCommand( "jmptb " + vregPretty( v1 ) )

	dim as string ln

	hLoadVreg( v1 )
	var dtype = hEmitType( v1->dtype, v1->subtype )

	ln = "switch "
	ln += dtype + " "
	ln += hVregToStr( v1 ) + ", "
	ln += "label %" + *symbGetMangledName( deflabel ) + " "
	ln += "["
	hWriteLine( ln )

	ctx.indent += 1
	for i as integer = 0 to labelcount - 1
		ln = dtype + " " & (values[i]+bias) & ", "
		ln += "label %" + *symbGetMangledName( labels[i] )
		hWriteLine( ln )
	next
	ctx.indent -= 1

	hWriteLine( "]" )

end sub

private sub _emitMem _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as longint _
	)

	dim as string ln

	ln = "call void "

	select case( op )
	case AST_OP_MEMCLEAR
		hAstCommand( "memclear " + vregPretty( v1 ) )
	case AST_OP_MEMMOVE
		hAstCommand( "memmove " + vregPretty( v1 ) + " <= " + vregPretty( v2 ) )
	end select

	hLoadVreg( v1 )
	hLoadVreg( v2 )

	select case( op )
	case AST_OP_MEMCLEAR
		builtins(BUILTIN_MEMSET).used = TRUE
		_setVregDataType( v1, typeAddrOf( FB_DATATYPE_BYTE ), NULL )
		_setVregDataType( v2, FB_DATATYPE_INTEGER, NULL )

		ln += "@llvm.memset.p0i8.i32( "
		ln += "i8* " + hVregToStr( v1 ) + ", "
		ln += "i8 0, "
		ln += "i32 " + hVregToStr( v2 ) + ", "

	case AST_OP_MEMMOVE
		builtins(BUILTIN_MEMMOVE).used = TRUE
		_setVregDataType( v1, typeAddrOf( FB_DATATYPE_BYTE ), NULL )
		_setVregDataType( v2, typeAddrOf( FB_DATATYPE_BYTE ), NULL )

		ln += "@llvm.memmove.p0i8.p0i8.i32( "
		ln += "i8* " + hVregToStr( v1 ) + ", "
		ln += "i8* " + hVregToStr( v2 ) + ", "
		ln += "i32 " + str( cunsg( bytes ) ) + ", "

	end select

	ln += "i32 1, i1 false )"

	hWriteLine( ln )
end sub

private sub _emitMacro _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)
	'' Used by C-emitter only
end sub

private sub _emitDECL( byval sym as FBSYMBOL ptr )
end sub

private sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		ByVal filename As zstring ptr _
	)

	if( op = AST_OP_DBG_LINEINI ) Then
		if( filename <> NULL ) then
			hWriteLine( "#line " & lnum & " """ & hReplace( filename, "\", $"\\" ) & """" )
		else
			hWriteLine( "#line " & lnum & " """ & hReplace( env.inf.name, "\", $"\\" ) & """" )
		end if
		ctx.linenum = lnum
	end If

end sub

private sub _emitComment( byval text as zstring ptr )
	hWriteLine( "; " + *text )
end sub

private sub _emitAsmLine( byval asmtokenhead as ASTASMTOK ptr )
	dim ln as string

	var n = asmtokenhead
	while( n )

		select case( n->type )
		case AST_ASMTOK_TEXT
			ln += *n->text
		case AST_ASMTOK_SYMB
			ln += *symbGetMangledName( n->sym )
			var ofs = symbGetOfs( n->sym )
			if( ofs <> 0 ) then
				if( ofs > 0 ) then
					ln += "+"
				end if
				ln += str( ofs )
			end if
		end select

		n = n->next
	wend

	hWriteLine( ln )
end sub

private sub _emitVarIniBegin( byval sym as FBSYMBOL ptr )
	ctx.varini = *symbGetMangledName( sym )
	ctx.varini += " = global "
	ctx.varini += hEmitSymType( sym )
	ctx.varini += " "
	ctx.variniscopelevel = 0
	ctx.variniscopes(0).is_array = FALSE
end sub

private sub _emitVarIniEnd( byval sym as FBSYMBOL ptr )
	hWriteLine( ctx.varini )
	ctx.varini = ""
end sub

'' For struct initializers, we have to emit each field's dtype in front of each
'' field's initializer expression. E.g.:
''    @myudtvar = global %UDT {i32 1, i32 2}
'' but not for array initializers:
''    @myarray = global [2 x i32] [1, 2]
'' and not at all if at toplevel (i.e. neither struct nor array):
''    @myintvar = global i32 1
private sub hVarIniElementType( byval sym as FBSYMBOL ptr )
	if( ctx.variniscopelevel > 0 ) then
		'' Can't use hEmitSymType() here in case it's the array and
		'' we're just initializing one of its elements
		if( ctx.variniscopes(ctx.variniscopelevel).is_array ) then
			ctx.varini += hEmitType( symbGetType( sym ), sym->subtype ) + " "
		else
			ctx.varini += hEmitSymType( sym ) + " "
		end if
	end if
end sub

private sub hVarIniSeparator( )
	if( ctx.variniscopelevel > 0 ) then
		ctx.varini += ", "
	end if
end sub

private sub _emitVarIniI( byval sym as FBSYMBOL ptr, byval value as longint )
	hVarIniElementType( sym )
	var dtype = symbGetType( sym )

	'' AST stores boolean true as -1, but we emit it as 1 for gcc compatibility
	if( (dtype = FB_DATATYPE_BOOLEAN) and (value <> 0) ) then
		value = 1
	end if

	if( typeGetSize( dtype ) = 8 ) then
		ctx.varini += hEmitLong( value )
	else
		ctx.varini += hEmitInt( dtype, sym->subtype, value )
	end if

	hVarIniSeparator( )
end sub

private sub _emitVarIniF( byval sym as FBSYMBOL ptr, byval value as double )
	hVarIniElementType( sym )
	ctx.varini += hEmitFloat( value )
	hVarIniSeparator( )
end sub

'' Add inline conversion instruction, to convert the expression in "s" from rhs
'' type to lhs type, if needed
private sub hMaybeAddConv _
	( _
		byref s as string, _
		byval ldtype as integer, _
		byval lsubtype as FBSYMBOL ptr, _
		byref ltype as string, _
		byval rdtype as integer, _
		byval rsubtype as FBSYMBOL ptr, _
		byval rtype as string _
	)

	if( (ldtype = rdtype) and (lsubtype = rsubtype) ) then
		exit sub
	end if

	var op = hGetConvOpCode( ldtype, rdtype )
	if( op = NULL ) then
		exit sub
	end if

	s = *op + " (" + rtype + " " + s + " to " + ltype + ")"

end sub

private sub _emitVarIniOfs _
	( _
		byval sym as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval ofs as longint _
	)

	hVarIniElementType( sym )

	var s = *symbGetMangledName( rhs )
	var symdtype = symbGetType( sym )
	var symtype = hEmitType( symdtype, sym->subtype )
	var ptrdtype = typeAddrOf( symbGetType( rhs ) )
	var ptrtype = hEmitType( ptrdtype, rhs->subtype )

	if( ofs <> 0 ) then
		var inttype = hEmitType( FB_DATATYPE_UINT, NULL )

		'' Emit inline LLVM instructions for something like: cptr(cint(@rhs) + ofs)

		'' %0 = ptrtoint foo* @global to i32
		s = "ptrtoint (" + ptrtype + " " + s + " to " + inttype + ")"

		'' %1 = add (i32 %0), i32 <offset>
		s = "add (" + inttype + " " + s + ", " + inttype + " " & ofs & ")"

		'' %2 = inttoptr (i32 %1) to foo*
		s = "inttoptr (" + inttype + " " + s + " to " + ptrtype + ")"
	end if

	hMaybeAddConv( s, symdtype, sym->subtype, symtype, ptrdtype, rhs->subtype, ptrtype )

	ctx.varini += s

	hVarIniSeparator( )
end sub

private sub _emitVarIniStr _
	( _
		byval varlength as longint, _
		byval literal as zstring ptr, _
		byval litlength as longint _
	)

	'' also see hVarIniElementType()
	if( ctx.variniscopelevel > 0 ) then
		ctx.varini += hEmitStrLitType( varlength ) + " "
	end if
	ctx.varini += "c"""
	hBuildStrLit( ctx.varini, varlength + 1, hUnescape( literal ), litlength + 1 )
	ctx.varini += """"
	hVarIniSeparator( )

end sub

private sub _emitVarIniWstr _
	( _
		byval varlength as longint, _
		byval literal as wstring ptr, _
		byval litlength as longint _
	)

	'' also see hVarIniElementType()
	if( ctx.variniscopelevel > 0 ) then
		ctx.varini += hEmitStrLitType( varlength ) + " "
	end if
	ctx.varini += "c"""
	hBuildWstrLit( ctx.varini, varlength + 1, hUnescapeW( literal ), litlength + 1 )
	ctx.varini += """"
	hVarIniSeparator( )

end sub

private sub _emitVarIniPad( byval bytes as longint )
end sub

private sub _emitVarIniScopeBegin( byval sym as FBSYMBOL ptr, byval is_array as integer )
	'' If starting a nested initializer we have to emit its type (it will
	'' be either a struct type or an array type).
	hVarIniElementType( sym )

	'' Add varini scope to stack
	ctx.variniscopelevel += 1
	if( ctx.variniscopelevel >= MAXVARINISCOPES ) then
		errReport( FB_ERRMSG_INTERNAL, , "global variable/array initializer nesting level too deep (MAXVARINISCOPES=" & MAXVARINISCOPES & ")" )
		ctx.variniscopelevel -= 1
	end if
	ctx.variniscopes(ctx.variniscopelevel).is_array = is_array

	if( is_array ) then
		ctx.varini += "[ "
	else
		ctx.varini += "{ "
	end if
end sub

private sub _emitVarIniScopeEnd( )
	'' Trim separator at the end, to make the output look a bit more clean
	'' (this isn't needed though, since the extra comma is allowed in C)
	if( right( ctx.varini, 2 ) = ", " ) then
		ctx.varini = left( ctx.varini, len( ctx.varini ) - 2 )
	end if

	if( ctx.variniscopes(ctx.variniscopelevel).is_array ) then
		ctx.varini += " ]"
	else
		ctx.varini += " }"
	end if

	'' Pop varini scope from stack
	'' (due to _emitVarIniScopeBegin's MAXVARINISCOPES handling there could
	'' be a count misbalance during error recovery)
	if( ctx.variniscopelevel > 0 ) then
		ctx.variniscopelevel -= 1
	end if

	hVarIniSeparator( )
end sub

private sub _emitFbctinfBegin( )
	hWriteLine( "" )
end sub

private sub _emitFbctinfString( byval s as const zstring ptr )
	ctx.fbctinf += *s + $"\00"
	ctx.fbctinf_len += len( *s ) + 1
end sub

private sub _emitFbctinfEnd( )
	dim as string ln

	'' This is based on the LLVM IR code generated by clang for a:
	'' static const char __attribute__((used, section(".fbctinf"))) __fbctinf[] = "...";

	'' internal  - private
	'' constant  - read-only
	'' section   - This global must be put into a custom .fbctinf section,
	''             as done by the ASM backend.
	ln = "@__fbctinf = internal constant "
	ln += hEmitStrLitType( ctx.fbctinf_len )
	ln += " c""" + ctx.fbctinf + """"
	if (fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_DARWIN) then
		'' Must specify a segment name (can use any name)
		ln += ", section ""__DATA," + FB_INFOSEC_NAME + """"
	else
		ln += ", section ""." + FB_INFOSEC_NAME + """"
	end if
	hWriteLine( ln )

	'' Append to the special llvm.used symbol to ensure it won't be
	'' optimized out:
	ln = "@llvm.used = appending global [1 x i8*] "
	ln += "["
	ln += "i8* bitcast (" + hEmitStrLitType( ctx.fbctinf_len ) + "* @__fbctinf to i8*)"
	ln += "]"
	ln += ", section ""llvm.metadata"""
	hWriteLine( ln )

	ctx.fbctinf = ""
	ctx.fbctinf_len = 0
end sub

private sub _emitProcBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr _
	)

	irhlEmitProcBegin( )

	hWriteLine( "" )

	dim as string ln

	ln += "define "
	if( symbIsExport( proc ) ) then
		ln += "dllexport "
	elseif( symbIsPrivate( proc ) ) then
		ln += "private "
		''ln += "internal "
	end if
	ln += hEmitProcHeader( proc, FALSE, FALSE )

	hWriteLine( ln )

	hWriteLine( "{" )
	ctx.indent += 1

end sub

private sub _emitProcEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

	'' Sub? Add ret manually, the AST doesn't do a LOAD[RES] for this
	if( symbGetType( proc ) = FB_DATATYPE_VOID ) then
		hWriteLine( "ret void" )
	end if

	ctx.indent -= 1
	hWriteLine( "}" )

	irhlEmitProcEnd( )

end sub

private sub _emitScopeBegin( byval s as FBSYMBOL ptr )
end sub

private sub _emitScopeEnd( byval s as FBSYMBOL ptr )
end sub

static as IR_VTBL irllvm_vtbl = _
( _
	@_init, _
	@_end, _
	@_emitBegin, _
	@_emitEnd, _
	@_getOptionValue, _
	@_supportsOp, _
	@_procBegin, _
	@_procEnd, _
	@_procAllocArg, _
	@_procAllocLocal, _
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
