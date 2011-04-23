''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


'' intrinsic runtime lib printing functions (PRINT, WRITE, LPRINT, USING, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 51 ) = _
	{ _
		/' fb_PrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTVOID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTUBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTUSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTUINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTLONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTULONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTSINGLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTDOUBLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintWstr ( byval filenum as integer = 0, byval x as wstring ptr, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_PRINTWSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTVOID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTUBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTUSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTUINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTLONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTULONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTSINGLE, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTDOUBLE, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTSTR, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintWstr ( byval filenum as integer = 0, byval x as wstring ptr, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_LPRINTWSTR, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' spc ( byval filenum as integer = 0, byval n as integer ) as void '/ _
		( _
			@FB_RTL_PRINTSPC, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' tab ( byval filenum as integer = 0, byval newcol as integer ) as void '/ _
		( _
			@FB_RTL_PRINTTAB, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteVoid ( byval filenum as integer = 0, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEVOID, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEBYTE, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_BYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEUBYTE, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITESHORT, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEUSHORT, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEINT, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEUINT, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITELONGINT, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEULONGINT, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITESINGLE, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEDOUBLE, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITESTR, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_WriteWstr ( byval filenum as integer = 0, byval x as wstring ptr, byval mask as integer ) as void '/ _
		( _
			@FB_RTL_WRITEWSTR, NULL, _
			FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUsingInit ( fmtstr as string ) as integer '/ _
		( _
			@FB_RTL_PRINTUSGINIT, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUsingStr ( byval filenum as integer, s as string, byval mask as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSGSTR, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUsingWstr ( byval filenum as integer, byval s as wstring ptr, byval mask as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSGWSTR, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUsingSingle ( byval filenum as integer, byval v as single, _
		  							byval mask as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSG_SNG, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUsingDouble ( byval filenum as integer, byval v as double, _
		  							byval mask as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSG_DBL, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_PrintUsingLongint ( byval filenum as integer, byval v as longint, _
		  							byval mask as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSG_LL, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_PrintUsingULongint ( byval filenum as integer, byval v as ulongint, _
		  							byval mask as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSG_ULL, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_PrintUsingEnd ( byval filenum as integer ) as integer '/ _
		( _
			@FB_RTL_PRINTUSGEND, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LPrintUsingInit ( fmtstr as string ) as integer '/ _
		( _
			@FB_RTL_LPRINTUSGINIT, NULL, _
			FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }


'':::::
sub rtlPrintModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlPrintModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlPrint _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval iscomma as integer, _
		byval issemicolon as integer, _
		byval expr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mask = any, args = any

    function = FALSE

	if( expr = NULL ) then
		if( islprint ) then
			f = PROCLOOKUP( LPRINTVOID )
		else
			f = PROCLOOKUP( PRINTVOID )
		end if
		args = 2
	else

		'' UDT? try to convert to string with type casting op overloading
		select case typeGet( astGetDataType( expr ) )
		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
			expr = astNewOvlCONV( FB_DATATYPE_STRING, NULL, expr )
			if( expr = NULL ) then
				exit function
			end if
		end select

		select case as const typeGet( astGetDataType( expr ) )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSTR )
			else
				f = PROCLOOKUP( PRINTSTR )
			end if

		case FB_DATATYPE_WCHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTWSTR )
			else
				f = PROCLOOKUP( PRINTWSTR )
			end if

		case FB_DATATYPE_BYTE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTBYTE )
			else
				f = PROCLOOKUP( PRINTBYTE )
			end if

		case FB_DATATYPE_UBYTE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUBYTE )
			else
				f = PROCLOOKUP( PRINTUBYTE )
			end if

		case FB_DATATYPE_SHORT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSHORT )
			else
				f = PROCLOOKUP( PRINTSHORT )
			end if

		case FB_DATATYPE_USHORT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUSHORT )
			else
				f = PROCLOOKUP( PRINTUSHORT )
			end if

		case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			if( islprint ) then
				f = PROCLOOKUP( LPRINTINT )
			else
				f = PROCLOOKUP( PRINTINT )
			end if

		case FB_DATATYPE_UINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUINT )
			else
				f = PROCLOOKUP( PRINTUINT )
			end if

		case FB_DATATYPE_LONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				if( islprint ) then
					f = PROCLOOKUP( LPRINTINT )
				else
					f = PROCLOOKUP( PRINTINT )
				end if
			else
				if( islprint ) then
					f = PROCLOOKUP( LPRINTLONGINT )
				else
					f = PROCLOOKUP( PRINTLONGINT )
				end if
			end if

		case FB_DATATYPE_ULONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUINT )
				else
					f = PROCLOOKUP( PRINTUINT )
				end if
			else
				if( islprint ) then
					f = PROCLOOKUP( LPRINTULONGINT )
				else
					f = PROCLOOKUP( PRINTULONGINT )
				end if
			end if

		case FB_DATATYPE_LONGINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTLONGINT )
			else
				f = PROCLOOKUP( PRINTLONGINT )
			end if

		case FB_DATATYPE_ULONGINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTULONGINT )
			else
				f = PROCLOOKUP( PRINTULONGINT )
			end if

		case FB_DATATYPE_SINGLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSINGLE )
			else
				f = PROCLOOKUP( PRINTSINGLE )
			end if

		case FB_DATATYPE_DOUBLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTDOUBLE )
			else
				f = PROCLOOKUP( PRINTDOUBLE )
			end if

		case FB_DATATYPE_POINTER
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUINT )
				else
					f = PROCLOOKUP( PRINTUINT )
				end if
			else
				if( islprint ) then
					f = PROCLOOKUP( LPRINTULONGINT )
				else
					f = PROCLOOKUP( PRINTULONGINT )
				end if
			end if

			expr = astNewCONV( FB_DATATYPE_ULONG, NULL, expr )

		case else
			exit function

		end select

		args = 3
	end if

    ''
	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewARG( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

	'' byval mask as integer
	mask = 0
	if( fbLangIsSet( FB_LANG_QB ) ) then mask or= FB_PRINTMASK_APPEND_SPACE
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	elseif( issemicolon = FALSE ) then
		mask or= FB_PRINTMASK_NEWLINE
	end if

	expr = astNewCONSTi( mask, FB_DATATYPE_INTEGER )
    if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintSPC _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer

    dim as ASTNODE ptr proc = any

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewCALL( PROCLOOKUP( PRINTSPC ) )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval n as integer
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintTab _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
    ) as integer

    dim as ASTNODE ptr proc = any

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewCALL( PROCLOOKUP( PRINTTAB ) )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval newcol as integer
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWrite _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval iscomma as integer, _
		byval expr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mask = any

	function = FALSE

	if( expr = NULL ) then
		f = PROCLOOKUP( WRITEVOID )
	else

		'' UDT? try to convert to string with type casting op overloading
		select case astGetDataType( expr )
		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
			expr = astNewOvlCONV( FB_DATATYPE_STRING, NULL, expr )
			if( expr = NULL ) then
				exit function
			end if
		end select

		select case as const typeGet( astGetDataType( expr ) )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
			f = PROCLOOKUP( WRITESTR )

		case FB_DATATYPE_WCHAR
			f = PROCLOOKUP( WRITEWSTR )

		case FB_DATATYPE_BYTE
			f = PROCLOOKUP( WRITEBYTE )

		case FB_DATATYPE_UBYTE
			f = PROCLOOKUP( WRITEUBYTE )

		case FB_DATATYPE_SHORT
			f = PROCLOOKUP( WRITESHORT )

		case FB_DATATYPE_USHORT
			f = PROCLOOKUP( WRITEUSHORT )

		case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			f = PROCLOOKUP( WRITEINT )

		case FB_DATATYPE_UINT
			f = PROCLOOKUP( WRITEUINT )

		case FB_DATATYPE_LONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = PROCLOOKUP( WRITEINT )
			else
				f = PROCLOOKUP( WRITELONGINT )
			end if

		case FB_DATATYPE_ULONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = PROCLOOKUP( WRITEUINT )
			else
				f = PROCLOOKUP( WRITEULONGINT )
			end if

		case FB_DATATYPE_LONGINT
			f = PROCLOOKUP( WRITELONGINT )

		case FB_DATATYPE_ULONGINT
			f = PROCLOOKUP( WRITEULONGINT )

		case FB_DATATYPE_SINGLE
			f = PROCLOOKUP( WRITESINGLE )

		case FB_DATATYPE_DOUBLE
			f = PROCLOOKUP( WRITEDOUBLE )

		case FB_DATATYPE_POINTER
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = PROCLOOKUP( WRITEUINT )
			else
				f = PROCLOOKUP( WRITEULONGINT )
			end if

			expr = astNewCONV( FB_DATATYPE_ULONG, NULL, expr )

		case else
			exit function

		end select

	end if

    ''
	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewARG( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	else
		mask or= FB_PRINTMASK_NEWLINE
	end if

    if( astNewARG( proc, _
    			   astNewCONSTi( mask, FB_DATATYPE_INTEGER ), _
    			   FB_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingInit _
	( _
		byval usingexpr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer 

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any

	function = FALSE

	''
	if( islprint ) then
		f = PROCLOOKUP( LPRINTUSGINIT )
	else
		f = PROCLOOKUP( PRINTUSGINIT )
	end if
    proc = astNewCALL( f )

    '' fmtstr as string
    if( astNewARG( proc, usingexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingEnd _
	( _
		byval fileexpr as ASTNODE ptr, _
        byval islprint as integer = FALSE _
	) as integer

    dim as ASTNODE ptr proc = any

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewCALL( PROCLOOKUP( PRINTUSGEND ) )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsing _
	( _
		byval fileexpr as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval iscomma as integer, _
		byval issemicolon as integer, _
        byval islprint as integer = FALSE _
    ) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer mask = any

	function = FALSE

    if( islprint ) then
    	rtlPrinter_cb( NULL )
    end if

    if( expr = NULL ) then
    	exit function
    end if

	'' UDT? try to convert to double with type casting op overloading
	select case astGetDataType( expr )
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		expr = astNewOvlCONV( FB_DATATYPE_DOUBLE, NULL, expr )
		if( expr = NULL ) then
			exit function
		end if
	end select

	select case astGetDataType( expr )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
		f = PROCLOOKUP( PRINTUSGSTR )

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( PRINTUSGWSTR )

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( PRINTUSG_SNG )

	case FB_DATATYPE_LONGINT, _
	    FB_DATATYPE_INTEGER, _
	    FB_DATATYPE_LONG, _
	    FB_DATATYPE_SHORT, _
	    FB_DATATYPE_BYTE

		f = PROCLOOKUP( PRINTUSG_LL )

	case FB_DATATYPE_ULONGINT, _
	    FB_DATATYPE_UINT, _
	    FB_DATATYPE_ULONG, _
	    FB_DATATYPE_USHORT, _
	    FB_DATATYPE_UBYTE

		f = PROCLOOKUP( PRINTUSG_ULL )

	case else
		f = PROCLOOKUP( PRINTUSG_DBL )
	end select

	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' s as string or byval v as double
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' byval mask as integer
	if( iscomma or issemicolon ) then
		mask = 0

#if 0
		'' this allows commas to print padding like in regular PRINTs
		'' (QB doesn't support this though - the IDE just converts them to semicolons)
		if( iscomma ) then
			mask or= FB_PRINTMASK_PAD
		end if
#endif

	else
		mask = FB_PRINTMASK_NEWLINE or FB_PRINTMASK_ISLAST
	end if

    if( astNewARG( proc, _
    			   astNewCONSTi( mask, FB_DATATYPE_INTEGER ), _
    			   FB_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWidthDev _
	( _
		byval device as ASTNODE ptr, _
		byval width_arg as ASTNODE ptr, _
        byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

    '' printer libraries are always required for width on devices
	rtlPrinter_cb( NULL )

	''
    proc = astNewCALL( PROCLOOKUP( WIDTHDEV ) )

    '' device as string
    if( astNewARG( proc, device ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewARG( proc, width_arg ) = NULL ) then
    	exit function
    end if

    ''
    if( isfunc = FALSE ) then
    	dim reslabel as FBSYMBOL ptr

    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function

'':::::
function rtlPrinter_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

    static as integer libsAdded = FALSE

	if( libsadded = FALSE ) then

        libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "winspool" )
			symbAddLib( "gdi32" )
		end select

	end if

    function = TRUE

end function


