''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' symbol table data type module
''
'' chng: feb/2006 moved off ir.bas [v1ctor]
''


#include once "inc\fb.bi"
#include once "inc\fbint.bi"

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
		(FB_DATACLASS_STRING , 1			 	, 8*1				, FALSE, FB_DATATYPE_FIXSTR	, @"string *"	), _
		(FB_DATACLASS_UDT	 , 0			 	, 0					, FALSE, FB_DATATYPE_STRUCT , @"type"		), _
		(FB_DATACLASS_UDT	 , 0			 	, 0					, FALSE, FB_DATATYPE_NAMESPC, @"namepace"	), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT	, @"function"	), _
		(FB_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, FB_DATATYPE_VOID	, @"fwdref"		), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT	, @"pointer"	)  _
	}


'':::::
sub symbDataInit( )

	'' wchar len depends on the target platform
	symb_dtypeTB(FB_DATATYPE_WCHAR) = symb_dtypeTB(env.target.wchar.type)

end sub

'':::::
sub symbDataEnd( )

	'' do nothing

end sub

'':::::
function symbGetDataClass _
	( _
		byval dtype as integer _
	) as integer static

	if( dtype > FB_DATATYPE_POINTER ) then
		dtype = FB_DATATYPE_POINTER
	end if

	function = symb_dtypeTB(dtype).class

end function

'':::::
function symbMaxDataType _
	( _
		byval ldtype as integer, _
		byval rdtype as integer _
	) as integer static

    dim as integer dtype1, dtype2

    function = INVALID

    if( ldtype > FB_DATATYPE_POINTER ) then
    	'' can't be POINTER, due the -1 +1 hacks below
    	dtype1 = FB_DATATYPE_UINT
    else
    	dtype1 = symb_dtypeTB(ldtype).remaptype
    end if

    if( rdtype > FB_DATATYPE_POINTER ) then
    	'' ditto
    	dtype2 = FB_DATATYPE_UINT
    else
    	dtype2 = symb_dtypeTB(rdtype).remaptype
    end if

    '' same?
    if( dtype1 = dtype2 ) then
    	exit function
    end if

    '' don't convert byte <-> ubyte
    select case as const dtype1
    case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
    	select case dtype2
    	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
    		exit function
    	end select

    '' neither short <-> ushort
    case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
    	select case dtype2
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
    	select case dtype2
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
function symbIsSigned _
	( _
		byval dtype as integer _
	) as integer static

	if( dtype > FB_DATATYPE_POINTER ) then
		dtype = FB_DATATYPE_POINTER
	end if

	function = symb_dtypeTB(dtype).signed

end function

'':::::
function symbGetDataSize _
	( _
		byval dtype as integer _
	) as integer static

	if( dtype > FB_DATATYPE_POINTER ) then
		dtype = FB_DATATYPE_POINTER
	end if

	function = symb_dtypeTB(dtype).size

end function

'':::::
function symbGetDataBits _
	( _
		byval dtype as integer _
	) as integer static

	if( dtype > FB_DATATYPE_POINTER ) then
		dtype = FB_DATATYPE_POINTER
	end if

	function = symb_dtypeTB(dtype).bits

end function

'':::::
function symbRemapType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer static

	if( dtype > FB_DATATYPE_POINTER ) then
		function = FB_DATATYPE_UINT

	elseif( dtype = FB_DATATYPE_BITFIELD ) then
		function = subtype->typ

	else
		function = symb_dtypeTB(dtype).remaptype

	end if

end function

'':::::
function symbGetSignedType _
	( _
		byval dtype as integer _
	) as integer static

	dim as integer dt

	dt = dtype
	if( dt > FB_DATATYPE_POINTER ) then
		dt = FB_DATATYPE_POINTER
	end if

	if( symb_dtypeTB(dt).class <> FB_DATACLASS_INTEGER ) then
		return dtype
	end if

	select case as const dt
	case FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR
		function = FB_DATATYPE_BYTE

	case FB_DATATYPE_USHORT
		function = FB_DATATYPE_SHORT

	case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
		function = FB_DATATYPE_INTEGER

	case FB_DATATYPE_WCHAR
		select case env.target.wchar.type
		case FB_DATATYPE_UBYTE
			function = FB_DATATYPE_BYTE
		case FB_DATATYPE_USHORT
			function = FB_DATATYPE_SHORT
		case else
			function = FB_DATATYPE_INTEGER
		end select

	case FB_DATATYPE_ULONG
		function = FB_DATATYPE_LONG

	case FB_DATATYPE_ULONGINT
		function = FB_DATATYPE_LONGINT

	case else
		function = dtype
	end select

end function

'':::::
function symbGetUnsignedType _
	( _
		byval dtype as integer _
	) as integer static

	dim as integer dt

	dt = dtype
	if( dt > FB_DATATYPE_POINTER ) then
		dt = FB_DATATYPE_POINTER
	end if

	if( symb_dtypeTB(dt).class <> FB_DATACLASS_INTEGER ) then
		return dtype
	end if

	select case as const dt
	case FB_DATATYPE_BYTE
		function = FB_DATATYPE_UBYTE

	case FB_DATATYPE_SHORT
		function = FB_DATATYPE_USHORT

	case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_POINTER
		function = FB_DATATYPE_UINT

	case FB_DATATYPE_LONG
		function = FB_DATATYPE_ULONG

	case FB_DATATYPE_LONGINT
		function = FB_DATATYPE_ULONGINT

	case else
		function = dtype
	end select

end function

'':::::
function symbGetCStdType _
	( _
		byval ctype as FB_CSTDTYPE _
	) as integer

	if( ctype = FB_CSTDTYPE_SIZET ) then
		select case as const env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			function = FB_DATATYPE_UINT

		case FB_COMPTARGET_LINUX, FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
			function = FB_DATATYPE_ULONG
		end select
	end if

end function

