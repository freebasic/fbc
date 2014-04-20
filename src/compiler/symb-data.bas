'' symbol table data type module
''
'' chng: feb/2006 moved off ir.bas [v1ctor]
''

#include once "fb.bi"
#include once "fbint.bi"

'' same order as FB_DATATYPE
dim shared symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE => _
{ _
	( FB_DATACLASS_UNKNOWN,  0, FALSE,  0, FB_DATATYPE_VOID    , -1                 , @"any"      ), _
	( FB_DATACLASS_INTEGER,  1, TRUE , 10, FB_DATATYPE_BYTE    , FB_SIZETYPE_INT8   , @"byte"     ), _
	( FB_DATACLASS_INTEGER,  1, FALSE, 15, FB_DATATYPE_UBYTE   , FB_SIZETYPE_UINT8  , @"ubyte"    ), _
	( FB_DATACLASS_INTEGER,  1, FALSE,  0, FB_DATATYPE_UBYTE   , FB_SIZETYPE_UINT8  , @"zstring"  ), _
	( FB_DATACLASS_INTEGER,  2, TRUE , 20, FB_DATATYPE_SHORT   , FB_SIZETYPE_INT16  , @"short"    ), _
	( FB_DATACLASS_INTEGER,  2, FALSE, 25, FB_DATATYPE_USHORT  , FB_SIZETYPE_UINT16 , @"ushort"   ), _
	( FB_DATACLASS_INTEGER,  2, FALSE,  0, -1                  , -1                 , @"wstring"  ), _
	( FB_DATACLASS_INTEGER, -1, TRUE , -1, FB_DATATYPE_INTEGER , -1                 , @"integer"  ), _
	( FB_DATACLASS_INTEGER, -1, FALSE, -1, FB_DATATYPE_UINT    , -1                 , @"uinteger" ), _
	( FB_DATACLASS_INTEGER, -1, TRUE ,  0, FB_DATATYPE_INTEGER , -1                 , @"enum"     ), _
	( FB_DATACLASS_INTEGER,  4, TRUE , 40, FB_DATATYPE_LONG    , FB_SIZETYPE_INT32  , @"long"     ), _
	( FB_DATACLASS_INTEGER,  4, FALSE, 45, FB_DATATYPE_ULONG   , FB_SIZETYPE_UINT32 , @"ulong"    ), _
	( FB_DATACLASS_INTEGER,  8, TRUE , 80, FB_DATATYPE_LONGINT , FB_SIZETYPE_INT64  , @"longint"  ), _
	( FB_DATACLASS_INTEGER,  8, FALSE, 85, FB_DATATYPE_ULONGINT, FB_SIZETYPE_UINT64 , @"ulongint" ), _
	( FB_DATACLASS_FPOINT ,  4, TRUE ,  0, FB_DATATYPE_SINGLE  , FB_SIZETYPE_FLOAT32, @"single"   ), _
	( FB_DATACLASS_FPOINT ,  8, TRUE ,  0, FB_DATATYPE_DOUBLE  , FB_SIZETYPE_FLOAT64, @"double"   ), _
	( FB_DATACLASS_STRING , -1, FALSE,  0, FB_DATATYPE_STRING  , -1                 , @"string"   ), _
	( FB_DATACLASS_STRING ,  1, FALSE,  0, FB_DATATYPE_FIXSTR  , -1                 , @"string"   ), _
	( FB_DATACLASS_UDT    ,  0, FALSE,  0, FB_DATATYPE_STRUCT  , -1                 , @"type"     ), _
	( FB_DATACLASS_UDT    ,  0, FALSE,  0, FB_DATATYPE_NAMESPC , -1                 , @"namepace" ), _
	( FB_DATACLASS_INTEGER,  0, FALSE,  0, FB_DATATYPE_UINT    , -1                 , @"function" ), _  '' FB_DATATYPE_FUNCTION has zero size, so function pointer arithmetic is disallowed (-> symbCalcDerefLen())
	( FB_DATACLASS_UNKNOWN,  0, FALSE,  0, FB_DATATYPE_VOID    , -1                 , @"fwdref"   ), _
	( FB_DATACLASS_INTEGER, -1, FALSE,  0, FB_DATATYPE_UINT    , -1                 , @"pointer"  ), _
	( FB_DATACLASS_INTEGER, 16, FALSE,  0, FB_DATATYPE_XMMWORD , -1                 , @"xmmword"  )  _
}

'' Note: the integer type ranking values are just arbitrary numbers, except
'' that they allow comparisons of the form
''    typeGetIntRank( a ) < typeGetIntRank( b )
'' to determine which type takes precedence. As long as the order is maintained,
'' the numbers can be changed.
''
'' For the small types it should be:
''    byte < ubyte < short < ushort < others
''
'' For the bigger types, it depends on whether the target is 32bit or 64bit:
''    32bit: long < integer < ulong < uinteger < longint < ulongint
''    64bit: long < ulong < longint < integer < ulongint < uinteger
''
'' Note: As in C, unsigned types are treated as if they had more precision,
'' even though they store the same number of bits. (for the sake of a '+' BOP's
'' result type being the same no matter whether we're doing signed + unsigned
'' or unsigned + signed, we need to have this kind of rule to decide)

dim shared symb_dtypeMatchTB( FB_DATATYPE_BYTE to FB_DATATYPE_DOUBLE, FB_DATATYPE_BYTE to FB_DATATYPE_DOUBLE ) as integer

declare function closestType _
	( _
		byval dtype as FB_DATATYPE, _
		byval dtype1 as FB_DATATYPE, _
		byval dtype2 as FB_DATATYPE _
	) as FB_DATATYPE

sub symbDataInit( )
	if( fbIs64bit( ) ) then
		'' 64bit
		symb_dtypeTB(FB_DATATYPE_INTEGER ).size = 8
		symb_dtypeTB(FB_DATATYPE_UINT    ).size = 8
		symb_dtypeTB(FB_DATATYPE_ENUM    ).size = 8
		symb_dtypeTB(FB_DATATYPE_STRING  ).size = 24
		symb_dtypeTB(FB_DATATYPE_POINTER ).size = 8

		symb_dtypeTB(FB_DATATYPE_INTEGER ).sizetype = FB_SIZETYPE_INT64
		symb_dtypeTB(FB_DATATYPE_UINT    ).sizetype = FB_SIZETYPE_UINT64
		symb_dtypeTB(FB_DATATYPE_ENUM    ).sizetype = FB_SIZETYPE_INT64
		symb_dtypeTB(FB_DATATYPE_POINTER ).sizetype = FB_SIZETYPE_UINT64

		symb_dtypeTB(FB_DATATYPE_INTEGER ).intrank = 81
		symb_dtypeTB(FB_DATATYPE_UINT    ).intrank = 86
	else
		'' 32bit
		symb_dtypeTB(FB_DATATYPE_INTEGER ).size = 4
		symb_dtypeTB(FB_DATATYPE_UINT    ).size = 4
		symb_dtypeTB(FB_DATATYPE_ENUM    ).size = 4
		symb_dtypeTB(FB_DATATYPE_STRING  ).size = 12
		symb_dtypeTB(FB_DATATYPE_POINTER ).size = 4

		symb_dtypeTB(FB_DATATYPE_INTEGER ).sizetype = FB_SIZETYPE_INT32
		symb_dtypeTB(FB_DATATYPE_UINT    ).sizetype = FB_SIZETYPE_UINT32
		symb_dtypeTB(FB_DATATYPE_ENUM    ).sizetype = FB_SIZETYPE_INT32
		symb_dtypeTB(FB_DATATYPE_POINTER ).sizetype = FB_SIZETYPE_UINT32

		symb_dtypeTB(FB_DATATYPE_INTEGER ).intrank = 41
		symb_dtypeTB(FB_DATATYPE_UINT    ).intrank = 46
	end if

	'' Remap wchar to target-specific type
	'' (all fields except the name, so symbTypeToStr() returns WSTRING
	'' instead of USHORT/ULONG...)
	symb_dtypeTB(FB_DATATYPE_WCHAR).class     = symb_dtypeTB(env.target.wchar).class
	symb_dtypeTB(FB_DATATYPE_WCHAR).size      = symb_dtypeTB(env.target.wchar).size
	symb_dtypeTB(FB_DATATYPE_WCHAR).signed    = symb_dtypeTB(env.target.wchar).signed
	symb_dtypeTB(FB_DATATYPE_WCHAR).remaptype = symb_dtypeTB(env.target.wchar).remaptype


	'' Create symb_dtypeMatchTB(), used to score overload resolutions
	const NUMTYPES = FB_DATATYPE_DOUBLE - FB_DATATYPE_BYTE + 1
	dim as FB_DATATYPE rank(0 to NUMTYPES - 1)

	dim as FB_DATATYPE dtype1 = any, dtype2 = any
	dim as integer i = any, j = any

	for dtype1 = FB_DATATYPE_BYTE to FB_DATATYPE_DOUBLE

		'' fill the rank() table with data types
		for dtype2 = FB_DATATYPE_BYTE to FB_DATATYPE_DOUBLE
			rank(dtype2 - FB_DATATYPE_BYTE) = dtype2
		next

		'' sort the table in order of closeness
		for i = 0 to NUMTYPES - 2
			for j = i + 1 to NUMTYPES - 1
				if( closestType( dtype1, rank(i), rank(j) ) = rank(j) ) then
					swap rank(i), rank(j)
				end if
			next
		next

		'' populate symb_dtypeMatchTB() with ranking numbers
		for i = 0 to NUMTYPES - 1
			dtype2 = rank(i)
			symb_dtypeMatchTB( dtype1, dtype2 ) = i
		next

	next

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

	'' If both are integers (only basic integers will appear, since it's
	'' the remap types), decide based on integer rank
	elseif( (typeGetClass( dtype1 ) = FB_DATACLASS_INTEGER) and _
	        (typeGetClass( dtype2 ) = FB_DATACLASS_INTEGER) ) then
		if( typeGetIntRank( dtype1 ) > typeGetIntRank( dtype2 ) ) then
			dtype = ldtype
			subtype = lsubtype
		else
			dtype = rdtype
			subtype = rsubtype
		end if

	'' Otherwise (i.e. floats are involved), decide based on FB_DATATYPE
	'' enum order (this lets SINGLE/DOUBLE win over integers, and also
	'' DOUBLE over SINGLE)
	elseif( dtype1 > dtype2 ) then
		dtype = ldtype
		subtype = lsubtype
	else
		dtype = rdtype
		subtype = rsubtype
	end if

end sub

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

'' Check for "trivial" types, i.e. those that will really be passed Byval when
'' used with Byval params.
'' Non-trivial types (class-like types with dtor or copy-ctor, etc.) are always
'' passed Byref implicitly. In case of Byval, a copy is made, but it's still
'' passed Byref, so that the caller can destroy the copy.
function typeIsTrivial _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	function = TRUE

	select case( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_STRING
		function = FALSE
	case FB_DATATYPE_STRUCT
		function = symbCompIsTrivial( subtype )
	end select

end function

''
'' Replace/merge a type with another type; used to replace forward references
'' (FB_DATATYPE_FWDREF) by the real dtype once its known (when the forward
'' reference is implemented).
''
'' Normal case:
''
''         type UDT as UDT_
''         dim p as UDT ptr
''         type UDT_
''             i as integer
''         end type
''
'' Variable 'p' is a pointer to a forward reference that will be implemented as
'' a struct, so we're going to turn typeAddrOf( FB_DATATYPE_FWDREF ) into
'' typeAddrOf( FB_DATATYPE_STRUCT ) and replace the subtype too.
''
'' Care must be taken in cases like the following:
''
''         type typedef as fwdref ptr ptr ptr ptr
''         type fwdref as integer ptr ptr ptr ptr ptr
''
'' 'typedef' has 4 PTRs, and the forward reference itself will be implemented
'' with 5 PTRs. These two cannot be merged because 4+5 would be too many PTRs,
'' the limit is 8 (FB_DT_PTRLEVELS).
''
function typeMerge _
	( _
		byval dtype1 as integer, _
		byval dtype2 as integer _
	) as integer

	dim as integer oldptrcount = any, addptrcount = any

	'' Existing PTR's (pointer to forward ref, e.g. on typedefs/variables)
	oldptrcount = typeGetPtrCnt( dtype1 )

	'' and additional PTR's
	addptrcount = typeGetPtrCnt( dtype2 )

	'' Too many PTR's after replacing the forward ref with its actual type?
	if( (oldptrcount + addptrcount) > FB_DT_PTRLEVELS ) then
		errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
		'' Error recovery: use the max. amount of PTRs on the final type
		oldptrcount = FB_DT_PTRLEVELS - addptrcount
	end if

	'' Replace the forward ref with the real type,
	'' but preserve existing PTRs and CONSTs
	dtype1 = typeMultAddrOf( dtype2, oldptrcount ) or _
	         typeGetConstMask( dtype1 )

	function = dtype1
end function

'' Return the closest (most "compatible") type to dtype,
'' out of dtype1 and dtype2
function closestType _
	( _
		byval dtype as FB_DATATYPE, _
		byval dtype1 as FB_DATATYPE, _
		byval dtype2 as FB_DATATYPE _
	) as FB_DATATYPE

	'' prefer non-enum/zstring/wstring, let them be handled elsewhere
	if( dtype1 <> FB_DATATYPE_ENUM and dtype2 = FB_DATATYPE_ENUM ) then return dtype1
	if( dtype2 <> FB_DATATYPE_ENUM and dtype1 = FB_DATATYPE_ENUM ) then return dtype2

	if( dtype1 <> FB_DATATYPE_CHAR and dtype2 = FB_DATATYPE_CHAR ) then return dtype1
	if( dtype2 <> FB_DATATYPE_CHAR and dtype1 = FB_DATATYPE_CHAR ) then return dtype2

	if( dtype1 <> FB_DATATYPE_WCHAR and dtype2 = FB_DATATYPE_WCHAR ) then return dtype1
	if( dtype2 <> FB_DATATYPE_WCHAR and dtype1 = FB_DATATYPE_WCHAR ) then return dtype2


	'' prefer same dataclass (integer / floating-point)
	dim as integer sameclass1 = (typeGetClass(dtype1) = typeGetClass(dtype))
	dim as integer sameclass2 = (typeGetClass(dtype2) = typeGetClass(dtype))

	if ( sameclass1 and not sameclass2 ) then return dtype1
	if ( sameclass2 and not sameclass1 ) then return dtype2


	'' prefer a type that's at least as large as dtype
	dim as integer larger1 = (typeGetSize( dtype1 ) >= typeGetSize( dtype ))
	dim as integer larger2 = (typeGetSize( dtype2 ) >= typeGetSize( dtype ))

	if( larger1 and not larger2 ) then return dtype1
	if( larger2 and not larger1 ) then return dtype2


	'' prefer closer size (if larger, then the smallest; if smaller, then the largest)
	dim as integer sizediff1 = abs( typeGetSize( dtype1 ) - typeGetSize( dtype ) )
	dim as integer sizediff2 = abs( typeGetSize( dtype2 ) - typeGetSize( dtype ) )

	if( sizediff1 < sizediff2 ) then return dtype1
	if( sizediff2 < sizediff1 ) then return dtype2


	'' prefer same signedness
	dim as integer samesign1 = (typeIsSigned( dtype1 ) = typeIsSigned( dtype ))
	dim as integer samesign2 = (typeIsSigned( dtype2 ) = typeIsSigned( dtype ))

	if( samesign1 and not samesign2 ) then return dtype1
	if( samesign2 and not samesign1 ) then return dtype2


	'' prefer same kind ([U]Long should prefer Long > Integer or ULong > UInteger)
	dim as integer samekind1 = (typeToSigned( dtype1 ) = typeToSigned( dtype ) )
	dim as integer samekind2 = (typeToSigned( dtype2 ) = typeToSigned( dtype ) )

	if( samekind1 and not samekind2 ) then return dtype1
	if( samekind2 and not samekind1 ) then return dtype2


	'' prefer [U]Integer type on tiebreaks with [U]Long[int] if same size
	dim as integer isint1 = (typeToSigned( dtype1 ) = FB_DATATYPE_INTEGER)
	dim as integer isint2 = (typeToSigned( dtype2 ) = FB_DATATYPE_INTEGER)

	if( isint1 and not isint2 ) then return dtype1
	if( isint2 and not isint1 ) then return dtype2


	'' should be no other differences
	assert( dtype1 = dtype2 )
	return dtype1

end function
