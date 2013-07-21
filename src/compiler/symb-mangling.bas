'' symbol mangling module (compatible with the GCC 3.x ABI)
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "flist.bi"
#include once "hash.bi"
#include once "ir.bi"

type FB_MANGLEABBR
	idx				as integer
	dtype			as integer
	subtype			as FBSYMBOL ptr
end type

type FB_MANGLECTX
	flist			as TFLIST					'' of FB_MANGLEABBR
	cnt				as integer

	tempstr			as zstring * 6 + 10 + 1
	uniqueidcount		as integer
	uniquelabelcount	as integer
	profilelabelcount	as integer
end type

const FB_INITMANGARGS = 96


declare function hDoCppMangling( byval sym as FBSYMBOL ptr ) as integer
declare sub hMangleProc( byval sym as FBSYMBOL ptr )
declare sub hMangleVariable( byval sym as FBSYMBOL ptr )
declare sub hGetProcParamsTypeCode _
	( _
		byref mangled as string, _
		byval sym as FBSYMBOL ptr _
	)

'' globals
	dim shared as FB_MANGLECTX ctx

sub symbMangleInit( )
	flistInit( @ctx.flist, FB_INITMANGARGS, len( FB_MANGLEABBR ) )
	ctx.cnt = 0
	ctx.uniqueidcount = 0
	ctx.uniquelabelcount = 0
	ctx.profilelabelcount = 0
end sub

sub symbMangleEnd( )
	flistEnd( @ctx.flist  )
end sub

function symbUniqueId( ) as zstring ptr
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		ctx.tempstr = "tmp$"
		ctx.tempstr += str( ctx.uniqueidcount )
	else
		ctx.tempstr = "Lt_"
		ctx.tempstr += *hHexUInt( ctx.uniqueidcount )
	end if

	ctx.uniqueidcount += 1

	function = @ctx.tempstr
end function

function symbUniqueLabel( ) as zstring ptr
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		ctx.tempstr = "label$"
		ctx.tempstr += str( ctx.uniquelabelcount )
		ctx.uniquelabelcount += 1
	else
		ctx.tempstr = ".Lt_"
		ctx.tempstr += *hHexUInt( ctx.uniqueidcount )
		ctx.uniqueidcount += 1
	end if

	function = @ctx.tempstr
end function

function symbMakeProfileLabelName( ) as zstring ptr
	ctx.tempstr = "LP_" + *hHexUInt( ctx.profilelabelcount )
	ctx.profilelabelcount += 1
	function = @ctx.tempstr
end function

function symbGetDBGName( byval sym as FBSYMBOL ptr ) as zstring ptr
    '' GDB will demangle the symbols automatically
	if( hDoCppMangling( sym ) ) then
		select case as const symbGetClass( sym )
		'' but UDT's, they shouldn't include any mangling at all..
		case FB_SYMBCLASS_ENUM, FB_SYMBCLASS_STRUCT, _
			 FB_SYMBCLASS_CLASS, FB_SYMBCLASS_NAMESPACE

    		'' check if an alias wasn't given
    		dim as zstring ptr res = sym->id.alias
    		if( res = NULL ) then
    			res = sym->id.name
    		end if

    		return res

		case else
			return symbGetMangledName( sym )
		end select
	end if

	'' no mangling, return as-is
	function = sym->id.name
end function

sub symbSetName( byval s as FBSYMBOL ptr, byval name_ as zstring ptr )
	dim as integer slen = any

	'' assuming only params will change names, no mangling reseted

	if( s->id.name <> NULL ) then
		poolDelItem( @symb.namepool, s->id.name ) 'ZstrFree( s->id.name )
	end if

	slen = len( *name_ )
	if( slen = 0 ) then
		s->id.name = NULL
	else
		s->id.name = poolNewItem( @symb.namepool, slen + 1 ) 'ZStrAllocate( slen )
		*s->id.name = *name_
	end if
end sub

private sub hMangleCompType( byval sym as FBSYMBOL ptr )
	dim as zstring ptr id = any, p = any
	dim as integer length = any

	id = sym->id.alias
	if( id = NULL ) then
		id = sym->id.name
	end if

	length = len( *id )

	'' Store the mangled id into the symbol
	p = ZStrAllocate( length + 2 )
	sym->id.mangled = p

	'' id length
	if( length < 10 ) then
		p[0] = asc( "0" ) + length
		p += 1
	else
		p[0] = asc( "0" ) + (length \ 10)
		p[1] = asc( "0" ) + (length mod 10)
		p += 2
	end if

	'' id
	*p = *id
end sub

function symbGetMangledName( byval sym as FBSYMBOL ptr ) as zstring ptr
	if( sym->id.mangled ) then
		return sym->id.mangled
	end if

	select case as const( symbGetClass( sym ) )
	case FB_SYMBCLASS_PROC
		hMangleProc( sym )
	case FB_SYMBCLASS_ENUM, FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_FWDREF, _
	     FB_SYMBCLASS_CLASS, FB_SYMBCLASS_NAMESPACE
		hMangleCompType( sym )
	case FB_SYMBCLASS_VAR
		hMangleVariable( sym )
	case else
		return sym->id.alias
	end select

	'' Periods in symbol names?  not allowed in C, must be replaced.
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			hReplaceChar( sym->id.mangled, asc( "." ), asc( "$" ) )
		end if
	end if

	function = sym->id.mangled
end function

sub symbMangleInitAbbrev( )
	ctx.cnt = 0
end sub

sub symbMangleEndAbbrev( )
	'' reset abbreviation list
	flistReset( @ctx.flist )
	ctx.cnt = 0
end sub

private function hAbbrevFind _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	dim as FB_MANGLEABBR ptr n = any

	if( ctx.cnt = 0 ) then
		return -1
	end if

	'' builtin?
	if( subtype = NULL ) then
		if( typeIsPtr( dtype ) = FALSE ) then
			if( typeGet( dtype ) <> FB_DATATYPE_STRING ) then
				return -1
			end if
		end if
	end if

	'' for each item..
	n = flistGetHead( @ctx.flist )
	do while( n <> NULL )
		'' same type?
		if( n->subtype = subtype ) then
			if( astGetFullType( n ) = dtype ) then
				return n->idx
			end if
		end if

		n = flistGetNext( n )
	loop

	function = -1
end function

private function hAbbrevAdd _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as FB_MANGLEABBR ptr

	dim as FB_MANGLEABBR ptr n = any

    n = flistNewItem( @ctx.flist )
    n->idx = ctx.cnt

    astGetFullType( n ) = dtype
    n->subtype = subtype

    ctx.cnt += 1

    function = n
end function

private sub hAbbrevGet( byref mangled as string, byval idx as integer )
	mangled += "S"

	if( idx > 0 ) then
		if( idx <= 10 ) then
			mangled += chr( asc( "0" ) + (idx - 1) )
		elseif( idx <= 33 ) then
			mangled += chr( asc( "A" ) + (idx - 11) )
		else
			'' 2 digits are enough for 333 abbreviations
			mangled += chr( idx \ 33 )
			idx mod= 33
			if( idx <= 10 ) then
				mangled += chr( asc( "0" ) + (idx - 1) )
			elseif( idx <= 33 ) then
				mangled += chr( asc( "A" ) + (idx - 11) )
			end if
		end if
	end if

	mangled += "_"
end sub

private function hMangleBuiltInType( byval dtype as integer ) as zstring ptr
	assert( dtype = typeGetDtOnly( dtype ) )

	if( fbCpuTypeIs64bit( ) ) then
		'' By default on x86 we mangle INTEGER to "int", but on 64bit
		'' our INTEGER becomes 64bit, while int stays 32bit, so we
		'' really shouldn't use the same mangling in that case.
		''
		'' Mangling the 64bit INTEGER as "long long" would conflict
		'' with the LONGINT mangling though (we cannot allow separate
		'' INTEGER/LONGINT overloads in code but then generate the same
		'' mangled id for them, the assembler/linker would complain).
		''
		'' Besides that, our LONG stays 32bit always, but "long" on
		'' 64bit Linux changes to 64bit, so we shouldn't mangle LONG
		'' to "long" in that case. It would still be possible on 64bit
		'' Windows, because there "long" stays 32bit, but it seems best
		'' to mangle LONG to "int" on 64bit consistently, since "int"
		'' stays 32bit on both Linux and Windows.
		''
		'' Itanium C++ ABI compatible mangling of non-C++ built-in
		'' types (vendor extended types):
		''    u <length-of-id> <id>

		select case( dtype )
		case FB_DATATYPE_INTEGER : return @"u7INTEGER"  '' seems like a good choice
		case FB_DATATYPE_UINT    : return @"u8UINTEGER"
		case FB_DATATYPE_LONG    : return @"i"  '' int
		case FB_DATATYPE_ULONG   : return @"j"  '' unsigned int
		end select
	else
		select case( dtype )
		case FB_DATATYPE_INTEGER : return @"i"  '' int
		case FB_DATATYPE_UINT    : return @"j"  '' unsigned int
		case FB_DATATYPE_LONG    : return @"l"  '' long
		case FB_DATATYPE_ULONG   : return @"m"  '' unsigned long
		end select
	end if

	static as zstring ptr typecodes(0 to FB_DATATYPES-1) => _
	{ _
		@"v", _ '' void
		@"a", _ '' byte (signed char)
		@"h", _ '' ubyte (unsigned char)
		@"c", _ '' char
		@"s", _ '' short
		@"t", _ '' ushort
		@"w", _ '' wchar
		NULL, _ '' integer
		NULL, _ '' uinteger
		NULL, _ '' enum
		NULL, _ '' bitfield
		NULL, _ '' long
		NULL, _ '' ulong
		@"x", _ '' longint (long long)
		@"y", _ '' ulongint (unsigned long long)
		@"f", _ '' single
		@"d", _ '' double
		NULL, _ '' var-len string
		NULL, _ '' fix-len string
		NULL, _ '' struct
		NULL, _ '' namespace
		NULL, _ '' function
		NULL, _ '' fwd-ref
		NULL  _ '' pointer
	}

	assert( typecodes(dtype) <> NULL )
	function = typecodes(dtype)
end function

sub symbMangleType _
	( _
		byref mangled as string, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr ns = any

	'' Lookup abbreviation for this type/namespace (if the current procedure
	'' name already contains the type somewhere, it can be referred to
	'' through an index instead of by repeating the full name)
	dim as integer idx = hAbbrevFind( dtype, subtype )
	if( idx <> -1 ) then
		hAbbrevGet( mangled, idx )
		exit sub
	end if

	'' forward type?
	if( typeGet( dtype ) = FB_DATATYPE_FWDREF ) then
		dtype = typeJoin( dtype and (not FB_DATATYPE_INVALID), FB_DATATYPE_STRUCT )
	end if

	select case as const( dtype )
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
		ns = symbGetNamespace( subtype )
		if( ns = @symbGetGlobalNamespc( ) ) then
			mangled += *symbGetMangledName( subtype )
		else
			mangled += "N"
			symbMangleType( mangled, symbGetFullType( ns ), ns )
			mangled += *symbGetMangledName( subtype )
			mangled += "E"
		end if

	case FB_DATATYPE_NAMESPC
		if( subtype = @symbGetGlobalNamespc( ) ) then
			exit sub
		end if

		ns = symbGetNamespace( subtype )
		if( ns ) then
			symbMangleType( mangled, FB_DATATYPE_NAMESPC, ns )
		end if
		mangled += *symbGetMangledName( subtype )

	case FB_DATATYPE_FUNCTION
		'' F(byref)(const)(return_type)(params - recursive, reuses hash)E
		mangled += "F"

		'' return BYREF?
		if( symbProcReturnsByref( subtype ) ) then
			'' const?
			if( typeIsConst( symbGetFullType( subtype ) ) ) then
				mangled += "RK"
			else
				mangled += "R"
			end if
		else
			'' const?
			if( typeIsConst( symbGetFullType( subtype ) ) ) then
				mangled += "K"
			end if
		end if

		symbMangleType( mangled, symbGetFullType( subtype ), symbGetSubtype( subtype ) )
		hGetProcParamsTypeCode( mangled, subtype )

		mangled += "E"

	case FB_DATATYPE_STRING
		mangled += "8FBSTRING"

	case else
		'' builtin?
		if( dtype = typeGetDtOnly( dtype ) ) then
			mangled += *hMangleBuiltInType( dtype )
			exit sub
		end if

		'' reference?
		if( typeIsRef( dtype ) ) then
			'' const?
			if( typeIsConst( dtype ) ) then
				mangled += "RK"
			else
				mangled + = "R"
			end if
			symbMangleType( mangled, typeUnsetIsRef( dtype ), subtype )

		'' array?
		elseif( typeIsArray( dtype ) ) then
			mangled += "A"
			symbMangleType( mangled, typeUnsetIsArray( dtype ), subtype )

		'' pointer? (must be checked/emitted before CONST)
		elseif( typeIsPtr( dtype ) ) then
			'' const?
			if( typeIsConstAt( dtype, 1 ) ) then
				mangled += "PK"
			else
				mangled += "P"
			end if

			symbMangleType( mangled, typeDeref( dtype ), subtype )

		'' const..
		else
			'' note: nothing is added (as in C++) because it's not a 'const ptr'
			symbMangleType( mangled, typeUnsetIsConst( dtype ), subtype )
		end if

	end select

	hAbbrevAdd( dtype, subtype )
end sub

sub symbMangleParam( byref mangled as string, byval param as FBSYMBOL ptr )
	dim as integer dtype = any

	dtype = symbGetFullType( param )

	select case as const( symbGetParamMode( param ) )
	'' by reference (or descriptor)?
	case FB_PARAMMODE_BYREF
		dtype = typeSetIsRef( dtype )

	case FB_PARAMMODE_BYDESC
		dtype = typeSetIsRefAndArray( dtype )

       '' var arg?
	case FB_PARAMMODE_VARARG
		mangled += "z"
		exit sub

	end select

	symbMangleType( mangled, dtype, symbGetSubtype( param ) )
end sub

private function hAddUnderscore( ) as integer
	'' C backend? don't add underscores; gcc will already do it.
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		function = FALSE
	else
		'' For ASM, add underscores if the target requires it
		function = ((env.target.options and FB_TARGETOPT_UNDERSCORE) <> 0)
	end if
end function

'' inside a namespace or class?
#define hIsNested(s) (symbGetNamespace( s ) <> @symbGetGlobalNamespc( ))

private function hDoCppMangling( byval sym as FBSYMBOL ptr ) as integer
    '' C++?
    if( symbGetMangling( sym ) = FB_MANGLING_CPP ) then
    	return TRUE
    end if

    '' RTL or exclude parent?
    if( (symbGetStats( sym ) and (FB_SYMBSTATS_RTL or _
    							  FB_SYMBSTATS_EXCLPARENT)) <> 0 ) then
    	return FALSE
    end if

    '' inside a namespace or class?
    if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
    	return TRUE
    end if

    if( sym->class = FB_SYMBCLASS_PROC ) then
    	'' overloaded? (this will handle operators too)
    	if( symbIsOverloaded( sym ) ) then
    		return TRUE
    	end if
    end if

	function = FALSE
end function

private sub hMangleNamespace _
	( _
		byref mangled as string, _
		byval ns as FBSYMBOL ptr, _
		byval dohashing as integer, _
		byval isconst as integer _
	)

	static as FBSYMBOL ptr nsStk(0 to FB_MAXNAMESPCRECLEVEL-1)
	dim as integer tos = any

	if( ns = NULL ) then
		exit sub
	end if

	if( ns = @symbGetGlobalNamespc( ) ) then
		exit sub
	end if

	if( dohashing ) then
		'' Just add the abbreviation for this if not yet done
		if( hAbbrevFind( symbGetFullType( ns ), ns ) = -1 ) then
			hAbbrevAdd( symbGetFullType( ns ), ns )
		end if
	end if

	'' create a stack
	tos = -1
	do
		tos += 1
		nsStk(tos) = ns
		ns = symbGetNamespace( ns )
	loop until( ns = @symbGetGlobalNamespc( ) )

	'' return the chain starting from base parent
	mangled += "N"
	if( isconst ) then
		mangled += "K"
	end if
	do
		ns = nsStk(tos)
		mangled += *symbGetMangledName( ns )
		tos -= 1
	loop until( tos < 0 )
end sub

private sub hMangleVariable( byval sym as FBSYMBOL ptr )
	static as string id
	static as integer varcounter
	dim as string mangled
	dim as zstring ptr p = any
	dim as integer docpp = any, isglobal = any

	'' local? no mangling
	if( sym->scope > FB_MAINSCOPE ) then
		docpp = FALSE
	else
		docpp = hDoCppMangling( sym )
	end if

	'' prefix
	'' public global/static?
	if( sym->attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN or _
	                     FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_COMMON or _
	                     FB_SYMBATTRIB_STATIC) ) then
		'' LLVM: @ prefix for global symbols
		if( env.clopt.backend = FB_BACKEND_LLVM ) then
			mangled += "@"
		end if

		select case( env.clopt.target )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			'' Win32 import? Don't add the prefix under the C backend; it will use
			'' __declspec(dllimport) instead in order to let gcc do it.
			if( (env.clopt.backend = FB_BACKEND_GAS) and symbIsImport( sym ) ) then
				mangled += "__imp_"
			end if
		end select

		'' Win32 underscore prefix
		if( hAddUnderscore( ) ) then
			mangled += "_"
		end if

		if( docpp ) then
			'' Note: This adds the _Z prefix to all global variables,
			'' unlike GCC, which does C++ mangling only for globals inside
			'' namespaces, but not globals from the toplevel namespace.
			mangled += "_Z"
		end if
	else
		'' LLVM: % prefix for local symbols
		if( env.clopt.backend = FB_BACKEND_LLVM ) then
			mangled += "%"
		end if
	end if

	'' namespace
	if( docpp ) then
		hMangleNamespace( mangled, symbGetNamespace( sym ), FALSE, FALSE )
	end if

	'' class (once static member variables are added)

	'' id
	if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
		'' Explicit var ALIAS given, overriding the default id
		id = *sym->id.alias
	else
		'' shared, public, extern or inside a ns?
		isglobal = ((sym->attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN or _
		                              FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_COMMON)) <> 0)

		if( isglobal or docpp ) then
			'' BASIC? use the upper-cased name
			if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
				id = *sym->id.name
				if( env.clopt.backend = FB_BACKEND_GCC ) then
					id += "$"
				end if
			'' else, the case-sensitive name saved in the alias..
			else
				id = *sym->id.alias
			end if

			'' suffixed?
			if( symbIsSuffixed( sym ) ) then
				id += *hMangleBuiltInType( symbGetType( sym ) )
				if( env.clopt.backend = FB_BACKEND_GCC ) then
					id += "$"
				end if
			end if
		else
			select case( env.clopt.backend )
			case FB_BACKEND_GCC
				'' ir-hlc emits statics with dtors as globals,
				'' so they need a unique name. Other statics are
				'' still emitted locally, so they can keep their
				'' own name, like other local vars.
				if( symbIsStatic( sym ) and symbHasDtor( sym ) ) then
					id = *symbUniqueId( )
				else
					if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
						'' BASIC mangling, use the upper-cased name
						id = *sym->id.name

						'' Using '$' to prevent collision with C keywords etc.
						'' ('$' isn't allowed as part of FB ids)
						id += "$"

						'' Type suffix?
						if( symbIsSuffixed( sym ) ) then
							'' Encode the type to prevent collisions with other variables
							'' using the same base id but different type suffix.
							id += *hMangleBuiltInType( symbGetType( sym ) )
							id += "$"
						end if

						'' Append the scope level to prevent collisions with symbols
						'' from parent scopes or from the toplevel namespace.
						'' Note: locals from the main scope will start at level 0,
						'' while locals from procedures start at level 1,
						'' but that's ok as long as globals aren't suffixed with
						'' a level at all.
						id += str( sym->scope )
					else
						'' Use the case-sensitive name saved in the alias
						id = *sym->id.alias
					end if
				end if
			case FB_BACKEND_LLVM
				if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
					'' BASIC mangling, use the upper-cased name
					id = *sym->id.name

					'' Type suffix?
					if( symbIsSuffixed( sym ) ) then
						id += *hMangleBuiltInType( symbGetType( sym ) )
					end if

					'' Make the symbol unique - LLVM IR doesn't have scopes.
					'' (appending the scope level wouldn't be enough due to
					'' conflicts between sibling scopes)
					id += "." + str( varcounter )
					varcounter += 1
				else
					'' Use the case-sensitive name saved in the alias
					id = *sym->id.alias
				end if
			case else '' ASM backend
				if( symbIsStatic( sym ) ) then
					id = *symbUniqueId( )
				else
					id = *irProcGetFrameRegName( )
				end if
			end select
		end if
	end if

	'' id length (C++ only) followed by the id itself
	if( docpp ) then
		mangled += str( len( id ) )
	end if
	mangled += id

	if( docpp ) then
		'' nested? (namespace or class)
		if( hIsNested( sym ) ) then
			mangled += "E"
		end if
	end if

	'' Store the mangled id into the symbol
	sym->id.mangled = ZStrAllocate( len( mangled ) )
	*sym->id.mangled = mangled
end sub

private sub hGetProcParamsTypeCode _
	( _
		byref mangled as string, _
		byval sym as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr param = any
	dim as integer dtype = any

	param = symbGetProcHeadParam( sym )
	if( param <> NULL ) then
		'' instance pointer? skip..
		if( symbIsParamInstance( param ) ) then
			param = symbGetParamNext( param )
		end if
	end if

	'' no params?
	if( param = NULL ) then
		'' void
		mangled += "v"
		exit sub
	end if

	'' for each param...
	do
		symbMangleParam( mangled, param )
		param = symbGetParamNext( param )
	loop while( param )
end sub

private function hGetOperatorName( byval proc as FBSYMBOL ptr ) as const zstring ptr
	''
	'' Most operators follow the "Operator Encodings" section of the
	'' Itanium C++ ABI.
	''
	'' However, FB has some operators that C++ doesn't have, these "custom"
	'' operators should use the predefined scheme of the ABI, to allow
	'' C++-compatible tools to demangle them:
	''    v <num-args> <length> <name>
	'' where <num-args> is the operand count as a single decimal
	'' digit, and <length> is the length of <name>.
	''
	select case as const symbGetProcOpOvl( proc )
	case AST_OP_ASSIGN
		function = @"aS"

	case AST_OP_ADD
		function = @"pl"

	case AST_OP_ADD_SELF
		function = @"pL"

	case AST_OP_SUB
		function = @"mi"

	case AST_OP_SUB_SELF
		function = @"mI"

	case AST_OP_MUL
		function = @"ml"

	case AST_OP_MUL_SELF
		function = @"mL"

	case AST_OP_DIV
		function = @"dv"

	case AST_OP_DIV_SELF
		function = @"dV"

	case AST_OP_INTDIV
		function = @"v24idiv"

	case AST_OP_INTDIV_SELF
		function = @"v28selfidiv"

	case AST_OP_MOD
		function = @"rm"

	case AST_OP_MOD_SELF
		function = @"rM"

	case AST_OP_AND
		function = @"an"

	case AST_OP_AND_SELF
		function = @"aN"

	case AST_OP_OR
		function = @"or"

	case AST_OP_OR_SELF
		function = @"oR"

	'' Note: The ANDALSO/ORELSE operators can't currently be
	'' overloaded, much less the self versions
	case AST_OP_ANDALSO
		function = @"aa"

	case AST_OP_ANDALSO_SELF
		function = @"aA" '' FB-specific

	case AST_OP_ORELSE
		function = @"oo"

	case AST_OP_ORELSE_SELF
		function = @"oO" '' FB-specific

	case AST_OP_XOR
		function = @"eo"

	case AST_OP_XOR_SELF
		function = @"eO"

	case AST_OP_EQV
		function = @"v23eqv"

	case AST_OP_EQV_SELF
		function = @"v27selfeqv"

	case AST_OP_IMP
		function = @"v23imp"

	case AST_OP_IMP_SELF
		function = @"v27selfimp"

	case AST_OP_SHL
		function = @"ls"

	case AST_OP_SHL_SELF
		function = @"lS"

	case AST_OP_SHR
		function = @"rs"

	case AST_OP_SHR_SELF
		function = @"rS"

	case AST_OP_POW
		function = @"v23pow"

	case AST_OP_POW_SELF
		function = @"v27selfpow"

	case AST_OP_CONCAT
		function = @"v23cat"

	case AST_OP_CONCAT_SELF
		function = @"v27selfcat"

	case AST_OP_EQ
		function = @"eq"

	case AST_OP_GT
		function = @"gt"

	case AST_OP_LT
		function = @"lt"

	case AST_OP_NE
		function = @"ne"

	case AST_OP_GE
		function = @"ge"

	case AST_OP_LE
		function = @"le"

	case AST_OP_NOT
		function = @"co"

	case AST_OP_NEG
		function = @"ng"

	case AST_OP_PLUS
		function = @"ps"

	case AST_OP_ABS
		function = @"v13abs"

	case AST_OP_FIX
		function = @"v13fix"

	case AST_OP_FRAC
		function = @"v14frac"

	case AST_OP_SGN
		function = @"v13sgn"

	case AST_OP_FLOOR
		function = @"v13int"

	case AST_OP_EXP
		function = @"v13exp"

	case AST_OP_LOG
		function = @"v13log"

	case AST_OP_SIN
		function = @"v13sin"

	case AST_OP_ASIN
		function = @"v14asin"

	case AST_OP_COS
		function = @"v13cos"

	case AST_OP_ACOS
		function = @"v14acos"

	case AST_OP_TAN
		function = @"v13tan"

	case AST_OP_ATAN
		function = @"v13atn"

	case AST_OP_NEW, AST_OP_NEW_SELF
		function = @"nw"

	case AST_OP_NEW_VEC, AST_OP_NEW_VEC_SELF
		function = @"na"

	case AST_OP_DEL, AST_OP_DEL_SELF
		function = @"dl"

	case AST_OP_DEL_VEC, AST_OP_DEL_VEC_SELF
		function = @"da"

	case AST_OP_DEREF
		function = @"de"

	case AST_OP_FLDDEREF
		function = @"pt"

	case AST_OP_PTRINDEX
		function = @"ix"

	case AST_OP_ADDROF
		function = @"ad"

	case AST_OP_FOR
		'' operator T.for( [ as T ] )
		if( symbGetProcParams( proc ) = 2 ) then
			function = @"v13for"
		else
			assert( symbGetProcParams( proc ) = 1 )
			function = @"v03for"
		end if

	case AST_OP_STEP
		'' operator T.step( [ as T ] )
		if( symbGetProcParams( proc ) = 2 ) then
			function = @"v14step"
		else
			assert( symbGetProcParams( proc ) = 1 )
			function = @"v04step"
		end if

	case AST_OP_NEXT
		'' operator T.next( as T [ , as T ] )
		if( symbGetProcParams( proc ) = 3 ) then
			function = @"v24next"
		else
			assert( symbGetProcParams( proc ) = 2 )
			function = @"v14next"
		end if

	end select
end function

private sub hMangleProc( byval sym as FBSYMBOL ptr )
	dim as string mangled
	dim as integer length = any, docpp = any
	dim as zstring ptr id = any

	docpp = hDoCppMangling( sym )

	symbMangleInitAbbrev( )

	'' LLVM: @ prefix for global symbols
	if( env.clopt.backend = FB_BACKEND_LLVM ) then
		mangled += "@"

		'' Going to add @N stdcall suffix below?
		if( sym->proc.mode = FB_FUNCMODE_STDCALL ) then
			'' In LLVM, @ is a special char, identifiers using it must be quoted
			mangled += """"
		end if
	end if

	'' Win32 underscore prefix
	if( hAddUnderscore( ) ) then
		mangled += "_"
	end if

	'' C++ prefix
	if( docpp ) then
		mangled += "_Z"
	end if

	'' namespace or class
	if( docpp ) then
		hMangleNamespace( mangled, symbGetNamespace( sym ), TRUE, symbIsConstant( sym ) )
	end if

	'' id
	if( (sym->stats and FB_SYMBSTATS_HASALIAS) <> 0 ) then
		'' Explicit proc ALIAS given, overriding the default id
		'' (even for constructors, operators and properties)
		'' id length (C++ only)
		if( docpp ) then
			mangled += str( len( *sym->id.alias ) )
		end if
		'' id
		mangled += *sym->id.alias
	elseif( symbIsOperator( sym ) ) then
		if( symbGetProcOpOvl( sym ) = AST_OP_CAST ) then
			mangled += "cv"
			'' mangle the return type
			symbMangleType( mangled, symbGetFullType( sym ), symbGetSubtype( sym ) )
		else
			mangled += *hGetOperatorName( sym )
		end if
	elseif( symbIsConstructor( sym ) ) then
		mangled += "C1"
	elseif( symbIsDestructor( sym ) ) then
		mangled += "D1"
	else
		if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
			'' BASIC, use the upper-cased name
			id = sym->id.name
		else
			'' use the case-sensitive name saved in the alias
			id = sym->id.alias
		end if

		'' id length (C++ only)
		if( docpp ) then
			length = len( *id )
			if( symbIsProperty( sym ) ) then
				length += 7  '' __get__ or __set__ (see below)
			end if
			mangled += str( length )
		end if

		'' id
		mangled += *id
		if( symbIsProperty( sym ) ) then
			'' custom property mangling,
			'' since the base id is the same for setters/getters
			'' GET?
			if( symbGetType( sym ) = FB_DATATYPE_VOID ) then
				mangled += "__set__"
			else
				mangled += "__get__"
			end if
		end if
	end if

	'' params
	if( docpp ) then
		'' nested? (namespace or class)
		if( hIsNested( sym ) ) then
			mangled += "E"
		end if
		hGetProcParamsTypeCode( mangled, sym )
	end if

	'' @N win32 stdcall suffix
	if( sym->proc.mode = FB_FUNCMODE_STDCALL ) then
		'' But not for the C backend, because gcc will do it already.
		if( env.clopt.backend <> FB_BACKEND_GCC ) then
			mangled += "@" + str( symbCalcProcParamsLen( sym ) )
		end if

		if( env.clopt.backend = FB_BACKEND_LLVM ) then
			'' In LLVM, @ is a special char, identifiers using it must be quoted
			mangled += """"
		end if
	end if

	symbMangleEndAbbrev( )

	'' Store the mangled id into the symbol
	sym->id.mangled = ZStrAllocate( len( mangled ) )
	*sym->id.mangled = mangled
end sub
