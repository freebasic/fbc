'' symbol table module for constants
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "dstr.bi"

'':::::
function symbAddConst _
	( _
		byval symbol as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as FBVALUE ptr, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	function = NULL

	sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
	                     NULL, _
	                     NULL, NULL, _
	                     FB_SYMBCLASS_CONST, _
	                     symbol, NULL, _
	                     dtype, subtype, _
	                     attrib, FB_PROCATTRIB_NONE )
	if( sym = NULL ) then
		exit function
	end if

	sym->val = *value

	function = sym
end function

'' Add new constant unless it already exists
function symbReuseOrAddConst _
	( _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as FBVALUE ptr, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

	function = NULL

	var sym = symbAddConst( id, dtype, subtype, value, attrib )

	if( sym = NULL ) then

		'' Duplicate definition; allow it if the existing symbol is
		'' also a CONST and has the same dtype and value.  If it does
		'' not have same dtype and value, allow it anyway if it is a
		'' symbol that may be redefined.
		sym = symbLookupByNameAndClass( symbGetCurrentNamespc( ), id, FB_SYMBCLASS_CONST, FALSE, FALSE )
		if( sym = NULL ) then
			'' There is an existing symbol with that name but it's not a constant, duplicate definition.
			exit function
		end if

		dim is_same as integer = FALSE

		'' same type?
		if( (sym->typ = dtype) and (sym->subtype = subtype) ) then

			'' same value?
			select case( typeGetDtAndPtrOnly( dtype ) )
			case FB_DATATYPE_STRING, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				'' Compare the string literal symbol (global VAR),
				'' symbAllocStrConst() will have re-used the same symbol if it's the same string.
				is_same = (value->s = sym->val.s)

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				'' Doing byte-by-byte comparison, instead of comparing floats,
				'' as float comparisons are unreliable
				assert( sizeof( value->f   ) = sizeof( ulongint ) )
				assert( sizeof( sym->val.f ) = sizeof( ulongint ) )
				is_same = (*cptr( ulongint ptr, @value->f ) = *cptr( ulongint ptr, @sym->val.f ))

			case else
				assert( typeGetClass( dtype ) = FB_DATACLASS_INTEGER )
				is_same = (value->i = sym->val.i)
			end select
		end if

		'' even if there is a name-type-value collision, may still be allowed
		if( is_same = FALSE ) then
			'' redefinition allowed?
			if( symbGetCanRedef( sym ) ) then
				errReportWarn( FB_WARNINGMSG_REDEFINITIONOFINTRINSIC )
				'' remove from lookup, but not type symbol data, it
				'' may be referenced from elsewhere
				symbDelFromHash( sym )
				'' try again
				sym = symbAddConst( id, dtype, subtype, value, attrib )
			else
				'' duplicate definition
				sym = NULL
			end if
		else
			sym->stats and= not FB_SYMBSTATS_CANREDEFINE
		end if
	end if

	function = sym
end function

''
'' Add or lookup a global var for the given value. The value string must
'' uniquely represent the value and the type size, such that we can use it as
'' the internal name for the global var. By re-using an existing global var (if
'' any) we ensure to only add one global var for each value and type size.
''
'' Variables with different dtype size must be treated different from
'' each-other, otherwise there could be buffer overflows in generated code if we
'' expect a 8 byte var and get a 4 byte one. symbAllocFloatConst and
'' symbAllocIntConst ensure this by using either 8 or 16 hex digits (4 or 8 byte
'' var).
''
'' We identify vars only based on the value and the type size, but not based on
'' the dtype. This way a 4 byte integer and a Single are the same, as long as
'' they have the same value (in terms of the in-memory representation), and we
'' avoid unnecessary duplicates.
''
private function hAllocIntOrFloatConst _
	( _
		byref svalue as string, _
		byval dtype as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXINTNAMELEN+1 id
	dim as FBARRAYDIM dTB(0)

	function = NULL

	id = "{fbnc}"
	id += svalue

	'' preserve case, 'D', 'd', 'E', 'e' will become 'e' in lexer
	var s = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), @id, FB_SYMBCLASS_VAR, TRUE, FALSE )
	if( s <> NULL ) then
		return s
	end if

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVar( @id, symbUniqueId( ), dtype, NULL, 0, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )
	assert( s )

	s->var_.littext = ZstrAllocate( len( svalue ) )
	*s->var_.littext = svalue

	function = s
end function

function symbAllocFloatConst( byval value as double, byval dtype as integer ) as FBSYMBOL ptr
	function = hAllocIntOrFloatConst( hFloatToHex( value, dtype ), dtype )
end function

function symbAllocIntConst( byval value as longint, byval dtype as integer ) as FBSYMBOL ptr
	dim as string svalue = "0x"
	if( typeGetSize( dtype ) = 8 ) then
		svalue += hex( value, 16 )
	else
		'' Using an intermediate uinteger to allow compiling with FB
		'' versions before the overload resolution overhaul
		svalue += hex( cuint( culng( value ) ), 8 )
	end if
	function = hAllocIntOrFloatConst( svalue, dtype )
end function

'':::::
function symbAllocStrConst _
	( _
		byval sname as zstring ptr, _
		byval strlength as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s = any

	function = NULL

	'' the strlength passed isn't the real one because it doesn't
	'' take into acount the escape characters
	dim as integer internalstrlen = len( *sname )
	if( strlength < 0 ) then
		strlength = internalstrlen
	end if

	if( internalstrlen <= FB_MAXNAMELEN-6 ) then
		id = "{fbsc}"
		id += *sname
	else
		id = *symbUniqueId( )
	end if

	s = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), @id, FB_SYMBCLASS_VAR, TRUE, FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *symbUniqueId( )

	'' strlength += the null-char (rtlib wrappers will take it into account)

	'' it must be declare as SHARED, see symbAllocFloatConst()
	var strsize = strlength + 1
	s = symbAddVar( @id, @id_alias, FB_DATATYPE_CHAR, NULL, strsize, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	s->var_.littext = ZstrAllocate( internalstrlen )
	*s->var_.littext = *sname

	function = s
end function

function symbAllocWStrConst _
	( _
		byval sname as wstring ptr, _
		byval strlength as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s = any

	function = NULL

	'' the strlength passed isn't the real one because it doesn't
	'' take into acount the escape characters
	dim as integer internalstrlen = len( *sname )
	if( strlength < 0 ) then
		strlength = internalstrlen
	end if

	'' hEscapeW() can use up to (4 * sizeof(wchar)) ascii chars per unicode char
	'' (up to one '\ooo' per byte of wchar)
	if( internalstrlen * ((1+3) * sizeof( wstring )) <= FB_MAXNAMELEN-6 ) then
		id = "{fbwc}"
		id += *hEscapeW( sname )
	else
		id = *symbUniqueId( )
	end if

	s = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), @id, FB_SYMBCLASS_VAR, TRUE, FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *symbUniqueId( )

	'' it must be declare as SHARED, see symbAllocFloatConst()
	var strsize = (strlength + 1) * typeGetSize( FB_DATATYPE_WCHAR )
	s = symbAddVar( @id, @id_alias, FB_DATATYPE_WCHAR, NULL, strsize, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	s->var_.littextw = WstrAllocate( internalstrlen )
	*s->var_.littextw = *sname

	function = s
end function

sub symbDelConst( byval s as FBSYMBOL ptr )
	if( s = NULL ) then
		exit sub
	end if

	'' if it's a string, the symbol attached will be deleted be delVar()
	symbFreeSymbol( s )
end sub

function symbGetConstValueAsStr( byval s as FBSYMBOL ptr ) as string
	select case( symbGetType( s ) )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		function = *symbGetConstStr( s )->var_.littext

	case FB_DATATYPE_DOUBLE
		function = str( symbGetConstFloat( s ) )

	case FB_DATATYPE_SINGLE
		function = str( csng( symbGetConstFloat( s ) ) )

	case else
		if( typeIsSigned( s->typ ) ) then
			function = str( symbGetConstInt( s ) )
		else
			function = str( cunsg( symbGetConstInt( s ) ) )
		end if
	end select
end function

function symbCloneConst( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	'' no need to make a copy of fbvalue.str, if it's a literal,
	'' it will be a non-local var
	function = symbAddConst( NULL, symbGetType( sym ), symbGetSubtype( sym ), _
	                         symbGetConstVal( sym ), symbGetAttrib( sym ) )
end function

function symbGetConstStrAsStr( byval s as FBSYMBOL ptr ) as zstring ptr

	assert( (symbGetType( s ) = FB_DATATYPE_CHAR) _
	        or (symbGetType( s ) = FB_DATATYPE_WCHAR) )

	static as DZSTRING res

	DZStrAssign( res, NULL )

	'' ASCII to ASCII
	if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
		dim textlen as integer
		dim text as zstring ptr = hUnescape( symbGetVarLitText( s ), textlen )
		if( len(*text) <> textlen ) then
			DZStrConcatAssign( res, "!" + QUOTE )
			for i as integer = 0 to textlen - 1
				DZStrConcatAssign( res, $"\x" & hex( cast( ulong, (*text)[i] ), 2 ) )
			next
		else
			DZStrConcatAssign( res, "$" + QUOTE )
			DZStrConcatAssign( res, text )
		end if
		DZStrConcatAssign( res, QUOTE )

	'' WSTRING to ASCII - always escape
	else
		dim textlen as integer
		dim text as wstring ptr = hUnescapeW( symbGetVarLitTextW( s ), textlen )
		DZStrConcatAssign( res, "!" + QUOTE )
		for i as integer = 0 to textlen - 1
			'' !!!FIXME!!! \u escaping assumptions
			DZStrConcatAssign( res, $"\u" & hex( cast( ulong, (*text)[i] ), 4 ) )
		next
		DZStrConcatAssign( res, QUOTE )
	end if

	return res.data

end function

function symbGetConstStrAsWstr( byval s as FBSYMBOL ptr ) as wstring ptr

	assert( (symbGetType( s ) = FB_DATATYPE_CHAR) _
	        or (symbGetType( s ) = FB_DATATYPE_WCHAR) )

	static as DWSTRING res

	DWStrAssign( res, NULL )

	'' WSTRING to WSTRING
	if( symbGetType( s ) = FB_DATATYPE_WCHAR ) then
		dim textlen as integer
		dim text as wstring ptr = hUnescapeW( symbGetVarLitTextW( s ), textlen )
		if( len(*text) <> textlen ) then
			DWStrConcatAssign( res, "!" + QUOTE )
			for i as integer = 0 to textlen - 1
				'' !!!FIXME!!! \u escaping assumptions
				DWStrConcatAssign( res, $"\u" & hex( cast( ulong, (*text)[i] ), 4 ) )
			next
		else
			DWStrConcatAssign( res, "$" + QUOTE )
			DWStrConcatAssign( res, text )
		end if
		DWStrConcatAssign( res, QUOTE )

	'' ASCII to WSTRING? escape everything, it's easier.
	else
		dim textlen as integer
		dim text as zstring ptr = hUnescape( symbGetVarLitText( s ), textlen )
		DWStrConcatAssign( res, "!" + QUOTE )
		for i as integer = 0 to textlen - 1
			'' !!!FIXME!!! \u escaping assumptions
			DWStrConcatAssign( res, $"\u" & hex( cast( ulong, (*text)[i] ), 4 ) )
		next
		DWStrConcatAssign( res, QUOTE )
	end if

	return res.data

end function
