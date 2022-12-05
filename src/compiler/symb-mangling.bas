'' symbol mangling module (compatible with the GCC 3.x ABI)
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "flist.bi"
#include once "hash.bi"
#include once "ir.bi"

type FB_MANGLEABBR
	idx             as integer
	dtype           as integer
	subtype         as FBSYMBOL ptr
end type

type FB_MANGLECTX
	flist               as TFLIST                   '' of FB_MANGLEABBR
	cnt                 as integer

	tempstr             as zstring * 6 + 10 + 1
	uniqueidcount       as integer
	uniquelabelcount    as integer
	profilelabelcount   as integer
end type

const FB_INITMANGARGS = 96

declare function hDoCppMangling( byval sym as FBSYMBOL ptr ) as integer
declare sub hMangleProc( byval sym as FBSYMBOL ptr )
declare sub hMangleVariable( byval sym as FBSYMBOL ptr )
declare sub hGetProcParamsTypeCode _
	( _
		byref mangled as string, _
		byval sym as FBSYMBOL ptr, _
		byval is_real_proc as integer _
	)
declare sub hMangleNamespace _
	( _
		byref mangled as string, _
		byval ns as FBSYMBOL ptr, _
		byval dohashing as integer, _
		byval isconst as integer _
	)

'' inside a namespace or class?
#define hIsNested(s) (symbGetNamespace( s ) <> @symbGetGlobalNamespc( ))

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

function symbUniqueId( byval validfbname as boolean ) as zstring ptr
	if( (env.clopt.backend = FB_BACKEND_GCC) and (validfbname = false) ) then
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
		if( env.clopt.target = FB_COMPTARGET_DARWIN ) then
			ctx.tempstr = "L_"
		else
			ctx.tempstr = ".L_"
		end if
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

	'' Respect ALIAS for array descriptor types, to avoid exposing their
	'' internal mangling
	if( symbIsStruct( sym ) and symbIsDescriptor( sym ) ) then
		if( sym->id.alias ) then
			return sym->id.alias
		end if
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

private sub symbSetMangledId( byval sym as FBSYMBOL ptr, byref mangled as string )
	assert( sym->id.mangled = NULL )
	sym->id.mangled = ZStrAllocate( len( mangled ) )
	*sym->id.mangled = mangled
end sub

private sub hMangleUdtId( byref mangled as string, byval sym as FBSYMBOL ptr )
	dim as integer arraydtype = any
	dim as FBSYMBOL ptr arraysubtype = any

	'' Itanium C++ ABI: All identifiers are encoded as:
	'' <length><id>
	if( sym->id.alias ) then
		mangled += str( len( *sym->id.alias ) )
		mangled += *sym->id.alias
	else
		mangled += str( len( *sym->id.name ) )
		mangled += *sym->id.name
	end if

	''
	'' Array descriptor mangling: '__FBARRAY[1-8]<dtype>'
	'' (based on the ALIAS specified in symbAddArrayDescriptorType())
	''
	'' The dimension count is already encoded in the ALIAS (also see
	'' symbAddArrayDescriptorType()); and we'll encode the
	'' arraydtype as template argument here - this allows C++
	'' demanglers to decode the arraydtype nicely.
	''
	'' The dimension count and arraydtype must be encoded in the
	'' name mangling, because FB allows overloading based on that.
	''
	if( symbIsStruct( sym ) and symbIsDescriptor( sym ) ) then
		mangled += "I" '' begin of template argument list

		symbGetDescTypeArrayDtype( sym, arraydtype, arraysubtype )
		symbMangleType( mangled, arraydtype, arraysubtype, FB_MANGLEOPT_KEEPTOPCONST )

		mangled += "E" '' end of template argument list
	end if
end sub

function symbGetMangledName( byval sym as FBSYMBOL ptr ) as zstring ptr
	if( sym->id.mangled ) then
		return sym->id.mangled
	end if

	assert( ctx.cnt = 0 )

	select case as const( symbGetClass( sym ) )
	case FB_SYMBCLASS_PROC
		hMangleProc( sym )
	case FB_SYMBCLASS_ENUM, FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_FWDREF, _
	     FB_SYMBCLASS_CLASS, FB_SYMBCLASS_NAMESPACE
		dim as string mangled
		hMangleNamespace( mangled, symbGetNamespace( sym ), TRUE, FALSE )
		hMangleUdtId( mangled, sym )
		if( hIsNested( sym ) ) then
			mangled += "E"
		end if
		symbSetMangledId( sym, mangled )
	case FB_SYMBCLASS_VAR
		hMangleVariable( sym )
	case else
		return sym->id.alias
	end select

	symbMangleResetAbbrev( )

	'' Periods in symbol names?  not allowed in C, must be replaced.
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			hReplaceChar( sym->id.mangled, asc( "." ), asc( "$" ) )
		end if
	end if

	function = sym->id.mangled
end function

'' Reset the abbreviation list.
'' Every symbMangleType() will add abbreviations, and the list must be reset
'' every time (after a symbol was mangled), to prevent the abbreviations from
'' leaking into the mangling process of the next symbol.
sub symbMangleResetAbbrev( )
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

	'' for each item..
	n = flistGetHead( @ctx.flist )
	do while( n <> NULL )
		'' same type?
		if( n->subtype = subtype ) then
			if( n->dtype = dtype ) then
				return n->idx
			end if
		end if

		n = flistGetNext( n )
	loop

	function = -1
end function

'' Add qualified/non-built-in type to lookup table for substitution/compression
'' according to Itanium C++ ABI.
private function hAbbrevAdd _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as FB_MANGLEABBR ptr

	dim as FB_MANGLEABBR ptr n = any

	n = flistNewItem( @ctx.flist )
	n->idx = ctx.cnt

	n->dtype = dtype
	n->subtype = subtype

	ctx.cnt += 1

	function = n
end function

private sub hAbbrevGet( byref mangled as string, byval idx as integer )
	mangled += "S"

	'' abbreviation index   mangling
	''   0                    S_
	''   1                    S0_
	''   2                    S1_
	'' etc.

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

function hMangleBuiltInType _
	( _
		byval dtype as integer, _
		byref add_abbrev as integer _
	) as zstring ptr

	assert( dtype = (typeGetDtOnly( dtype ) or (dtype and FB_DT_MANGLEMASK)) )

	''
	'' Plain unqualified C++ built-in types are not considered for abbreviation.
	'' However, custom/vendor-specific types still are.
	''
	'' This only matters when hMangleBuiltInType() is called from
	'' symbMangleType(), but it does not matter when hMangleBuiltInType() is
	'' just used encode type suffixes into variable names for the C backend.
	''
	add_abbrev = FALSE

	if( dtype = FB_DATATYPE_STRING ) then
		add_abbrev = TRUE
		return @"8FBSTRING"
	end if

	''
	'' Integer/Long mangling:
	''
	''           32bit        64bit
	'' Integer   long         long (Unix) or INTEGER (Windows)
	'' Long      int          int
	'' LongInt   long long    long long
	''
	''  - Fundamental problem: FB and C++ types are different, an exact mapping
	''    is impossible
	''
	''  - mangling should match the C/C++ binding recommendations, i.e. use Long
	''    for int and Integer for things like ssize_t. On linux-x86_64 Integer
	''    can be mangled as long, but on win64 the only 64bit integer type is
	''    long long and that's already used for LongInt. So it seems that we have
	''    to use a custom mangling for that case (INTEGER).
	''
	''  - 32bit fbc used to mangle Integer as int and Long as long, but to match
	''    64bit fbc it was reversed, allowing the same FB and C++ code to work
	''    together on both 32bit and 64bit.
	''
	''  - as special exception for windows 64bit, to get a 32bit type that will
	''    mangle to C++ long, allow 'as [u]long alias "[u]long"' declarations.
	''    The size of LONG/ULONG does not change, it's 32bit, only the mangling,
	''    so fbc programs can call C++ code requiring 'long int' arguments.

	if( fbIs64bit( ) and ((env.target.options and FB_TARGETOPT_UNIX) = 0) ) then
		'' Windows 64bit

		'' check for remapping of dtype mangling
		if( typeHasMangleDt( dtype ) ) then
			dtype = typeGetMangleDt( dtype )
			'' Windows 64bit
			select case( dtype )
			case FB_DATATYPE_INTEGER : return @"l"  '' long
			case FB_DATATYPE_UINT    : return @"m"  '' unsigned long
			end select
		else
			'' Itanium C++ ABI compatible mangling of non-C++ built-in types (vendor extended types):
			''    u <length-of-id> <id>
			select case( dtype )
			case FB_DATATYPE_INTEGER : add_abbrev = TRUE : return @"u7INTEGER"  '' seems like a good choice
			case FB_DATATYPE_UINT    : add_abbrev = TRUE : return @"u8UINTEGER"
			end select
		end if

	else
		'' 32bit, Unix 64bit
		select case( dtype )
		case FB_DATATYPE_INTEGER : return @"l"  '' long
		case FB_DATATYPE_UINT    : return @"m"  '' unsigned long
		end select
	end if

	'' Still have a mangle data type? remap.
	if( typeHasMangleDt( dtype ) ) then
		dtype = typeGetMangleDt( dtype )
	end if

	'' dtype should be a FB_DATATYPE by now
	assert( dtype = typeGetDtOnly( dtype ) )

	static as zstring ptr typecodes(0 to FB_DATATYPES-1) => _
	{ _
		@"v", _ '' void
		@"b", _ '' boolean
		@"a", _ '' Byte: signed char
		@"h", _ '' UByte: unsigned char
		@"c", _ '' char
		@"s", _ '' short
		@"t", _ '' ushort
		@"w", _ '' wchar
		NULL, _ '' Integer
		NULL, _ '' UInteger
		NULL, _ '' enum
		@"i", _ '' Long: int
		@"j", _ '' ULong: unsigned int
		@"x", _ '' LongInt: long long
		@"y", _ '' ULongInt: unsigned long long
		@"f", _ '' Single: float
		@"d", _ '' double
		NULL, _ '' var-len string
		NULL, _ '' fix-len string
		@"c", _ '' va_list
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
		byval subtype as FBSYMBOL ptr, _
		byval options as FB_MANGLEOPT = FB_MANGLEOPT_NONE _
	)

	dim as FBSYMBOL ptr ns = any
	dim as integer add_abbrev = any

	'' Lookup abbreviation for this type/namespace (if the current procedure
	'' name already contains the type somewhere, it can be referred to
	'' through an index instead of by repeating the full name, as specified
	'' in the Itanium C++ ABI)
	dim as integer idx = hAbbrevFind( dtype, subtype )
	if( idx <> -1 ) then
		hAbbrevGet( mangled, idx )
		exit sub
	end if

	'' forward type?
	if( typeGet( dtype ) = FB_DATATYPE_FWDREF ) then
		'' Remap to STRUCT for mangling purposes
		dtype = typeJoin( dtype and (not FB_DATATYPE_INVALID), FB_DATATYPE_STRUCT )
	end if

	'' reference?
	if( typeIsRef( dtype ) ) then
		mangled += "R"

		symbMangleType( mangled, typeUnsetIsRef( dtype ), subtype, _
		                options or FB_MANGLEOPT_HASREF or FB_MANGLEOPT_KEEPTOPCONST)

		hAbbrevAdd( dtype, subtype )
		exit sub
	end if

	'' const?
	if( typeIsConst( dtype ) ) then
		'' If mangling a pointed-to type of a reference or pointer,
		'' the CONST is included in the mangling (FB_MANGLEOPT_KEEPTOPCONST).
		''
		'' But, if the CONST is at toplevel, it's not included,
		'' because "byval x as const type" is effectively the same as a "byval x as type".
		'' C++ and FB do not allow overloads that differ only in BYVAL CONSTness.

		if( (options and FB_MANGLEOPT_KEEPTOPCONST) <> 0 ) then
			mangled += "K"
		end if

		symbMangleType( mangled, typeUnsetIsConst( dtype ), subtype, options )

		'' Skipped toplevel CONSTs are not considered for abbreviation.
		if( (options and FB_MANGLEOPT_KEEPTOPCONST) <> 0 ) then
			hAbbrevAdd( dtype, subtype )
		end if
		exit sub
	end if

	'' pointer?
	if( typeIsPtr( dtype ) ) then
		mangled += "P"

		symbMangleType( mangled, typeDeref( dtype ), subtype, _
		                options or FB_MANGLEOPT_HASPTR or FB_MANGLEOPT_KEEPTOPCONST )

		hAbbrevAdd( dtype, subtype )
		exit sub
	end if

	'' struct with __builtin_va_list mangle modifier?
	'' use the stuct name instead
	if( typeHasMangleDt( dtype ) ) then
		if( typeGetDtOnly( dtype ) = FB_DATATYPE_STRUCT ) then
			if( typeGetMangleDt( dtype ) = FB_DATATYPE_VA_LIST ) then

				select case symbGetValistType( dtype, subtype )
				case FB_CVA_LIST_BUILTIN_C_STD
					'' if the type was passed as byval ptr or byref
					'' need to mangle in "A1_" to indicate the array type, but
					'' not on aarch64, __va_list is a plain struct, it doesn't
					'' need the array type specifier.

					if( (options and (FB_MANGLEOPT_HASREF or FB_MANGLEOPT_HASPTR)) <> 0 ) then
						mangled += "A1_"
					else
						mangled += "P"
					end if
					dtype = typeSetMangleDt( dtype, 0 )

				case FB_CVA_LIST_BUILTIN_AARCH64, FB_CVA_LIST_BUILTIN_ARM
					'' on arm and aarch targets, __builtin_va_list actually
					'' maps to "std::__va_list" where "std::" has the mangling
					'' identifier of "St"

					mangled += "St"
					dtype = typeSetMangleDt( dtype, 0 )

				end select
			end if
		end if
	end if

	''
	'' Plain type without reference/pointer/const bits
	''
	assert( dtype = (typeGetDtOnly( dtype ) or (dtype and FB_DT_MANGLEMASK)) )

	select case( typeGetDtOnly( dtype ) )
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		ns = symbGetNamespace( subtype )
		if( ns = @symbGetGlobalNamespc( ) ) then
			hMangleUdtId( mangled, subtype )
		else
			if( (options and FB_MANGLEOPT_NESTED) = 0 ) then
				mangled += "N"
			end if
			symbMangleType( mangled, symbGetFullType( ns ), ns, FB_MANGLEOPT_NESTED )
			hMangleUdtId( mangled, subtype )
			if( (options and FB_MANGLEOPT_NESTED) = 0 ) then
				mangled += "E"
			end if
		end if

		hAbbrevAdd( dtype, subtype )

	case FB_DATATYPE_NAMESPC
		if( subtype = @symbGetGlobalNamespc( ) ) then
			exit sub
		end if

		ns = symbGetNamespace( subtype )
		if( ns ) then
			symbMangleType( mangled, FB_DATATYPE_NAMESPC, ns )
		end if
		hMangleUdtId( mangled, subtype )

		hAbbrevAdd( dtype, subtype )

	case FB_DATATYPE_FUNCTION
		'' F(byref)(const)(return_type)(params - recursive, reuses hash)E
		mangled += "F"

		'' return BYREF?
		if( symbIsReturnByRef( subtype ) ) then
			mangled += "R"
		end if

		'' const?
		'' (for function results, even BYVAL CONST is encoded into the
		'' C++ mangling, unlike for parameters)
		if( typeIsConst( symbGetFullType( subtype ) ) ) then
			mangled += "K"
		end if

		symbMangleType( mangled, symbGetFullType( subtype ), symbGetSubtype( subtype ) )
		hGetProcParamsTypeCode( mangled, subtype, FALSE )

		mangled += "E"

		hAbbrevAdd( dtype, subtype )

	case else
		mangled += *hMangleBuiltInType( dtype, add_abbrev )
		if( add_abbrev ) then
			hAbbrevAdd( dtype, subtype )
		end if
	end select

end sub

sub symbMangleParam( byref mangled as string, byval param as FBSYMBOL ptr )
	select case as const( symbGetParamMode( param ) )
	case FB_PARAMMODE_BYVAL
		symbMangleType( mangled, param->typ, param->subtype )

	case FB_PARAMMODE_BYREF
		symbMangleType( mangled, typeSetIsRef( param->typ ), param->subtype )

	case FB_PARAMMODE_BYDESC
		'' Mangling array params as 'FBARRAY[1-8]<dtype>&' because
		'' that's what they really are from C++'s point of view.
		assert( symbIsDescriptor( param->param.bydescrealsubtype ) )
		symbMangleType( mangled, typeSetIsRef( FB_DATATYPE_STRUCT ), param->param.bydescrealsubtype, FB_MANGLEOPT_KEEPTOPCONST )

	case FB_PARAMMODE_VARARG
		mangled += "z"
	end select
end sub

private function hAddUnderscore( ) as integer
	'' C backend? don't add underscores; gcc will already do it.
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		function = FALSE
	else
		'' For ASM, add underscores if the target requires it
		function = env.underscoreprefix
	end if
end function

private function hDoCppMangling( byval sym as FBSYMBOL ptr ) as integer
	'' C++?
	if( symbGetMangling( sym ) = FB_MANGLING_CPP ) then
		return TRUE
	end if

	'' RTL or exclude parent?
	if( (symbGetStats( sym ) and (FB_SYMBSTATS_RTL or FB_SYMBSTATS_EXCLPARENT)) <> 0 ) then
		return FALSE
	end if

	'' extern "rtlib"? disable cpp mangling
	if( symbGetMangling( sym ) = FB_MANGLING_RTLIB ) then
		'' disable cpp mangling only if it's not internally generated:
		'' Internally generated symbols:
		''   - vtable
		''   - rtti
		''   - default constructor / copy constructor
		''   - default assignment operator
		''   - default complete destructor / deleting constructor

		if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_INTERNAL)) = 0 ) then
			return FALSE
		end if
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
		'' (just doing hAbbrevFind()/hAbbrevAdd() is not enough,
		'' because the parent namespaces may need to be abbreviated too,
		'' which symbMangleType() will do recursively)
		dim as string unused
		symbMangleType( unused, symbGetFullType( ns ), ns )
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
		hMangleUdtId( mangled, ns )
		tos -= 1
	loop until( tos < 0 )
end sub

private sub hMangleVariable( byval sym as FBSYMBOL ptr )
	'' local optimization for 'id' allocation - it's always initialized by logic below
	static as string id

	'' !!!TODO!!! should varcounter reset between modules and on restarts with fbRestartableStaticVariable()?
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

		'' Win32 underscore prefix
		if( hAddUnderscore( ) ) then
			mangled += "_"
		end if

		select case( env.clopt.target )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			'' Win32 import? Add same prefix as done by gcc
			if( symbIsImport( sym ) ) then
				mangled += "_imp__"
			end if
		end select

		if( docpp ) then
			'' Note: This adds the _Z prefix to all global variables,
			'' unlike GCC, which does C++ mangling only for globals inside
			'' namespaces, but not globals from the toplevel namespace.
			mangled += "_Z"

			if( sym->stats and FB_SYMBSTATS_RTTITABLE ) then
				mangled += "TS"
			elseif( sym->stats and FB_SYMBSTATS_VTABLE ) then
				mangled += "TV"
			end if
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

	'' rtti/vtables don't have an id, their mangled name is just the prefixes
	'' plus the parent UDT namespace(s), all done above already
	if( sym->stats and (FB_SYMBSTATS_RTTITABLE or FB_SYMBSTATS_VTABLE) ) then
		id = ""
	'' id
	elseif( sym->stats and FB_SYMBSTATS_HASALIAS ) then
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
				if( ( env.clopt.backend = FB_BACKEND_GCC ) or (env.clopt.backend = FB_BACKEND_GAS64) ) then
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
			case FB_BACKEND_GAS64
				if( symbGetMangling( sym ) = FB_MANGLING_BASIC ) then
					'' BASIC mangling, use the upper-cased name
					id = *sym->id.name

					'' Type suffix?
					if( symbIsSuffixed( sym ) ) then
						id += *hMangleBuiltInType( symbGetType( sym ) )
					end if

					'' Make the symbol unique - gas doesn't have scopes.
					'' (appending the scope level wouldn't be enough due to
					'' conflicts between sibling scopes)
					id += "." + str( varcounter )
					varcounter += 1
				elseif( symbIsStatic( sym ) ) then
					id = *symbUniqueId( )
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

	if( len( id ) > 0 ) then
		'' id length (C++ only) followed by the id itself
		if( docpp ) then
			mangled += str( len( id ) )
		end if
		mangled += id
	end if

	if( docpp ) then
		'' nested? (namespace or class)
		if( hIsNested( sym ) ) then
			mangled += "E"
		end if
	end if

	symbSetMangledId( sym, mangled )
end sub

private sub hGetProcParamsTypeCode _
	( _
		byref mangled as string, _
		byval sym as FBSYMBOL ptr, _
		byval is_real_proc as integer _
	)

	dim as FBSYMBOL ptr param = any

	param = symbGetProcHeadParam( sym )
	if( param <> NULL ) then
		''
		'' When doing C++ mangling for method, the THIS pointer isn't
		'' included in the mangled name.
		''
		'' However, when producing the unique internal id for a
		'' procedure pointer, we need to encode even the THIS pointer.
		'' Also see symbAddProcPtr(). This can happen with the symbols
		'' created by symbAddProcPtrFromFunction() when calling a
		'' virtual method through the procedure pointer in the vtable.
		''
		if( is_real_proc and symbIsInstanceParam( param ) ) then
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

	case AST_OP_LEN
		function = @"v13len"

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

	case AST_OP_SQRT
		function = @"v13sqr"

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
	dim as integer length = any, docpp = any, add_stdcall_suffix = any
	dim as integer quote_mangled_name = false
	dim as zstring ptr id = any

	docpp = hDoCppMangling( sym )

	'' Should the @N win32 stdcall suffix be added for this procedure?
	'' * only for stdcall/fastcall, not stdcallms/cdecl/pascal/thiscall
	''   (that also makes it win32-only)
	'' *
	'' * only on x86, since these calling conventions matter there only
	'' * only for ASM/LLVM backends, but not for the C backend, because gcc
	''   will do it already
	add_stdcall_suffix = ((sym->proc.mode = FB_FUNCMODE_STDCALL) or _
	                     ((sym->proc.mode = FB_FUNCMODE_FASTCALL) and _
	                     ((env.clopt.target = FB_COMPTARGET_WIN32) or _
	                      (env.clopt.target = FB_COMPTARGET_CYGWIN) or _
	                      (env.clopt.target = FB_COMPTARGET_XBOX)))) and _
	                     (fbGetCpuFamily( ) = FB_CPUFAMILY_X86) and _
	                     (env.clopt.backend <> FB_BACKEND_GCC)

	'' LLVM: @ prefix for global symbols
	if( env.clopt.backend = FB_BACKEND_LLVM ) then
		mangled += "@"

		'' TODO: should be able to clean up this logic where we have a windows
		'' target and remove the check on 'add_stdcall_suffix' here.
		'' on win we are also quoting and escaping and should not need to quote
		'' only or have @N suffix only on any other target.

		'' Going to add @N stdcall suffix below?
		'' In LLVM, @ is a special char, identifiers using it must be quoted
		if( add_stdcall_suffix ) then
			mangled += """"
			quote_mangled_name = true
		end if

		'' Windows target also? we provide the mangling so the name
		'' must be both quoted and escaped so that our mangled name does not
		'' get mangled again by llvm.  we need to do this on all names
		'' not just the ones with @N suffix due the leading underscore handling
		select case( env.clopt.target )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX
			if( quote_mangled_name = false ) then
				mangled += """"
				quote_mangled_name = true
			end if

			'' chr(1) will escape the name so it's passed through to assembler as-is
			mangled += chr(1)
		end select

	end if

	'' Win32 underscore prefix
	if( hAddUnderscore( ) ) then
		if( sym->proc.mode = FB_FUNCMODE_FASTCALL ) then
			select case( env.clopt.target )
			case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN, FB_COMPTARGET_XBOX
				mangled += "@"
			case else
				mangled += "_"
			end select
		else
			mangled += "_"
		end if
	end if

	'' C++ prefix
	'' global overloaded operators need the prefix
	if( docpp or symbIsOperator( sym ) ) then
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
	elseif( symbIsDestructor0( sym ) ) then
		mangled += "D0"
	elseif( symbIsDestructor1( sym ) ) then
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
		hGetProcParamsTypeCode( mangled, sym, TRUE )
	end if

	'' @N win32 stdcall suffix
	if( add_stdcall_suffix ) then
		mangled += "@" + str( symbProcCalcStdcallSuffixN( sym ) )
	end if

	'' close the quoted name if needed
	if( quote_mangled_name ) then
		mangled += """"
	end if

	symbSetMangledId( sym, mangled )
end sub
