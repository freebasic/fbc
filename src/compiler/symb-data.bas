'' symbol table data type module
''
'' chng: feb/2006 moved off ir.bas [v1ctor]
''

#include once "fb.bi"
#include once "fbint.bi"

'' same order as FB_DATATYPE
dim shared symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE => _
{ _
	( FB_DATACLASS_UNKNOWN,  0, FALSE, FB_DATATYPE_VOID    , -1                 , @"void"     ), _
	( FB_DATACLASS_INTEGER,  1, TRUE , FB_DATATYPE_BYTE    , FB_SIZETYPE_INT8   , @"byte"     ), _
	( FB_DATACLASS_INTEGER,  1, FALSE, FB_DATATYPE_UBYTE   , FB_SIZETYPE_UINT8  , @"ubyte"    ), _
	( FB_DATACLASS_INTEGER,  1, FALSE, FB_DATATYPE_UBYTE   , FB_SIZETYPE_UINT8  , @"zstring"  ), _
	( FB_DATACLASS_INTEGER,  2, TRUE , FB_DATATYPE_SHORT   , FB_SIZETYPE_INT16  , @"short"    ), _
	( FB_DATACLASS_INTEGER,  2, FALSE, FB_DATATYPE_USHORT  , FB_SIZETYPE_UINT16 , @"ushort"   ), _
	( FB_DATACLASS_INTEGER,  2, FALSE, -1                  , -1                 , @"wstring"  ), _
	( FB_DATACLASS_INTEGER, -1, TRUE , FB_DATATYPE_INTEGER , -1                 , @"integer"  ), _
	( FB_DATACLASS_INTEGER, -1, FALSE, FB_DATATYPE_UINT    , -1                 , @"uinteger" ), _
	( FB_DATACLASS_INTEGER, -1, TRUE , FB_DATATYPE_INTEGER , -1                 , @"enum"     ), _
	( FB_DATACLASS_INTEGER, -1, FALSE, FB_DATATYPE_UINT    , -1                 , @"bitfield" ), _
	( FB_DATACLASS_INTEGER,  4, TRUE , FB_DATATYPE_LONG    , FB_SIZETYPE_INT32  , @"long"     ), _
	( FB_DATACLASS_INTEGER,  4, FALSE, FB_DATATYPE_ULONG   , FB_SIZETYPE_UINT32 , @"ulong"    ), _
	( FB_DATACLASS_INTEGER,  8, TRUE , FB_DATATYPE_LONGINT , FB_SIZETYPE_INT64  , @"longint"  ), _
	( FB_DATACLASS_INTEGER,  8, FALSE, FB_DATATYPE_ULONGINT, FB_SIZETYPE_UINT64 , @"ulongint" ), _
	( FB_DATACLASS_FPOINT ,  4, TRUE , FB_DATATYPE_SINGLE  , FB_SIZETYPE_FLOAT32, @"single"   ), _
	( FB_DATACLASS_FPOINT ,  8, TRUE , FB_DATATYPE_DOUBLE  , FB_SIZETYPE_FLOAT64, @"double"   ), _
	( FB_DATACLASS_STRING , -1, FALSE, FB_DATATYPE_STRING  , -1                 , @"string"   ), _
	( FB_DATACLASS_STRING ,  1, FALSE, FB_DATATYPE_FIXSTR  , -1                 , @"string"   ), _
	( FB_DATACLASS_UDT    ,  0, FALSE, FB_DATATYPE_STRUCT  , -1                 , @"type"     ), _
	( FB_DATACLASS_UDT    ,  0, FALSE, FB_DATATYPE_NAMESPC , -1                 , @"namepace" ), _
	( FB_DATACLASS_INTEGER, -1, FALSE, FB_DATATYPE_UINT    , -1                 , @"function" ), _
	( FB_DATACLASS_UNKNOWN,  0, FALSE, FB_DATATYPE_VOID    , -1                 , @"fwdref"   ), _
	( FB_DATACLASS_INTEGER, -1, FALSE, FB_DATATYPE_UINT    , -1                 , @"pointer"  ), _
	( FB_DATACLASS_INTEGER, 16, FALSE, FB_DATATYPE_XMMWORD , -1                 , @"xmmword"  )  _
}

sub symbDataInit( )
	if( env.target.options and FB_TARGETOPT_64BIT ) then
		'' 64bit
		symb_dtypeTB(FB_DATATYPE_INTEGER ).size = 8
		symb_dtypeTB(FB_DATATYPE_UINT    ).size = 8
		symb_dtypeTB(FB_DATATYPE_ENUM    ).size = 8
		symb_dtypeTB(FB_DATATYPE_BITFIELD).size = 8
		symb_dtypeTB(FB_DATATYPE_STRING  ).size = 24
		symb_dtypeTB(FB_DATATYPE_FUNCTION).size = 8
		symb_dtypeTB(FB_DATATYPE_POINTER ).size = 8

		symb_dtypeTB(FB_DATATYPE_INTEGER ).sizetype = FB_SIZETYPE_INT64
		symb_dtypeTB(FB_DATATYPE_UINT    ).sizetype = FB_SIZETYPE_UINT64
		symb_dtypeTB(FB_DATATYPE_ENUM    ).sizetype = FB_SIZETYPE_INT64
		symb_dtypeTB(FB_DATATYPE_BITFIELD).sizetype = FB_SIZETYPE_UINT64
		symb_dtypeTB(FB_DATATYPE_FUNCTION).sizetype = FB_SIZETYPE_UINT64
		symb_dtypeTB(FB_DATATYPE_POINTER ).sizetype = FB_SIZETYPE_UINT64
	else
		'' 32bit
		symb_dtypeTB(FB_DATATYPE_INTEGER ).size = 4
		symb_dtypeTB(FB_DATATYPE_UINT    ).size = 4
		symb_dtypeTB(FB_DATATYPE_ENUM    ).size = 4
		symb_dtypeTB(FB_DATATYPE_BITFIELD).size = 4
		symb_dtypeTB(FB_DATATYPE_STRING  ).size = 12
		symb_dtypeTB(FB_DATATYPE_FUNCTION).size = 4
		symb_dtypeTB(FB_DATATYPE_POINTER ).size = 4

		symb_dtypeTB(FB_DATATYPE_INTEGER ).sizetype = FB_SIZETYPE_INT32
		symb_dtypeTB(FB_DATATYPE_UINT    ).sizetype = FB_SIZETYPE_UINT32
		symb_dtypeTB(FB_DATATYPE_ENUM    ).sizetype = FB_SIZETYPE_INT32
		symb_dtypeTB(FB_DATATYPE_BITFIELD).sizetype = FB_SIZETYPE_UINT32
		symb_dtypeTB(FB_DATATYPE_FUNCTION).sizetype = FB_SIZETYPE_UINT32
		symb_dtypeTB(FB_DATATYPE_POINTER ).sizetype = FB_SIZETYPE_UINT32
	end if

	'' Remap wchar to target-specific type
	'' (all fields except the name, so symbTypeToStr() returns WSTRING
	'' instead of USHORT/UINTEGER...)
	symb_dtypeTB(FB_DATATYPE_WCHAR).class     = symb_dtypeTB(env.target.wchar).class
	symb_dtypeTB(FB_DATATYPE_WCHAR).size      = symb_dtypeTB(env.target.wchar).size
	symb_dtypeTB(FB_DATATYPE_WCHAR).signed    = symb_dtypeTB(env.target.wchar).signed
	symb_dtypeTB(FB_DATATYPE_WCHAR).remaptype = symb_dtypeTB(env.target.wchar).remaptype
end sub

function typeMax _
	( _
		byval ldtype as integer, _
		byval rdtype as integer _
	) as integer

    dim as integer dtype1 = any, dtype2 = any

    function = FB_DATATYPE_INVALID

    dtype1 = typeGet( ldtype )
    if( dtype1 = FB_DATATYPE_POINTER ) then
    	'' can't be POINTER, due the -1 +1 hacks below
    	dtype1 = FB_DATATYPE_ULONG
    else
    	dtype1 = symb_dtypeTB(dtype1).remaptype
    end if

    dtype2 = typeGet( rdtype )
    if( dtype2 = FB_DATATYPE_POINTER ) then
    	'' ditto
    	dtype2 = FB_DATATYPE_ULONG
    else
    	dtype2 = symb_dtypeTB(dtype2).remaptype
    end if

    '' same?
    if( dtype1 = dtype2 ) then
    	exit function
    end if

    '' don't convert byte <-> ubyte
    select case as const dtype1
    case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
    	select case as const dtype2
    	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
    		exit function
    	end select

    '' neither short <-> ushort
    case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
    	select case as const dtype2
    	case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
    		exit function
    	end select

	'' neither int <-> uint
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
    	select case as const dtype2
    	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
    		exit function

    	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
    		if( FB_LONGSIZE = FB_INTEGERSIZE ) then
    			exit function
    		end if
    	end select

	'' neither long <-> ulong
	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
    	select case as const dtype2
    	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
    		exit function

    	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
    		if( FB_LONGSIZE = FB_INTEGERSIZE ) then
    			exit function
    		end if

    	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
    		if( FB_LONGSIZE = FB_INTEGERSIZE*2 ) then
    			exit function
    		end if
    	end select

    '' neither qword <-> longint
    case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
    	select case as const dtype2
    	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
    		exit function

    	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
    		if( FB_LONGSIZE = FB_INTEGERSIZE*2 ) then
    			exit function
    		end if
    	end select

    '' neither single <-> double
    case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
    	select case as const dtype2
    	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
    		exit function
    	end select

    '' neither string, fixstring
    case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
    	return FB_DATATYPE_STRING

    case else
    	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
    end select

    '' assuming DATATYPE's are in order of precision
    if( dtype1 > dtype2 ) then
    	function = ldtype
    else
    	function = rdtype
    end if

end function

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
