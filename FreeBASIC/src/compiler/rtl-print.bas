''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

''
'' fb_PrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data @FB_RTL_PRINTVOID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data @FB_RTL_PRINTBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data @FB_RTL_PRINTUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data @FB_RTL_PRINTSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data @FB_RTL_PRINTUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data @FB_RTL_PRINTINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data @FB_RTL_PRINTUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data @FB_RTL_PRINTLONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data @FB_RTL_PRINTULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data @FB_RTL_PRINTSINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data @FB_RTL_PRINTDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data @FB_RTL_PRINTSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintWstr ( byval filenum as integer = 0, byval x as wstring ptr, byval mask as integer ) as void
data @FB_RTL_PRINTWSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_LPrintVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data @FB_RTL_LPRINTVOID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data @FB_RTL_LPRINTBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data @FB_RTL_LPRINTUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data @FB_RTL_LPRINTSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data @FB_RTL_LPRINTUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data @FB_RTL_LPRINTINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data @FB_RTL_LPRINTUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data @FB_RTL_LPRINTLONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data @FB_RTL_LPRINTULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data @FB_RTL_LPRINTSINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data @FB_RTL_LPRINTDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data @FB_RTL_LPRINTSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintWstr ( byval filenum as integer = 0, byval x as wstring ptr, byval mask as integer ) as void
data @FB_RTL_LPRINTWSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' spc ( byval filenum as integer = 0, byval n as integer ) as void
data @FB_RTL_PRINTSPC,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' tab ( byval filenum as integer = 0, byval newcol as integer ) as void
data @FB_RTL_PRINTTAB,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

''
'' fb_WriteVoid ( byval filenum as integer = 0, byval mask as integer ) as void
data @FB_RTL_WRITEVOID,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteByte ( byval filenum as integer = 0, byval x as byte, byval mask as integer ) as void
data @FB_RTL_WRITEBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteUByte ( byval filenum as integer = 0, byval x as ubyte, byval mask as integer ) as void
data @FB_RTL_WRITEUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteShort ( byval filenum as integer = 0, byval x as short, byval mask as integer ) as void
data @FB_RTL_WRITESHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteUShort ( byval filenum as integer = 0, byval x as ushort, byval mask as integer ) as void
data @FB_RTL_WRITEUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteInt ( byval filenum as integer = 0, byval x as integer, byval mask as integer ) as void
data @FB_RTL_WRITEINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteUInt ( byval filenum as integer = 0, byval x as uinteger, byval mask as integer ) as void
data @FB_RTL_WRITEUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteLongint ( byval filenum as integer = 0, byval x as longint, byval mask as integer ) as void
data @FB_RTL_WRITELONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteULongint ( byval filenum as integer = 0, byval x as ulongint, byval mask as integer ) as void
data @FB_RTL_WRITEULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteSingle ( byval filenum as integer = 0, byval x as single, byval mask as integer ) as void
data @FB_RTL_WRITESINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteDouble ( byval filenum as integer = 0, byval x as double, byval mask as integer ) as void
data @FB_RTL_WRITEDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteString ( byval filenum as integer = 0, x as string, byval mask as integer ) as void
data @FB_RTL_WRITESTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_WriteWstr ( byval filenum as integer = 0, byval x as wstring ptr, byval mask as integer ) as void
data @FB_RTL_WRITEWSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUsingInit ( fmtstr as string ) as integer
data @FB_RTL_PRINTUSGINIT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' fb_PrintUsingStr ( byval filenum as integer, s as string, byval mask as integer ) as integer
data @FB_RTL_PRINTUSGSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUsingWstr ( byval filenum as integer, byval s as wstring ptr, byval mask as integer ) as integer
data @FB_RTL_PRINTUSGWSTR,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_WCHAR,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUsingVal ( byval filenum as integer, byval v as double, byval mask as integer ) as integer
data @FB_RTL_PRINTUSGVAL,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_PrintUsingEnd ( byval filenum as integer ) as integer
data @FB_RTL_PRINTUSGEND,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' fb_LPrintUsingInit ( fmtstr as string ) as integer
data @FB_RTL_LPRINTUSGINIT,"", _
	 FB_SYMBTYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' EOL
data NULL


'':::::
sub rtlPrintModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlPrintModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlPrint( byval fileexpr as ASTNODE ptr, _
				   byval iscomma as integer, _
				   byval issemicolon as integer, _
				   byval expr as ASTNODE ptr, _
                   byval islprint as integer = FALSE ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer mask, args, dtype

    function = FALSE

	if( expr = NULL ) then
		if( islprint ) then
			f = PROCLOOKUP( LPRINTVOID )
		else
			f = PROCLOOKUP( PRINTVOID )
		end if
		args = 2
	else

		dtype = astGetDataType( expr )
		select case as const dtype
		case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSTR )
			else
				f = PROCLOOKUP( PRINTSTR )
			end if

		case IR_DATATYPE_WCHAR
			if( islprint ) then
				f = PROCLOOKUP( LPRINTWSTR )
			else
				f = PROCLOOKUP( PRINTWSTR )
			end if

		case IR_DATATYPE_BYTE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTBYTE )
			else
				f = PROCLOOKUP( PRINTBYTE )
			end if

		case IR_DATATYPE_UBYTE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUBYTE )
			else
				f = PROCLOOKUP( PRINTUBYTE )
			end if

		case IR_DATATYPE_SHORT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSHORT )
			else
				f = PROCLOOKUP( PRINTSHORT )
			end if

		case IR_DATATYPE_USHORT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUSHORT )
			else
				f = PROCLOOKUP( PRINTUSHORT )
			end if

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			if( islprint ) then
				f = PROCLOOKUP( LPRINTINT )
			else
				f = PROCLOOKUP( PRINTINT )
			end if

		case IR_DATATYPE_UINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTUINT )
			else
				f = PROCLOOKUP( PRINTUINT )
			end if

		case IR_DATATYPE_LONGINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTLONGINT )
			else
				f = PROCLOOKUP( PRINTLONGINT )
			end if

		case IR_DATATYPE_ULONGINT
			if( islprint ) then
				f = PROCLOOKUP( LPRINTULONGINT )
			else
				f = PROCLOOKUP( PRINTULONGINT )
			end if

		case IR_DATATYPE_SINGLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTSINGLE )
			else
				f = PROCLOOKUP( PRINTSINGLE )
			end if

		case IR_DATATYPE_DOUBLE
			if( islprint ) then
				f = PROCLOOKUP( LPRINTDOUBLE )
			else
				f = PROCLOOKUP( PRINTDOUBLE )
			end if

		case IR_DATATYPE_USERDEF
			exit function						'' illegal

		case else
			if( dtype >= IR_DATATYPE_POINTER ) then
				if( islprint ) then
					f = PROCLOOKUP( LPRINTUINT )
				else
					f = PROCLOOKUP( PRINTUINT )
				end if
				expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
			else
				exit function
			end if
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewPARAM( proc, expr ) = NULL ) then
 			exit function
 		end if
    end if

    '' byval mask as integer
	mask = 0
	if( iscomma ) then
		mask or= FB_PRINTMASK_PAD
	elseif( not issemicolon ) then
		mask or= FB_PRINTMASK_NEWLINE
	end if

	expr = astNewCONSTi( mask, IR_DATATYPE_INTEGER )
    if( astNewPARAM( proc, expr, IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintSPC( byval fileexpr as ASTNODE ptr, _
					  byval expr as ASTNODE ptr, _
                      byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewFUNCT( PROCLOOKUP( PRINTSPC ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval n as integer
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintTab( byval fileexpr as ASTNODE ptr, _
					  byval expr as ASTNODE ptr, _
                      byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewFUNCT( PROCLOOKUP( PRINTTAB ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' byval newcol as integer
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWrite( byval fileexpr as ASTNODE ptr, _
				   byval iscomma as integer, _
				   byval expr as ASTNODE ptr ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer mask, args, dtype

	function = FALSE

	if( expr = NULL ) then
		f = PROCLOOKUP( WRITEVOID)
		args = 2
	else

		dtype = astGetDataType( expr )
		select case as const dtype
		case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
			f = PROCLOOKUP( WRITESTR )

		case IR_DATATYPE_WCHAR
			f = PROCLOOKUP( WRITEWSTR )

		case IR_DATATYPE_BYTE
			f = PROCLOOKUP( WRITEBYTE )

		case IR_DATATYPE_UBYTE
			f = PROCLOOKUP( WRITEUBYTE )

		case IR_DATATYPE_SHORT
			f = PROCLOOKUP( WRITESHORT )

		case IR_DATATYPE_USHORT
			f = PROCLOOKUP( WRITEUSHORT )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			f = PROCLOOKUP( WRITEINT )

		case IR_DATATYPE_UINT
			f = PROCLOOKUP( WRITEUINT )

		case IR_DATATYPE_LONGINT
			f = PROCLOOKUP( WRITELONGINT )

		case IR_DATATYPE_ULONGINT
			f = PROCLOOKUP( WRITEULONGINT )

		case IR_DATATYPE_SINGLE
			f = PROCLOOKUP( WRITESINGLE )

		case IR_DATATYPE_DOUBLE
			f = PROCLOOKUP( WRITEDOUBLE )

		case IR_DATATYPE_USERDEF
			exit function						'' illegal

		case else
			if( dtype >= IR_DATATYPE_POINTER ) then
				f = PROCLOOKUP( WRITEUINT )
				expr = astNewCONV( INVALID, IR_DATATYPE_UINT, NULL, expr )
			else
				exit function
			end if
		end select

		args = 3
	end if

    ''
	proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    if( expr <> NULL ) then
    	'' byval? x as ???
    	if( astNewPARAM( proc, expr ) = NULL ) then
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

    if( astNewPARAM( proc, astNewCONSTi( mask, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingInit( byval usingexpr as ASTNODE ptr, _
                            byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = FALSE

	''
	if( islprint ) then
		f = PROCLOOKUP( LPRINTUSGINIT )
	else
		f = PROCLOOKUP( PRINTUSGINIT )
	end if
    proc = astNewFUNCT( f )

    '' fmtstr as string
    if( astNewPARAM( proc, usingexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsingEnd( byval fileexpr as ASTNODE ptr, _
                           byval islprint as integer = FALSE ) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	''
    proc = astNewFUNCT( PROCLOOKUP( PRINTUSGEND ) )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlPrintUsing( byval fileexpr as ASTNODE ptr, _
						byval expr as ASTNODE ptr, _
						byval iscomma as integer, _
						byval issemicolon as integer, _
                        byval islprint as integer = FALSE ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer mask

	function = FALSE

    if islprint then
    	rtlPrinter_cb( NULL )
    end if

	select case astGetDataType( expr )
	case IR_DATATYPE_FIXSTR, IR_DATATYPE_STRING, IR_DATATYPE_CHAR
		f = PROCLOOKUP( PRINTUSGSTR )

	case IR_DATATYPE_WCHAR
		f = PROCLOOKUP( PRINTUSGWSTR )

	case else
		f = PROCLOOKUP( PRINTUSGVAL )
	end select

	proc = astNewFUNCT( f )

    '' byval filenum as integer
    if( astNewPARAM( proc, fileexpr ) = NULL ) then
 		exit function
 	end if

    '' s as string or byval v as double
    if( astNewPARAM( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' byval mask as integer
	if( iscomma or issemicolon ) then
		mask = 0
	else
		mask = FB_PRINTMASK_NEWLINE or FB_PRINTMASK_ISLAST
	end if

    if( astNewPARAM( proc, astNewCONSTi( mask, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlWidthDev ( byval device as ASTNODE ptr, _
					   byval width_arg as ASTNODE ptr, _
                       byval isfunc as integer ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

    '' printer libraries are always required for width on devices
	rtlPrinter_cb( NULL )

	''
    proc = astNewFUNCT( PROCLOOKUP( WIDTHDEV ) )

    '' device as string
    if( astNewPARAM( proc, device ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewPARAM( proc, width_arg ) = NULL ) then
    	exit function
    end if

    ''
    if( not isfunc ) then
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
function rtlPrinter_cb( byval sym as FBSYMBOL ptr ) as integer static
    static as integer libsAdded = FALSE

	if( not libsadded ) then

        libsAdded = TRUE

		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			symbAddLib( "winspool" )
			symbAddLib( "gdi32" )
		end select

	end if

    function = TRUE

end function


