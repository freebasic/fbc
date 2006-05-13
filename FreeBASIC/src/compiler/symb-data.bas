''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"

	'' same order as FB_DATATYPE
	dim shared symb_dtypeTB( 0 to FB_DATATYPES-1 ) as SYMB_DATATYPE => _
	{ _
		(FB_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, FB_DATATYPE_VOID    ), _
		(FB_DATACLASS_INTEGER, 1			 	, 8*1				, TRUE , FB_DATATYPE_BYTE    ), _
		(FB_DATACLASS_INTEGER, 1			 	, 8*1				, FALSE, FB_DATATYPE_UBYTE   ), _
		(FB_DATACLASS_INTEGER, 1			 	, 8*1				, FALSE, FB_DATATYPE_UBYTE	 ), _ '' zstring
		(FB_DATACLASS_INTEGER, 2			 	, 8*2				, TRUE , FB_DATATYPE_SHORT 	 ), _
		(FB_DATACLASS_INTEGER, 2			 	, 8*2				, FALSE, FB_DATATYPE_USHORT	 ), _
		(FB_DATACLASS_INTEGER, 2			 	, 8*2				, FALSE, FB_DATATYPE_USHORT	 ), _ '' wstring
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, TRUE , FB_DATATYPE_INTEGER ), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT 	 ), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, TRUE , FB_DATATYPE_INTEGER ), _ '' enum
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT    ), _ '' bitfield
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE*2	, 8*FB_INTEGERSIZE*2, TRUE , FB_DATATYPE_LONGINT ), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE*2	, 8*FB_INTEGERSIZE*2, FALSE, FB_DATATYPE_ULONGINT), _
		(FB_DATACLASS_FPOINT , 4             	, 8*4				, TRUE , FB_DATATYPE_SINGLE	 ), _
		(FB_DATACLASS_FPOINT , 8			 	, 8*8				, TRUE , FB_DATATYPE_DOUBLE	 ), _
		(FB_DATACLASS_STRING , FB_STRDESCLEN	, 0					, FALSE, FB_DATATYPE_STRING	 ), _
		(FB_DATACLASS_STRING , 1			 	, 8*1				, FALSE, FB_DATATYPE_FIXSTR	 ), _
		(FB_DATACLASS_UDT	 , 0			 	, 0					, FALSE, FB_DATATYPE_USERDEF ), _
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT	 ), _ '' func
		(FB_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, FB_DATATYPE_VOID	 ), _ '' fwdref
		(FB_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, FB_DATATYPE_UINT	 )  _ '' ptr
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

    '' don't convert byte <-> char
    select case as const dtype1
    case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
    	select case dtype2
    	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
    		exit function
    	end select

    '' neither word <-> short
    case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
    	select case dtype2
    	case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
    		exit function
    	end select

	'' neither dword <-> integer
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
    	select case dtype2
    	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
    		exit function
    	end select

    '' neither qword <-> longint
    case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
    	select case dtype2
    	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
    		exit function
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
    	hReportErrorEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
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

	case FB_DATATYPE_LONGINT
		function = FB_DATATYPE_ULONGINT

	case else
		function = dtype
	end select

end function
