'' symbol table data type module
''
'' chng: feb/2006 moved off ir.bas [v1ctor]
''

#include once "fb.bi"
#include once "fbint.bi"

	'' same order as FB_DATATYPE
	dim shared symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE => _
	{ _
		(FB_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, FB_DATATYPE_VOID	, @"void"    	), _
		(FB_DATACLASS_INTEGER, 1			 	, 8*1				, TRUE , FB_DATATYPE_BYTE	, @"byte"  		), _
		(FB_DATACLASS_INTEGER, 1			 	, 8*1				, FALSE, FB_DATATYPE_UBYTE  , @"ubyte" 		), _
		(FB_DATACLASS_INTEGER, 1			 	, 8*1				, FALSE, FB_DATATYPE_UBYTE	, @"zstring" 	), _
		(FB_DATACLASS_INTEGER, 2			 	, 8*2				, TRUE , FB_DATATYPE_SHORT 	, @"short" 		), _
		(FB_DATACLASS_INTEGER, 2			 	, 8*2				, FALSE, FB_DATATYPE_USHORT	, @"ushort" 	), _
		(FB_DATACLASS_INTEGER, 2			 	, 8*2				, FALSE, FB_DATATYPE_USHORT	, @"wstring" 	), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, TRUE , FB_DATATYPE_INTEGER, @"integer" 	), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT 	, @"uinteger" 	), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, TRUE , FB_DATATYPE_INTEGER, @"enum"		), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT   , @"bitfield"	), _
		(FB_DATACLASS_INTEGER, FB_LONGSIZE		, 8*FB_LONGSIZE		, TRUE , FB_DATATYPE_LONG	, @"long" 		), _
		(FB_DATACLASS_INTEGER, FB_LONGSIZE		, 8*FB_LONGSIZE		, FALSE, FB_DATATYPE_ULONG 	, @"ulong" 		), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE*2	, 8*FB_INTEGERSIZE*2, TRUE , FB_DATATYPE_LONGINT, @"longint"	), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE*2	, 8*FB_INTEGERSIZE*2, FALSE, FB_DATATYPE_ULONGINT,@"ulongint"	), _
		(FB_DATACLASS_FPOINT , 4             	, 8*4				, TRUE , FB_DATATYPE_SINGLE	, @"single"		), _
		(FB_DATACLASS_FPOINT , 8			 	, 8*8				, TRUE , FB_DATATYPE_DOUBLE	, @"double"		), _
		(FB_DATACLASS_STRING , FB_STRDESCLEN	, 0					, FALSE, FB_DATATYPE_STRING	, @"string"		), _
		(FB_DATACLASS_STRING , 1			 	, 8*1				, FALSE, FB_DATATYPE_FIXSTR	, @"string"	), _
		(FB_DATACLASS_UDT	 , 0			 	, 0					, FALSE, FB_DATATYPE_STRUCT , @"type"		), _
		(FB_DATACLASS_UDT	 , 0			 	, 0					, FALSE, FB_DATATYPE_NAMESPC, @"namepace"	), _
		(FB_DATACLASS_INTEGER, FB_POINTERSIZE	, 8*FB_POINTERSIZE	, FALSE, FB_DATATYPE_UINT	, @"function"	), _
		(FB_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, FB_DATATYPE_VOID	, @"fwdref"		), _
		(FB_DATACLASS_INTEGER, FB_POINTERSIZE	, 8*FB_POINTERSIZE	, FALSE, FB_DATATYPE_UINT	, @"pointer"	)  _
	}

sub symbDataInit( )
	'' Remap wchar to target-specific type
	'' (all fields except the name, so symbTypeToStr() returns WSTRING
	'' instead of USHORT/UINTEGER...)
	symb_dtypeTB(FB_DATATYPE_WCHAR).class     = symb_dtypeTB(env.target.wchar).class
	symb_dtypeTB(FB_DATATYPE_WCHAR).size      = symb_dtypeTB(env.target.wchar).size
	symb_dtypeTB(FB_DATATYPE_WCHAR).bits      = symb_dtypeTB(env.target.wchar).bits
	symb_dtypeTB(FB_DATATYPE_WCHAR).signed    = symb_dtypeTB(env.target.wchar).signed
	symb_dtypeTB(FB_DATATYPE_WCHAR).remaptype = symb_dtypeTB(env.target.wchar).remaptype
end sub

sub typeMax _
	( _
		byval ldtype as integer, _
		byval lsubtype as FBSYMBOL ptr, _
		byval rdtype as integer, _
		byval rsubtype as FBSYMBOL ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	)

	dim as integer dtype1 = any, dtype2 = any

	'' Same type?
	if( (typeGetDtAndPtrOnly( ldtype ) = typeGetDtAndPtrOnly( rdtype )) and _
	    (lsubtype = rsubtype) ) then
		dtype = ldtype
		subtype = lsubtype
		exit sub
	end if

	dtype1 = symb_dtypeTB(typeGet( ldtype )).remaptype
	dtype2 = symb_dtypeTB(typeGet( rdtype )).remaptype

	if( dtype1 = dtype2 ) then
		'' Different types, but they remapped to the same,
		'' will this ever happen? (special cases such as enums and
		'' pointers should already have been handled by the caller)
		'' Return the generic remapped type, since we don't
		'' know which side to prefer
		dtype = dtype1
		subtype = NULL
	elseif( dtype1 > dtype2 ) then
		dtype = ldtype
		subtype = lsubtype
	else
		dtype = rdtype
		subtype = rsubtype
	end if

end sub

'':::::
function typeRemap _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer
    
    dim as integer nd = any
    
	select case typeGet( dtype )
	case FB_DATATYPE_POINTER
		nd = FB_DATATYPE_ULONG
	case FB_DATATYPE_BITFIELD
		nd = subtype->typ
	case else
		nd = symb_dtypeTB(dtype).remaptype
	end select
	
	function = typeJoin( dtype, nd )

end function

'':::::
function typeToSigned _
	( _
		byval dtype as integer _
	) as integer

	dim as integer dt = typeGet( dtype ), nd = any

	if( symb_dtypeTB(dt).class <> FB_DATACLASS_INTEGER ) then
		return dtype
	end if

	select case as const dt
	case FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR
		nd = FB_DATATYPE_BYTE

	case FB_DATATYPE_USHORT
		nd = FB_DATATYPE_SHORT

	case FB_DATATYPE_UINT
		nd = FB_DATATYPE_INTEGER

	case FB_DATATYPE_WCHAR
		return typeToSigned( env.target.wchar )

	case FB_DATATYPE_ULONG, FB_DATATYPE_POINTER
		nd = FB_DATATYPE_LONG

	case FB_DATATYPE_ULONGINT
		nd = FB_DATATYPE_LONGINT

	case else
		nd = dtype
	end select

	function = typeJoin( dtype, nd )

end function

'':::::
function typeToUnsigned _
	( _
		byval dtype as integer _
	) as integer

	dim as integer dt = typeGet( dtype ), nd = any

	if( symb_dtypeTB(dt).class <> FB_DATACLASS_INTEGER ) then
		return dtype
	end if

	select case as const dt
	case FB_DATATYPE_BYTE
		nd = FB_DATATYPE_UBYTE

	case FB_DATATYPE_SHORT
		nd = FB_DATATYPE_USHORT

	case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		nd = FB_DATATYPE_UINT

	case FB_DATATYPE_LONG, FB_DATATYPE_POINTER
		nd = FB_DATATYPE_ULONG

	case FB_DATATYPE_LONGINT
		nd = FB_DATATYPE_ULONGINT

	case else
		nd = dtype
	end select
	
	function = typeJoin( dtype, nd )

end function

function typeHasCtor _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	select case( typeGet( dtype ) )
	case FB_DATATYPE_STRUCT '', FB_DATATYPE_CLASS
		function = (symbGetCompCtorHead( subtype ) <> NULL)
	end select

end function

function typeHasDefCtor _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	select case( typeGet( dtype ) )
	case FB_DATATYPE_STRUCT '', FB_DATATYPE_CLASS
		function = (symbGetCompDefCtor( subtype ) <> NULL)
	end select

end function

function typeHasDtor _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	select case( typeGet( dtype ) )
	case FB_DATATYPE_STRUCT '', FB_DATATYPE_CLASS
		function = (symbGetCompDtor( subtype ) <> NULL)
	end select

end function
