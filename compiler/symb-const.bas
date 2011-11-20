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

	sym->con.val = *value

	function = sym

end function

'':::::
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
	dim as string svalue = hFloatToStr( value, dtype )

	id = "{fbnc}"
	id += svalue

	'' preserve case, 'D', 'd', 'E', 'e' will become 'e' in lexer
	s = symbLookupByNameAndSuffix( @symbGetGlobalNamespc( ), _
								   @id, _
								   dtype, _
								   TRUE, _
								   FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *hMakeTmpStrNL( )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVarEx( @id, @id_alias, _
					  dtype, NULL, _
					  0, _
					  0, dTB(), _
					  FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_LITCONST, _
					  FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	''
	s->var_.littext = ZstrAllocate( len( svalue ) )
	*s->var_.littext = svalue

	function = s

end function


'':::::
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
	s = symbLookupByNameAndSuffix( @symbGetGlobalNamespc( ), _
								   @id, _
								   dtype, _
								   TRUE, _
								   FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *hMakeTmpStrNL( )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVarEx( @id, @id_alias, dtype, NULL, 0, 0, dTB(), _
					  FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_LITCONST, _
					  FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE )

	''
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
	s = symbLookupByNameAndSuffix( @symbGetGlobalNamespc( ), _
								   @id, _
								   dtype, _
								   TRUE, _
								   FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *hMakeTmpStrNL( )

	'' it must be declare as SHARED, because even if currently inside an
	'' proc, the global symbol tb should be used, so just one constant
	'' will be ever allocated over the module
	s = symbAddVarEx( @id, @id_alias, dtype, NULL, 0, 0, dTB(), _
					  FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_LITCONST, _
					  FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE )

	''
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
		id = *hMakeTmpStrNL( )
	end if

	''
	s = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
								  @id, _
								  FB_SYMBCLASS_VAR, _
								  TRUE, _
								  FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *hMakeTmpStrNL( )

	'' lgt += the null-char (rtlib wrappers will take it into account)

	'' it must be declare as SHARED, see symbAllocFloatConst()
	s = symbAddVarEx( @id, @id_alias, _
					  FB_DATATYPE_CHAR, NULL, _
					  lgt + 1, _
					  0, dTB(), _
					  FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_LITCONST, _
					  FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	''
	s->var_.littext = ZstrAllocate( strlen )
	*s->var_.littext = *sname

	function = s

end function

'':::::
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

	wcharlen = symbGetDataSize( FB_DATATYPE_WCHAR )
	'' hEscapeW() can use up to (4 * wcharlen) ascii chars per unicode char
	'' (up to one '\ooo' per byte of wchar)
	if( strlen * ((1+3) * wcharlen) <= FB_MAXNAMELEN-6 ) then
		id = "{fbwc}"
		id += *hEscapeW( sname )
	else
		id = *hMakeTmpStrNL( )
	end if

	''
	s = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
								  @id, _
								  FB_SYMBCLASS_VAR, _
								  TRUE, _
								  FALSE )
	if( s <> NULL ) then
		return s
	end if

	id_alias = *hMakeTmpStrNL( )

	'' lgt = (lgt + null-char) * sizeof( wstring ) (see parser-decl-symbinit.bas)
	'' it must be declare as SHARED, see symbAllocFloatConst()
	s = symbAddVarEx( @id, @id_alias, _
					  FB_DATATYPE_WCHAR, NULL, _
					  (lgt+1) * len( wstring ), _
					  0, dTB(), _
					  FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_LITCONST, _
					  FB_SYMBOPT_MOVETOGLOB or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

	''
	s->var_.littextw = WstrAllocate( strlen )
	*s->var_.littextw = *sname

	function = s

end function

'':::::
sub symbDelConst _
	( _
		byval s as FBSYMBOL ptr _
	)

    if( s = NULL ) then
    	exit sub
    end if

    '' if it's a string, the symbol attached will be deleted be delVar()

	symbFreeSymbol( s )

end sub

'':::::
function symbGetConstValueAsStr _
	( _
		byval s as FBSYMBOL ptr _
	) as string

  	select case as const symbGetType( s )
  	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
  		function = *symbGetConstValStr( s )->var_.littext

  	case FB_DATATYPE_LONGINT
  		function = str( symbGetConstValLong( s ) )

  	case FB_DATATYPE_ULONGINT
  	    function = str( cunsg( symbGetConstValLong( s ) ) )

	case FB_DATATYPE_SINGLE
		function = str( csng( symbGetConstValFloat( s ) ) )

	case FB_DATATYPE_DOUBLE
		function = str( symbGetConstValFloat( s ) )

  	case FB_DATATYPE_LONG
  		if( FB_LONGSIZE = len( integer ) ) then
  			function = str( symbGetConstValInt( s ) )
  		else
  			function = str( symbGetConstValLong( s ) )
  		end if

  	case FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = str( cunsg( symbGetConstValInt( s ) ) )
  	    else
  	    	function = str( cunsg( symbGetConstValLong( s ) ) )
  	    end if

  	case FB_DATATYPE_UBYTE, FB_DATATYPE_USHORT, FB_DATATYPE_UINT
  		function = str( cunsg( symbGetConstValInt( s ) ) )

  	case else
  		function = str( symbGetConstValInt( s ) )
  	end select

end function

'':::::
function symbCloneConst _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	'' no need to make a copy of fbvalue.str, if it's a literal,
	'' it will be a non-local var

	function = symbAddConst( NULL, _
							 symbGetType( sym ), _
							 symbGetSubType( sym ), _
							 @sym->con.val, _
							 symbGetAttrib( sym ) )

end function
