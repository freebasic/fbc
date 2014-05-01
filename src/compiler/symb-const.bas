'' symbol table module for constants
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ir.bi"

'':::::
function symbAddConst _
	( _
		byval symbol as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as FBVALUE ptr, _
		byval attrib as integer _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr sym = any

    function = NULL

    sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    					 NULL, _
    					 NULL, NULL, _
    					 FB_SYMBCLASS_CONST, _
    				   	 symbol, NULL, _
    				   	 dtype, subtype, _
    				   	 attrib )
	if( sym = NULL ) then
		exit function
	end if

	sym->val = *value

	function = sym
end function

function symbAllocFloatConst _
	( _
		byval value as double, _
		byval dtype as integer _
	) as FBSYMBOL ptr

    static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s = any

	function = NULL

	'' can't use STR() because GAS doesn't support the 1.#INF notation
	dim as string svalue = hFloatToHex( value, dtype )

	id = "{fbnc}"
	id += svalue

	'' preserve case, 'D', 'd', 'E', 'e' will become 'e' in lexer
	s = symbLookupByNameAndSuffix( @symbGetGlobalNamespc( ), @id, dtype, TRUE, FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *symbUniqueId( )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVar( @id, @id_alias, dtype, NULL, 0, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	s->var_.littext = ZstrAllocate( len( svalue ) )
	*s->var_.littext = svalue

	function = s
end function

function symbAllocIntConst _
	( _
		byval value as integer, _
		byval dtype as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as string svalue

	function = NULL

	svalue = "0x" + Hex(value)

	id = "{fbnc}"
	id += svalue

	'' preserve case, 'D', 'd', 'E', 'e' will become 'e' in lexer
	s = symbLookupByNameAndSuffix( @symbGetGlobalNamespc( ), @id, dtype, TRUE, FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *symbUniqueId( )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVar( @id, @id_alias, dtype, NULL, 0, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE )

	s->var_.littext = ZstrAllocate( len( svalue ) )
	*s->var_.littext = svalue

	function = s
end function

'':::::
function symbAllocLongIntConst _
	( _
		byval value as longint, _
		byval dtype as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	dim as FBSYMBOL ptr s
	dim as FBARRAYDIM dTB(0)
	dim as string svalue

	function = NULL

	svalue = "0x" + Hex(value)

	id = "{fbnc}"
	id += svalue

	'' preserve case, 'D', 'd', 'E', 'e' will become 'e' in lexer
	s = symbLookupByNameAndSuffix( @symbGetGlobalNamespc( ), @id, dtype, TRUE, FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *symbUniqueId( )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVar( @id, @id_alias, dtype, NULL, 0, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE )

	s->var_.littext = ZstrAllocate( len( svalue ) )
	*s->var_.littext = svalue

	function = s
end function

'':::::
function symbAllocStrConst _
	( _
		byval sname as zstring ptr, _
		byval lgt as integer _
	) as FBSYMBOL ptr

    static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s = any
	dim as integer strlen = any

	function = NULL

	'' the lgt passed isn't the real one because it doesn't
	'' take into acount the escape characters
	strlen = len( *sname )
	if( lgt < 0 ) then
		lgt = strlen
	end if

	if( strlen <= FB_MAXNAMELEN-6 ) then
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

	'' lgt += the null-char (rtlib wrappers will take it into account)

	'' it must be declare as SHARED, see symbAllocFloatConst()
	s = symbAddVar( @id, @id_alias, FB_DATATYPE_CHAR, NULL, lgt + 1, 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	s->var_.littext = ZstrAllocate( strlen )
	*s->var_.littext = *sname

	function = s
end function

function symbAllocWStrConst _
	( _
		byval sname as wstring ptr, _
		byval lgt as integer _
	) as FBSYMBOL ptr

    static as zstring * FB_MAXINTNAMELEN+1 id, id_alias
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s = any
	dim as integer strlen = any
	dim as integer wcharlen = any

	function = NULL

	'' the lgt passed isn't the real one because it doesn't
	'' take into acount the escape characters
	strlen = len( *sname )
	if( lgt < 0 ) then
		lgt = strlen
	end if

	wcharlen = typeGetSize( FB_DATATYPE_WCHAR )
	'' hEscapeW() can use up to (4 * wcharlen) ascii chars per unicode char
	'' (up to one '\ooo' per byte of wchar)
	if( strlen * ((1+3) * wcharlen) <= FB_MAXNAMELEN-6 ) then
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

	'' lgt = (lgt + null-char) * sizeof( wstring ) (see parser-decl-symbinit.bas)
	'' it must be declare as SHARED, see symbAllocFloatConst()
	s = symbAddVar( @id, @id_alias, FB_DATATYPE_WCHAR, NULL, (lgt+1) * len( wstring ), 0, dTB(), _
	                FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_LITERAL, _
	                FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	s->var_.littextw = WstrAllocate( strlen )
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
